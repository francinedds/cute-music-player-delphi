# Music Player em Delphi 🦊

- Este é um simples e fofo reprodutor de música feito em Delphi (VCL). Ele permite que o usuário selecione uma música do computador, controle a reprodução com um botão play/pause, veja uma raposinha mudar de posição conforme a música, e usar uma barra de progresso (TrackBar) totalmente funcional para acompanhar a posição da música.

- Funcionalidades
  
Selecionar Música

Botão que abre um TOpenDialog para o usuário escolher um arquivo .mp3, .wav, etc

O caminho da música é carregado no TMediaPlayer, e o nome pode ser exibido num TLabel.

- ▶ Play / ⏸ Pause
Um botão alterna entre Play e Pause.

- Raposa Dinâmica
  
Um TImage exibe a raposinha.

A imagem é trocada automaticamente dependendo do estado da música.

A imagem da raposa muda conforme:

pngwing - raposa deitada → Música pausada.

pngwing - raposa em pé → Música tocando.

- TrackBar Funcional (Progresso da Música)
A TTrackBar mostra o progresso da música em tempo real.

A posição da barra se atualiza automaticamente enquanto a música toca.

- Componentes Usados 🛠️ 

TImage - Selecionar música, play/pause, botão fechar, next/previous, favoritar(esses últimos sem funcionalidades)

TOpenDialog	- Selecionar arquivos

TMediaPlayer -	Tocar música

TImage -	Mostrar a imagem da raposinha

TPanel -	Mostrar e controlar progresso da música

TImage - Circulo da TrackBar

TTimer -	Atualizar a TrackBar em tempo real

TLabel - 	Exibir nome da música e títulos

- Como Rodar 🚀

1. Abra o projeto no Delphi.

2. Adicione as imagens da raposa na pasta do executável ou ajuste os caminhos.

3. Compile e execute.

4. Clique em Procurar Música.

5. Clique sobre a música assim que ela aparecer na interface do music player.

6. Use os botões Play/Pause para interagir com a música.

7. Acompanhe a animação da raposinha enquanto a música toca! 
