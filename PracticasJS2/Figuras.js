function Cuadrado(lado){
    return lado * lado;
}

function Rectangulo(base, altura){
    return base * altura;
}

function Triangulo(base, altura){
    return (base * altura) / 2;
}

function Rombo(diagonalMayor, diagonalMenor){
    return (diagonalMayor * diagonalMenor) / 2;
}

function Romboide(base, altura){
    return base * altura;
}

function Trapecio(baseMayor, baseMenor, altura){
    return ((baseMayor + baseMenor) * altura) / 2;
}

function Circulo(radio){
    return Math.PI * radio * radio;
}

export {
    Cuadrado,
    Rectangulo,
    Triangulo,
    Rombo,
    Romboide,
    Trapecio,
    Circulo
};


