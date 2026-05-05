# mobile_arquitetura_02

Projeto feito em Flutter para a disciplina de Desenvolvimento para Dispositivos Moveis II.

O app consome a API `https://fakestoreapi.com/products` e mostra os produtos em tela com titulo, preco e imagem.

Neste projeto eu organizei o codigo em camadas:

- `presentation`
- `domain`
- `data`
- `core`

Tambem foram adicionados:

- estado de carregamento
- estado de sucesso
- estado de erro
- tratamento de erro na requisicao
- cache local simples

## Como executar

```bash
flutter pub get
flutter run
```

## Atividade 5

### 1. Em qual camada foi implementado o mecanismo de cache? Explique por que essa decisao e adequada dentro da arquitetura proposta.

O cache foi implementado na camada `data`, no `ProductLocalDataSource`.

Eu considerei essa decisao adequada porque o cache faz parte do acesso aos dados. Assim, a interface nao precisa saber se os produtos vieram da internet ou do armazenamento local. Isso ajuda a manter o projeto mais organizado.

### 2. Por que o ViewModel nao deve realizar chamadas HTTP diretamente?

O ViewModel nao deve fazer chamadas HTTP diretamente porque a funcao dele e controlar o estado da tela.

Se ele tambem fizer requisicao na internet, acaba misturando responsabilidades. Isso deixa o codigo mais dificil de entender, testar e manter.

### 3. O que poderia acontecer se a interface acessasse diretamente o DataSource?

Se a interface acessasse direto o DataSource, o codigo ficaria mais acoplado e menos organizado.

Tambem ficaria mais dificil fazer manutencao, trocar implementacoes e reutilizar partes do sistema, porque a tela passaria a depender direto do acesso aos dados.

### 4. Como essa arquitetura facilitaria a substituicao da API por um banco de dados local?

Essa arquitetura facilita porque a tela nao depende direto da API.

Quem decide de onde os dados vao vir e o repositorio. Entao, se no futuro eu quiser trocar a API por um banco local, a maior parte da aplicacao pode continuar igual, mudando mais a camada de dados.
