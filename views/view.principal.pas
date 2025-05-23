unit view.principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.StrUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.MPlayer, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage, System.ImageList, Vcl.ImgList, Vcl.StdCtrls, System.RegularExpressions;

type
  TViewMusicPlayer = class(TForm)
    pnlHeader: TPanel;
    pnlContent: TPanel;
    btnPlay: TImage;
    btnNext: TImage;
    btnPrevious: TImage;
    pnlTrackBar: TPanel;
    imgCircleTrackBar: TImage;
    btnClose: TImage;
    lblTitle: TLabel;
    lblSongTitle: TLabel;
    lblArtist: TLabel;
    imgFavorite: TImage;
    OpenDialog: TOpenDialog;
    btnAdd: TImage;
    listMusic: TListBox;
    MediaPlayer: TMediaPlayer;
    btnPause: TImage;
    imgRaposaDown: TImage;
    imgRaposaUp: TImage;
    Timer: TTimer;
    procedure btnPlayClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure pnlHeaderMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnAddClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure listMusicDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure AtualizarLabelMusica(const FilePath: string);
    procedure TimerTimer(Sender: TObject);
  private
    { Private declarations }
    isPlaying: Boolean;
    isPaused: Boolean;
  public
    { Public declarations }
  end;

var
  ViewMusicPlayer: TViewMusicPlayer;

implementation

{$R *.dfm}

procedure TViewMusicPlayer.btnPlayClick(Sender: TObject);
begin
  if not isPlaying then
  begin
    if listMusic.ItemIndex > -1 then
    begin
      MediaPlayer.FileName := string(listMusic.Items.Objects[listMusic.ItemIndex]);
      MediaPlayer.Open;
      MediaPlayer.Play;
      isPlaying := True;
      isPaused := False;
      btnPause.Visible := True;
      btnPlay.Visible := False;
      imgRaposaDown.Visible := False;
      imgRaposaUp.Visible := True;
      Timer.Enabled := True;
    end;
  end
  else
  begin
    if not isPaused then
    begin
      MediaPlayer.Pause;
      isPaused := True;
      btnPlay.Visible := True;
      btnPause.Visible := False;
      imgRaposaDown.Visible := True;
      imgRaposaUp.Visible := False;
    end
    else
    begin
      MediaPlayer.Play;
      isPaused := False;
      btnPlay.Visible := False;
      btnPause.Visible := True;
      imgRaposaDown.Visible := False;
      imgRaposaUp.Visible := True;
    end;
  end;
end;

procedure TViewMusicPlayer.FormCreate(Sender: TObject);
begin
  isPlaying := False;
  isPaused := False;
end;

procedure TViewMusicPlayer.listMusicDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  with (Control as TListBox).Canvas do
  begin

    if odSelected in State then
    begin
      Brush.Color := $00E4E4C9;       // fundo
      Font.Color := clWhite;        // cor do texto
    end
    else
    begin
      Brush.Color := $00E4E4C9;       // fundo normal
      Font.Color := clWhite;
    end;

    FillRect(Rect);
    TextOut(Rect.Left + 4, Rect.Top + 2, listMusic.Items[Index]);

     // sem ret�ngulo de foco
     if odFocused in State then
       DrawFocusRect(Rect);
  end;
end;


procedure TViewMusicPlayer.AtualizarLabelMusica(const FilePath: string);
var
  NomeArquivo, NomeMusica, NomeArtista: string;
  Partes: TArray<string>;
begin
  NomeArquivo := ChangeFileExt(ExtractFileName(FilePath), '');

  // quebra o nome em duas partes, artista e m�sica, com regex flex�vel
  Partes := TRegEx.Split(NomeArquivo, '\s*-\s*');

  if Length(Partes) = 2 then
  begin
    NomeArtista := Partes[0].Trim;
    NomeMusica := Partes[1].Trim;

    // remove o que estiver entre par�nteses na m�sica
    NomeMusica := TRegEx.Replace(NomeMusica, '\s*\(.*\)', '', [roIgnoreCase]);
  end
  else
  begin
    NomeArtista := 'Desconhecido';
    NomeMusica := NomeArquivo;
  end;

  lblArtist.Caption := 'Artista: ' + NomeArtista;
  lblSongTitle.Caption := 'M�sica: ' + NomeMusica;
end;

procedure TViewMusicPlayer.btnAddClick(Sender: TObject);
var
  filePath: string;
begin
  OpenDialog.Filter := 'Arquivos de �udio|*.mp3;*.wav';

  if OpenDialog.Execute then
  begin
    filePath := OpenDialog.FileName;

    listMusic.Items.AddObject(
      ExtractFileName(filePath),
      TObject(filePath)
    );

    // atualiza as labels com base no nome do arquivo
    AtualizarLabelMusica(filePath);
  end;
end;

procedure TViewMusicPlayer.btnCloseClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TViewMusicPlayer.pnlHeaderMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
const
   sc_DragMove = $f012;
begin
  ReleaseCapture;
  Perform(wm_SysCommand, sc_DragMove, 0);
end;

procedure TViewMusicPlayer.TimerTimer(Sender: TObject);
var
  Progresso: Double;
  LarguraBarra, NovaPosicao: Integer;
begin
  if (MediaPlayer.Mode = mpPlaying) and (MediaPlayer.Length > 0) then
  begin
    Progresso := MediaPlayer.Position / MediaPlayer.Length;
    LarguraBarra := pnlTrackBar.Width - imgCircleTrackBar.Width;
    NovaPosicao := pnlTrackBar.Left + Round(Progresso * LarguraBarra);
    imgCircleTrackBar.Left := NovaPosicao;
  end;
end;

end.
