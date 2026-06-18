
function sumaHastaN(n=100){
    let suma = 0;
    for(let i=1;i <= n; i++){
        suma = suma + i;
    }
    return suma;
}
//FUNCION ALTERNATIVA USANDO FORMULA MATEMATICA (MAS EFICEIENTE)
function sumaHastaNFormula(n = 100){
    return (n*(n+1))/2;
}

//Ejemplos de prueba
console.log("===SUMA DE NUMEROS===");
console.log(`Suma del 1 al 100 (con loop): ${sumaHastaN(100)}`);
console.log(`Suma del 1 al 100 (con formula) : ${sumaHastaNFormula(100)}`);