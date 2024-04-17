<?php

// Carrega configurações globais
require("_global.php");

// Configurações desta página
$page = array(
    "title" => "Lendo e Entendendo",
    "css" => "portfolio.css"
);

// Inicializa a view de colaboradores
$employees = '';

// Obtém a lista de colaboradores do banco de dados
$sql = <<<SQL

SELECT 
	-- Campos necessários
    emp_id, emp_photo, emp_name, emp_type,
    -- Converte a data de cadastro
    DATE_FORMAT(emp_date, "%d/%m/%Y") AS emp_datebr,
    -- Obtém a idade
    TIMESTAMPDIFF(YEAR, emp_birth, CURDATE()) AS emp_age 
FROM employee
-- Requisitos
WHERE emp_status = 'on'
-- Ordena pelo mais antigo
ORDER BY emp_date;

SQL;
$res = $conn->query($sql);

if ($res->num_rows > 0) :

    $employees .= <<<HTML

        <h3>Colaboradores</h3>
        <p>No {$site['sitename']}, contamos com uma equipe dedicada de administradores, autores e moderadores apaixonados pelo mundo das plantas. Nossos administradores garantem o bom funcionamento do blog, enquanto nossos autores especializados trazem sua experiência e conhecimento para criar conteúdo informativo e inspirador. Nossos moderadores garantem que a comunidade se mantenha positiva e construtiva, proporcionando uma experiência enriquecedora para todos os nossos leitores e participantes.</p>
        <div class="emprow">

    HTML;

    while ($row = $res->fetch_assoc()) :

        switch ($row['emp_type']):
            case 'admin':
                $emp_type = 'administrador';
                break;
            case 'author':
                $emp_type = 'autor';
                break;
            case 'moderator':
                $emp_type = 'moderador';
                break;
            default:
                $emp_type = 'colaborador';
                break;
        endswitch;

        $employees .= <<<HTML

        <div class="empcol">
            <img src="{$row['emp_photo']}" alt="{$row['emp_name']}">
            <h3>{$row['emp_name']}</h3>
            <ul>
                <li>{$row['emp_age']} anos</li>
                <li>Colabora desde {$row['emp_datebr']} como {$emp_type}.</li>
            </ul>
        </div>

        HTML;

    endwhile;

    $employees .= '</div>';

endif;

// Inclui o cabeçalho do documento
require('_header.php');
?>

<article>

    <h2>Portfólio da <?php echo $site['sitename']. ' "Programando a Construção"' ?></h2>
    <strong><p><em>Introdução:</em></p></strong>
    <p>A Construtora <?php echo $site['sitename']. ' "Programando a Construção"' ?> é uma empresa comprometida com a excelência na construção civil. Com uma equipe de profissionais altamente qualificados e uma abordagem centrada no cliente, estamos empenhados em transformar ideias em realidade e construir espaços que inspiram e melhoram a vida das pessoas.
</p>

    <h3>Nossos Serviços</h3>
    <p>Com a <?php echo $site['sitename'] ?> Trabalhamos com, </p>
    <hr>
    <ul>
        <li><a href="view.php?id=1">Casas</a></li>
        <li><a href="view.php?id=11">Plantas ornamentais</a></li>
        <li><a href="view.php?id=10">Sitios Lazer</a></li>
        <li><a href="view.php?id=9">Jardins Personalizadas Residencial</a></li>
        <li><a href="view.php?id=8">Projeto Personalizado</a></li>
        <li><a href="view.php?id=7">Condomínio Comercial</a></li>
        <li><a href="index.php">Entre outros...</a></li>
    </ul>
    
    <hr>


    <h3>Participe</h3>
    <p>Junte-se à nossa comunidade de entusiastas do verde enquanto cultivamos conhecimento, fomentamos a criatividade e semeamos as bases de um futuro mais verde e sustentável juntos.</p>

    <?php echo $employees ?>

</article>

<aside>

    <h3>Veja +</h3>
    <ul>
        <li><a href="contacts.php">Faça contato conosco</a></li>
        <li><a href="about.php">Sobre o <?php echo $site['sitename'] ?></a></li>
    </ul>

    <?php
    // Mostra ícone de contatos na lista de redes sociais
    $show_contact = true;
    // Importa lista de redes sociais
    require('widgets/_socialaside.php');
    // Importa lista de artigos recentes
    require('widgets/_newest.php');
    ?>

</aside>

<?php
// Inclui o rodapé do documento
require('_footer.php');
?>


