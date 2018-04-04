program Remover;

uses
  Forms,
  Remove in 'Remove.pas' {Form1},
  AboutForm in 'AboutForm.pas' {AboutBox};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.Run;
end.
