# 🚌 Locomove

Locomove é um app iOS que ajuda quem depende do transporte público em São Paulo a encontrar linhas de ônibus e suas paradas em tempo real, direto no mapa. Ele consome a API pública **SPTrans Olho Vivo** para trazer dados oficiais das linhas que circulam pela cidade.

A ideia nasceu de um problema simples e cotidiano: saber rapidamente onde pegar o ônibus certo, sem precisar abrir três apps diferentes ou adivinhar em qual esquina fica o ponto.

---

## ✨ Funcionalidades

- **Busca de linhas** por número ou destino, com resultados instantâneos conforme você digita
- **Mapa interativo** com a localização do usuário e os pontos de parada da linha selecionada
- **Detalhes da linha**: letreiro, terminal de origem, terminal de destino e quantidade de paradas
- **Painel deslizante (bottom sheet)** que expande e recolhe suavemente entre a busca e o mapa
- Centralização automática do mapa na região da linha assim que ela é selecionada

## 🛠️ Tecnologias

- **SwiftUI** — toda a interface, incluindo o comportamento de sheet expansível
- **MapKit** — exibição do mapa, anotações de paradas e localização do usuário
- **Combine** — propagação de estado entre a camada de API e a interface
- **Swift Concurrency (async/await)** — chamadas de rede e atualizações de estado na main thread
- **Core Location** — permissão e obtenção da localização do usuário

## 🏗️ Arquitetura

O projeto segue o padrão **MVVM**:

```
Locomove
├── Model/          → LineModel e StopModel (structs Codable que espelham o payload da Olho Vivo)
├── ViewModel/       → APIViewModel (autenticação, busca de linhas e paradas) e LocationManager
├── View/            → ContentView (mapa + sheet) e SheetView (busca e lista de resultados)
└── Components/      → LineCard, LineIdentificator, ArrowComponent, PointIdentificator
```

A `APIViewModel` centraliza a comunicação com a Olho Vivo: autentica com token, busca linhas por termo e busca as paradas de uma linha selecionada, publicando tudo via `@Published` para a interface reagir automaticamente.

## 🚀 Como rodar

1. Clone o repositório e abra `Checkin.xcodeproj` no Xcode
2. Gere um token de acesso na [API SPTrans Olho Vivo](https://www.sptrans.com.br/desenvolvedores/api-do-olho-vivo-guia-de-referencia/) (é gratuito, basta se cadastrar)
3. Insira seu token no lugar do token de autenticação usado em `SheetView.swift`
4. Rode em um simulador ou dispositivo com iOS mais recente e permita o acesso à localização

> ⚠️ **Nota de segurança:** atualmente o token da API está declarado direto no código-fonte. Antes de publicar o app ou compartilhar o repositório publicamente, mova-o para fora do controle de versão (variável de ambiente, arquivo `.xcconfig` ignorado no Git, ou um serviço de configuração remota).

## 🔭 Próximos passos

- Externalizar o token de API do código-fonte
- Restringir o `NSAllowsArbitraryLoads` do `Info.plist` a domínios específicos (App Transport Security)
- Rota entre a localização do usuário e a parada selecionada
- Previsão de chegada do ônibus em tempo real
- Favoritar linhas de uso frequente

---

Desenvolvido por **André Contarelli Lima**, estudante da Apple Developer Academy (Mackenzie/Apple).
