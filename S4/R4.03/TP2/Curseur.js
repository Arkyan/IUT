let curseurVentes = db.sales.find({
    saleDate: {$gte: ISODate("2016-12-15"), $lt: ISODate("2016-12-18")}
});

while (curseurVentes.hasNext()) {

    let uneVente = curseurVentes.next();

    console.log(
        "Vente " + uneVente._id +
        " réalisée à " + uneVente.storeLocation +
        " achetée par " + uneVente.customer.email +
        " et notée " + uneVente.customer.satisfaction
    );

    let totalCommande = 0;

    for (let item of uneVente.items) {

        let montantLigne = item.price * item.quantity;
        totalCommande += montantLigne;

        console.log(
            "Article : " + item.name +
            " | Prix : " + item.price +
            " | Quantité : " + item.quantity +
            " | Montant ligne : " + montantLigne
        );
    }

    console.log("Total de la commande : " + totalCommande);
    console.log("----------------------------------");
}