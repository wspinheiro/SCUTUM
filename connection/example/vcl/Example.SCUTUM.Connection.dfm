object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 463
  ClientWidth = 494
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  DesignSize = (
    494
    463)
  PixelsPerInch = 96
  TextHeight = 16
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 473
    Height = 121
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Connection Params'
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 24
      Width = 38
      Height = 16
      Caption = 'Server'
    end
    object Label2: TLabel
      Left = 8
      Top = 54
      Width = 26
      Height = 16
      Caption = 'User'
    end
    object Label3: TLabel
      Left = 182
      Top = 54
      Width = 55
      Height = 16
      Caption = 'Password'
    end
    object Label4: TLabel
      Left = 182
      Top = 24
      Width = 53
      Height = 16
      Caption = 'Database'
    end
    object Label5: TLabel
      Left = 8
      Top = 84
      Width = 42
      Height = 16
      Caption = 'Factory'
    end
    object edtServer: TEdit
      Left = 55
      Top = 21
      Width = 121
      Height = 24
      TabOrder = 0
    end
    object edtUser: TEdit
      Left = 55
      Top = 51
      Width = 121
      Height = 24
      TabOrder = 2
    end
    object edtPass: TEdit
      Left = 242
      Top = 51
      Width = 121
      Height = 24
      TabOrder = 3
    end
    object edtDatabase: TEdit
      Left = 242
      Top = 21
      Width = 121
      Height = 24
      TabOrder = 1
    end
    object BitBtn1: TBitBtn
      Left = 369
      Top = 21
      Width = 96
      Height = 84
      Action = acActiveConnection
      Caption = 'Active Connection'
      TabOrder = 4
      WordWrap = True
    end
    object cmbTypeFactory: TComboBox
      Left = 55
      Top = 81
      Width = 308
      Height = 24
      Style = csDropDownList
      TabOrder = 5
      Items.Strings = (
        'Firebird - DBX'
        'Firebird - Firedac'
        'SQL Server - Firedac')
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 135
    Width = 473
    Height = 166
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Grid'
    TabOrder = 1
    DesignSize = (
      473
      166)
    object DBGrid1: TDBGrid
      Left = 5
      Top = 16
      Width = 462
      Height = 113
      Anchors = [akLeft, akTop, akRight, akBottom]
      DataSource = DataSource
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -13
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
    object BitBtn2: TBitBtn
      Left = 5
      Top = 135
      Width = 462
      Height = 25
      Action = acOpenQueryGrid
      Anchors = [akLeft, akRight, akBottom]
      Caption = 'Open Query Grid'
      TabOrder = 1
    end
  end
  object GroupBox3: TGroupBox
    Left = 8
    Top = 307
    Width = 473
    Height = 142
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = 'List'
    TabOrder = 2
    DesignSize = (
      473
      142)
    object ListView: TListView
      Left = 8
      Top = 16
      Width = 459
      Height = 89
      Anchors = [akLeft, akTop, akRight, akBottom]
      Columns = <
        item
          AutoSize = True
        end>
      TabOrder = 0
      ViewStyle = vsReport
    end
    object BitBtn3: TBitBtn
      Left = 8
      Top = 111
      Width = 459
      Height = 25
      Action = acQueryList
      Anchors = [akLeft, akRight, akBottom]
      Caption = 'List By Query'
      TabOrder = 1
    end
  end
  object ActionList: TActionList
    Left = 296
    Top = 40
    object acActiveConnection: TAction
      Caption = 'Active Connection'
      OnExecute = acActiveConnectionExecute
    end
    object acOpenQueryGrid: TAction
      Caption = 'Open Query Grid'
      OnExecute = acOpenQueryGridExecute
    end
    object acQueryList: TAction
      Caption = 'List By Query'
      OnExecute = acQueryListExecute
    end
  end
  object DataSource: TDataSource
    Left = 240
    Top = 208
  end
end
