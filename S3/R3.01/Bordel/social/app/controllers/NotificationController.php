<?php
namespace App\R301\Controller;
use App\R301\Model\Notification;

class NotificationController
{
    private $notificationModel;

    public function __construct()
    {
        $this->notificationModel = new Notification();
    }

    public function getUnreadCount()
    {
        header('Content-Type: application/json');
        
        if (!isset($_SESSION['id'])) {
            echo json_encode(['count' => 0]);
            exit;
        }

        $count = $this->notificationModel->countUnreadByUserId($_SESSION['id']);
        echo json_encode(['count' => (int)$count]);
        exit;
    }

    public function getNotifications()
    {
        header('Content-Type: application/json');
        
        if (!isset($_SESSION['id'])) {
            http_response_code(401);
            echo json_encode(['error' => 'Non authentifié']);
            exit;
        }

        $limit = isset($_GET['limit']) ? (int)$_GET['limit'] : 10;
        $notifications = $this->notificationModel->findByUserId($_SESSION['id'], $limit);
        
        foreach ($notifications as &$notif) {
            if (empty($notif['message']) || $notif['message'] == 0) {
                $notif['message'] = '(Message vide)';
            }
            if (empty($notif['date_notification'])) {
                $notif['date_notification'] = date('Y-m-d H:i:s');
            }
        }
        
        echo json_encode([
            'success' => true,
            'notifications' => $notifications
        ]);
        exit;
    }

    public function markAsRead()
    {
        header('Content-Type: application/json');
        
        if (!isset($_SESSION['id'])) {
            http_response_code(401);
            echo json_encode(['error' => 'Non authentifié']);
            exit;
        }

        $data = json_decode(file_get_contents("php://input"), true);
        
        if (!isset($data['notification_id'])) {
            http_response_code(400);
            echo json_encode(['error' => 'ID de notification manquant']);
            exit;
        }

        $notification = $this->notificationModel->find($data['notification_id']);
        
        if (!$notification || $notification['utilisateur_id'] != $_SESSION['id']) {
            http_response_code(403);
            echo json_encode(['error' => 'Accès non autorisé']);
            exit;
        }

        $success = $this->notificationModel->markAsRead($data['notification_id']);
        
        echo json_encode([
            'success' => $success,
            'message' => 'Notification marquée comme lue'
        ]);
        exit;
    }

    public function markAllAsRead()
    {
        header('Content-Type: application/json');
        
        if (!isset($_SESSION['id'])) {
            http_response_code(401);
            echo json_encode(['error' => 'Non authentifié']);
            exit;
        }

        $success = $this->notificationModel->markAllAsReadByUserId($_SESSION['id']);
        
        echo json_encode([
            'success' => $success,
            'message' => 'Toutes les notifications ont été marquées comme lues'
        ]);
        exit;
    }
}
