<?php
try {
  $host = '127.0.0.1';
  $dbname = 'bibliotek';
  $user = 'root';
  $password = '';

  $pdo = new PDO("mysql:host=$host;dbname=$dbname", $user, $password);
} 
catch (Exception $e) 
{
  die('Erreur : ' .$e->getMessage());
}