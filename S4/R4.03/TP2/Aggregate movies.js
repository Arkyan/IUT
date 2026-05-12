db.movies.aggregate(
    [
        {
            $match: {
                genres : "Action"
            } 
        },
        {
            $group: {
                _id: "$countries",
                nbrFilms: { $sum : 1}
            }
        }
    ]
);

db.movies.aggregate(
    [
        {
            $match: {
                genres : "Action"
            } 
        },
        {
            $unwind: "$countries"
        },
        {
            $group: {
                _id: "$countries",
                nbrFilms: { $sum : 1}
            }
        }
    ]
);
