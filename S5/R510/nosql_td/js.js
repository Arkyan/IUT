///////////////////
//1.1 : Insertions 
///////////////////
//3) Document JSON
//Utilisateur 
{
  _id: ObjectId("65a1f2c3e4b0a1b2c3d4e5f6"),
  nom: "Marie Dubois",
  email: "marie.dubois@example.com",
  bio: "Passionnée de trail et de vélo de route, je cours 4 fois par semaine.",
  dateInscription: ISODate("2024-03-15T10:00:00Z"),
  equipements: [
    {
      nom: "Nimbus 2000",
      categorie: "chaussures",
      dateAchat: ISODate("2025-06-01T00:00:00Z")
    },
    {
      nom: "BTWIN Q7",
      categorie: "velo",
      dateAchat: ISODate("2023-11-20T00:00:00Z")
    },
    {
      nom: "Garminne Forerunner 965",
      categorie: "montre",
      dateAchat: ISODate("2024-01-10T00:00:00Z")
    }
  ]
}

//Une activité de course à pied de 10km avec 2 commentaires
{
  _id: ObjectId("65a1f2c3e4b0a1b2c3d4e600"),
  user_id: ObjectId("65a1f2c3e4b0a1b2c3d4e5f6"),
  type: "course_a_pied",
  date: ISODate("2026-09-15T07:30:00Z"),
  distance: 10.2,
  duree: 3500,
  allureMoyenne: "5:06",
  parcours: {
    depart: {
      type: "Point",
      coordinates: [43.56872057829341, 1.585009859184221]
    },
    nom: "Parc de la Bâtie"
  },
  commentaires: [
    {
      _id: ObjectId("65a1f2c3e4b0a1b2c3d4e601"),
      user_id: ObjectId("65a1f2c3e4b0a1b2c3d4e601"),
      auteur: "Lucas Martin",
      texte: "Belle allure sur ce parcours, bravo bel homme !",
      date: ISODate("2026-09-15T08:15:00Z")
    },
    {
      _id: ObjectId("65a1f2c3e4b0a1b2c3d4e602"),
      user_id: ObjectId("65a1f2c3e4b0a1b2c3d4e602"),
      auteur: "Sophie Renard",
      texte: "On se fait la même la semaine prochaine ?",
      date: ISODate("2026-09-15T09:02:00Z")
    }
  ]
}


///////////////////
//2.1 : Insertions 
///////////////////
db.utilisateurs.insertMany([
  {
    _id: ObjectId("65a1f2c3e4b0a1b2c3d4e5f6"),
    nom: "Marie Dubois",
    email: "marie.dubois@example.com",
    bio: "Passionnée de trail et de vélo de route.",
    dateInscription: ISODate("2024-03-15T10:00:00Z"),
    equipements: [
      { nom: "Nike Pegasus 40", categorie: "chaussures" },
      { nom: "Specialized Tarmac SL7", categorie: "velo" }
    ]
  },
  {
    _id: ObjectId("65a1f2c3e4b0a1b2c3d4e5f7"),
    nom: "Lucas Martin",
    email: "lucas.martin@example.com",
    bio: "Nageur amateur, triathlon les week-ends.",
    dateInscription: ISODate("2024-05-02T09:00:00Z"),
    equipements: [
      { nom: "Combinaison Zone3", categorie: "natation" }
    ]
  },
  {
    _id: ObjectId("65a1f2c3e4b0a1b2c3d4e5f8"),
    nom: "Sophie Renard",
    email: "sophie.renard@example.com",
    bio: "Course à pied et randonnée en montagne.",
    dateInscription: ISODate("2024-01-20T14:30:00Z"),
    equipements: [
      { nom: "Garmin Forerunner 965", categorie: "montre" }
    ]
  }
])

