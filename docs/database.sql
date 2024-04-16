-- ------------------------------------------------- --
-- Cria o banco de dados da aplicação no MySQL.      --
-- Referências:                                      --
--  •  MySQL → https://www.w3schools.com/mysql       --
--  •  SQL ANSI → https://www.w3schools.com/sql      --
-- ------------------------------------------------- --
--      ATENÇÃO! DANGER! PERIGO! CUIDADO! OOOPS!     --
-- ------------------------------------------------- --
-- Este script só deve ser usado em desenvolvimento. --
-- Ele apaga o banco de dados e recria as estruturas --
-- do zero, apagando dados preexistentes.            --
-- Apague este arquivo no branch de produção.        --
-- ------------------------------------------------- --

-- Apaga o banco de dados caso ele exista.
DROP DATABASE IF EXISTS helloword;

-- Cria o banco de dados.
--     Seleciona o CHARSET UTF-8 para aramazenar caracteres do portugês.
--     Seleciona o COLLATE 'utf8mb4_general_ci' para fazer buscas case-insensitive.
CREATE DATABASE helloword CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

-- Seleciona o banco de dados para criar as tabelas.
USE helloword;

-- Cria a tabela 'employee'.
CREATE TABLE employee (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    emp_photo VARCHAR(255),
    emp_name VARCHAR(127) NOT NULL,
    emp_birth DATE,
    emp_email VARCHAR(255) NOT NULL,
    emp_password VARCHAR(63) NOT NULL,
    emp_type ENUM('admin', 'author', 'moderator') DEFAULT 'moderator',
    emp_status ENUM('on', 'off', 'del') DEFAULT 'on'
);

-- Cria a tabela 'article'.
CREATE TABLE article (
    art_id INT PRIMARY KEY AUTO_INCREMENT,
    art_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    art_thumbnail VARCHAR(255),
    art_title VARCHAR(127),
    art_summary VARCHAR(255),
    art_author INT,
    art_content TEXT,
    art_views INT DEFAULT '0',
    art_status ENUM('on', 'off', 'del') DEFAULT 'on',
    FOREIGN KEY (art_author) REFERENCES employee(emp_id)
);

-- Cria a tabela 'comment'.
CREATE TABLE comment (
    cmt_id INT PRIMARY KEY AUTO_INCREMENT,
    cmt_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    cmt_article INT,
    cmt_social_id VARCHAR(255),
    cmt_social_name VARCHAR(255),
    cmt_social_photo VARCHAR(255),
    cmt_social_email VARCHAR(255),
    cmt_content TEXT,
    cmt_status ENUM('on', 'off', 'del') DEFAULT 'on',
    FOREIGN KEY (cmt_article) REFERENCES article(art_id)
);

-- Cria a tabela 'contact'.
CREATE TABLE contact (
    ctt_id INT PRIMARY KEY AUTO_INCREMENT,
    ctt_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ctt_name VARCHAR(255),
    ctt_email VARCHAR(255),
    ctt_subject VARCHAR(255),
    ctt_message TEXT,
    ctt_status ENUM('received', 'read', 'answered', 'deleted') DEFAULT 'received'
);

-- imagens dos imoveis
CREATE TABLE images (
    img_id INT PRIMARY KEY AUTO_INCREMENT,
    img_article INT, 
    img_link VARCHAR(255),
    FOREIGN KEY(img_article) REFERENCES article(art_id)

);

-- --------------------------------------------------------------- --
-- Insere alguns dados "fake" nas tabelas para os testes iniciais. --
-- Dizemos "popular tabela com dados".
-- --------------------------------------------------------------- --

-- Popular tabela 'employee'.
INSERT INTO employee (
    emp_id, emp_photo, emp_name, emp_birth, emp_email, emp_password, emp_type
) VALUES 
('1', 'https://randomuser.me/api/portraits/lego/5.jpg', 'Joca da Silva', '2000-01-29', 'joca@silva.com', SHA1('senha123'), 'admin'),
('2', 'https://randomuser.me/api/portraits/women/33.jpg', 'Marineuza Siriliano', '1984-09-20', 'mari@neuza.com', SHA1('senha123'), 'author'),
('3', 'https://randomuser.me/api/portraits/men/40.jpg', 'Setembrino Trocatapas', '1999-10-21', 'set@brino.com', SHA1('senha123'), 'moderator'),
('4', 'https://randomuser.me/api/portraits/men/41.jpg', 'Hermenildo Sirigildo', '2001-12-24', 'herme@gildo.com', SHA1('senha123'), 'author');

