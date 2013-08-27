unit SCUTUM.Connection.Firebird.FireDac;

interface
uses
  SCUTUM.Connection.Generic.FireDac,
  SCUTUM.Connection.Abstract;

type
  TSCUTUMConnectionFirebirdFireDac = class(TSCUTUMConnectionGenericFireDac ,ISCUTUMConnectionAbstract)
  public
    procedure Open;override;
  end;

  TSCUTUMConnectionFactoryFirebirdFireDac = class(TSCUTUMConnectionFactoryGenericFireDac, ISCUTUMConnectionFactoryAbstract)
  public
    function CreateConnection: ISCUTUMConnectionAbstract;override;
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

function TSCUTUMConnectionFactoryFirebirdFireDac.CreateConnection: ISCUTUMConnectionAbstract;
begin
  Result := TSCUTUMConnectionFirebirdFireDac.Create;
end;

end.
