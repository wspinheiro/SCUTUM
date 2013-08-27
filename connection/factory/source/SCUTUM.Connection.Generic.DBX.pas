unit SCUTUM.Connection.Generic.DBX;

interface

uses
  SCUTUM.Connection.Abstract,
  Data.SqlExpr,
  Datasnap.DBClient,
  Datasnap.Provider,
  Data.DB,
  System.Classes;

type
  TSCUTUMConnectionGenericDbx = class(TInterfacedObject ,ISCUTUMConnectionAbstract)
  protected
    FConnection : TSQLConnection;
    FDatabase : String;
    FUsername : String;
    FPassword : String;
    FServer   : String;
  public
    procedure Open;virtual;
    procedure Close;
    function ConcreteConnection: TComponent;
    procedure SetDatabase(const ADatabase: string);
    procedure SetPassword(const APassword: string);
    procedure SetUsername(const AUsername: string);
    procedure SetServer(const AServer: string);
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
  end;

  TSCUTUMQueryGenericDbx = class(TInterfacedObject,ISCUTUMQueryAbstract)
  private
    FQuery : TSQLQuery;
    FCds   : TClientDataSet;
    FProvider : TDataSetProvider;
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

  TSCUTUMConnectionFactoryGenericDbx = class(TInterfacedObject, ISCUTUMConnectionFactoryAbstract)
  public
    function CreateConnection: ISCUTUMConnectionAbstract;virtual;
    function CreateQuery: ISCUTUMQueryAbstract;
  end;

implementation

uses
  System.SysUtils;

{ TSCUTUMConnectionFirebird }

procedure TSCUTUMConnectionGenericDbx.AfterConstruction;
begin
  inherited;
  Self.FConnection := TSQLConnection.Create(nil);
end;

procedure TSCUTUMConnectionGenericDbx.BeforeDestruction;
begin
  Self.FConnection.Free;
  inherited;
end;

procedure TSCUTUMConnectionGenericDbx.Close;
begin
  Self.FConnection.Close;
end;

function TSCUTUMConnectionGenericDbx.ConcreteConnection: TComponent;
begin
  Result := Self.FConnection;
end;

procedure TSCUTUMConnectionGenericDbx.Open;
begin
  with Self.FConnection do
  begin
    with Params do
    begin
      Values['User_name'] := Self.FUsername;
      Values['Password'] := Self.FPassword;
      Values['Database'] := Format('%s:%s',[self.FServer,Self.FDatabase]);
    end;
    LoginPrompt := false;
  end;
  Self.FConnection.Open;
end;

procedure TSCUTUMConnectionGenericDbx.SetDatabase(const ADatabase: string);
begin
  Self.FDatabase := ADatabase;
end;

procedure TSCUTUMConnectionGenericDbx.SetPassword(const APassword: string);
begin
  Self.FPassword := APassword;
end;

procedure TSCUTUMConnectionGenericDbx.SetServer(const AServer: string);
begin
  Self.FServer := AServer;
end;

procedure TSCUTUMConnectionGenericDbx.SetUsername(const AUsername: string);
begin
  Self.FUsername := AUsername;
end;

{ TSCUTUMQueryFirebird }

procedure TSCUTUMQueryGenericDbx.AfterConstruction;
begin
  inherited;
  Self.FQuery := TSQLQuery.Create(nil);
  Self.FProvider := TDataSetProvider.Create(nil);
  Self.FCds      := TClientDataSet.Create(nil);

  Self.FProvider.DataSet := Self.FQuery;
  Self.FCds.SetProvider(Self.FProvider);
end;

procedure TSCUTUMQueryGenericDbx.BeforeDestruction;
begin
  Self.FCds.Free;
  Self.FProvider.Free;
  Self.FQuery.Free;
  inherited;
end;

procedure TSCUTUMQueryGenericDbx.Close;
begin
  Self.FCds.Close;
end;

function TSCUTUMQueryGenericDbx.DataSet: TDataSet;
begin
  Result := Self.FCds;
end;

procedure TSCUTUMQueryGenericDbx.ExecSql;
begin
  Self.FQuery.ExecSQL();
end;

function TSCUTUMQueryGenericDbx.GetConnection: ISCUTUMConnectionAbstract;
begin
  Result := Self.FConnection;
end;

procedure TSCUTUMQueryGenericDbx.Open;
begin
  Self.FCds.Open;
end;

procedure TSCUTUMQueryGenericDbx.SetConnection(Value: ISCUTUMConnectionAbstract);
begin
  Self.FConnection := Value;
  Self.FQuery.SQLConnection := TSQLConnection(Self.FConnection.ConcreteConnection());
end;

function TSCUTUMQueryGenericDbx.SQL: TStrings;
begin
  Result := Self.FQuery.SQL;
end;

{ TSCUTUMConnectionFactoryFirebird }

function TSCUTUMConnectionFactoryGenericDbx.CreateConnection: ISCUTUMConnectionAbstract;
begin
  Result := TSCUTUMConnectionGenericDbx.Create;
end;

function TSCUTUMConnectionFactoryGenericDbx.CreateQuery: ISCUTUMQueryAbstract;
begin
  Result := TSCUTUMQueryGenericDbx.Create;
end;

end.
