<?php

// Carrega configurações globais
require("_global.php");

// Configurações desta página
$page = array(
    "title" => $site['slogan'], // Título desta página
    "css" => "index.css",       // Folha de estilos desta página
);

// Paginação de artigos: obtém número da página atual
$navpage = (isset($_GET['p'])) ? intval($_GET['p']) : 1;

// Paginação de artigos: calcula a diferença entre a página atual e o total de páginas
$offset = ($navpage * $site['articles_perpage']) - $site['articles_perpage'];

// Limita os links de paginação
$lim_pag = 4;

// Conta o total de registros a serem obtidos
$sql = "SELECT art_id FROM article WHERE art_date <= NOW() AND art_status = 'on'";
$res = $conn->query($sql);
$total_rows = $res->num_rows;

/**
 * Listar os artigos do banco de dados
 * Regras / parâmetros:
 *  • Ordenados pela data de publicação com os mais recentes primeiro
 *  • Obter somente artigos no passado e presente
 *      • Não obter artigos agendados para o futuro
 *  • Obter somente artigos com status = 'on'
 *  • Obter os campos id, thumbnail, title, summary
 **/
$sql = <<<SQL

SELECT
    -- Obter o id
	art_id
FROM article

    -- Obter somente artigos no passado e presente
    -- Não obter artigos agendados para o futuro
	WHERE art_date <= NOW()	  	
        
        -- Obter somente artigos com status = 'on'
		AND art_status = 'on'

    -- Ordenados pela data de publicação com os mais recentes primeiro
	ORDER BY art_date DESC
    
-- Paginação
LIMIT {$offset},{$site['articles_perpage']};

SQL;

//  Executa o SQL e armazena os resultados em $res
$res = $conn->query($sql);

// Se ultrapassou último registro, volta para a primeira página
if ($res->num_rows == 0) header('Location: ?pag=1');

// Variável que contém a lista de artigos em HTML e título
$articles = $navigator = '';

// Se não tem artigos, exibe um aviso
if ($total_rows == 0) :
    $articles = "<h2>Artigos recentes</h2><p>Não achei nada!</p>";
else :

    // Título
    if ($total_rows == 1) $articles = '<h2>Artigo mais recente</h2>';
    else $articles = "<h2>Artigos mais recentes</h2> <div class='artrow'>";

    // Loop para obter cada artigo
    while ($art = $res->fetch_assoc())

        // Chama a função que gera a lista de artigos
        $articles .= view_article($art['art_id']);

endif;

$articles .="</div>";

// Calcula os links de paginação
$total_pages = Ceil($total_rows / $site['articles_perpage']);
$offset = ((($navpage - $lim_pag) > 1) ? $navpage - $lim_pag : 1);
$fim = ((($navpage + $lim_pag) < $total_pages) ? $navpage + $lim_pag : $total_pages);

// Inicializa links de navegação
$navigator = '<p class="pagination">';

// Exibe o total de artigos
if ($total_rows == 0)
    $navigator .= "<small>Não encontramos artigos</small>";
elseif ($total_rows == 1)
    $navigator .= "<small>1 artigo</small>";
else
    $navigator .= "<small>{$total_rows} artigos</small>";

// Link para primeira página
if ($navpage > 1)
    $navigator .= '<a href="index.php?p=1" title="Primeira página"><i class="fa-solid fa-backward fa-fw"></i></a>';
else
    $navigator .= '<span><i class="fa-solid fa-backward fa-fw"></i></span>';

// Loop de links para todas as páginas
if ($total_pages > 1 && $navpage <= $total_pages) {
    for ($i = $offset; $i <= $fim; $i++) {
        if ($navpage == $i)
            $navigator .=  "<span>" . $i . "</span>";
        else
            $navigator .=  '<a href="index.php?p=' . $i . '" title="Página ' . $i . '">' . $i . '</a>';
    }
}

// Link para última página
if ($navpage != $total_pages)
    $navigator .= '<a href="index.php?p=' . $total_pages . '" title="Última página"><i class="fa-solid fa-forward fa-fw"></i></a>';
else
    $navigator .= '<span><i class="fa-solid fa-forward fa-fw"></i></span>';

// Fecha links de paginação
$navigator .= '</p>';

// Inclui o cabeçalho do documento
require('_header.php');
?>

<article>
    <?php echo $articles ?>
    <?php echo $navigator ?>
</article>

<aside>
    <?php
    // Mostra os artigos mais visualizados
    require('widgets/_mostviewed.php');

    // Mostra os artigos mais comentados
    require('widgets/_mostcommented.php');
    ?>
</aside>

<?php require('_footer.php'); ?>