db.activites.insertMany([
  // Marie (3 activités)
  {
    user_id: ObjectId("65a1f2c3e4b0a1b2c3d4e5f6"),
    type: "course_a_pied",
    date: ISODate("2026-09-15T07:30:00Z"),
    distance: 10.2,
    duree: 3120,
    parcours: { depart: { type: "Point", coordinates: [0.3403, 45.8836] } },
    commentaires: []
  },
  {
    user_id: ObjectId("65a1f2c3e4b0a1b2c3d4e5f6"),
    type: "velo",
    date: ISODate("2026-09-12T15:00:00Z"),
    distance: 45.0,
    duree: 5400,
    parcours: { depart: { type: "Point", coordinates: [0.3500, 45.8900] } },
    commentaires: []
  },
  {
    user_id: ObjectId("65a1f2c3e4b0a1b2c3d4e5f6"),
    type: "course_a_pied",
    date: ISODate("2026-09-08T06:45:00Z"),
    distance: 6.5,
    duree: 2100,
    parcours: { depart: { type: "Point", coordinates: [0.3403, 45.8836] } },
    commentaires: []
  },
  // Lucas (3 activités)
  {
    user_id: ObjectId("65a1f2c3e4b0a1b2c3d4e5f7"),
    type: "natation",
    date: ISODate("2026-09-14T18:00:00Z"),
    distance: 2.0,
    duree: 2400,
    parcours: { depart: { type: "Point", coordinates: [0.3600, 45.8700] } },
    commentaires: []
  },
  {
    user_id: ObjectId("65a1f2c3e4b0a1b2c3d4e5f7"),
    type: "velo",
    date: ISODate("2026-09-10T08:00:00Z"),
    distance: 30.0,
    duree: 3900,
    parcours: { depart: { type: "Point", coordinates: [0.3450, 45.8800] } },
    commentaires: []
  },
  {
    user_id: ObjectId("65a1f2c3e4b0a1b2c3d4e5f7"),
    type: "course_a_pied",
    date: ISODate("2026-09-05T07:00:00Z"),
    distance: 8.0,
    duree: 2700,
    parcours: { depart: { type: "Point", coordinates: [0.3403, 45.8836] } },
    commentaires: []
  },
  // Sophie (4 activités)
  {
    user_id: ObjectId("65a1f2c3e4b0a1b2c3d4e5f8"),
    type: "course_a_pied",
    date: ISODate("2026-09-16T07:15:00Z"),
    distance: 12.0,
    duree: 3600,
    parcours: { depart: { type: "Point", coordinates: [0.3403, 45.8836] } },
    commentaires: [
      { user_id: ObjectId("65a1f2c3e4b0a1b2c3d4e5f6"), auteur: "Marie Dubois", texte: "Bravo !", date: ISODate("2026-09-16T08:00:00Z") },
      { user_id: ObjectId("65a1f2c3e4b0a1b2c3d4e5f7"), auteur: "Lucas Martin", texte: "Belle perf.", date: ISODate("2026-09-16T08:10:00Z") }
    ]
  },
  {
    user_id: ObjectId("65a1f2c3e4b0a1b2c3d4e5f8"),
    type: "randonnee",
    date: ISODate("2026-09-13T09:00:00Z"),
    distance: 18.0,
    duree: 14400,
    parcours: { depart: { type: "Point", coordinates: [0.3700, 45.9000] } },
    commentaires: []
  },
  {
    user_id: ObjectId("65a1f2c3e4b0a1b2c3d4e5f8"),
    type: "course_a_pied",
    date: ISODate("2026-09-09T06:30:00Z"),
    distance: 5.5,
    duree: 1800,
    parcours: { depart: { type: "Point", coordinates: [0.3403, 45.8836] } },
    commentaires: []
  },
  {
    user_id: ObjectId("65a1f2c3e4b0a1b2c3d4e5f8"),
    type: "velo",
    date: ISODate("2026-09-03T14:00:00Z"),
    distance: 22.0,
    duree: 3300,
    parcours: { depart: { type: "Point", coordinates: [0.3550, 45.8850] } },
    commentaires: []
  }
])

///////////////////
//2.2 : Requetes de bases 
///////////////////
// a) Afficher toutes les activités d'un utilisateur donné, triées par date décroissante
db.activites.find({ user_id: ObjectId("65a1f2c3e4b0a1b2c3d4e5f6") })
            .sort({ date: -1 })

// b) Afficher les activités de type "course_a_pied" de plus de 5 km
db.activites.find({type: "course_a_pied", distance: { $gt: 5 }})

// c) Ajouter un commentaire à une activité existante ($push)
db.activites.updateOne(
  { _id: ObjectId("65a1f2c3e4b0a1b2c3d4e600") },
  {
    $push: {
      commentaires: {
        user_id: ObjectId("65a1f2c3e4b0a1b2c3d4e5f8"),
        auteur: "Sophie Renard",
        texte: "On se fait la même la semaine prochaine ?",
        date: new Date()
      }
    }
  }
)

// d) Calculer la distance totale parcourue par un utilisateur (agrégation $group)
db.activites.aggregate([
  { $match: { user_id: ObjectId("65a1f2c3e4b0a1b2c3d4e5f6") } },
  { $group: {
      _id: "$user_id",
      distanceTotale: { $sum: "$distance" }
  }}
])

// e) Afficher le nombre d'activités par type de sport (agrégation $group + $sum)
db.activites.aggregate([
  { $group: {
      _id: "$type",
      nombreActivites: { $sum: 1 }
  }}
])

///////////////////
//3.1 : Analyse sans index 
///////////////////

//Analyse sans index 
db.activites.find({ user_id: ObjectId("65a1f2c3e4b0a1b2c3d4e5f6") })
            .sort({ date: -1 })
            .explain("executionStats")


///////////////////
//3.2 : Création d'index et comparaison
///////////////////

//a) Index pour la requête a)
db.activites.createIndex({ user_id: 1, date: -1 })
//user_id en premier car c'est un filtre d'égalité ($eq) 
//date en second, avec l'ordre -1, car c'est le champ de tri 
//Mettre date en premier serait inefficace : l'index balaierait toutes les dates sans pouvoir filtrer efficacement par utilisateur en même temps

//b) Meme requete réexecuter
db.activites.find({ user_id: ObjectId("65a1f2c3e4b0a1b2c3d4e5f6") })
            .sort({ date: -1 })
            .explain("executionStats")

//c) Index géospatial 2dsphere + requête de proximité
db.activites.createIndex({ "parcours.depart": "2dsphere" })

db.activites.aggregate([
  {
    $geoNear: {
      near: { type: "Point", coordinates: [0.3403, 45.8836] },
      distanceField: "distanceDepart",
      maxDistance: 5000,
      spherical: true
    }
  }
])