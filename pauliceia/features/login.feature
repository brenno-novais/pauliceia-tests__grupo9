Feature: Login do usuário
  Como um Usuário
  Quero fazer login
  Para acessar funcionalidades exclusivas
    
  Scenario: Login bem-sucedido
    Given Estou na página de login
    When Eu preencho as informações válidas
    And Eu clico em "Entrar"
    Then a API retorna sucesso no login
    And o login é bem-sucedido e eu sou redirecionado para a página inicial