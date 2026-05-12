db.movies.aggregate(
    [
        {
            $match: {
                _id: ObjectId("573a1396f29313caabce4a9a")
            }
        },
        {
            $lookup:
            {
                from: "comments",
                localField: "_id",
                foreignField: "movie_id",
                as: "Comments"
            }
        },
    ]
);

db.comments.aggregate(
    [
        {
            $match: {
                movie_id: ObjectId("573a1396f29313caabce4a9a")
            }
        },
        {
            $lookup:
            {
                from: "movies",
                localField: "movie_id",
                foreignField: "_id",
                as: "Comments"
            }
        },
    ]
);

db.comments.aggregate(
    [
        {
            $match: {
                movie_id: ObjectId("573a1396f29313caabce4a9a")
            }
        },
        {
            $lookup:
            {
                from: "movies",
                localField: "movie_id",
                foreignField: "_id",
                as: "Movie"
            }
        },
        {
            $unwind: "$Movie"
        },
    ]
);

db.users.aggregate([
    {
        $lookup: {
            from: "comments",
            localField: "email",
            foreignField: "email",
            as: "user_comments"
        }
    },
    {
        $match: {
            "user_comments.0": { $exists: true }
        }
    }
])

db.movies.aggregate(
    [
        {
            $match: {
                year: 2010,
                "imdb.rating": { $gte: 7 }
            }
        },
        {
            $lookup:
            {
                from: "comments",
                localField: "_id",
                foreignField: "movie_id",
                as: "Com"
            }
        },
        {
            $project: {
                "Com.email": 1
            }
        }
    ]
);

db.movies.aggregate([
    {
        $match: {
            year: { $lt: 1920 }
        }
    },
    {
        $lookup: {
            from: "comments",
            localField: "_id",
            foreignField: "movie_id",
            as: "Commentaires"
        }
    },
    {
        $project: {
            _id: 0,
            title: 1,
            year: 1,
            nbrCommentaires: { $size: "$Commentaires" }
        }
    },
    {
        $sort: {
            nbrCommentaires: -1
        }
    }
])

db.comments.aggregate([
    {
        $group: {
            _id: "$email",
            nbrCommentaires: { $sum: 1 }
        }
    },
    {
        $lookup: {
            from: "users",
            localField: "_id",
            foreignField: "email",
            as: "user"
        }
    },
    {
        $unwind: "$user"
    },
    {
        $project: {
            _id: 0,
            email: "$_id",
            name: "$user.name",
            nbrCommentaires: 1
        }
    }
])

