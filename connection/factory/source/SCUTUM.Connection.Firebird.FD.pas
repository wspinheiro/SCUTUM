unit SCUTUM.Connection.Firebird.FD;

interface

uses
  SCUTUM.Connection.Abstract,
  uADCompClient,
  Data.DB,
  System.Classes;

type
  TSCUTUMConnectionFirebirdFD = class(TInterfacedObject ,ISCUTUMConnectionAbstract)
  private
    FConnection : TADConnection;
    FDatabase : String;
    FUsername : String;
    FPassword : String;
    FServer : String;
  public
    procedure Open;
    procedure Close;
    function ConcreteConnection: TComponent;
    procedure SetDatabase(const ADatabase: string);
    procedure SetPassword(const APassword: string);
    procedure SetUsername(const AUsername: string);
    procedure SetServer(const AServer: string);
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

  end;

  TSCUTUMQueryFirebirdFD = class(TInterfacedObject,ISCUTUMQueryAbstract)
  private
    FQuery : TADQuery;
    FConnection : ISCUTUMConnectionAbstract;
  public
    procedure BeforeDestruction; override;
    procedure AfterConstruction; override;
    procedure Close;
    procedure ExecSql;
    procedure Open;
    procedure SetConnection(Value: ISCUTUMConnectionAbstract);
    function GetConnection: ISCUTUMConnectionAbstract;
    function DataSet: TDataSet;
    function SQL: TStrings;
  end;

  TSCUTUMConnectionFactoryFirebirdFD = class(TInterfacedObject, ISCUTUMConnectionFactoryAbstract)
  public
    function CreateConnection: ISCUTUMConnectionAbstract;
    function CreateQuery: ISCUTUMQueryAbstract;
  end;

implementation
uses
  uADStanDef,
  uADStanAsync,
  uADPhysIB,
  uADDAptManager,
  uADGUIxFormsWait;

{ TSCUTUMConnectionFirebirdFD }

procedure TSCUTUMConnectionFirebirdFD.AfterConstruction;
begin
  inherited;
  Self.FConnection := TADConnection.Create(nil);
end;

procedure TSCUTUMConnectionFirebirdFD.BeforeDestruction;
begin
  Self.FConnection.Free;
  inherited;
end;

procedure TSCUTUMConnectionFirebirdFD.Close;
begin
  Self.FConnection.Close;
end;

function TSCUTUMConnectionFirebirdFD.ConcreteConnection: TComponent;
begin
  Result := Self.FConnection;
end;

procedure TSCUTUMConnectionFirebirdFD.Open;
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
    end;
    LoginPrompt := false;
  end;
  Self.FConnection.Open();
end;

procedure TSCUTUMConnectionFirebirdFD.SetDatabase(const ADatabase: string);
begin
  Self.FDatabase := ADatabase;
end;

procedure TSCUTUMConnectionFirebirdFD.SetPassword(const APassword: string);
begin
  Self.FPassword := APassword;
end;

procedure TSCUTUMConnectionFirebirdFD.SetServer(const AServer: string);
begin
  Self.FServer := AServer;
end;

procedure TSCUTUMConnectionFirebirdFD.SetUsername(const AUsername: string);
begin
  Self.FUsername := AUsername;
end;

{ TSCUTUMQueryFirebirdFD }

procedure TSCUTUMQueryFirebirdFD.AfterConstruction;
begin
  inherited;
  Self.FQuery := TADQuery.Create(nil);
end;

procedure TSCUTUMQueryFirebirdFD.BeforeDestruction;
begin
  Self.FQuery.Free;
  inherited;
end;

procedure TSCUTUMQueryFirebirdFD.Close;
begin
  Self.FQuery.Close;
end;

function TSCUTUMQueryFirebirdFD.DataSet: TDataSet;
begin
  Result := Self.FQuery;
end;

procedure TSCUTUMQueryFirebirdFD.ExecSql;
begin
  Self.FQuery.ExecSQL();
end;

function TSCUTUMQueryFirebirdFD.GetConnection: ISCUTUMConnectionAbstract;
begin
  Result := Self.FConnection;
end;

procedure TSCUTUMQueryFirebirdFD.Open;
begin
  Self.FQuery.Open();
end;

procedure TSCUTUMQueryFirebirdFD.SetConnection(
  Value: ISCUTUMConnectionAbstract);
begin
  Self.FConnection := Value;
  Self.FQuery.Connection := TADCustomConnection(Self.FConnection.ConcreteConnection);
end;

function TSCUTUMQueryFirebirdFD.SQL: TStrings;
begin
  Result := Self.FQuery.SQL;
end;

{ TSCUTUMConnectionFactoryFirebirdFD }

function TSCUTUMConnectionFactoryFirebirdFD.CreateConnection: ISCUTUMConnectionAbstract;
begin
  Result := TSCUTUMConnectionFirebirdFD.Create;
end;

function TSCUTUMConnectionFactoryFirebirdFD.CreateQuery: ISCUTUMQueryAbstract;
begin
  Result := TSCUTUMQueryFirebirdFD.Create;
end;

end.
