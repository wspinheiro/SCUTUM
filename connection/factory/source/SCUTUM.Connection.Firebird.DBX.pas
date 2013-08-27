unit SCUTUM.Connection.Firebird.DBX;

interface

uses
  SCUTUM.Connection.Abstract,
  SCUTUM.Connection.Generic.DBX;

type
  TSCUTUMConnectionFirebirdDbx = class(TSCUTUMConnectionGenericDbx,ISCUTUMConnectionAbstract)
  public
    procedure Open;override;
  end;

  TSCUTUMConnectionFactoryFirebirdDbx = class(TSCUTUMConnectionFactoryGenericDbx, ISCUTUMConnectionFactoryAbstract)
  public
    function CreateConnection: ISCUTUMConnectionAbstract;override;
  end;

implementation
uses
  DBXFirebird;

{ TSCUTUMConnectionFirebird }

procedure TSCUTUMConnectionFirebirdDbx.Open;
begin
  with Self.FConnection do
  begin
    ConnectionName := 'FBConnectionDBX';
    DriverName := 'Firebird';
    LibraryName := 'dbxfb.dll';
    VendorLib := 'fbclient.dll';
    GetDriverFunc := 'getSQLDriverINTERBASE';
  end;
  inherited;
end;

{ TSCUTUMConnectionFactoryFirebird }

function TSCUTUMConnectionFactoryFirebirdDbx.CreateConnection: ISCUTUMConnectionAbstract;
begin
  Result := TSCUTUMConnectionFirebirdDbx.Create;
end;

end.
