<?php

// Carrega configurações globais
require("_global.php");

// Configurações desta página
$page = array(
    "title" => "Perfil do Usuário",
    "css" => "profile.css",
    "js" => "profile.js"
);

// Inclui o cabeçalho do documento
require('_header.php');
?>

<article>

    <h2>Eai? <span id="userName">Caga tronco</span>!</h2>

    <div id="userCard"></div>

    <p>Mongol, você entrou pelo Google, seu perfil é là </p>
    <p class="center">
        <button type="button" id="btnGoogleProfile">
            <i class="fa-brands fa-google fa-fw"></i>
            Seu perfil
        </button>
    </p>

    <p>Pronto agora quer sair, o que eu fiz dessa vez</p>

    <p class="center">
        <button type="button" id="btnLogout">
        <i class="fa-solid fa-right-from-bracket fa-fw"></i>
            Deslogar
        </button>
    </p>

</article>

<aside>
    <h3>Mais para você</h3>
</aside>

<?php
// Inclui o rodapé do documento
require('_footer.php');
?>