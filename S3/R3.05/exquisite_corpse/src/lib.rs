pub fn add_line_and_make_response(line: &str, text: &mut String) -> String {
    // Ajoute la ligne au texte existant et entre 2 lignes de délimiteurs
    text.push_str("\n---\n");
    text.push_str(line);
    text.push_str("\n---\n");
    text.clone()
}