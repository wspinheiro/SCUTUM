unit SCUTUM.Connection.Firebird.FireDac;

interface
uses
  SCUTUM.Connection.Generic.FireDac,
  SCUTUM.Connection.Abstract;

type
  TSCUTUMConnectionFirebirdFireDac = class(TSCUTUMConnectionGenericFireDac ,ISCUTUMConnection)
  public
    procedure Open;override;
  end;

  TSCUTUMDatabaseFactoryFirebirdFireDac = class(TSCUTUMDatabaseFactoryGenericFireDac, ISCUTUMDatabaseFactory)
  public
    function CreateConnection: ISCUTUMConnection;override;
  end;

implementation
uses
  uADPhysIB;

{ TSCUTUMConnectionFirebirdFireDac }

procedure TSCUTUMConnectionFirebirdFireDac.Open;
begin
  with Self.FConnection do
  begin
    ConnectionName := 'FBConnectionFD';
    DriverName := 'IB';
    with Params do
    begin
      Values['DriverID'] := 'IB';
      Values['Database'] := Self.FDatabase;
      Values['User_Name'] := Self.FUsername;
      Values['Password'] := Self.FPassword;
      Values['Server']   := Self.FServer;
    end;
  end;
  inherited;
end;

{ TSCUTUMConnectionFactoryFirebirdFireDac }

function TSCUTUMDatabaseFactoryFirebirdFireDac.CreateConnection: ISCUTUMConnection;
begin
  Result := TSCUTUMConnectionFirebirdFireDac.Create;
end;

end.
