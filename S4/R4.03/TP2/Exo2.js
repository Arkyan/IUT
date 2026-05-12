db.movies.distinct('genres');

db.movies.distinct("countries");

db.movies.find({
    "countries" : "France",
    "released" :{$gte:ISODate("1997-01-01"),$lt:ISODate("1997-12-31")},
    "awards.wins" : {$gte: 2}
})

db.movies.find({
    "imdb.rating": {$lte : 2},
    "awards.wins" : {$gte: 1}
}).projection({
    "title" : true,
    "countries" : true,
    "year" : true,
    "imdb.rating": true,
    "awards.wins": true
})

db.movies.find({
    "tomatoes.critic.rating": {$gte : 9},
    "imdb.rating": {$lte : 4}
})

db.movies.distinct("languages")

db.movies.find({
  $and: [
    { languages: { $all: ["French", "Portuguese"] } },
    { languages: { $nin: ["German", "Spanish"] } }
  ]
})

db.movies.find({
    "type" : "series",
    "released" : {$gte:ISODate("1990-01-01")},
    "countries" : "France"
})

db.movies.find({
    "tomatoes.critic.rating" : {$eq : 0},
    "awards.nominations": {$gte : 6},
    "awards.wins": {$gte : 2}
})

db.movies.find({
  "countries": {$nin: ["USA"]},
  "released" : {$lte:ISODate("1935-01-01")},
}).sort({"imdb.rating" : -1})