<?php

/**
 * _config.php
 * 
 * Este é o arquivo de configuração inicial das páginas do aplicativo.
 * Este arquivo deve ser incluído nas páginas antes de quaisquer outros códigos PHP.
 * Antes de transferir este aplicativo para um provedor, as configurações abaixo
 * devem ser revisadas e atualizadas conforme as configurações do provedor.
 * 
 * IMPORTANTE!
 * Este arquivo tem dados sensíveis como crdenciais de usuários e senhas, inclusive
 * do banco de dados, portanto, deve ser tratado com muito cuidado.
 **/

/**
 * Define a tabela de caracteres para UTF-8
 * Evita problemas de acentuação
 **/
header("Content-type: text/html; charset=utf-8");
setlocale(LC_ALL, 'pt_BR.UTF8');
mb_internal_encoding('UTF8');
mb_regex_encoding('UTF8');

/**
 * Configurações globais do site.
 * Altere conforme suas necessidades.
 **/
$site = [
    "sitename" => "Capivarias",              // Usado na tag <title>
    "title" => "Capivarias",                 // Usado na tag <header>
    "slogan" => "Capivarando a progamação",       // Usado na tag <header>
    "logo" => "capibara.png",                 // Usado na tag <header>

    // Dados de conexão com o MySQL:
    "mysql_hostname" => "localhost",        // Servidor do banco de dados MySQL
    "mysql_username" => "root",             // Nome do usuário do MySQL para o app
    "mysql_password" => "",                 // Senha do usuário do MySQL para o app
    "mysql_database" => "helloword",        // Nome do banco de dados do MySQL para o app

    // Setup da visualização
    "summary_length" => 40,                  // Tamanho do corte do resumo 

    /**
     * Lista de redes sociais
     *     "icon" foi obtido de https://fontawesome.com/icons/
     *     "color" foi obtido de https://brandcolors.net/
     **/
    "social_list" => [
        [
            "name" => "GitHub.com",
            "link" => "https://github.com/Luferat",
            "icon" => "fa-brands fa-square-github fa-fw",
            "color" => "#333"
        ], [
            "name" => "X / Twitter",
            "link" => "https://twitter.com/Luferat",
            "icon" => "fa-brands fa-square-x-twitter fa-fw",
            "color" => "#14171a"
        ], [
            "name" => "Youtube",
            "link" => "https://www.youtube.com/channel/UCkN6I-gfJlL5lUj9shkyxPQ",
            "icon" => "fa-brands fa-square-youtube fa-fw",
            "color" => "#ff0000"
        ], [
            "name" => "Facebook",
            "link" => "https://facebook.com/Luferat",
            "icon" => "fa-brands fa-square-facebook fa-fw",
            "color" => "#1877f2"
        ], [
            "name" => "Instagram",
            "link" => "https://instagram.com/Luferat",
            "icon" => "fa-brands fa-square-instagram fa-fw",
            "color" => "#405de6"
        ], [
            "name" => "LinkedIn",
            "link" => "https://www.linkedin.com/in/luferat/",
            "icon" => "fa-brands fa-linkedin fa-fw",
            "color" => "#0a66c2"
        ]
    ]
];

/**
 * Conexão com o MySQL usando a biblioteca MySQLi.
 * Referências: https://www.w3schools.com/php/php_mysql_connect.asp
 * Dica: experimente também fazer a conexão ao mySQL usando PDO conforme a documentação
 **/
$conn = new mysqli(
    $site["mysql_hostname"],    // Servidor do banco de dados MySQL
    $site["mysql_username"],    // Nome do usuário do MySQL para o app
    $site["mysql_password"],    // Senha do usuário do MySQL para o app
    $site["mysql_database"]     // Nome do banco de dados do MySQL para o app
);

/**
 * Trata erros de conexão com o banco de dados
 * ATENÇÃO! Isso não trata erros de script e não gera exceptions...
 *          Para isso, use PDO.
 **/
if ($conn->connect_error)
    die("Falha de conexão com o banco e dados: " . $conn->connect_error);

/**
 * Com o MySQL conectado, seta transações do PHP com MySQL para usar UTF-8
 * Referências: https://www.catabits.com.br/devops/acentua%C3%A7%C3%A3o-em-php-com-mysql
 **/
$conn->query("SET NAMES 'utf8'");
$conn->query('SET character_set_connection=utf8');
$conn->query('SET character_set_client=utf8');
$conn->query('SET character_set_results=utf8');

// Seta os dias da semana e meses do MySQL para "português do Brasil"
$conn->query('SET GLOBAL lc_time_names = pt_BR');
$conn->query('SET lc_time_names = pt_BR');

/*********************************
 * Funções globais do aplicativo *
 *********************************/

/**
 * Função para debug 
 * Referências: 
 *      https://www.w3schools.com/tags/tag_pre.asp
 *      https://www.w3schools.com/php/func_var_var_dump.asp
 *      https://www.w3schools.com/php/func_var_print_r.asp
 * Exemplos de uso:
 *      debug($site);       → Debug de $site sem interromper o aplicativo.
 *      debug($conn, true); → Debug de $conn interrompendo o aplicativo.
 * O primeiro parâmetro é obrigatório, tipo "any", sendo o elemento alvo a ser "debugado"
 * O segundo parâmetro é opcional, tipo "boolean", sendo:
 *      Se false → (Default) mostra o debug do alvo e segue a execução do aplicativo
 *      Se true → mostra o debug do alvo e encerra a execução do aplicativo
 * Dica: troque entre print_r() e var_dump() para ver o que é melhor para seu case,
 *       basta comentar um e descomentar outro no código da função.
 **/
function debug($target, $exit = false)
{
    echo "<pre>";
    print_r($target);       // Exibe um debug mais simplificado e limpo
    // var_dump($target);   // Exibe um debug mais completo
    echo "</pre>";
    if ($exit) exit();
}