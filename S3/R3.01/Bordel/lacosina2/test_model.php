<?php
require 'vendor/autoload.php';

use App\R301\Model\Recette;

$model = new Recette();

echo "Testing findAll:\n";
$all = $model->findAll();
echo "Count all: " . count($all) . "\n";
if (count($all) > 0) {
    echo "First recipe type: " . $all[0]['type_plat'] . "\n";
}

echo "\nTesting findBy type_plat='entree':\n";
$entrees = $model->findBy(['type_plat' => 'entree']);
echo "Count entrees: " . count($entrees) . "\n";

echo "\nTesting findBy type_plat='plat':\n";
$plats = $model->findBy(['type_plat' => 'plat']);
echo "Count plats: " . count($plats) . "\n";

echo "\nTesting findBy type_plat='dessert':\n";
$desserts = $model->findBy(['type_plat' => 'dessert']);
echo "Count desserts: " . count($desserts) . "\n";
