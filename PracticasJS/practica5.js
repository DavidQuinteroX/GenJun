//35 Ordenamiento burbuja(Bubble sorth)
function bubbleSort(lista){
    //Crear una copia para no modificar el arrary original
    const arr = [...lista];
    const n= arr.length;
    for (let i = 0; i < n-1; i++) {
        for (let j = 0; j < n - i; j++) {
            //Intercambiar Elementos
            if (arr[j] > arr [j + 1]) {
                let temp = arr[j];
            arr[j]=arr[j + 1 ];
            arr[j + 1 ] = temp;
            }
            
            
        }
        
    }
    return arr
}


function bubbleSortConPasos(lista){
    const arr=[...lista];
    const n= arr.length;
    let pasos = 0;

    console.log(`Array inicial ; [${arr}]`);
    for (let i = 0; i < n-1; i++) {
        let huboIntercambio = false;
        for (let j = 0; j < n-1; j++) {
            if(arr[j]> arr[j + 1]){
                let temp = arr[j];
                arr[j] = arr[j + 1];
                arr[j +1] = temp;
                huboIntercambio= true;
                pasos++
            }
            
        }
        console.log(`pasada ${i + 1}: [${arr}]`);
        //Optimizacion si HUBO CAMBIOS
        if (!huboIntercambio) {
            console.log("No hubo mas intercambios, array ordenado");
            break;
        }
        
    }

    console.log(`Total de intercambios : ${pasos}\n`);
    return arr
}

const numeros1 = [64,34,25,12,22,11,90];
console.log("Ejemplo 1:");
console.log(`Original [${numeros1}]`);
console.log(`Ordenado: [${bubbleSort(numeros1)}]\n`);