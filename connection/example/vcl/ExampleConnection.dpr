program ExampleConnection;

uses
  Vcl.Forms,
  Example.SCUTUM.Connection in 'Example.SCUTUM.Connection.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
