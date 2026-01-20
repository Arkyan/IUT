<?php

namespace App\R301\Controller;
use App\R301\Model\User;
use App\R301\Model\Post;
use App\R301\Model\Comment;

class SearchController
{
  private $userModel;
  private $postModel;
  private $commentModel;

  public function __construct()
  {
    $this->userModel = new User();
    $this->postModel = new Post();
    $this->commentModel = new Comment();
  }

  public function liveSearch()
  {
    header('Content-Type: application/json');
    
    if (!isset($_GET['q']) || empty($_GET['q'])) {
      echo json_encode(['success' => false, 'message' => 'Aucune requête']);
      exit;
    }

    $query = trim($_GET['q']);
    $limit = isset($_GET['limit']) ? intval($_GET['limit']) : 5;

    $results = [
      'users' => [],
      'posts' => [],
      'comments' => []
    ];

    try {
      $users = $this->userModel->search($query, $limit);
      $results['users'] = $users ?: [];
    } catch (\Exception $e) {
      $results['users'] = [];
    }

    try {
      $posts = $this->postModel->search($query, $limit);
      $results['posts'] = $posts ?: [];
    } catch (\Exception $e) {
      $results['posts'] = [];
    }

    try {
      $comments = $this->commentModel->search($query, $limit);
      $results['comments'] = $comments ?: [];
    } catch (\Exception $e) {
      $results['comments'] = [];
    }

    echo json_encode([
      'success' => true,
      'results' => $results,
      'query' => $query
    ]);
    exit;
  }
}

