using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;
using System.Text;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring OpenAPI at https://aka.ms/aspnet/openapi
builder.Services.AddOpenApi();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.MapOpenApi();
}

builder.Services.AddAuthentication(
  JwtBearerDefaults.AuthenticationScheme)
.AddJwtBearer(options => {
    options.TokenValidationParameters =
     new TokenValidationParameters
     {
         ValidateIssuer = true,
         ValidateAudience = true,
         ValidateLifetime = true,
         ValidateIssuerSigningKey = true,
         ValidIssuer = config["Jwt:Issuer"],
         ValidAudience = config["Jwt:Audience"],
         IssuerSigningKey = new SymmetricSecurityKey(
        Encoding.UTF8.GetBytes(
          config["Jwt:SecretKey"]!))
     };
});
app.UseAuthentication();
app.UseAuthorization();




app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
