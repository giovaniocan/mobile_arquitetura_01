# mobile_arquitetura_01

Aplicacao Flutter desenvolvida para a atividade de Arquitetura em Camadas da disciplina Desenvolvimento para Dispositivos Moveis II.

## Objetivo

Consumir a API publica `https://fakestoreapi.com/products` e exibir uma lista de produtos com:

- titulo
- preco
- imagem

## Arquitetura utilizada

O projeto foi organizado nas seguintes camadas:

- `presentation`: telas, widgets e controller da interface
- `domain`: entidades, contratos e caso de uso
- `data`: models, datasource remoto e implementacao do repositorio
- `core`: utilitarios compartilhados, como cliente HTTP e tratamento de erro

## Estrutura de pastas

```text
lib/
  core/
  data/
  domain/
  presentation/
```

## Como executar

```bash
flutter pub get
flutter run
```

## Como testar

```bash
flutter analyze
flutter test
```

## Funcionamento

Ao abrir a aplicacao, a tela principal faz a requisicao para a API, converte os dados em objetos da aplicacao e exibe os produtos em uma lista.

Tambem foi implementado:

- carregamento com `CircularProgressIndicator`
- tratamento simples de erro com botao para tentar novamente
- teste de widget para validar a exibicao da lista
