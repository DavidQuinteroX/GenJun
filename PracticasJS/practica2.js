function esParOImpar(numero){
    if (numero % 2 === 0){
        return "El numero es par";

    }else{
        return "El numero es impar";
    }
}

//Ejmplos de Prueba
console.log("====DETERMINAR PAR O IMPAR ====");
console.log(`${5}: ${esParOImpar(5)}`);