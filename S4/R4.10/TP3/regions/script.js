const path = "https://geo.api.gouv.fr";
const regList = document.getElementById("regions");
const dptList = document.getElementById("departements");
const cityList = document.getElementById("villes");
const cityDetails = document.getElementById("cityDetails");

const displayError = (message, type = "alert") => {
  alert.log(message, type);
};

/**
 *
 * Mise à jour du compteur des listes
 * @param {*} list
 * @param {*} value
 */
const setCounter = (list, value) => {
  list.parentElement.parentElement.querySelector(".counter").innerText = value;
};

/**
 * Affichage des infos de la commune survolée
 * @param {*} e
 */
const displayInfo = (e) => {
  //Maj du contenu
  const elt = e.target;
  cityDetails.innerHTML = `<h2 class="border-b-2 border-gray-500  ">${elt.innerText
    }</h2><p class="text-sm text-gray-500">Population : ${elt.getAttribute(
      "elt-population"
    )}<br>Surface : ${elt.getAttribute("elt-surface")}</p>`;

  //Positionnement
  cityDetails.style.left =
    e.target.offsetLeft + e.target.offsetWidth - cityDetails.offsetWidth + "px";
  cityDetails.style.top = e.target.offsetTop - 10 + "px";
  cityDetails.style.display = "block";
};

/**
 * Fonction de changement du style d'un item sélectionné dans une liste
 * @param {*} e
 */
const setItemStatus = (e) => {
  const style = "bg-slate-100";
  //On désactive les autres régions actives
  const parentList = e.target.parentElement;
  const oldActive = parentList.querySelectorAll(`.${style}`);
  [...oldActive].forEach((element) => element.classList.remove(style));

  e.target.classList.add(style); //On modifie l'élement sélectionné
};

//Récupération des régions
fetch(`${path}/regions`)
  .then((response) => response.json())
  .then((data) => {
    // Trier les régions par code
    data.sort((a, b) => a.code.localeCompare(b.code));
    
    data.forEach((region) => {
      const li = document.createElement("li");
      li.className = "py-2 hover:bg-slate-50 cursor-pointer px-2";
      li.innerText = `${region.code} : ${region.nom}`;
      li.setAttribute("elt-code", region.code);
      //Ajout de l'évènement de sélection
      li.addEventListener("click", (e) => {
        setItemStatus(e);
        //Récupération des départements de la région
        fetch(`${path}/regions/${region.code}/departements`)
          .then((response) => response.json())
          .then((data) => {
            //Vider la liste des départements
            dptList.innerHTML = "";
            cityList.innerHTML = "";
            setCounter(dptList, 0); //Reset compteur
            setCounter(cityList, 0);
            data.forEach((dpt) => {
              const dptLi = document.createElement("li");
              dptLi.className = "py-2 hover:bg-slate-50 cursor-pointer px-2";
              dptLi.innerText = `${dpt.code} : ${dpt.nom}`;
              dptLi.setAttribute("elt-code", dpt.code);
              //Ajout de l'évènement de sélection
              dptLi.addEventListener("click", (e) => {
                setItemStatus(e);
                //Récupération des communes du département
                fetch(`${path}/departements/${dpt.code}/communes?fields=code,nom,population,surface`)
                  .then((response) => response.json())
                  .then((data) => {
                    //Vider la liste des communes
                    cityList.innerHTML = "";
                    setCounter(cityList, 0); //Reset compteur
                    data.forEach((city) => {
                      const cityLi = document.createElement("li");
                      cityLi.className = "py-2 hover:bg-slate-50 cursor-pointer px-2";
                      cityLi.innerText = `${city.code} : ${city.nom}`;
                      cityLi.setAttribute("elt-population", city.population);
                      cityLi.setAttribute("elt-surface", city.surface);
                      //Ajout de l'évènement d'affichage des infos
                      cityLi.addEventListener("mouseover", displayInfo);
                      cityLi.addEventListener("mouseout", () => {
                        cityDetails.style.display = "none";
                      });
                      cityList.appendChild(cityLi);
                    });
                    setCounter(cityList, data.length);
                  })
                  .catch((error) => {
                    displayError(
                      "Erreur lors de la récupération des communes : " +
                      error.message
                    );
                  });
              });
              dptList.appendChild(dptLi);
            });
            setCounter(dptList, data.length);
          })
          .catch((error) => {
            displayError(
              "Erreur lors de la récupération des départements : " +
              error.message
            );
          });
      });
      regList.appendChild(li);
    });
    setCounter(regList, data.length);
  })
  .catch((error) => {
    displayError(
      "Erreur lors de la récupération des régions : " + error.message
    );
  });
