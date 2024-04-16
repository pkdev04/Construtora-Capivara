<?php

// Carrega configurações globais
require("_global.php");

// Configurações desta página
$page = array(
    "title" => "Procurando...",
    "css" => "index.css"
);

// inicializa a view
$search_view = '';

// Obtém o termo de busca da URL
$query = isset($_GET['q']) ? trim(htmlentities(strip_tags($_GET['q']))) : '';

// Paginação de artigos: obtém número da página atual
$navpage = (isset($_GET['p'])) ? intval($_GET['p']) : 1;

// Paginação de artigos: calcula a diferença entre a página atual e o total de páginas
$offset = ($navpage * $site['articles_perpage']) - $site['articles_perpage'];

// Limita os links de paginação
$lim_pag = 4;

// Prepara a query de busca
$search_query = "%{$query}%";

// Conta o total de registros a serem obtidos
$sql = "
    SELECT art_id 
    FROM article 
    WHERE 
        art_date <= NOW() 
        AND art_status = 'on'
        AND art_title LIKE ?
        OR art_summary LIKE ?
        OR art_content LIKE ?        
";
// Prepara e executa o statement
$stmt = $conn->prepare($sql);
$stmt->bind_param(
    'sss',
    $search_query,
    $search_query,
    $search_query
);
$stmt->execute();

// Obtém o resultado da consulta
$res = $stmt->get_result();
$total_rows = $res->num_rows;

// inicializa a view
$search_view = $navigator = '';

// Incializa vatiável com total de comentários
$total = 0;

// Obtém o termo de busca da URL
$query = isset($_GET['q']) ? trim(htmlentities(strip_tags($_GET['q']))) : '';

// Se a query NÃO está vazia
if ($query != '') :

    // Incializa variável da view
    $search_view .= "<h2>Procurando por '{$query}'</h2>";

    // Altera <title>
    $page['title'] = "Procurando por '{$query}'";

    // Consulta SQL usa prepared statement
    $sql = <<<SQL

    -- Referências: https://www.w3schools.com/mysql/mysql_like.asp

        SELECT 
            art_id 
        FROM article 
        WHERE
            -- Requisitos padrão
            art_date <= NOW()
            AND art_status = 'on'
            -- Busca
            AND art_title LIKE ?
            OR art_summary LIKE ?
            OR art_content LIKE ?
        ORDER BY art_date DESC
        -- Paginação
        LIMIT {$offset},{$site['articles_perpage']};

    SQL;

    // Prepara a query de busca
    $search_query = "%{$query}%";

    // Prepara e executa o statement
    $stmt = $conn->prepare($sql);
    $stmt->bind_param(
        'sss',
        $search_query,
        $search_query,
        $search_query
    );
    $stmt->execute();

    // Obtém o resultado da consulta
    $res = $stmt->get_result();

    // Se ultrapassou último registro, volta para a primeira página
    if ($res->num_rows == 0) header('Location: ?pag=1');

    // Total de registros
    $total = $res->num_rows;

    // Se vieram registros:
    if ($total > 0) :

        // Processa o total de resultados
        if ($total == 1) $viewtotal = '1 resultato';
        else $viewtotal = "{$total} resultados";

        $search_view .= "<p><small class=\"authordate\">{$viewtotal}</small></p>";

        // Loop para obter e exibir os artigos
        while ($art = $res->fetch_assoc())
            $search_view .= view_article($art['art_id']);

        // Calcula os links de paginação
        $total_pages = Ceil($total_rows / $site['articles_perpage']);
        $offset = ((($navpage - $lim_pag) > 1) ? $navpage - $lim_pag : 1);
        $fim = ((($navpage + $lim_pag) < $total_pages) ? $navpage + $lim_pag : $total_pages);

        $navigator = '<p class="pagination">';

        // Exibe o total de artigos
        if ($total_rows == 0) $navigator .= "<small>Não encontramos artigos</small>";
        elseif ($total_rows == 1) $navigator .= "<small>1 artigo</small>";
        else $navigator .= "<small>{$total_rows} artigos</small>";

        // Gera os links de paginação
        if ($navpage > 1) $navigator .= '<a href="search.php?q=' . $query . '&p=1"><i class="fa-solid fa-backward fa-fw"></i></a> ';

        if ($total_pages > 1 && $navpage <= $total_pages) {
            for ($i = $offset; $i <= $fim; $i++) {
                if ($navpage == $i) $navigator .=  "<span>" . $i . "</span>";
                else $navigator .=  '<a href="search.php?q=' . $query . '&p=' . $i . '">' . $i . '</a>';
            }
        }

        if ($navpage != $total_pages) $navigator .= '<a href="search.php?q=' . $query . '&p=' . $total_pages . '"><i class="fa-solid fa-forward fa-fw"></i></a>';

        $navigator .= '</p>';

    // Se não achou nada:
    else :
        $search_view .= "<p class=\"center\">Nenhum conteúdo encontrado com '{$query}'.</p>";
    endif;

else :

    $search_view .= <<<HTML

<h2>Procurando...</h2>
<p class="center">Digite algo no campo de busca!</p>

HTML;

endif;

// Inclui o cabeçalho do documento
require('_header.php');
?>

<article>
    <?php echo $search_view ?>
    <?php echo $navigator ?>
</article>

<aside>
    <?php
    // Mostra os artigos mais visualizados
    require('widgets/_mostviewed.php');
    // Caso a busca retorne mais que 4 itens, exibe artigos mais comentados.
    if ($site['articles_perpage'] > 4)
        require('widgets/_mostcommented.php');
    ?>
</aside>

<?php
// Inclui o rodapé do documento
require('_footer.php');
?>