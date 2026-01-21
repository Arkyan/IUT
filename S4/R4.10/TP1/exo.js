const Separator = "----------------------------------------";

console.log(Separator);
console.log("Exo 1");
console.log(Separator);
//Exo 1
let num = 255;
let txt = "255";
let bin = true;
let flt = 7.23;

console.log("num =", num);
num++ ;
console.log("num =", num);

console.log(txt + " est ici une chaîne de caractères.");

bin = !bin;
console.log("bin =", bin);

flt = flt + num;
console.log("flt =", flt);

console.log(Separator);
console.log("Exo 2");
console.log(Separator);
//Exo 2
let num2 = 23;
let txt2 = "33";
let tmp = 0;

console.log(txt2 + num2);
console.log(num2 + txt2);

tmp = parseInt(txt2);
num2 = num2 + tmp;
console.log("num2 =", num2);

console.log(Separator);
console.log("Exo 3");
console.log(Separator);
//Exo 3
function isoNum() {
    return 42;
}

function myFct(arg1, arg2) {
    result = arg1 + arg2;
    console.log("La somme de", arg1, "et", arg2, "est égale à", result);
}

console.log(isoNum());
myFct(23, 27);

console.log(Separator);
console.log("Exo 4");
console.log(Separator);
//Exo 4
function isTooLong(txt) {
    if (txt.length > 10) {
        return true;
    } else {
        return false;
    }
}

console.log(isTooLong("Bonjour tout le monde"));
console.log(isTooLong("Salut"));

console.log(Separator);
console.log("Exo 5");
console.log(Separator);

function myFct2(arg1, arg2) {
    if (typeof arg1 !== 'number' || typeof arg2 !== 'number') {
        console.log("Erreur : les deux arguments doivent être des nombres.");
        return -99999999999999;
    }

    result = arg1 + arg2;
    console.log("La somme de", arg1, "et", arg2, "est égale à", result);
}

myFct2(23, 27);
myFct2(23, "27");

console.log(Separator);
console.log("Exo 6");
console.log(Separator);

function aprec(note) {
    if (note < 0 || note > 20) {
        return "BUG";
    }

    if (note < 7) {
        return "Hideux";
    }

    if (note > 7 && note < 10) {
        return "Moche";
    }

    if (note > 10 && note < 15) {
        return "Nice";
    }

    if (note > 15 && note < 20) {
        return "GG";
    }
}

console.log(aprec(5));
console.log(aprec(8));
console.log(aprec(12));
console.log(aprec(18));
console.log(aprec(25));

//let age = prompt("Quel est votre âge ?");
//age = parseInt(age);
//
//if (age >= 18) {
//    alert("Vous êtes majeur.");
//} else {
//    alert("Vous êtes mineur.");
//}

console.log(Separator);
console.log("Exo 7 - Les tableaux");
console.log(Separator);
