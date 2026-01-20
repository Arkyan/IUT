document.addEventListener('DOMContentLoaded', () => {

    const USER_ID = (typeof user_id !== 'undefined') ? user_id : null;

    document.querySelectorAll('.btn-like').forEach(button => {
        button.addEventListener('click', async (e) => {
            e.preventDefault();

            const btn = e.target.closest('.btn-like');
            const postId = btn.dataset.id;
            const countSpan = document.getElementById(`like-count-${postId}`);

            if (!postId) return;

            try {
                const response = await fetch('index.php?page=ajax&action=like_post', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ post_id: postId })
                });

                const data = await response.json();

                let currentCount = parseInt(countSpan.innerText);
                if (isNaN(currentCount)) currentCount = 0;

                if (data.status === 'liked') {
                    btn.textContent = '❤️ Je n\'aime plus';
                    btn.style.color = 'blue';
                    currentCount++;
                } else if (data.status === 'unliked') {
                    btn.textContent = '🤍 J\'aime';
                    btn.style.color = 'black';
                    currentCount = Math.max(0, currentCount - 1);
                }

                countSpan.innerText = `${currentCount} Like(s)`;

            } catch (error) {
                console.error("Like error:", error);
            }
        });
    });

    document.querySelectorAll('.form-comment').forEach(form => {
        form.addEventListener('submit', async (e) => {
            e.preventDefault();
            const input = form.querySelector('input[name="contenu"]');
            const postId = form.querySelector('input[name="post_id"]').value;
            const container = document.getElementById(`comments-post-${postId}`);

            const response = await fetch('index.php?page=ajax&action=add_comment', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ post_id: postId, contenu: input.value })
            });
            const data = await response.json();

            if (data.status === 'success') {
                const div = document.createElement('div');
                div.className = 'comment-container';
                div.id = `comment-container-${data.comment_id}`;
                div.innerHTML = `
                    <div class="comment-main">
                        <strong>${data.user} :</strong>
                        <span class="comment-content" data-id="${data.comment_id}" contenteditable="true" title="Cliquez pour modifier">${input.value}</span>
                        <br><small>(${data.date})</small>
                    </div>
                    <div class="vote-section">
                        <button class="btn-vote" data-id="${data.comment_id}" data-type="up">⬆️</button>
                        <span id="score-${data.comment_id}">0</span>
                        <button class="btn-vote" data-id="${data.comment_id}" data-type="down">⬇️</button>
                    </div>`;
                container.prepend(div);
                input.value = '';
                attachCommentListeners(div);
            }
        });
    });

    const attachCommentListeners = (container) => {
        container.querySelectorAll('.btn-vote').forEach(btn => {
            btn.addEventListener('click', async (e) => {
                const cid = e.target.dataset.id;
                const type = e.target.dataset.type;
                const resp = await fetch('index.php?page=ajax&action=vote_comment', {
                    method: 'POST',
                    headers: {'Content-Type': 'application/json'},
                    body: JSON.stringify({ comment_id: cid, vote_type: type })
                });
                const d = await resp.json();
                if(d.status === 'success') document.getElementById(`score-${cid}`).innerText = d.new_score;
            });
        });

        container.querySelectorAll('.comment-content[contenteditable="true"]').forEach(span => {
            span.addEventListener('blur', async (e) => {
                const cid = e.target.dataset.id;
                const txt = e.target.innerText.trim();
                
                if (span.getAttribute('contenteditable') !== 'true') return;

                if(txt === "") { alert("Comment cannot be empty"); return; }
                
                await fetch('index.php?page=ajax&action=edit_comment', {
                    method: 'POST',
                    headers: {'Content-Type': 'application/json'},
                    body: JSON.stringify({ id: cid, contenu: txt })
                });
            });
        });
    };

    document.querySelectorAll('.comment-container').forEach(attachCommentListeners);


    const searchInput = document.getElementById('live-search');
    const resultsDiv = document.getElementById('search-results');

    if (searchInput && resultsDiv) {
        searchInput.addEventListener('keyup', async (e) => {
            const query = e.target.value.trim();
            
            if (query.length < 2) {
                resultsDiv.style.display = 'none';
                resultsDiv.innerHTML = '';
                return;
            }

            const response = await fetch(`index.php?page=ajax&action=search&q=${encodeURIComponent(query)}`);
            const results = await response.json();
            
            if (results.length > 0) {
                resultsDiv.style.display = 'block';
                resultsDiv.innerHTML = results.map(item => {
                    let label = 'Message';
                    if (item.type === 'user') label = 'Utilisateur';
                    if (item.type === 'comment') label = 'Commentaire';
                    
                    const shortText = item.text.length > 50 ? item.text.substring(0, 50) + '...' : item.text;

                    // Store IDs in data-attributes for click handling
                    return `
                    <div class="search-item" data-type="${item.type}" data-id="${item.id}" data-link-id="${item.link_id}">
                        <strong>${shortText}</strong>
                        <small>${label}</small>
                    </div>`;
                }).join('');
            } else {
                resultsDiv.style.display = 'block';
                resultsDiv.innerHTML = '<div class="search-item" style="cursor:default;">Aucun résultat.</div>';
            }
        });

            document.addEventListener('click', (e) => {
            if (!searchInput.contains(e.target) && !resultsDiv.contains(e.target)) {
                resultsDiv.style.display = 'none';
            }
        });

        resultsDiv.addEventListener('click', (e) => {
            const item = e.target.closest('.search-item');
            if (!item) return;

            const type = item.dataset.type;
            const id = item.dataset.id;        
            const linkId = item.dataset.linkId; 
            
            let targetElement = null;

            if (type === 'post') {
                targetElement = document.getElementById(`post-${id}`);
            } 
            else if (type === 'comment') {
                targetElement = document.getElementById(`comment-container-${id}`);
            } 
            else if (type === 'user') {
                // Find first post by this author visible on page
                const allAuthors = document.querySelectorAll('.post small strong');
                for (let author of allAuthors) {
                    if (author.textContent.trim().toLowerCase().includes(item.querySelector('strong').textContent.trim().toLowerCase())) {
                        targetElement = author.closest('.post');
                        break;
                    }
                }
                if (!targetElement) alert("Aucun message visible de cet utilisateur sur cette page.");
            }

            if (targetElement) {
                targetElement.scrollIntoView({ behavior: 'smooth', block: 'center' });
                targetElement.classList.remove('highlight-anim'); 
                void targetElement.offsetWidth; // Force reflow to restart animation
                targetElement.classList.add('highlight-anim');
                
                resultsDiv.style.display = 'none';
                searchInput.value = '';
            }
        });
    }


    const notifBadge = document.getElementById('notif-badge');
    const notifBtn = document.getElementById('notif-btn');
    const notifDropdown = document.getElementById('notif-dropdown');
    const notifList = document.getElementById('notif-list');
    const markReadBtn = document.getElementById('mark-read-btn');

    const fetchNotifications = async () => {
        if (!USER_ID) return;
        try {
            const response = await fetch('index.php?page=ajax&action=get_notifications');
            const data = await response.json();

            if (data.count > 0) {
                if (notifBadge) {
                    notifBadge.innerText = data.count;
                    notifBadge.style.display = 'inline-block';
                }
                
                if (notifList) {
                    notifList.innerHTML = data.items.map(n => `
                        <div style="padding: 10px; border-bottom: 1px solid #eee; font-size: 0.9em;">
                            ${n.message}
                            <br><small style="color:gray">${n.created_at}</small>
                        </div>
                    `).join('');
                }
                
                if (markReadBtn) markReadBtn.style.display = 'block';
            } else {
                if (notifBadge) notifBadge.style.display = 'none';
                if (notifList) notifList.innerHTML = '<div style="padding:10px; color:gray;">Aucune nouvelle notification</div>';
                if (markReadBtn) markReadBtn.style.display = 'none';
            }
        } catch (e) { console.error(e); }
    };

    if (USER_ID) {
        fetchNotifications(); // Initial fetch
        setInterval(fetchNotifications, 10000);
    }

    if (notifBtn) {
        notifBtn.addEventListener('click', (e) => {
            e.stopPropagation(); 
            if (notifDropdown) notifDropdown.style.display = (notifDropdown.style.display === 'block') ? 'none' : 'block';
        });
    }

    if (markReadBtn) {
        markReadBtn.addEventListener('click', async () => {
            await fetch('index.php?page=ajax&action=mark_notifications_read');
            // Refresh local view immediately
            if (notifBadge) notifBadge.style.display = 'none';
            if (notifList) notifList.innerHTML = '<div style="padding:10px; color:gray;">Aucune nouvelle notification</div>';
            if (markReadBtn) markReadBtn.style.display = 'none';
            if (notifDropdown) notifDropdown.style.display = 'none'; 
        });
    }

    document.addEventListener('click', (e) => {
        if (notifDropdown && notifDropdown.style.display === 'block') {
            if (!notifDropdown.contains(e.target) && e.target !== notifBtn) {
                notifDropdown.style.display = 'none';
            }
        }
    });

});