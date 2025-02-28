Desafio Flutter Web - Estágio
📌 Projeto desenvolvido como parte do desafio técnico para a vaga de estágio.

1. Sobre o Projeto
Este projeto é uma aplicação Flutter Web que permite ao usuário:

- Fazer login com credenciais fixas.
- Anexar arquivos e visualizar a lista de anexos.
- Excluir arquivos e adicioná-los ao histórico.
- Restaurar arquivos excluídos do histórico.
- Fazer logout para voltar à tela de login.

2. Como Fazer o Login
Para acessar o sistema, utilize as credenciais abaixo:
-----------------------------
E-mail: usuario@email.com
Senha: 12345678
-----------------------------

3. Tecnologias Utilizadas
Flutter Web
Dart
Vercel (para hospedagem)
GitHub (para versionamento)
File Picker (para seleção de arquivos)

4. Link para Testar o Projeto
🔗 [Aplicação hospedada no Vercel](https://desafio-flutter-bpphina6l-victor-benattis-projects.vercel.app/)

5. Como Rodar o Projeto Localmente
Caso queira rodar o projeto na sua máquina, siga os passos:

    1- Clone o repositório:
        git clone https://github.com/victorbenatti/desafio-flutter-web
    2- Acesse a pasta do projeto:
        cd desafio-flutter-web
    3- Instale as dependências:
        flutter pub get
    4- Execute o projeto:
        flutter run -d chrome

6. Estrutura do Código
📂 lib/main.dart → Inicializa a aplicação e direciona para a LoginScreen.
📂 lib/login_screen.dart → Tela de login com validação e autenticação simulada.
📂 lib/home_screen.dart → Tela principal (CRUD de arquivos, histórico e logout).