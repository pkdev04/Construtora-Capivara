// Seleciona os elementos do HTML para interação
const userName = document.getElementById('userName');
const userCard = document.getElementById('userCard');
const btnGoogleProfile = document.getElementById('btnGoogleProfile');
const btnLogout = document.getElementById('btnLogout');

// Monitora se houve mudanças na autenticação do usuário
firebase.auth().onAuthStateChanged((user) => {
    if (user) {
        // Se alguém se logou, faça isso:
        // Chama a função que exibe o card do usuário logado
        showUserCard(user);
        // Monitora cliques no botão perfil
        btnGoogleProfile.addEventListener('click', viewProfile);
    } else {
        // Se alguém deslogou, faça isso:
        // Obtém o parâmetro do link da página
        var searchParams = new URLSearchParams(window.location.search);
        // Obtém o valor do parâmetro "ref"
        var refValue = searchParams.get('ref');
        // Redireciona para a página de origem
        location.href = refValue ? refValue : 'index.php';
    }
});

// Função que exibe o card do usuário logado
function showUserCard(user) {

    // Converte as datas para pt-br
    createdDateBr = convertTimestampToDateFormat(user.metadata.creationTime);
    lastSignInBr = convertTimestampToDateFormat(user.metadata.lastSignInTime);
    
    
    

    // Variável com a view do card
    var userCardData = `
    
<img src="${user.photoURL}" alt="${user.displayName}" referrerpolicy="no-referrer">
<h4>${user.displayName}</h4>
<ul>
    <li>E-mail: ${user.email}</li>
    <li>Cadastrado em ${createdDateBr}</li>
    <li>Último login em ${lastSignInBr}</li>
</ul>
    
    `;

    // Envia a variável para a view
    userCard.innerHTML = userCardData;

    // Exibe a view
    userCard.style.display = 'block';

}

// Exibe o perfil do usuario no Google
function viewProfile() {
    window.open('https://myaccount.google.com/', '_blank');
}

// Faz logout do usuario atual
function fbLogout(){

    // Para desconectar um usuario, chame signout
    firebase.auth().signout();

}