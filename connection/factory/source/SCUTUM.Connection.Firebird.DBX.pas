unit SCUTUM.Connection.Firebird.DBX;

interface

uses
  SCUTUM.Connection.Abstract,
  SCUTUM.Connection.Generic.DBX;

type
  TSCUTUMConnectionFirebirdDbx = class(TSCUTUMConnectionGenericDbx,ISCUTUMConnection)
  public
    procedure Open;override;
  end;

  TSCUTUMDatabaseFactoryFirebirdDbx = class(TSCUTUMDatabaseFactoryGenericDbx, ISCUTUMDatabaseFactory)
  public
    function CreateConnection: ISCUTUMConnection;override;
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

function TSCUTUMDatabaseFactoryFirebirdDbx.CreateConnection: ISCUTUMConnection;
begin
  Result := TSCUTUMConnectionFirebirdDbx.Create;
end;

end.
