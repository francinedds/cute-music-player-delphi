program ProjetoMusicPlayer;

uses
  Vcl.Forms,
  view.principal in 'views\view.principal.pas' {ViewMusicPlayer};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TViewMusicPlayer, ViewMusicPlayer);
  Application.Run;
end.
