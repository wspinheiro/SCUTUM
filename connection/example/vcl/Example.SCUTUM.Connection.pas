unit Example.SCUTUM.Connection;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SCUTUM.Connection.Abstract,
  System.Actions, Vcl.ActnList, Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtServer: TEdit;
    edtUser: TEdit;
    edtPass: TEdit;
    edtDatabase: TEdit;
    BitBtn1: TBitBtn;
    Label5: TLabel;
    cmbTypeFactory: TComboBox;
    ActionList: TActionList;
    acActiveConnection: TAction;
    GroupBox2: TGroupBox;
    DBGrid1: TDBGrid;
    BitBtn2: TBitBtn;
    acOpenQueryGrid: TAction;
    DataSource: TDataSource;
    GroupBox3: TGroupBox;
    ListView: TListView;
    BitBtn3: TBitBtn;
    acQueryList: TAction;
    procedure acActiveConnectionExecute(Sender: TObject);
    procedure acOpenQueryGridExecute(Sender: TObject);
    procedure acQueryListExecute(Sender: TObject);
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
  uADGUIxFormsWait; {Necessary because application uses DBGrid}
{$R *.dfm}

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
      Self.ListView.Items.Add.Caption := format('%d - %s',[DataSet.FieldByName('cdb_id').AsInteger, DataSet.FieldByName('cdb_unit').AsString]);
      DataSet.Next;
    end;
  end;
  oQuery.Close;
  acQueryList.Enabled := false;
end;

end.
