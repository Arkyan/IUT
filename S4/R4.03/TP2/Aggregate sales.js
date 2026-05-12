db.sales.aggregate(
    [
        {
            $match: {
                "couponUsed": true
            } 
        },
        {
            $group: {
                _id: "$storeLocation", 
                nbreVentes: { $sum: 1 },
            }
        }
    ]
);

db.sales.aggregate(
    [
        {
            $match: {
            } 
        },
        {
            $group: {
                _id: "$storeLocation",
                avgSatisfaction : {$avg: "$customer.satisfaction"}
            }
        }
    ]
);

db.sales.aggregate(
    [
        {
            $match: {
                
            } 
        },
        {
            $group: {
                _id: {"StoreLocation : ""$storeLocation", "PurchaseMethod" : "$purchaseMethod"}
                avgSatisfaction : {$avg: "$customer.satisfaction"}
                
            }
        }
    ]
);



