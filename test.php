<?php
// Conexão com o banco de dados
$servername = "Olá mundo";
$username = "Joãozinho loucura";
$password = "quesenha123";
$dbname = "seu_banco_de_dados";

// Cria a conexão
$conn = new mysqli($servername, $username, $password, $dbname);

// Verifica a conexão
if ($conn->connect_error) {
    die("Erro na conexão: " . $conn->connect_error);
}

// Consulta SQL para obter os três artigos mais visualizados
$sql = "SELECT art_id, art_title, art_summary, art_thumbnail 
FROM article 
ORDER BY art_views 
DESC LIMIT 3";
$result = $conn->query($sql);

// Inicializa uma variável para armazenar o conteúdo do aside
$aside_content = "";

// Verifica se foram encontrados resultados
if ($result->num_rows > 0) {
    // Loop pelos resultados e monta o conteúdo do aside
    while($row = $result->fetch_assoc()) {
        $aside_content .= "<div>";
        $aside_content .= "<h4>" . $row["art_title"] . "</h4>";
        $aside_content .= "</div>";
    }
} else {
    $aside_content = "Nenhum artigo encontrado.";
}

// Fecha a conexão com o banco de dados
$conn->close();
?>
