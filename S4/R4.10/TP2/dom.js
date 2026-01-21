// Exercice 1 : Recréer la structure HTML en JavaScript

const divTP1 = document.createElement('div');
divTP1.id = 'divTP1';

const textes = [
    'Le ',
    'World Wide Web Consortium',
    ', abrégé par le sigle ',
    'W3C',
    ', est un ',
    'organisme de standardisation',
    ' à but non-lucratif chargé de promouvoir la compatibilité des technologies du ',
    'World Wide Web',
    '.'
];

divTP1.appendChild(document.createTextNode(textes[0]));

const strong1 = document.createElement('strong');
strong1.textContent = textes[1];
divTP1.appendChild(strong1);

divTP1.appendChild(document.createTextNode(textes[2]));

const strong2 = document.createElement('strong');
strong2.textContent = textes[3];
divTP1.appendChild(strong2);

divTP1.appendChild(document.createTextNode(textes[4]));

const lien1 = document.createElement('a');
lien1.href = 'http://fr.wikipedia.org/wiki/Organisme_de_normalisation';
lien1.title = 'Organisme de normalisation';
lien1.textContent = textes[5];
divTP1.appendChild(lien1);

divTP1.appendChild(document.createTextNode(textes[6]));

const lien2 = document.createElement('a');
lien2.href = 'http://fr.wikipedia.org/wiki/World_Wide_Web';
lien2.title = 'World Wide Web';
lien2.textContent = textes[7];
divTP1.appendChild(lien2);

divTP1.appendChild(document.createTextNode(textes[8]));

document.body.appendChild(divTP1);

//Exercice 2 : Recréez en JS la structure suivante
const divTP2 = document.createElement('div');
divTP2.id = 'divTP2';

const textes2 = [
    'Langages basées sur ECMAScript : ',
    'JavaScript',
    'Jscript',
    'ActionScript',
    'Ex4'
];

const pTP2 = document.createElement('p');
pTP2.appendChild(document.createTextNode(textes2[0]));

const ulTP2 = document.createElement('ul');

for (let i = 1; i < textes2.length; i++) {
    const li = document.createElement('li');
    li.textContent = textes2[i];
    ulTP2.appendChild(li);
}

pTP2.appendChild(ulTP2);
divTP2.appendChild(pTP2);
document.body.appendChild(divTP2);

//Exercice 3 : Recréez en JS la structure suivante
const divTP3 = document.createElement('div');
divTP3.id = 'divTP3';

const textes3 = [
    'Langages basées sur ECMAScript : ',
    'JavaScript',
    'JavaScript est un langage de programmation de scripts principalement utilisé dans les pages web interactives mais aussi coté serveur.',
    'Jscript',
    'JScript est le nom générique de plusieurs implémentations d\'ECMAScript 3 créées par Microsoft',
    'ActionScript',
    'ActionScript est le langage de programmation utilisé au sein d\'applications clientes (Adobe Flash, Adobe Flex) et serveur (Flash media server, JRun, Macromedia Generator).',
    'Ex4',
    'ECMAScript for XML (E4X) est une extension XML au langage ECMAScript.',
];

const pTP3 = document.createElement('p');
pTP3.appendChild(document.createTextNode(textes3[0]));

const dlTP3 = document.createElement('dl');

for (let i = 1; i < textes3.length; i += 2) {
    const dt = document.createElement('dt');
    dt.textContent = textes3[i];
    dlTP3.appendChild(dt);
    const dd = document.createElement('dd');
    dd.textContent = textes3[i + 1];
    dlTP3.appendChild(dd);
}

pTP3.appendChild(dlTP3);
divTP3.appendChild(pTP3);
document.body.appendChild(divTP3);

//Exercice 4 : Recréez en JS la structure suivante
const divTP4 = document.createElement('div');
divTP4.id = 'divTP4';

const textes4 = [
    'Uploader une image',
    'Image à uploader : ',
    'Submit',
];

const formTP4 = document.createElement('form');
formTP4.method = 'post';
formTP4.enctype = 'multipart/form-data';
formTP4.action = 'upload.php';

const fieldset = document.createElement('fieldset');
const legend = document.createElement('legend');
legend.textContent = textes4[0];
fieldset.appendChild(legend);

const label = document.createElement('label');
label.textContent = textes4[1];
const inputFile = document.createElement('input');
inputFile.type = 'file';
inputFile.name = 'inputUpload';
inputFile.id = 'inputUpload';
label.appendChild(inputFile);
const br = document.createElement('br');
fieldset.appendChild(label);
fieldset.appendChild(br);
const inputSubmit = document.createElement('input');
inputSubmit.type = 'submit';
inputSubmit.value = textes4[2];
fieldset.appendChild(inputSubmit);
formTP4.appendChild(fieldset);
divTP4.appendChild(formTP4);
document.body.appendChild(divTP4);