-- Popular tabela 'article'.
INSERT INTO `article` (`art_id`, `art_date`, `art_thumbnail`, `art_title`, `art_summary`, `art_author`, `art_content`, `art_views`, `art_status`) VALUES
(1, '2024-02-27 21:36:21', 'https://picsum.photos/200', 'Casa\r\n', 'Conheça e saiba cuida de figueira e comer frutos deliciosos.', 2, '\r\n            <p>\r\nUm estilo de casa programada geralmente refere-se a residências que são equipadas com sistemas de automação residencial avançados. Esses sistemas permitem que os moradores controlem diversos aspectos da casa, como temperatura, iluminação, segurança, entre outros, por meio de dispositivos eletrônicos, como smartphones, tablets ou computadores.</p>\r\n            <p>A automação residencial pode incluir uma variedade de tecnologias, como termostatos inteligentes que ajustam automaticamente a temperatura da casa, sistemas de iluminação controlados remotamente para economia de energia, fechaduras e câmeras de segurança acessíveis via internet, e até mesmo sistemas de entretenimento integrados que permitem aos moradores controlar o áudio e vídeo em toda a casa.</p>\r\n            <figure>\r\n            <img src=\"https://picsum.photos/300/200\" alt=\"Imagem qualquer\">    \r\n            <figcaption>Imagem aleatória.</figcaption>                    \r\n            </figure>\r\n            <p> Esses sistemas de automação residencial oferecem conveniência, conforto e segurança aos moradores, permitindo que controlem sua casa de forma remota, mesmo quando não estão fisicamente presentes. Além disso, podem contribuir para a eficiência energética, reduzindo o consumo de energia e os custos associados.</p>\r\n            <p> Os estilos de casa programada podem variar dependendo das preferências e necessidades dos proprietários, assim como das tecnologias disponíveis no mercado. Essa tendência tem se tornado cada vez mais popular à medida que a tecnologia avança e se torna mais acessível.</p>\r\n        ', 349, 'on'),
(2, '2024-02-27 21:36:21', 'https://picsum.photos/201', 'Terreno', 'Como lidar com a colheita das rosas sem sangrar.', 4, '<p>Um terreno programado é aquele que é preparado ou adaptado especificamente para a construção de uma casa equipada com sistemas de automação residencial avançados. O perfil desse terreno pode variar dependendo das necessidades e requisitos do projeto da casa programada, bem como das preferências do proprietário. O terreno deve estar localizado em uma área que tenha acesso adequado à infraestrutura básica, como eletricidade, água, esgoto e conexão com a internet. A disponibilidade de serviços de telefonia móvel e banda larga também é importante para garantir a conectividade dos sistemas de automação residencial.</p>\r\n            <figure>\r\n            <img src=\"https://picsum.photos/300/200\" alt=\"Imagem qualquer\">    \r\n            <figcaption>Imagem aleatória.</figcaption>                    \r\n            </figure>\r\n            <p>A topografia do terreno deve ser analisada para garantir uma drenagem adequada e minimizar os riscos de inundações ou erosão. Terrenos planos ou levemente inclinados podem ser mais adequados para a construção de casas programadas, facilitando a instalação de sistemas de irrigação e drenagem. A orientação do terreno em relação ao sol pode influenciar o design da casa programada e a eficiência dos sistemas de energia solar. Terrenos com boa exposição solar podem permitir a instalação de painéis solares para gerar eletricidade limpa e reduzir os custos de energia.</p>\r\n            <p>O tamanho e a forma do terreno podem influenciar o layout e o design da casa programada, bem como o uso do espaço exterior. Terrenos maiores podem oferecer mais flexibilidade para a instalação de sistemas de automação residencial, como sistemas de irrigação automatizados e áreas de lazer ao ar livre. É importante considerar as regulamentações locais de zoneamento e uso da terra ao escolher um terreno para uma casa programada. Algumas áreas podem ter restrições quanto ao tamanho máximo da construção, altura do edifício, área de construção, entre outros aspectos, que podem afetar o design e a instalação de sistemas de automação residencial.</p>\r\n        ', 28, 'on'),
(3, '2024-02-27 21:36:21', 'https://picsum.photos/202', 'Loteamento', 'Cuide bem das plantinhas da varanda neste verão.', 2, '\r\n            <p>\r\nA programação de loteamento é um processo essencial no desenvolvimento urbano, envolvendo a divisão de uma área de terra em lotes menores para construção. Antes de tudo, é crucial considerar as regulamentações de zoneamento locais para determinar o tipo de desenvolvimento permitido em cada área. Em seguida, um layout é projetado, definindo a localização de cada lote, ruas e áreas comuns, visando otimizar o uso da terra e criar um ambiente funcional para os futuros moradores.</p>\r\n            <figure>\r\n            <img src=\"https://picsum.photos/300/200\" alt=\"Imagem qualquer\">    \r\n            <figcaption>Imagem aleatória.</figcaption>                    \r\n            </figure>\r\n            <p>Além disso, é necessário planejar a infraestrutura básica, como redes de água, esgoto, eletricidade e transporte, para suportar o desenvolvimento. Reservar espaços públicos e áreas verdes dentro do loteamento é igualmente importante, proporcionando oportunidades de recreação e melhorando a qualidade de vida dos residentes. Diretrizes de design urbano podem ser estabelecidas para garantir uma estética harmoniosa e coesa em todo o desenvolvimento, promovendo uma identidade única para o loteamento.</p>\r\n           ', 6, 'on'),
(5, '2024-02-27 21:36:21', 'https://picsum.photos/203', 'Parque Residencial', 'Descubra os mistérios por trás da arte do jardim zen.', 3, '<p>\r\nUm Parque Residencial é uma comunidade planejada que combina habitação com áreas verdes e recreativas. Ao contrário de bairros convencionais, onde a urbanização é predominante, os Parques Residenciais destacam-se por seu design integrado à natureza, priorizando espaços abertos e preservação ambiental. Esses desenvolvimentos frequentemente incluem parques, trilhas para caminhadas, áreas de lazer e jardins comunitários, proporcionando aos moradores um ambiente mais calmo e próximo da natureza.</p>\r\n        <figure>\r\n        <img src=\"https://picsum.photos/300/200\" alt=\"Imagem qualquer\">    \r\n        <figcaption>Imagem aleatória.</figcaption>                    \r\n        </figure>\r\n        <p>Além disso, os Parques Residenciais valorizam a arquitetura e o design que se fundem com o entorno natural, utilizando materiais sustentáveis e práticas de construção ecológicas. Essa abordagem não apenas promove uma atmosfera mais tranquila, mas também reforça a qualidade de vida dos residentes. A presença de espaços verdes e recreativos não só contribui para o bem-estar dos moradores, mas também fomenta um senso de comunidade mais forte, onde os vizinhos podem desfrutar de atividades ao ar livre juntos, promovendo a interação e o compartilhamento de experiências.</p>', 5, 'on'),
(6, '2024-02-27 21:36:21', 'https://picsum.photos/204', 'Apartamento Conjugado', 'Dicas e truques para manter suas orquídeas saudáveis e florescentes.', 4, '<p>\r\nUm apartamento conjugado, também conhecido como studio, é um tipo de unidade residencial que combina vários espaços funcionais em uma única área sem divisórias estruturais. Geralmente, esses espaços incluem uma área de dormir, uma sala de estar, uma cozinha compacta e um banheiro, todos integrados em um layout aberto. A principal característica de um apartamento conjugado é a otimização do espaço, o que o torna uma opção popular para solteiros, casais ou pessoas que procuram uma moradia compacta e prática.</p>\r\n        <figure>\r\n        <img src=\"https://picsum.photos/300/200\" alt=\"Imagem qualquer\">    \r\n        <figcaption>Imagem aleatória.</figcaption>                    \r\n        </figure>\r\n      <p>Esse tipo de apartamento é ideal para quem valoriza a praticidade e a simplicidade, já que oferece todas as comodidades básicas em um único espaço. A falta de divisórias estruturais pode criar uma sensação de amplitude e luminosidade, além de permitir uma maior flexibilidade no design e decoração do ambiente. No entanto, é importante considerar que a privacidade pode ser limitada em um apartamento conjugado devido à ausência de áreas separadas, o que pode não ser adequado para todos os estilos de vida.</p>\r\n    ', 6, 'on'),
(7, '2024-02-27 21:36:21', 'https://picsum.photos/205', 'Condomínio Comercial', 'Um guia para cultivar cactos em condições extremas de desertos.', 1, '\r\n        <p>Um condomínio comercial é um empreendimento imobiliário composto por múltiplas unidades comerciais dentro de um mesmo complexo ou edifício. Cada unidade comercial é de propriedade individual, mas compartilha certas áreas e serviços comuns, como corredores, estacionamento, segurança e manutenção. Esses condomínios são projetados para abrigar uma variedade de negócios e empresas, desde escritórios e consultórios até lojas e restaurantes.</p>\r\n        <p>\r\nUm condomínio comercial é um empreendimento imobiliário composto por múltiplas unidades comerciais dentro de um mesmo complexo ou edifício. Cada unidade comercial é de propriedade individual, mas compartilha certas áreas e serviços comuns, como corredores, estacionamento, segurança e manutenção. Esses condomínios são projetados para abrigar uma variedade de negócios e empresas, desde escritórios e consultórios até lojas e restaurantes.\r\n\r\nA principal vantagem de um condomínio comercial é a possibilidade de compartilhar custos operacionais e de manutenção entre os proprietários das unidades comerciais. Isso pode resultar em economia de despesas, tornando a posse de um espaço comercial mais acessível para pequenas empresas e empreendedores. Além disso, a localização central e a infraestrutura compartilhada podem atrair clientes e aumentar o potencial de sucesso dos negócios instalados no condomínio.</p>\r\n        <figure>\r\n        <img src=\"https://picsum.photos/300/200\" alt=\"Imagem qualquer\">    \r\n        <figcaption>Imagem aleatória.</figcaption>                    \r\n        </figure>\r\n        <p>Por outro lado, é importante considerar que os proprietários das unidades comerciais devem cumprir as regras e regulamentos estabelecidos pelo condomínio, o que pode limitar sua liberdade operacional em relação ao próprio espaço. Além disso, é essencial garantir uma gestão eficiente do condomínio para manter a qualidade dos serviços compartilhados e resolver eventuais conflitos entre os proprietários das unidades. Em resumo, um condomínio comercial oferece uma solução conveniente e econômica para empresas que buscam espaço em uma localização central e desejam compartilhar recursos e custos com outros negócios.</p>\r\n    ', 13, 'on'),
(8, '2024-02-27 21:36:21', 'https://picsum.photos/206', 'Projeto Personalizado', 'Descubra como cuidar das suculentas de forma fácil e eficaz.', 3, '<p>Um projeto personalizado é uma abordagem na arquitetura e no design que se concentra em criar soluções exclusivas e adaptadas às necessidades específicas de cada cliente. Em vez de adotar um modelo padrão ou pré-fabricado, um projeto personalizado envolve uma colaboração próxima entre o cliente e os profissionais de design, como arquitetos e designers de interiores. Durante esse processo, são considerados diversos fatores, como as preferências estéticas do cliente, seu estilo de vida, requisitos funcionais e orçamento disponível.</p>\r\n            <figure>\r\n            <img src=\"https://picsum.photos/300/200\" alt=\"Imagem qualquer\">    \r\n            <figcaption>Imagem aleatória.</figcaption>                    \r\n            </figure>\r\n          <p>Essa abordagem permite que o cliente tenha controle total sobre todos os aspectos do projeto, desde o layout do espaço até a seleção de materiais e acabamentos. A vantagem principal de um projeto personalizado é a criação de um ambiente verdadeiramente único e exclusivo, que reflete a personalidade e os gostos individuais do cliente. No entanto, é importante notar que esse tipo de projeto pode exigir mais tempo e recursos do que soluções pré-fabricadas, devido à sua natureza mais detalhada e personalizada.</p>\r\n        ', 3, 'on'),
(9, '2024-02-27 21:36:21', 'https://picsum.photos/207', 'Jardins Personalizadas Residencial', 'Saiba como criar um jardim vertical mesmo em ambientes compactos.', 4, '<p>Jardins personalizados residenciais são espaços ao ar livre projetados de acordo com as preferências individuais dos proprietários. Em vez de seguir modelos padronizados de paisagismo, esses jardins são criados para refletir o estilo, as necessidades e o gosto pessoal de cada cliente. Isso envolve colaboração entre o proprietário e um paisagista ou designer de jardins, onde são discutidos elementos como plantas, cores, texturas, estruturas e características especiais desejadas.</p>\r\n            <figure>\r\n            <img src=\"https://picsum.photos/300/200\" alt=\"Imagem qualquer\">    \r\n            <figcaption>Imagem aleatória.</figcaption>                    \r\n            </figure>\r\n           <p>Durante o processo de design, são considerados fatores como o clima local, a topografia do terreno, a disponibilidade de água e a manutenção necessária. O resultado é um jardim único e exclusivo, que não só complementa a estética da residência, mas também cria um espaço exterior funcional e agradável para os moradores desfrutarem.\r\n</p>\r\n        ', 1, 'on'),
(10, '2024-02-27 21:36:21', 'https://picsum.photos/208', 'Sitio Lazer', 'Aprenda a cultivar uma horta urbana sustentável em sua própria casa.', 1, '<p>Um sítio de lazer é uma propriedade rural projetada para proporcionar entretenimento e relaxamento longe das áreas urbanas. Geralmente equipados com uma variedade de comodidades, como casas, áreas de recreação ao ar livre e recursos naturais, esses sítios oferecem um refúgio tranquilo onde os proprietários e convidados podem desfrutar da natureza e participar de atividades recreativas.</p>\r\n            <figure>\r\n            <img src=\"https://picsum.photos/300/200\" alt=\"Imagem qualquer\">    \r\n            <figcaption>Imagem aleatória.</figcaption>                    \r\n            </figure>\r\n            <p>Esses espaços são projetados para proporcionar um ambiente relaxante e rejuvenescedor, permitindo que as pessoas se reconectem com a natureza e desfrutem de momentos de lazer com amigos e familiares. Combinando comodidades modernas e recursos naturais, os sítios de lazer oferecem uma fuga da vida urbana agitada e proporcionam uma oportunidade para relaxar e recarregar as energias em um ambiente natural e sereno.</p>\r\n        ', 19, 'on'),
(11, '2024-02-27 21:36:21', 'https://picsum.photos/209', 'Plantas Ornamentais ', 'Aprenda a cultivar uma horta urbana sustentável em sua própria casa.', 1, '<p>\r\nAdicionar plantas ornamentais ao redor de uma casa pode transformar significativamente sua aparência. As plantas ornamentais são escolhidas por suas características estéticas, como folhagens coloridas, flores vibrantes ou formas interessantes. Ao integrá-las ao paisagismo, elas podem suavizar as linhas rígidas da arquitetura, trazendo uma sensação de harmonia e beleza para o ambiente externo. Além disso, as plantas ornamentais podem ser usadas para destacar pontos focais da casa, como entradas, janelas ou varandas, criando uma entrada convidativa e agradável aos olhos.</p>\r\n            <figure>\r\n            <img src=\"https://picsum.photos/300/200\" alt=\"Imagem qualquer\">    \r\n            <figcaption>Imagem aleatória.</figcaption>                    \r\n            </figure>\r\n            <p>Por meio do uso estratégico de plantas ornamentais, é possível criar um ambiente exterior que complemente e aprimore o estilo arquitetônico da casa. As plantas podem adicionar camadas visuais interessantes, texturas e cores ao redor da estrutura, criando um cenário visualmente atraente. Além disso, elas podem proporcionar privacidade, sombra e até mesmo reduzir o calor, tornando o ambiente externo mais confortável e acolhedor. Em resumo, as plantas ornamentais têm o poder de transformar a aparência de uma casa, adicionando beleza, charme e caráter ao ambiente externo.</p>\r\n        ', 20, 'on'),
(12, '2024-02-27 21:36:21', 'https://picsum.photos/210', 'Galpões Industriais\r\n', 'Aprenda a cultivar uma horta urbana sustentável em sua própria casa.', 1, '<p>Galpões industriais são estruturas projetadas para armazenar e abrigar mercadorias, equipamentos ou realizar processos industriais. O funcionamento desses galpões depende do tipo de indústria ou atividade para a qual são destinados. Geralmente, eles são construídos com materiais resistentes, como aço ou concreto, e projetados para suportar cargas pesadas e proteger o conteúdo interno das intempéries. Internamente, podem incluir áreas de armazenamento, linhas de produção, escritórios e instalações para manuseio de materiais. A eficiência do funcionamento de um galpão industrial também depende de fatores como layout interno, acessibilidade, segurança e adequação às normas e regulamentações aplicáveis.</p>\r\n            <figure>\r\n            <img src=\"https://picsum.photos/300/200\" alt=\"Imagem qualquer\">    \r\n            <figcaption>Imagem aleatória.</figcaption>                    \r\n            </figure>\r\n            <p>\r\nGalpões industriais são estruturas projetadas para armazenar e abrigar mercadorias, equipamentos ou realizar processos industriais. O funcionamento desses galpões depende do tipo de indústria ou atividade para a qual são destinados. Geralmente, eles são construídos com materiais resistentes, como aço ou concreto, e projetados para suportar cargas pesadas e proteger o conteúdo interno das intempéries. Internamente, podem incluir áreas de armazenamento, linhas de produção, escritórios e instalações para manuseio de materiais. A eficiência do funcionamento de um galpão industrial também depende de fatores como layout interno, acessibilidade, segurança e adequação às normas e regulamentações aplicáveis.\r\n\r\nEsses galpões são essenciais para o funcionamento de diversas indústrias, desde armazenamento e distribuição até produção e logística. Eles são projetados para oferecer um ambiente funcional e seguro para as operações industriais, permitindo o armazenamento adequado de materiais, a movimentação eficiente de mercadorias e o funcionamento adequado das linhas de produção. Em resumo, os galpões industriais são espaços versáteis e adaptáveis que desempenham um papel fundamental no funcionamento de muitas empresas e indústrias.</p>\r\n        ', 19, 'on');


    -- Popular tabela images
    INSERT INTO images
    (
    img_article, 
    img_link

    ) VALUES(
    "1",
    "https://picsum.photos/300"
    ), ("1",
    "https://picsum.photos/301"), ("1",
    "https://picsum.photos/302");

