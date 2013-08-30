unit Example.SCUTUM.Connection;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Rtti, System.Classes,
  System.Variants, FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs,
  FMX.StdCtrls, SCUTUM.Connection.Abstract, System.Actions, FMX.ActnList,
  FMX.Edit, FMX.ListBox, Fmx.Bind.Grid, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components,
  Data.Bind.Grid, Data.Bind.DBScope, Data.DB, FMX.Layouts, FMX.Grid,
  FMX.ListView.Types, FMX.ListView;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    btnConnection: TButton;
    ActionList: TActionList;
    acActiveConnection: TAction;
    Label1: TLabel;
    edtServer: TEdit;
    Label2: TLabel;
    edtDatabase: TEdit;
    Label3: TLabel;
    edtUser: TEdit;
    Label4: TLabel;
    edtPass: TEdit;
    Label5: TLabel;
    cmbTypeFactory: TComboBox;
    GroupBox2: TGroupBox;
    StringGrid: TStringGrid;
    DataSource: TDataSource;
    BindSourceDB1: TBindSourceDB;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    BindingsList1: TBindingsList;
    btnQueryGrid: TButton;
    acOpenQueryGrid: TAction;
    GroupBox3: TGroupBox;
    ListView: TListView;
    btnListQuery: TButton;
    acQueryList: TAction;
    procedure acActiveConnectionExecute(Sender: TObject);
    procedure acOpenQueryGridExecute(Sender: TObject);
    procedure acQueryListExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FFactory : ISCUTUMDatabaseFactory;
    FConn : ISCUTUMConnection;
    FQueryGrid : ISCUTUMQuery;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
uses
  SCUTUM.Connection.Firebird.FireDac,
  SCUTUM.Connection.MSSQL.FireDac,
  SCUTUM.Connection.Firebird.DBX,
  uADGUIxFMXWait; {Necessary because application uses Grid}

{$R *.fmx}

procedure TForm1.acActiveConnectionExecute(Sender: TObject);
begin
  case cmbTypeFactory.ItemIndex of
    0 : FFactory := TSCUTUMDatabaseFactoryFirebirdDbx.Create;
    1 : FFactory := TSCUTUMDatabaseFactoryFirebirdFireDac.Create;
    2 : FFactory := TSCUTUMDatabaseFactoryMSSQLFireDac.Create;
  end;

  FConn := FFactory.CreateConnection();
  with FConn do
  begin
    SetServer(edtServer.Text);
    SetDatabase(edtDatabase.Text);
    SetUsername(edtUser.Text);
    SetPassword(edtPass.Text);
    Open();
  end;
  acActiveConnection.Enabled := false;
end;

procedure TForm1.acOpenQueryGridExecute(Sender: TObject);
begin
  Self.FQueryGrid := Self.FFactory.CreateQuery;
  Self.FQueryGrid.SetConnection(Self.FConn);
  Self.FQueryGrid.SQL.Add('select * from TBL_CLASSES_DB');
  Self.FQueryGrid.Open;
  Self.DataSource.DataSet := Self.FQueryGrid.DataSet;
  acOpenQueryGrid.Enabled := false;
end;

procedure TForm1.acQueryListExecute(Sender: TObject);
var
  oQuery : ISCUTUMQuery;
begin
  oQuery := Self.FFactory.CreateQuery();
  with oQuery do
  begin
    SetConnection(Self.FConn);
    SQL.Add('select cdb_id, cdb_unit from TBL_CLASSES_DB');
    Open();
    DataSet.First;
    while not DataSet.Eof do
    begin
      Self.ListView.Items.Add.Text := format('%d - %s',[DataSet.FieldByName('cdb_id').AsInteger, DataSet.FieldByName('cdb_unit').AsString]);
      DataSet.Next;
    end;
  end;
  oQuery.Close;
  acQueryList.Enabled := false;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown := true;
end;

end.
