console.log('Hola mundo')  //impresion
 

//Variable Es un cotenedor paa almacenar datos que retiene su valor 
var nombre =  'Juan';
let edad = 30;
const PI = 3.1416

//Ejemplo
let libro = 'Caballo de troya de JJ benitez';
console.log(libro);

//Tipos de datos
let numero = 42;
let texto = 'Hola mundo';
let booleano = true;
let nulo = null;
let indefinido;


//Listas
//Las litas en JavaScrip son una estructura de datos que nos permite
//almacenar una colexoin,ordenada de elementos

let frutas = ['Manzana','Banana','Naranja'];
console.log(frutas[0]);//manzana

console.log('======================PELICULAS=============================')
//Reto: Crar una lista de tus pelicaulas favoritas y mostrar la primera pelicula en al consola
let peliculas = ['spiderman1','spiderman2','spiderman3','spiderman4'];

console.log(peliculas[0]);


console.log('=======================MESES==============================')

//Reto: Crea una lista que contenga los nombres de los meses del año e imprimelos
let meses = ['Enero','Febrero','Marzo','Abril','Mayo','Junio','Julio','Agosto','Septiembre','Obtubre','Nombiembre','Diciembre'];

for (let index = 0; index < meses.length; index++) {
    const Lista = meses[index];

    console.log(Lista);
}


//Datos mixtos
let datosMixtos=['Hello',42,true,null,undefined];
console.log(datosMixtos[1]);

//Objetos
//Los objetos en JavaScript sp una fomra de almacenar y organizar datos mapeandolos de uno a uno

let persona ={
    nombre:'Juan',
    edad:30,
    profesion:'Desarrollador'
};
console.log(persona.nombre);//Juan
console.log(persona.edad)


//Reto:Crea un objeto que represente a tu pelicula favorita con Propiedades cmo Titulo,directo y año de lanzamiento

let pelicula ={
    titulo :'The ameazing spiderman',
    director : 'Un vato',
    anio : '2017'
};

console.log(pelicula.titulo,pelicula.director,pelicula.anio);

//Reto:Crea un objeto que representa a tu pais con propiedades como capital,poblacion y idoma oficial e imprimelo

let pais={
    capital:'CDMX',
    poblacion: 9209944,
    idioma:'español'
}
console.log(" Capital ","  Poblacion  "," Idioma ");
console.log(pais.capital,pais.poblacion,pais.idioma);

//Reto:Crea un objeto que repesente a tu comida favorita con propiedades como nombre,ingresdientes y tiempo de preparacion e imprimerlo en consola
let comidafavorita={
    nombre:'Panvaso' ,
    ingredientes: 'La doña que los hace y $$',
    tiempoPreparacion : ' 10 min'

} ;

console.log(comidafavorita)

//Reto:Crea un objeto que represente tu deporte favorito con propiedapes como Nombre,Reglas y jugadores
let deporteFavorito={
    nombre:'Calistenia',
    Reglas: 'No rendirse',
    
};

console.log(deporteFavorito);

/*Reto:Crea un objeto JS que represente una computadora con sus respectivas caracteristicas como
 marca,modelo,procesador,memoria Ram y almancenamiento*/

let computadora={
    marca:'Asus',
    modelo:'Rog Strix G16',
    procesador:'i7 treceava ' ,
    memoria:'32 Gb',
    almacenamiento: '1500 GB'

}

console.log(computadora);
console.log(
    `Marca: ${computadora.marca}, Modelo: ${computadora.modelo}, Procesador: ${computadora.procesador}`
);
console.log(JSON.stringify(computadora));


//Condicionales
//Son una estructura de flujo de control que nos permiteejecutar diferentes bloques de codigo segun ciertas condiciones

let edadUsuario = 18;

if(edadUsuario >= 18){
    console.log('Eres mayor de edad');
}else{
    console.log('Eres menor de edad');
}

//Multiples condiciones
let hora= 14;
if (hora < 12 ) {
    console.log('Buenos dias');   
} else if(hora < 18 ){
    console.log('Buenas tardes');    
}else {
    console.log('Buenas noches');
}

//Swicht

switch (hora) {
    case 0:
        console.log('Media Noche');
        break;
    case 12:
        console.log('Medio dia');    
        break

    default:
        console.log('Hora no especificada')
        
}

//Bucle FOR
//Es una estructura de cotrol de flujo que se utiliza para iterar sobre una secuencia de elementos
//como una lista
let animales = ['Perro','Gato','Pajaro'];
for (let index = 0; index < animales.length; index++) {
    const element = animales[index];
    console.log(animales[index]);
    
}

//Bucle WHILE
//Es una estructura de control de flujo que se utiliza para repartir un bloque de codigo
//Mientras una condicion se verdadera

let contador =0;
while (contador < 5 ) {
    console.log(contador);
    contador++;
}

//reto: Crea un bucle for que imprima los numeros del 1 al 10 en la consola

for (let index = 0; index <= 10; index++) {
    console.log(index);
    
}

//Reto Crea un bucle while que imprima los numero pares del 0 al 29 en la consola
let contador2 = 0;
while (contador2 <= 29) {
    console.log(contador2);
   contador2++;
    
}

