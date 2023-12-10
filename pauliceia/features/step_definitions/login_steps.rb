Given('Estou na página de login') do
  visit '/portal/login'
end

When('Eu preencho as informações válidas') do
  fill_in 'E-mail', with: 'usuario@example.com'
  fill_in 'Senha', with: 'senha123'
end

And('Eu clico em "Entrar"') do
  Capybara.current_session.driver.browser.manage.window.resize_to(1920, 1080)
  button = find_button('Entrar', match: :first)
end

Then('a API retorna sucesso no login') do
  stub_request(:get, "http://localhost:8888/api/vgi/api/auth/login")
    .to_return(status: 200, body: '', headers: {})
  stub_request(:get, "http://localhost:8888/api/vgi/api/user/?email=usuario@example.com")
    .to_return(status: 200, body: '{
                                    "type": "FeatureCollection",
                                    "features": [
                                        {
                                            "type": "User",
                                            "properties": {
                                                "name": "usuario",
                                                "email": "usuario@example.com",
                                                "picture": "",
                                                "user_id": 1,
                                                "username": "usuario",
                                                "social_id": "",
                                                "created_at": "2023-12-01 22:36:57",
                                                "login_date": null,
                                                "is_the_admin": false,
                                                "terms_agreed": true,
                                                "is_email_valid": true,
                                                "social_account": "",
                                                "receive_notification_by_email": false
                                            }
                                        }
                                    ]
                                }', headers: {})
end

And('o login é bem-sucedido e eu sou redirecionado para a página inicial') do
  assert_equal '/portal/login', current_path
end
