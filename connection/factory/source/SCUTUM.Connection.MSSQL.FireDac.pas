unit SCUTUM.Connection.MSSQL.FireDac;

interface
uses
  SCUTUM.Connection.Generic.FireDac,
  SCUTUM.Connection.Abstract;

type
  TSCUTUMConnectionMSSQLFireDac = class(TSCUTUMConnectionGenericFireDac ,ISCUTUMConnection)
  public
    procedure Open;override;
  end;

  TSCUTUMDatabaseFactoryMSSQLFireDac = class(TSCUTUMDatabaseFactoryGenericFireDac, ISCUTUMDatabaseFactory)
  public
    function CreateConnection: ISCUTUMConnection;override;
  end;

implementation
uses
  uADPhysMSSQL;

{ TSCUTUMConnectionMSSQLFireDac }

procedure TSCUTUMConnectionMSSQLFireDac.Open;
begin
  with Self.FConnection do
  begin
    ConnectionName := 'MSSQLConnectionFD';
    DriverName := 'MSSQL';
    with Params do
    begin
      Values['DriverID'] := 'MSSQL';
      Values['Database'] := Self.FDatabase;
      Values['User_Name'] := Self.FUsername;
      Values['Password'] := Self.FPassword;
      Values['Server']   := Self.FServer;
      Values['MARS']     := 'yes';
    end;
  end;
  inherited;
end;

{ TSCUTUMDatabaseFactoryMSSQLFireDac }

function TSCUTUMDatabaseFactoryMSSQLFireDac.CreateConnection: ISCUTUMConnection;
begin
  Result := TSCUTUMConnectionMSSQLFireDac.Create;
end;

end.
