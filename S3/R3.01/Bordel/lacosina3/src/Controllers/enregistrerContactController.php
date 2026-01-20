<?php

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

require 'vendor/phpmailer/phpmailer/src/Exception.php';
require 'vendor/phpmailer/phpmailer/src/PHPMailer.php';
require 'vendor/phpmailer/phpmailer/src/SMTP.php';

$nom = $_POST['nom'] ?? '';
$email = $_POST['email'] ?? '';
$description = $_POST['description'] ?? '';

/** @var PDO $pdo */
$requete = $pdo->prepare("INSERT INTO contact (nom, email, description) VALUES (:nom, :email, :description)");
$requete->bindParam(':nom', $nom);
$requete->bindParam(':email', $email);
$requete->bindParam(':description', $description);

$ajoutOk = $requete->execute();

$mail = new PHPMailer(true);

try {
    // Configuration du serveur SMTP
    $mail->isSMTP();
    $mail->CharSet = 'UTF-8';
    $mail->Encoding = 'base64';
    $mail->Host = 'ssl0.ovh.net';
    $mail->SMTPAuth = true;
    $mail->Username = 'EMAIL'; // Votre adresse email OVH
    $mail->Password = "MDP"; // Votre mot de passe email
    $mail->SMTPSecure = PHPMailer::ENCRYPTION_SMTPS;
    $mail->Port = 465;

    // Envoyer un email à vous-même
    $mail->addAddress($email, $nom); // L'adresse email de l'utilisateur
    $mail->setFrom('EMAIL', 'EMAIL'); // Votre adresse email OVH
    $mail->isHTML(false);
    $mail->Subject = "Nouveau message de $nom";
    $mail->Body = $message;
    $mail->send();
} catch (Exception $e) {
    echo "Le message n'a pas pu être envoyé. Erreur du Mailer: {$mail->ErrorInfo}";
}

if ($ajoutOk) {
    require_once __DIR__ . DIRECTORY_SEPARATOR . '..' . DIRECTORY_SEPARATOR . 'Views' . DIRECTORY_SEPARATOR . 'recette' . DIRECTORY_SEPARATOR . 'enregistrer.php';
} else {
    echo "Erreur lors de l'enregistrement de la recette.";
}
