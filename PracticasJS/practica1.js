function encontrarMayor(a,b,c){
    let mayor;

    if(a>b && a>c){
        mayor = a;
    } else if (b>c){
        mayor = b;
    }else {
        mayor = c;
    }
    return mayor
}

//Ejemplos de Prueba
console.log("====ENCONTRAR NUMERO MAS GRANDE ====");
console.log(`Mayor entre 5,3,8 :${encontrarMayor(5,3,8)}`);//Interpolacion de Strings
