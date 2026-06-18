//36 elementos comunes entre dos arreglos

function elementosComunes(arr1, arr2){
    const comunes = [];
    const n = arr1.length;
    const m = arr2.length;

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < m; j++) {
            if(arr1[i] === arr2[j]){
                //verificatr que ee elemento no este ya en el array
                if (!comunes.includes(arr1[i])) {
                    comunes.push(arr1[i]);
                    
                }
            }
            
        }
        
    }
    return comunes
}

//Version optimizada usando Set (mas eficiente)
function elementosComunesOptimizado(arr1,arr2){
    const set1 = new Set(arr1);
    const set2 = new Set(arr2);
    const comunes = [];

    for (let elemento of set1) {
        if (set2.has(elemento)) {
            comunes.push(elemento);
            
        }
        
    }

    return comunes
}

//Version con metodos modernos de JavaSacript

function elementosComunesModerno(arr1,arr2){
    return arr1.filter(elemento => arr2.includes(elemento))
    .filter((elemento,index,self) => self.indexOf(elemento) === index);

}

//Ejemplos de Prueba
console.log("Elementos Comunes entre dos arreglos \n");

const arr1 =[1,2,3,4,5];
const arr2 =[3,4,5,6,7];
console.log("Ejemplo1 :");
console.log(`Array 1: [${arr1}]`);
console.log(`Array 2: [${arr2}]`);
console.log(`Comunes: [${elementosComunes(arr1,arr2)}]\n`);

const array3 = [10,20,30,40,50];
const array4 = [15,20,35,40,55];
console.log ("Ejmplo 2 :")
console.log(`Array 1 : [${array3}]`);
console.log(`Array 2 : [${array4}]`);
console.log(`Comunes : [${elementosComunes(array3,array4)}]`);