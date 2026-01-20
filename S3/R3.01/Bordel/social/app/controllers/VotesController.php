<?php

namespace App\R301\Controller;

use App\R301\Model\CommentLikes;

class VotesController
{
    public function toggleVote()
    {
        header('Content-Type: application/json');
        
        if (!isset($_SESSION['id'])) {
            http_response_code(401);
            echo json_encode(['error' => 'Non authentifié']);
            exit;
        }

        $data = json_decode(file_get_contents("php://input"), true);
        
        if (!isset($data['comment_id']) || !isset($data['vote_type'])) {
            http_response_code(400);
            echo json_encode(['error' => 'Données manquantes']);
            exit;
        }

        $comment_id = $data['comment_id'];
        $vote_type = $data['vote_type'];
        $utilisateur_id = $_SESSION['id'];

        if (!in_array($vote_type, ['up', 'down'])) {
            http_response_code(400);
            echo json_encode(['error' => 'Type de vote invalide']);
            exit;
        }

        $commentLikesModel = new CommentLikes();

        $existingVote = $commentLikesModel->findBy([
            'comment_id' => $comment_id,
            'utilisateur_id' => $utilisateur_id
        ]);

        $currentVote = null;

        if (!empty($existingVote)) {
            if ($existingVote[0]['vote_type'] === $vote_type) {
                $commentLikesModel->delete($existingVote[0]['id']);
                $currentVote = null;
            } else {
                $date_vote = date('Y-m-d H:i:s');
                $commentLikesModel->update($existingVote[0]['id'], $utilisateur_id, $comment_id, $vote_type, $date_vote);
                $currentVote = $vote_type;
            }
        } else {
            $date_vote = date('Y-m-d H:i:s');
            $commentLikesModel->add($utilisateur_id, $comment_id, $vote_type, $date_vote);
            $currentVote = $vote_type;
        }

        $upvotes = count($commentLikesModel->findBy(['comment_id' => $comment_id, 'vote_type' => 'up']));
        $downvotes = count($commentLikesModel->findBy(['comment_id' => $comment_id, 'vote_type' => 'down']));

        echo json_encode([
            'success' => true,
            'currentVote' => $currentVote,
            'upvotes' => $upvotes,
            'downvotes' => $downvotes,
            'score' => $upvotes - $downvotes
        ]);
        exit;
    }

    public function getVoteCount()
    {
        header('Content-Type: application/json');
        
        if (!isset($_GET['comment_id'])) {
            http_response_code(400);
            echo json_encode(['error' => 'Comment ID manquant']);
            exit;
        }

        $comment_id = $_GET['comment_id'];
        $commentLikesModel = new CommentLikes();
        
        $upvotes = count($commentLikesModel->findBy(['comment_id' => $comment_id, 'vote_type' => 'up']));
        $downvotes = count($commentLikesModel->findBy(['comment_id' => $comment_id, 'vote_type' => 'down']));

        $currentVote = null;
        if (isset($_SESSION['id'])) {
            $userVote = $commentLikesModel->findBy([
                'comment_id' => $comment_id,
                'utilisateur_id' => $_SESSION['id']
            ]);
            if (!empty($userVote)) {
                $currentVote = $userVote[0]['vote_type'];
            }
        }

        echo json_encode([
            'upvotes' => $upvotes,
            'downvotes' => $downvotes,
            'score' => $upvotes - $downvotes,
            'currentVote' => $currentVote
        ]);
        exit;
    }
}
