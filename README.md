# mobile_arquitetura_01

Projeto Flutter da disciplina de Desenvolvimento para Dispositivos Moveis II.

O app utiliza a API [DummyJSON](https://dummyjson.com/) para autenticar usuarios e listar produtos. O fluxo principal exige login antes do acesso a listagem, exibe o nome do usuario autenticado, permite logout, abre a tela de detalhes do produto e oferece controle de favoritos com atualizacao automatica da interface.

## Estrutura

O projeto esta organizado com separacao entre responsabilidades:

- `lib/models`: modelos do usuario autenticado e do produto
- `lib/services`: comunicacao HTTP com a DummyJSON
- `lib/session`: controle da sessao autenticada
- `lib/pages`: telas de login, produtos e detalhes
- `lib/presentation/controllers`: controle de favoritos e estados auxiliares

## Funcionalidades implementadas

- login com validacao de usuario e senha
- chamada `POST /auth/login`
- tratamento de erro para credenciais invalidas
- bloqueio de acesso a tela de produtos sem login
- listagem via `GET /products`
- detalhes via `GET /products/{id}`
- exibicao do nome do usuario autenticado
- logout com retorno para o login
- favoritos com marcar, remover e atualizacao automatica da interface
- botao manual para atualizar a lista de produtos
- carregamento e tratamento de erro nas requisicoes

## Gerenciamento de estado

Neste projeto, o estado da interface foi resolvido com `setState` nas telas e `ChangeNotifier` nos controladores compartilhados. Essa escolha foi suficiente para o porte atual do app, manteve a implementacao simples e permitiu atualizar automaticamente a UI em login, favoritos, carregamento e detalhes.

## Como executar

```bash
flutter pub get
flutter run
```

## Credenciais de teste

- Usuario: `emilys`
- Senha: `emilyspass`