-- Popular tabela 'comment'.
INSERT INTO comment 
(
    cmt_article,
    cmt_social_id,
    cmt_social_name,
    cmt_social_photo,
    cmt_social_email,
    cmt_content
) VALUES
(
    '1', 
    'abc123',
    'Mariah do Bairro', 
    'https://randomuser.me/api/portraits/women/40.jpg',
    'mariahbairro@gmail.com',
    'Não gosto de Figos. Eles tem caroços.'
), (
    '2', 
    'def456',
    'Esmeraldino', 
    'https://randomuser.me/api/portraits/lego/7.jpg',
    'esmeraldo@dino.com',
    'Prefiro os cravos às rosas. Pelo menos eles não tem espinhos.'
), (
    '1', 
    'ghi890',
    'Pedro Pedroso', 
    'https://randomuser.me/api/portraits/men/87.jpg',
    'pedro@pedroso.com',
    'Fogos são gostosos somente no Natal.'
), (
    '1', 
    'ghi890',
    'Pedro Pedroso', 
    'https://randomuser.me/api/portraits/men/87.jpg',
    'pedro@pedroso.com',
    'Fogos são gostosos somente no Natal.'
), (
    '2', 
    'ghi890',
    'Pedro Pedroso', 
    'https://randomuser.me/api/portraits/men/87.jpg',
    'pedro@pedroso.com',
    'Fogos são gostosos somente no Natal.'
), (
    '1', 
    'ghi890',
    'Pedro Pedroso', 
    'https://randomuser.me/api/portraits/men/87.jpg',
    'pedro@pedroso.com',
    'Fogos são gostosos somente no Natal.'
), (
    '3', 
    'ghi890',
    'Pedro Pedroso', 
    'https://randomuser.me/api/portraits/men/87.jpg',
    'pedro@pedroso.com',
    'Fogos são gostosos somente no Natal.'
);

-- Popular tabela 'contact'.
