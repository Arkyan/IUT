<?php
try {
  $host = '127.0.0.1';
  $dbname = 'lacosina';
  $user = 'root';
  $password = '';

  $pdo = new PDO("mysql:host=$host;dbname=$dbname", $user, $password);
} 
catch (Exception $e) 
{
  // En cas d'erreur, on affiche un message et on arrete le script
  die('Erreur : ' .$e->getMessage());
}

