db.sales.find({
    "purchaseMethod" : "Phone"
})

db.sales.find({
    "purchaseMethod" : "In store",
    "couponUsed" : true
})

db.sales.find({
    "customer.age":{$gte:65},
})

db.sales.find({
    "purchaseMethod" : "Online",
    "customer.satisfaction" :{$gte:4},
})
.sort({"customer.satisfaction" : -1})

db.sales.find({
    $and: [{"customer.gender" : {$ne: "F"}}, {"customer.gender" : {$ne: "M"}}]
})

db.sales.distinct("storeLocation")

db.sales.find({
    items : {$elemMatch: {"name":"laptop", "price":{$gte: 1595}}}
}).
projection({
    "customer.email" :true,
    "saleDate":true,
    "items" :true,
});

db.sales.find({
    $and:[{items : {$elemMatch: {"name":"laptop", "price":{$gte: 1550}}}}, {items : {$elemMatch: {"name":"backpack", "price":{$gte: 180}}}}]
}).
projection({
    "customer.email" :true,
    "saleDate":true,
    "items" :true,
});

