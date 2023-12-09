# Instruções de Instalação do Projeto Pauliceia

Este guia passo a passo irá auxiliá-lo na configuração do ambiente para o projeto Pauliceia.

## Pré-requisitos

Antes de iniciar, certifique-se de ter instalado:

- [Node Version Manager (nvm)](https://github.com/nvm-sh/nvm)
- [Docker Desktop](https://www.docker.com/products/docker-desktop/)
- [PostgreSQL e PostGIS](https://geoone.com.br/instalacao-postgresql-postgis/)
- [GeoServer](https://geoserver.org/release/stable/)

## Configuração do Ambiente

### Configurando Node.js

1. Abra o terminal e navegue até o diretório do projeto:

```
cd pauliceia
```

2. Instale e use o Node.js versão 8.17.0 usando nvm:

```
nvm install 8.17.0
nvm use 8.17.0
```

3. Copie o arquivo de configuração de exemplo:

```
cp config/prod.env.js.EXAMPLE config/prod.env.js
```

> ou faça manualmente

4. Instale as dependências do projeto:

```
npm i
```

5. Inicie a aplicação:

```
npm start
```

6. Acesse a aplicação em: [http://localhost:8080/](http://localhost:8080/)

#### Testes no Pauliceia

1. Instale o [Ruby](https://rubyinstaller.org/downloads/)
2. Rode o comando a seguir para instalar as bibliotecas de teste (Capybara + Cucumber):

```
bundle install
```

### Configurando PostgreSQL e PostGIS

1. Instale o PostgreSQL e PostGIS seguindo as instruções disponíveis em [GeoOne](https://geoone.com.br/instalacao-postgresql-postgis/).
2. Crie um banco de dados chamado 'pauliceia' e o outro chamado 'pauliceia-test'.
3. Habilite as extensões necessárias nos dois bancos, através dos comandos a seguir (utilize a QueryTool do PgAdmin4)

```
CREATE EXTENSION postgis;
CREATE EXTENSION unaccent;
```

```
CREATE TABLE pauliceia_user (
  user_id INT PRIMARY KEY,
  email TEXT,
  password TEXT,
  username TEXT,
  name TEXT,
  created_at TIMESTAMP,
  terms_agreed BOOLEAN,
  login_date TIMESTAMP,
  is_the_admin BOOLEAN,
  is_email_valid BOOLEAN,
  is_curator BOOLEAN,
  receive_notification_by_email BOOLEAN,
  profile_text TEXT,
  picture VARCHAR
  social_id TEXT,
  social_account TEXT
);

CREATE TABLE notification (
  notification_id INT PRIMARY KEY,
  description TEXT,
  created_at TIMESTAMP,
  is_done BOOLEAN,
  user_id_creator INT,
  layer_id INT,
  notification_id_parent INT
);

CREATE TABLE user_notification (
  user_id INT,
  notification_id INT,
  PRIMARY KEY (user_id, notification_id),
  FOREIGN KEY (user_id) REFERENCES pauliceia_user(user_id),
  FOREIGN KEY (notification_id) REFERENCES notification(notification_id)
);

ALTER TABLE notification
  ADD CONSTRAINT fk_notification_parent FOREIGN KEY (notification_id_parent) REFERENCES notification(notification_id);

CREATE TABLE layer (
  layer_id INT PRIMARY KEY,
  table_name TEXT,
  name TEXT,
  description TEXT,
  source_description TEXT,
  created_at TIMESTAMP
);

CREATE TABLE user_layer (
  user_id INT,
  layer_id INT,
  created_at TIMESTAMP,
  is_the_creator BOOLEAN,
  PRIMARY KEY (user_id, layer_id),
  FOREIGN KEY (user_id) REFERENCES pauliceia_user(user_id),
  FOREIGN KEY (layer_id) REFERENCES layer(layer_id)
);

CREATE TABLE layer_followers (
  user_id INT,
  layer_id INT,
  created_at TIMESTAMP,
  PRIMARY KEY (user_id, layer_id),
  FOREIGN KEY (user_id) REFERENCES pauliceia_user(user_id),
  FOREIGN KEY (layer_id) REFERENCES layer(layer_id)
);

CREATE TABLE keyword (
  keyword_id INT PRIMARY KEY,
  name TEXT,
  created_at TIMESTAMP,
  user_id_creator INT
);

ALTER TABLE keyword
  ADD CONSTRAINT fk_keyword_user_id_creator FOREIGN KEY (user_id_creator) REFERENCES pauliceia_user(user_id);

CREATE TABLE layer_keyword (
  layer_id INT,
  keyword_id INT,
  PRIMARY KEY (layer_id, keyword_id),
  FOREIGN KEY (layer_id) REFERENCES layer(layer_id),
  FOREIGN KEY (keyword_id) REFERENCES keyword(keyword_id)
);

CREATE TABLE reference (
  reference_id INT PRIMARY KEY,
  description TEXT,
  user_id_creator INT
);

ALTER TABLE reference
  ADD CONSTRAINT fk_reference_user_id_creator FOREIGN KEY (user_id_creator) REFERENCES pauliceia_user(user_id);

CREATE TABLE layer_reference (
  layer_id INT,
  reference_id INT,
  PRIMARY KEY (layer_id, reference_id),
  FOREIGN KEY (layer_id) REFERENCES layer(layer_id),
  FOREIGN KEY (reference_id) REFERENCES reference(reference_id)
);

CREATE TABLE changeset (
  changeset_id INT PRIMARY KEY,
  description TEXT,
  created_at TIMESTAMP,
  closed_at TIMESTAMP,
  user_id_creator INT,
  layer_id INT,
  FOREIGN KEY (user_id_creator) REFERENCES pauliceia_user(user_id),
  FOREIGN KEY (layer_id) REFERENCES layer(layer_id)
);

CREATE TABLE version_feature_table (
  id INT PRIMARY KEY,
  geom GEOMETRY(GEOMETRYCOLLECTION),
  attributes TEXT,
  version INT,
  removed_at TIMESTAMP,
  changeset_id INT,
  FOREIGN KEY (changeset_id) REFERENCES changeset(changeset_id)
);

CREATE TABLE feature_table (
  id INT PRIMARY KEY,
  geom GEOMETRY(GEOMETRYCOLLECTION),
  attributes TEXT,
  version INT,
  changeset_id INT,
  FOREIGN KEY (changeset_id) REFERENCES changeset(changeset_id)
);

CREATE TABLE mask (
  mask_id INT PRIMARY KEY,
  mask_text TEXT
);

CREATE TABLE media_columns (
  table_name TEXT,
  media_column_name TEXT,
  media_type TEXT,
  PRIMARY KEY (table_name, media_column_name)
);

CREATE TABLE temporal_columns (
  table_name TEXT,
  start_date_column_name TEXT,
  end_date_column_name TEXT,
  start_date TIMESTAMP,
  end_date TIMESTAMP,
  start_date_mask_id INT,
  end_date_mask_id INT,
  PRIMARY KEY (table_name, start_date_column_name, end_date_column_name),
  FOREIGN KEY (start_date_mask_id) REFERENCES mask(mask_id),
  FOREIGN KEY (end_date_mask_id) REFERENCES mask(mask_id)
);

```

4. Configure o acesso externo conforme as instruções deste [link](https://stackoverflow.com/questions/1287067/unable-to-connect-postgresql-to-remote-database-using-pgadmin).

### Configurando GeoServer

1. Instale o GeoServer conforme as instruções do [site oficial](https://geoserver.org/release/stable/).
2. Durante a instalação, selecione a porta `8085` (para evitar conflito com a porta `8080` usada pelo frontend).
3. Após a instalação, acesse [http://localhost:8085/geoserver/web/?0](http://localhost:8085/geoserver/web/?0).
4. Faça login com as credenciais fornecidas durante a instalação.
5. No painel de controle do GeoServer, vá em 'Workspace' e crie dois workspaces: `pauliceia` e `pauliceia-test`.
6. Em 'Stores', crie um novo store para cada workspace (`pauliceia` e `pauliceia-test`), e insira as informações do banco de dados correspondentes.

### Configurando Outros Componentes

#### GeoServer REST

```
cd geoserver-rest
npm install
```

Faça uma cópia do arquivo environment-test.js na pasta \_config e altere o nome para envirnment.js. Altere as configurações se necessário

```
npm start
```

#### VGIWS

```
cd vgiws
```

Na pasta settings, faça uma cópia de SAMPLE_db_settings.py e altere o nome do arquivo para db_settings.py.

Preencha as variáveis conforme sua configuração.

Após isso, rode os comando a seguir no terminal para criar os containers do Docker (o Docker deve estar aberto para funcionar corretamente).

```
docker build -t vgiws .
docker run -d --name apivgiws -p 8888:8888 -e TZ=America/Sao_Paulo vgiws
```

# Testes de Aceitação

1. Estão localizados em pauliceia/features
2. No terminal, na pasta pauliceia, digite 'cucumber' para rodar os testes
