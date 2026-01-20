let notificationInterval;
let notificationDropdownOpen = false;

document.addEventListener('DOMContentLoaded', function() {
    initializeNotifications();
    
    const notificationBtn = document.getElementById('notificationBtn');
    if (notificationBtn) {
        notificationBtn.addEventListener('click', function(e) {
            e.preventDefault();
            toggleNotificationDropdown();
        });
    }
    
    const markAllReadBtn = document.getElementById('markAllReadBtn');
    if (markAllReadBtn) {
        markAllReadBtn.addEventListener('click', function(e) {
            e.preventDefault();
            markAllNotificationsAsRead();
        });
    }
    
    document.addEventListener('click', function(e) {
        const notificationDropdown = document.getElementById('notificationDropdown');
        const notificationBtn = document.getElementById('notificationBtn');
        
        if (notificationDropdown && notificationBtn) {
            if (!notificationDropdown.contains(e.target) && !notificationBtn.contains(e.target)) {
                notificationDropdown.classList.remove('show');
                notificationDropdownOpen = false;
            }
        }
    });
});

function initializeNotifications() {
    updateNotificationCount();
    
    notificationInterval = setInterval(function() {
        updateNotificationCount();
        
        if (notificationDropdownOpen) {
            loadNotifications();
        }
    }, 10000); 
}

function updateNotificationCount() {
    fetch('?c=notification&a=getUnreadCount', {
        method: 'GET',
        headers: {
            'Content-Type': 'application/json'
        }
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('Erreur réseau');
        }
        return response.json();
    })
    .then(data => {
        const badge = document.getElementById('notificationBadge');
        if (badge) {
            if (data.count > 0) {
                badge.textContent = data.count > 99 ? '99+' : data.count;
                badge.style.display = 'inline-block';
                badge.classList.add('pulse');
            } else {
                badge.style.display = 'none';
                badge.classList.remove('pulse');
            }
        }
    })
    .catch(error => console.error('Erreur lors de la récupération du compte:', error));
}

function toggleNotificationDropdown() {
    const dropdown = document.getElementById('notificationDropdown');
    if (!dropdown) return;
    
    notificationDropdownOpen = !notificationDropdownOpen;
    
    if (notificationDropdownOpen) {
        dropdown.classList.add('show');
        loadNotifications();
    } else {
        dropdown.classList.remove('show');
    }
}

function loadNotifications() {
    fetch('?c=notification&a=getNotifications&limit=10', {
        method: 'GET',
        headers: {
            'Content-Type': 'application/json'
        }
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('Erreur réseau');
        }
        return response.json();
    })
    .then(data => {
        displayNotifications(data.notifications);
    })
    .catch(error => console.error('Erreur lors du chargement des notifications:', error));
}

function displayNotifications(notifications) {
    const container = document.getElementById('notificationList');
    if (!container) return;
    
    if (notifications.length === 0) {
        container.innerHTML = `
            <div class="dropdown-item text-center text-muted py-3">
                <i class="bi bi-bell-slash"></i> Aucune notification
            </div>
        `;
        return;
    }
    
    container.innerHTML = notifications.map(notification => {
        const isUnread = notification.isRead == 0;
        const unreadClass = isUnread ? 'bg-light' : '';
        const unreadBadge = isUnread ? '<span class="badge bg-primary ms-2">Nouveau</span>' : '';
        
        return `
            <div class="dropdown-item ${unreadClass} notification-item p-3" data-notification-id="${notification.id}" ${isUnread ? 'onclick="markNotificationAsRead(' + notification.id + ')"' : ''} style="cursor: pointer; min-height: auto;">
                <div class="d-flex align-items-start gap-2">
                    <i class="bi bi-bell-fill text-primary flex-shrink-0 mt-1"></i>
                    <div class="flex-grow-1 min-width-0">
                        <p class="mb-1 small text-break">${escapeHtml(notification.message)} ${unreadBadge}</p>
                        <small class="text-muted d-block">${formatDate(notification.date_notification)}</small>
                    </div>
                </div>
            </div>
        `;
    }).join('');
}

function markNotificationAsRead(notificationId) {
    fetch('?c=notification&a=markAsRead', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            notification_id: notificationId
        })
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            updateNotificationCount();
            loadNotifications();
        }
    })
    .catch(error => console.error('Erreur:', error));
}

function markAllNotificationsAsRead() {
    fetch('?c=notification&a=markAllAsRead', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        }
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            updateNotificationCount();
            loadNotifications();
            
            // Feedback visuel
            const btn = document.getElementById('markAllReadBtn');
            if (btn) {
                const originalText = btn.innerHTML;
                btn.innerHTML = '<i class="bi bi-check-lg"></i> Marquées';
                btn.classList.add('btn-success');
                btn.classList.remove('btn-outline-secondary');
                
                setTimeout(() => {
                    btn.innerHTML = originalText;
                    btn.classList.remove('btn-success');
                    btn.classList.add('btn-outline-secondary');
                }, 2000);
            }
        }
    })
    .catch(error => console.error('Erreur:', error));
}

function formatDate(dateString) {
    const date = new Date(dateString);
    const now = new Date();
    const diffMs = now - date;
    const diffMins = Math.floor(diffMs / 60000);
    
    if (diffMins < 1) return 'À l\'instant';
    if (diffMins < 60) return `Il y a ${diffMins} min`;
    
    const diffHours = Math.floor(diffMins / 60);
    if (diffHours < 24) return `Il y a ${diffHours}h`;
    
    const diffDays = Math.floor(diffHours / 24);
    if (diffDays < 7) return `Il y a ${diffDays}j`;
    
    const options = { 
        year: 'numeric', 
        month: '2-digit', 
        day: '2-digit',
        hour: '2-digit',
        minute: '2-digit'
    };
    return date.toLocaleDateString('fr-FR', options);
}

function escapeHtml(text) {
    const div = document.createElement('div');
    div.textContent = text;
    return div.innerHTML;
}

window.addEventListener('beforeunload', function() {
    if (notificationInterval) {
        clearInterval(notificationInterval);
    }
});
