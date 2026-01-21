//Récupérer le contenu du input zipcode
const inputZipcode = document.getElementById('zipcode');
const cityDiv = document.getElementById('city');

//Avec http://api.zippopotam.us/FR/{zipcode}
//Afficher les villes dans le id city
inputZipcode.addEventListener('change', function () {
    const zipcode = inputZipcode.value;
    fetch(`http://api.zippopotam.us/FR/${zipcode}`)
        .then(response => response.json())
        .then(data => {
            cityDiv.innerHTML = '';
            data.places.forEach(place => {
                const option = document.createElement('option');
                option.value = place['place name'];
                option.textContent = place['place name'];
                cityDiv.appendChild(option);
            });
        })
        .catch(error => {
            cityDiv.innerHTML = '<option>Ville : Non trouvée</option>';
            console.error('Erreur : ', error);
        });
});
