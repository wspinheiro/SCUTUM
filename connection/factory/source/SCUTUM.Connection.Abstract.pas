unit SCUTUM.Connection.Abstract;

interface

uses
  System.Classes, Data.DB;

type
  ISCUTUMConnectionAbstract = interface
    procedure SetDatabase(const ADatabase : String);
    procedure SetUsername(const AUsername : String);
    procedure SetPassword(const APassword : String);
    procedure SetServer(const AServer : String);
    procedure Open;
    procedure Close;
    function ConcreteConnection : TComponent;
  end;

  ISCUTUMQueryAbstract = interface
    procedure Open;
    procedure Close;
    procedure ExecSql;
    procedure SetConnection(Value : ISCUTUMConnectionAbstract);
    function GetConnection: ISCUTUMConnectionAbstract;
    function DataSet : TDataSet;
    function SQL : TStrings;
  end;

  ISCUTUMConnectionFactoryAbstract = interface
    function CreateConnection : ISCUTUMConnectionAbstract;
    function CreateQuery : ISCUTUMQueryAbstract;
  end;

implementation

end.
