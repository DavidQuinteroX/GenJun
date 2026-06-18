function contarMayoresQueX(arr,x){
    let contador = 0;
    const n= arr.length;
    for (let i = 0; i < n; i++) {
        if (arr[i] > x ) {
            contador = contador + 1;
        }  
    }
    return contador;
}
//Funcion alternatica usando metodos modernos de JavaScrip
function contarMayoresQueXModerno(arr,x){
    return arr.filter(elemento => elemento > x).length;
}

//Ejemplos de prueba
console.log("=== CONTAR ELEMENTOS MAYORES QUE X ===")

const numeros1 = [5,12,8,3,15,7,20];
console.log(`Array : [${numeros1}]`);