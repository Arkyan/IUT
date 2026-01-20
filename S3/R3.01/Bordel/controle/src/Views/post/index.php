<?php 
// On instancie le modèle Comment pour récupérer les scores facilement
$commentModel = new \App\Models\Comment();
require 'src/Views/layout/header.php'; 
?>

<style>
    .comment-container { display: flex; align-items: flex-start; justify-content: space-between; gap: 10px; border-bottom: 1px solid #eee; padding: 10px 0; }
    .comment-main { flex: 1; }
    .vote-section { display: flex; flex-direction: column; align-items: center; min-width: 30px; }
    .btn-vote { background: none; border: none; cursor: pointer; font-size: 1.2em; padding: 0; opacity: 0.5; transition: 0.2s; }
    .btn-vote:hover { opacity: 1; transform: scale(1.1); }
    [contenteditable="true"]:hover { background-color: #f0f8ff; border: 1px dashed #ccc; cursor: text; padding: 2px; }
    .post-actions a { text-decoration: none; font-weight: bold; margin-left: 5px; font-size: 0.9em; }
    .post-actions a:hover { text-decoration: underline; }
</style>

<div style="max-width: 800px; margin: 0 auto;">
    <h1>Fil d'actualité</h1>

    <?php if (empty($posts)): ?>
        <p>Aucun message pour le moment. Soyez le premier à poster !</p>
    <?php else: ?>
        
        <?php foreach ($posts as $post): ?>
            <div class="post" id="post-<?= $post['id'] ?>" style="border: 1px solid #ddd; padding: 20px; margin-bottom: 20px; background: #fff; border-radius: 8px;">
                
                <h3 style="margin-top: 0; margin-bottom: 5px;"><?= htmlspecialchars($post['titre']) ?></h3>
                
                <?php if (!empty($post['image'])): ?>
                    <div style="margin: 10px 0;">
                        <img src="upload/<?= htmlspecialchars($post['image']) ?>" alt="Post image" style="max-width: 100%; max-height: 400px; border-radius: 8px;">
                    </div>
                <?php endif; ?>

                <p style="font-size: 1.1em; line-height: 1.5;"><?= nl2br(htmlspecialchars($post['contenu'])) ?></p>
                
                <small style="color: #666;">
                    Par <strong><?= htmlspecialchars($post['auteur'] ?? 'Utilisateur Inconnu') ?></strong> 
                    le <?= date('d/m/Y à H:i', strtotime($post['date_publication'])) ?>
                </small>
                
                <hr style="border: 0; border-top: 1px solid #eee; margin: 15px 0;">

                <div class="actions" style="display: flex; justify-content: space-between; align-items: center;">
                    
                    <?php if (isset($_SESSION['user_id'])): 
                        $btn_text = $post['is_liked_by_user'] ? '❤️ Je n\'aime plus' : '🤍 J\'aime';
                        $btn_color = $post['is_liked_by_user'] ? 'blue' : 'black';
                    ?>
                        <div style="display: flex; align-items: center; gap: 10px;">
                            <button class="btn-like" data-id="<?= $post['id'] ?>" style="cursor: pointer; background: none; border: 1px solid #ccc; padding: 5px 10px; border-radius: 4px; color: <?= $btn_color ?>;">
                                <?= $btn_text ?>
                            </button>
                            <span id="like-count-<?= $post['id'] ?>" style="font-weight: bold;">
                                <?= $post['like_count'] ?> Like(s)
                            </span>
                        </div>
                    <?php else: ?>
                        <span style="color:#555; font-size: 0.9em;"><?= $post['like_count'] ?> Likes</span>
                    <?php endif; ?>

                    <?php if (isset($_SESSION['user_id']) && $_SESSION['user_id'] == $post['utilisateur_id']): ?>
                        <div class="post-actions">
                            <a href="index.php?page=edit_post&id=<?= $post['id'] ?>" style="color: orange;">✏️ Modifier</a> | 
                            <a href="index.php?page=delete_post&id=<?= $post['id'] ?>" onclick="return confirm('Supprimer ce message ?')" style="color: red;">🗑️ Supprimer</a>
                        </div>
                    <?php endif; ?>

                </div>

                <div style="background: #f9f9f9; padding: 15px; margin-top: 15px; border-radius: 5px;">
                    <h4 style="margin-top:0;">Commentaires</h4>
                    
                    <div id="comments-post-<?= $post['id'] ?>">
                        <?php if (!empty($post['comments'])): ?>
                            <?php foreach ($post['comments'] as $comment): ?>
                                <div class="comment-container" id="comment-container-<?= $comment['id'] ?>">
                                    <div class="comment-main">
                                        <strong><?= htmlspecialchars($comment['user_nom'] ?? 'Utilisateur Inconnu') ?> :</strong>
                                        
                                        <span class="editable-comment" data-id="<?= $comment['id'] ?>"
                                            <?php if (isset($_SESSION['user_id']) && $_SESSION['user_id'] == $comment['user_id']): ?>
                                                contenteditable="true" title="Cliquez pour modifier" style="cursor: pointer; border-bottom: 1px dashed #ccc;"
                                            <?php endif; ?>
                                        >
                                            <?= htmlspecialchars($comment['contenu']) ?>
                                        </span>
                                        
                                        <br><small style="color:#999; font-size: 0.8em;"><?= date('d/m H:i', strtotime($comment['created_at'])) ?></small>
                                    </div>

                                    <div class="vote-section">
                                        <?php if (isset($_SESSION['user_id'])): ?>
                                            <button class="btn-vote" data-id="<?= $comment['id'] ?>" data-type="up">⬆️</button>
                                            <span id="score-<?= $comment['id'] ?>" style="font-weight: bold;"><?= $commentModel->getScore($comment['id']) ?></span>
                                            <button class="btn-vote" data-id="<?= $comment['id'] ?>" data-type="down">⬇️</button>
                                        <?php endif; ?>
                                    </div>
                                </div>
                            <?php endforeach; ?>
                        <?php else: ?>
                            <p style="color: #888; font-style: italic; font-size: 0.9em;">Aucun commentaire.</p>
                        <?php endif; ?>
                    </div>

                    <?php if (isset($_SESSION['user_id'])): ?>
                        <form class="form-comment" style="margin-top: 15px; display: flex; gap: 10px;">
                            <input type="hidden" name="post_id" value="<?= $post['id'] ?>">
                            <input type="text" name="contenu" placeholder="Écrire un commentaire..." required style="flex: 1; padding: 10px; border: 1px solid #ccc; border-radius: 4px;">
                            <button type="submit" style="background: #007bff; color: white; border: none; padding: 10px 15px; border-radius: 4px; cursor: pointer;">Envoyer</button>
                        </form>
                    <?php endif; ?>
                </div>

            </div>
        <?php endforeach; ?>

    <?php endif; ?>
</div>

<?php require 'src/Views/layout/footer.php'; ?>