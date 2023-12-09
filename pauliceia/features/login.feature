Feature: Usuário fazendo login
  Como um Usuário
  Quero fazer login
  Para acessar funcionalidades exclusivas

  Scenario: Login bem-sucedido
    Given Estou na página de logjn
    When Eu preencho as informações válidas
    And Eu clico em "Entrar"
    Then Eu deveria ser redirecionado para a página inicial
