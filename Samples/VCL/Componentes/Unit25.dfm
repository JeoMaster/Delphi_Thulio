object Form25: TForm25
  Left = 0
  Top = 0
  Caption = 'Form25'
  ClientHeight = 479
  ClientWidth = 834
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 8
    Top = 0
    Width = 818
    Height = 377
    Caption = 'Panel1'
    TabOrder = 0
    object Label1: TLabel
      Left = 24
      Top = 3
      Width = 38
      Height = 13
      Caption = 'AutoInc'
    end
    object MongoImage1: TMongoImage
      Left = 367
      Top = 16
      Width = 124
      Height = 129
      MongoCampo = 'foto'
    end
    object Label2: TLabel
      Left = 367
      Top = 151
      Width = 69
      Height = 13
      Caption = 'Abrir uma foto'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsUnderline]
      ParentFont = False
      OnClick = Label2Click
      OnMouseEnter = Label2MouseEnter
      OnMouseLeave = Label2MouseLeave
    end
    object Bevel1: TBevel
      Left = 360
      Top = 9
      Width = 138
      Height = 142
    end
    object MongoEdit1: TMongoEdit
      Left = 24
      Top = 64
      Width = 305
      Height = 21
      TabOrder = 0
      Text = ''
      MongoCampo = 'nome'
      AutoInc = False
      CampoChave = False
    end
    object MongoCheckBox1: TMongoCheckBox
      Left = 24
      Top = 91
      Width = 97
      Height = 17
      Caption = 'inativo'
      Checked = False
      TabOrder = 1
      MongoCampo = 'inativo'
    end
    object MongoEdit2: TMongoEdit
      Left = 24
      Top = 16
      Width = 113
      Height = 21
      Enabled = False
      TabOrder = 2
      Text = ''
      MongoCampo = 'IDPessoa'
      AutoInc = True
      CampoChave = True
    end
    object MongoListBox1: TMongoListBox
      Left = 24
      Top = 114
      Width = 305
      Height = 183
      ItemHeight = 13
      Items.Strings = (
        'Vermelho'
        'Azul'
        'Verd'#227'o')
      TabOrder = 3
      MongoCampo = 'cores'
    end
    object MongoComboBox1: TMongoComboBox
      Left = 360
      Top = 170
      Width = 131
      Height = 21
      ItemIndex = 2
      TabOrder = 4
      Text = 'Pendente'
      Items.Strings = (
        'Aprovado'
        'Recusado'
        'Pendente')
      MongoCampo = 'aprovacao'
    end
    object MongoDateTimePicker1: TMongoDateTimePicker
      Left = 24
      Top = 303
      Width = 186
      Height = 21
      Date = 42708.724280671300000000
      Time = 42708.724280671300000000
      TabOrder = 5
      MongoCampo = 'data'
      MongoTipoCampo = Texto
    end
    object Mensagens: TMongoMemo
      Left = 504
      Top = 8
      Width = 289
      Height = 65
      Lines.Strings = (
        'Mensagens')
      TabOrder = 6
      MongoCampo = 'mensagens'
    end
    object MongoRadioButton1: TMongoRadioButton
      Left = 224
      Top = 307
      Width = 97
      Height = 17
      Caption = 'avisar'
      Checked = False
      TabOrder = 7
      MongoCampo = 'avisar'
    end
    object MongoRadioGroup1: TMongoRadioGroup
      Left = 360
      Top = 197
      Width = 139
      Height = 105
      Caption = 'Est'#225'gio'
      Items.Strings = (
        'apresenta'#231#227'o'
        'instrumenta'#231#227'o'
        'negocia'#231#227'o'
        'fechado'
        'perdido')
      TabOrder = 8
      MongoCampo = 'Estagio'
    end
    object MongoCalendarPicker1: TMongoCalendarPicker
      Left = 568
      Top = 316
      Height = 32
      CalendarHeaderInfo.DaysOfWeekFont.Charset = DEFAULT_CHARSET
      CalendarHeaderInfo.DaysOfWeekFont.Color = clWindowText
      CalendarHeaderInfo.DaysOfWeekFont.Height = -13
      CalendarHeaderInfo.DaysOfWeekFont.Name = 'Segoe UI'
      CalendarHeaderInfo.DaysOfWeekFont.Style = []
      CalendarHeaderInfo.Font.Charset = DEFAULT_CHARSET
      CalendarHeaderInfo.Font.Color = clWindowText
      CalendarHeaderInfo.Font.Height = -20
      CalendarHeaderInfo.Font.Name = 'Segoe UI'
      CalendarHeaderInfo.Font.Style = []
      Color = clWindow
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 9
      TextHint = 'select a date'
      MongoCampo = 'DataNascimento'
      MongoTipoCampo = Texto
    end
    object MongoToggleSwitch1: TMongoToggleSwitch
      Left = 721
      Top = 316
      Width = 72
      Height = 20
      TabOrder = 10
      MongoCampo = 'ligado'
      Checked = False
    end
    object MongoCalendarView1: TMongoCalendarView
      Left = 536
      Top = 79
      Width = 257
      Height = 231
      Date = 42708.000000000000000000
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Segoe UI'
      Font.Style = []
      HeaderInfo.DaysOfWeekFont.Charset = DEFAULT_CHARSET
      HeaderInfo.DaysOfWeekFont.Color = clWindowText
      HeaderInfo.DaysOfWeekFont.Height = -13
      HeaderInfo.DaysOfWeekFont.Name = 'Segoe UI'
      HeaderInfo.DaysOfWeekFont.Style = []
      HeaderInfo.Font.Charset = DEFAULT_CHARSET
      HeaderInfo.Font.Color = clWindowText
      HeaderInfo.Font.Height = -20
      HeaderInfo.Font.Name = 'Segoe UI'
      HeaderInfo.Font.Style = []
      ParentFont = False
      TabOrder = 11
      MongoCampo = 'Calendario'
      MongoTipoCampo = Texto
    end
  end
  object Button1: TButton
    Left = 16
    Top = 383
    Width = 137
    Height = 25
    Action = MongoInsert1
    Caption = 'Inserir Novo'
    TabOrder = 1
  end
  object Button2: TButton
    Left = 159
    Top = 383
    Width = 75
    Height = 25
    Action = MongoUpdate1
    TabOrder = 2
  end
  object Button3: TButton
    Left = 240
    Top = 384
    Width = 75
    Height = 25
    Action = MongoDelete1
    TabOrder = 3
  end
  object Button4: TButton
    Left = 321
    Top = 383
    Width = 75
    Height = 25
    Action = MongoSelectEdit1
    TabOrder = 4
  end
  object Button5: TButton
    Left = 402
    Top = 383
    Width = 75
    Height = 25
    Action = MongoLimpar1
    TabOrder = 5
  end
  object ActionList1: TActionList
    Left = 544
    Top = 40
    object MongoInsert1: TVCLMongoInsert
      Category = 'MongoVCL Components'
      Caption = 'MongoInsert1'
      MongoQuery = MongoQuery1
      Layout = Panel1
    end
    object MongoUpdate1: TVCLMongoUpdate
      Category = 'MongoVCL Components'
      Caption = 'Atualizar'
      MongoQuery = MongoQuery1
      Layout = Panel1
    end
    object MongoDelete1: TVCLMongoDelete
      Category = 'MongoVCL Components'
      Caption = 'Excluir'
      MongoQuery = MongoQuery1
      Layout = Panel1
    end
    object MongoSelectEdit1: TVCLMongoSelectEdit
      Category = 'MongoVCL Components'
      Caption = 'Recarregar'
      MongoQuery = MongoQuery1
      Layout = Panel1
    end
    object MongoLimpar1: TVCLMongoLimpar
      Category = 'MongoVCL Components'
      Caption = 'Limpar'
      MongoQuery = MongoQuery1
      Layout = Panel1
    end
  end
  object MongoConexao1: TMongoConexao
    Database = 'storeware'
    Host = 'localhost'
    Porta = 27017
    Ativar = True
    Left = 480
    Top = 112
  end
  object MongoQuery1: TMongoQuery
    MongoConexao = MongoConexao1
    Ativar = True
    Collection = 'Pessoas'
    Left = 416
    Top = 88
  end
  object OpenPictureDialog1: TOpenPictureDialog
    Left = 416
    Top = 40
  end
end
