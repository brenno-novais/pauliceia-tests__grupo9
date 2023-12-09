Given('Estou na página de login') do
    visit '/portal/login'
  end
  
  When('Preencho as informações de login com dados válidos') do
    fill_in 'Email', with: 'teste@example.com'
    fill_in 'Senha', with: 'senha123'
  end
  
  And('Clico em "Entrar"') do
    click_button 'Entrar'
  end
  
  Then('Devo ser redirecionado para a página inicial') do
    expect(current_path).to eq '/portal/home'
  end