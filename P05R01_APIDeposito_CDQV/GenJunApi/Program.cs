using Microsoft.AspNetCore.Builder;
var builder = WebApplication.CreateBuilder(args);

builder.Services.AddEndpointsApiExplorer();
builder.Services.AddControllers();//Agrega servicios necesacios para usar controladores en la aplicion

var app = builder.Build();

app.UseAuthorization();
app.MapControllers();
app.Run();