//Funciones 
//Una funcion es un bloque de codifo reutilizable que realira una tarea especifica

function saludar(nombre){
    console.log('Hola '+ nombre + '!');
}

saludar('Juan');//Hola juan!

//Funciones con retorno
function sumar(a,b){
    return a + b ;
}

//Funcion anónima para las 4 operaciones basicas
let sumar2 = (a,b) => a + b;
let restar = (a,b) => a - b;
let multiplicar = (a,b) => a * b;
let dividir = (a,b) => a / b;

console.log(sumar2(5,3)); //8
console.log(restar(5,3)); //2
console.log(multiplicar(5,3)); //15
console.log(dividir(5,3)); //1.6666666666666667 




//Quick SOurt
/*Esta funcion implementa el algoritmo de ordenamiento QuickSort para ordenar una lista de
elementos. En algoritmo comienza tomando un elemento de la lista como pivote y
luego coloca los elementos menores que el pivote a su izquierda y los elemetos 
mayores a su derecha Luego se aplica el mismo algoritmo a las sublistas izquierda y 
derecha hasta que la lista este ordenada
*/

function quicksort(lista){
    if (lista.length <= 1) {
        return lista;      
    }
    let pivote = lista[0];
    let menores = [];
    let mayores = [];

    for (let i = 1; i < lista.length; i++) {
        lista[i] < pivote ? menores.push(lista[i]) : mayores.push(lista[i]);        
    } 
    return quicksort(menores).concat(pivote,quicksort(mayores));    
}

let numeros = [5,8,8,7,54,34,654,75,324,324,1231,23,32];
let listaOrdenada = quicksort(numeros);
console.log(listaOrdenada);

//Ejercicio con letras

function quicksort(lista){
    if (lista.length <= 1) {
        return lista;      
    }
    let pivote = lista[0];   

    let menores = [];
    let mayores = [];

    for (let i = 1; i < lista.length; i++) {
        lista[i] < pivote ? menores.push(lista[i]) : mayores.push(lista[i]);        
    } 
    return quicksort(menores).concat(pivote,quicksort(mayores));       
}

let letra = ['C','D','B','A'];
let listaOrdenada = quicksort(letra);
console.log(listaOrdenada);


//CLASES
/*Las clases */

class lenguaje {
    constructor(nombre,creador,año){
        this.nombre = nombre ;
        this.creador = creador;
        this.año = año;
    }
    descripcion(){
        console.log(`${this.nombre} fue creado por ${this.creador} en el año ${this.año}.`);
    }
}

let js = new lenguaje('JavaScrip','Brendan Eich',1955);
js.descripcion();

/*Reto Crea una clase que repsesente a tu pelicula favorita con propiedades 
como titulo director y anio de lanzamiento e imprimelo en la consola*/
class peliculaFav{
    constructor(titulo,director,anio){
        this.titulo = titulo;
        this.director = director;
        this.anio = anio;
    }
    descripcion(){
        console.log(`${this.titulo} fue creado por ${this.director} en el año ${this.anio}.`)
    }
}

let jsPeliculas  = new peliculaFav('Spiderman','JhonWhats',2019);
jsPeliculas.peliculaFav();


/*Reto Crea una clase que repsesente a tu pelicula favorita con propiedades 
como titulo director y anio de lanzamiento e imprimelo en la consola*/
class peliculaFav{
    constructor(titulo,director,anio){
        this.titulo = titulo;
        this.director = director;
        this.anio = anio;
    }
    descripcion(){
        console.log(`${this.titulo} fue creado por ${this.director} en el año ${this.anio}.`)
    }
}

let jsPeliculas  = new peliculaFav('Spiderman','JhonWhats',2019);
jsPeliculas.descripcion();

/*Reto Crae una clase que represente a tu pais con propiedades como capital
poblacion y idioma oficial e imprimelo en consola*/
class pais{
    constructor(capital,poblacion,idiomaOficial){
        this.capital=capital;
        this.poblacion=poblacion;
        this.idiomaOficial=idiomaOficial;
    }
    descripcion(){
        console.log(`${this.capital} tiene una poblacion de ${this.poblacion} y su idoma  es ${this.idiomaOficial}.`)
    }
}

let jsPais = new pais('CDMX',9000000,'Español')
jsPais.descripcion(); 


/*Reto Crea una clase llamada moto que tenga propiedades como marca , modelo y anio
y crea e imprime 5 instancias de ella*/

class moto{
    constructor(marca,modelo,anio){
        this.marca=marca;
        this.modelo=modelo;
        this.anio=anio;
    }
    descripcion(){
        console.log(`La moto de marca ${this.marca} el modelo ${this.modelo} año ${this.anio} es buena.`)
    }
}

 let motos = [
    new moto('CfMoto', 'NK250', 2026),
    new moto('Yamaha', 'MT-03', 2025),
    new moto('Honda', 'CB190R', 2024),
    new moto('Kawasaki', 'Ninja 400', 2026)
];

motos.forEach(m => {
    m.descripcion();
});


//Modulos
/*Los modulos en javaScrip son una forma de organizar y reutilizar el codigo dividiendolo 
en archivos separados Cada modulo puede exportar e importar funciones, objetos o valores 
Son una forma de incluir codigo externo de otro archivo     */



