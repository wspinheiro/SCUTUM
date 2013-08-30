unit SCUTUM.Connection.Abstract;

interface

uses
  System.Classes, Data.DB;

type
  ISCUTUMConnection = interface
    procedure SetDatabase(const ADatabase : String);
    procedure SetUsername(const AUsername : String);
    procedure SetPassword(const APassword : String);
    procedure SetServer(const AServer : String);
    procedure BeginTrans;
    procedure Commit;
    procedure Rollback;
    procedure Open;
    procedure Close;
    function ConcreteConnection : TComponent;
  end;

  ISCUTUMQuery = interface
    procedure Open;
    procedure Close;
    procedure ExecSql;
    procedure SetConnection(Value : ISCUTUMConnection);
    function GetConnection: ISCUTUMConnection;
    function DataSet : TDataSet;
    function SQL : TStrings;
  end;

  ISCUTUMDatabaseFactory = interface
    function CreateConnection : ISCUTUMConnection;
    function CreateQuery : ISCUTUMQuery;
  end;

implementation

end.
