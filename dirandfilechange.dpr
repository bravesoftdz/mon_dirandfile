program dirandfilechange;

uses
  Forms,
  MonDirAndFile in 'MonDirAndFile.pas' {Form1},
  SanningThread in 'SanningThread.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
