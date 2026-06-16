using System.Text;
using JwtDemoAPI.Data;
using JwtDemoAPI.Services;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi.Models;

var builder = WebApplication.CreateBuilder(args);
var config  = builder.Configuration;

// ── 1. Base de datos — SQL Server 2019 ──────────────────────────────────────
builder.Services.AddDbContext<AppDbContext>(opt =>
    opt.UseSqlServer(config.GetConnectionString("DefaultConnection")));

// ── 2. Servicio de tokens ────────────────────────────────────────────────────
builder.Services.AddScoped<ITokenService, TokenService>();

// ── 3. Autenticacion JWT ─────────────────────────────────────────────────────
builder.Services
    .AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
    .AddJwtBearer(options =>
    {
        options.TokenValidationParameters = new TokenValidationParameters
        {
            ValidateIssuer           = true,
            ValidateAudience         = true,
            ValidateLifetime         = true,          // valida exp
            ValidateIssuerSigningKey = true,
            ValidIssuer              = config["Jwt:Issuer"],
            ValidAudience            = config["Jwt:Audience"],
            IssuerSigningKey         = new SymmetricSecurityKey(
                                           Encoding.UTF8.GetBytes(config["Jwt:SecretKey"]!)),
            ClockSkew                = TimeSpan.Zero, // sin tolerancia de tiempo extra
        };

        // Respuesta personalizada cuando el token falla
        options.Events = new JwtBearerEvents
        {
            OnChallenge = ctx =>
            {
                ctx.HandleResponse();
                ctx.Response.StatusCode  = 401;
                ctx.Response.ContentType = "application/json";
                return ctx.Response.WriteAsync(
                    "{\"mensaje\":\"No autorizado. Proporciona un JWT valido en el header Authorization: Bearer <token>\"}");
            },
            OnForbidden = ctx =>
            {
                ctx.Response.StatusCode  = 403;
                ctx.Response.ContentType = "application/json";
                return ctx.Response.WriteAsync(
                    "{\"mensaje\":\"Acceso denegado. No tienes el rol necesario para este recurso\"}");
            }
        };
    });

builder.Services.AddAuthorization();

// ── 4. CORS — permite peticiones desde Angular/React (localhost:4200 / 3000) ─
builder.Services.AddCors(opt => opt.AddPolicy("FrontEnd", policy =>
    policy.WithOrigins("http://localhost:4200", "http://localhost:3000")
          .AllowAnyHeader()
          .AllowAnyMethod()));

// ── 5. Controllers + Swagger con soporte JWT ─────────────────────────────────
builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(c =>
{
    c.SwaggerDoc("v1", new OpenApiInfo
    {
        Title       = "JWT Demo API",
        Version     = "v1",
        Description = "API de ejemplo para capacitacion JWT con .NET Core y SQL Server 2019"
    });

    // Boton Authorize en Swagger para ingresar el JWT
    c.AddSecurityDefinition("Bearer", new OpenApiSecurityScheme
    {
        Name        = "Authorization",
        Type        = SecuritySchemeType.ApiKey,
        Scheme      = "Bearer",
        BearerFormat = "JWT",
        In          = ParameterLocation.Header,
        Description = "Ingresa: Bearer {tu_token_jwt}"
    });
    c.AddSecurityRequirement(new OpenApiSecurityRequirement
    {
        {
            new OpenApiSecurityScheme
            {
                Reference = new OpenApiReference
                {
                    Type = ReferenceType.SecurityScheme,
                    Id   = "Bearer"
                }
            },
            Array.Empty<string>()
        }
    });
});

// ─────────────────────────────────────────────────────────────────────────────
var app = builder.Build();

// ── 6. Aplicar migraciones automaticamente al iniciar ────────────────────────
using (var scope = app.Services.CreateScope())
{
    var db = scope.ServiceProvider.GetRequiredService<AppDbContext>();
    db.Database.Migrate();
}

// ── 7. Pipeline ──────────────────────────────────────────────────────────────
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI(c => c.SwaggerEndpoint("/swagger/v1/swagger.json", "JWT Demo API v1"));
}

app.UseHttpsRedirection();
app.UseCors("FrontEnd");

app.UseAuthentication();  // <-- ANTES de UseAuthorization
app.UseAuthorization();

app.MapControllers();
app.Run();
