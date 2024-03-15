<?php

// Carrega configurações globais
require("_global.php");

// Configurações desta página
$page = array(
    "title" => "Erro 404", // Título desta página
    "css" => "404.css",    // Folha de estilos desta página 
);

// Inclui o cabeçalho do documento
require('_header.php');
?>

<article>
    <h1>Oooops! Hehe</h1>
    <img src="assets/img/mike.png" alt="Erro 404">
    <h3><strong> Você esta no lugar errado calabreso. </strong></h3>
    <h3><strong>Tente isto mortandelo "onlyfans.com" </strong></h3>
</article>

<?php
// Inclui o rodapé do documento
require('_footer.php');
?>