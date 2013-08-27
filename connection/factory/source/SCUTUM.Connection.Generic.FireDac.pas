unit SCUTUM.Connection.Generic.FireDac;

interface

uses
  SCUTUM.Connection.Abstract,
  uADCompClient,
  Data.DB,
  System.Classes;

type
  TSCUTUMConnectionGenericFireDac = class(TInterfacedObject ,ISCUTUMConnectionAbstract)
  protected
    FConnection : TADConnection;
    FDatabase : String;
    FUsername : String;
    FPassword : String;
    FServer : String;
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

  TSCUTUMQueryGenericFireDac = class(TInterfacedObject,ISCUTUMQueryAbstract)
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

  TSCUTUMConnectionFactoryGenericFireDac = class(TInterfacedObject, ISCUTUMConnectionFactoryAbstract)
  public
    function CreateConnection: ISCUTUMConnectionAbstract;virtual;
    function CreateQuery: ISCUTUMQueryAbstract;
  end;

implementation
uses
  uADStanDef,
  uADStanAsync,
  uADDAptManager,
  uADGUIxFormsWait;

{ TSCUTUMConnectionFirebirdFD }

procedure TSCUTUMConnectionGenericFireDac.AfterConstruction;
begin
  inherited;
  Self.FConnection := TADConnection.Create(nil);
end;

procedure TSCUTUMConnectionGenericFireDac.BeforeDestruction;
begin
  Self.FConnection.Free;
  inherited;
end;

procedure TSCUTUMConnectionGenericFireDac.Close;
begin
  Self.FConnection.Close;
end;

function TSCUTUMConnectionGenericFireDac.ConcreteConnection: TComponent;
begin
  Result := Self.FConnection;
end;

procedure TSCUTUMConnectionGenericFireDac.Open;
begin
  Self.FConnection.LoginPrompt := false;
  Self.FConnection.Open();
end;

procedure TSCUTUMConnectionGenericFireDac.SetDatabase(const ADatabase: string);
begin
  Self.FDatabase := ADatabase;
end;

procedure TSCUTUMConnectionGenericFireDac.SetPassword(const APassword: string);
begin
  Self.FPassword := APassword;
end;

procedure TSCUTUMConnectionGenericFireDac.SetServer(const AServer: string);
begin
  Self.FServer := AServer;
end;

procedure TSCUTUMConnectionGenericFireDac.SetUsername(const AUsername: string);
begin
  Self.FUsername := AUsername;
end;

{ TSCUTUMQueryFirebirdFD }

procedure TSCUTUMQueryGenericFireDac.AfterConstruction;
begin
  inherited;
  Self.FQuery := TADQuery.Create(nil);
end;

procedure TSCUTUMQueryGenericFireDac.BeforeDestruction;
begin
  Self.FQuery.Free;
  inherited;
end;

procedure TSCUTUMQueryGenericFireDac.Close;
begin
  Self.FQuery.Close;
end;

function TSCUTUMQueryGenericFireDac.DataSet: TDataSet;
begin
  Result := Self.FQuery;
end;

procedure TSCUTUMQueryGenericFireDac.ExecSql;
begin
  Self.FQuery.ExecSQL();
end;

function TSCUTUMQueryGenericFireDac.GetConnection: ISCUTUMConnectionAbstract;
begin
  Result := Self.FConnection;
end;

procedure TSCUTUMQueryGenericFireDac.Open;
begin
  Self.FQuery.Open();
end;

procedure TSCUTUMQueryGenericFireDac.SetConnection(
  Value: ISCUTUMConnectionAbstract);
begin
  Self.FConnection := Value;
  Self.FQuery.Connection := TADCustomConnection(Self.FConnection.ConcreteConnection);
end;

function TSCUTUMQueryGenericFireDac.SQL: TStrings;
begin
  Result := Self.FQuery.SQL;
end;

{ TSCUTUMConnectionFactoryFirebirdFD }

function TSCUTUMConnectionFactoryGenericFireDac.CreateConnection: ISCUTUMConnectionAbstract;
begin
  Result := TSCUTUMConnectionGenericFireDac.Create;
end;

function TSCUTUMConnectionFactoryGenericFireDac.CreateQuery: ISCUTUMQueryAbstract;
begin
  Result := TSCUTUMQueryGenericFireDac.Create;
end;

end.
