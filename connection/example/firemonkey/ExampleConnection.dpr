program ExampleConnection;

uses
  FMX.Forms,
  Example.SCUTUM.Connection in 'Example.SCUTUM.Connection.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
