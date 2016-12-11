object Form1: TForm1
  Left = 0
  Top = 0
  Caption = ' Delphi MongoDB mLab ACBr'
  ClientHeight = 388
  ClientWidth = 693
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object ToolBar1: TToolBar
    Left = 0
    Top = 352
    Width = 693
    Height = 36
    Align = alBottom
    Caption = 'ToolBar1'
    TabOrder = 0
    object Button1: TButton
      Left = 0
      Top = 0
      Width = 75
      Height = 22
      Caption = 'Conectar'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button3: TButton
      Left = 75
      Top = 0
      Width = 75
      Height = 22
      Caption = 'Inserir'
      TabOrder = 2
      OnClick = Button2Click
    end
    object btnUpdate: TButton
      Left = 150
      Top = 0
      Width = 75
      Height = 22
      Caption = 'Update'
      TabOrder = 3
      OnClick = btnUpdateClick
    end
    object btnBuscar: TButton
      Left = 225
      Top = 0
      Width = 75
      Height = 22
      Caption = 'Buscar'
      TabOrder = 1
      OnClick = btnBuscarClick
    end
  end
  object Memo1: TMemo
    Left = 0
    Top = 312
    Width = 693
    Height = 40
    Align = alBottom
    TabOrder = 1
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 693
    Height = 312
    Align = alClient
    TabOrder = 2
    ExplicitLeft = 8
    ExplicitTop = 8
    ExplicitWidth = 685
    ExplicitHeight = 284
    object Label8: TLabel
      Left = 24
      Top = 27
      Width = 36
      Height = 13
      Caption = 'Buscar:'
    end
    object edtBuscar: TEdit
      Left = 75
      Top = 24
      Width = 590
      Height = 21
      TabOrder = 0
    end
    object GroupBox1: TGroupBox
      Left = 16
      Top = 59
      Width = 657
      Height = 118
      Caption = ' Emitente '
      TabOrder = 1
      object Label1: TLabel
        Left = 456
        Top = 28
        Width = 54
        Height = 13
        Caption = 'CPF / CNPJ'
      end
      object Label2: TLabel
        Left = 13
        Top = 27
        Width = 31
        Height = 13
        Caption = 'Nome:'
      end
      object Label3: TLabel
        Left = 13
        Top = 54
        Width = 45
        Height = 13
        Caption = 'Fantasia:'
      end
      object Label4: TLabel
        Left = 325
        Top = 54
        Width = 18
        Height = 13
        Caption = 'I.E:'
      end
      object Label5: TLabel
        Left = 477
        Top = 54
        Width = 33
        Height = 13
        Caption = 'I.E ST:'
      end
      object Label6: TLabel
        Left = 13
        Top = 81
        Width = 16
        Height = 13
        Caption = 'IM:'
      end
      object Label7: TLabel
        Left = 312
        Top = 81
        Width = 31
        Height = 13
        Caption = 'CNAE:'
      end
      object edtCPF: TMongoEdit
        Left = 516
        Top = 24
        Width = 121
        Height = 21
        TabOrder = 0
        Text = ''
        MongoCampo = 'cNPJCPF'
        AutoInc = False
        CampoChave = False
      end
      object edtNome: TMongoEdit
        Left = 86
        Top = 24
        Width = 364
        Height = 21
        TabOrder = 1
        Text = ''
        MongoCampo = 'xNome'
        AutoInc = False
        CampoChave = False
      end
      object edtFantasia: TMongoEdit
        Left = 86
        Top = 51
        Width = 216
        Height = 21
        TabOrder = 2
        Text = ''
        MongoCampo = 'xFant'
        AutoInc = False
        CampoChave = False
      end
      object edtIE: TMongoEdit
        Left = 349
        Top = 51
        Width = 101
        Height = 21
        TabOrder = 3
        Text = ''
        MongoCampo = 'iE'
        AutoInc = False
        CampoChave = False
      end
      object edtIEST: TMongoEdit
        Left = 516
        Top = 51
        Width = 121
        Height = 21
        TabOrder = 4
        Text = ''
        MongoCampo = 'iEST'
        AutoInc = False
        CampoChave = False
      end
      object edtIM: TMongoEdit
        Left = 86
        Top = 78
        Width = 216
        Height = 21
        TabOrder = 5
        Text = ''
        MongoCampo = 'iM'
        AutoInc = False
        CampoChave = False
      end
      object edtCNAE: TMongoEdit
        Left = 349
        Top = 78
        Width = 101
        Height = 21
        TabOrder = 6
        Text = ''
        MongoCampo = 'cNAE'
        AutoInc = False
        CampoChave = False
      end
    end
    object GroupBox2: TGroupBox
      Left = 16
      Top = 183
      Width = 657
      Height = 98
      Caption = ' Endere'#231'o '
      TabOrder = 2
      object Label9: TLabel
        Left = 13
        Top = 26
        Width = 55
        Height = 13
        Caption = 'Logradouro'
      end
      object Label10: TLabel
        Left = 584
        Top = 26
        Width = 12
        Height = 13
        Caption = 'N'#186
      end
      object Label11: TLabel
        Left = 13
        Top = 53
        Width = 65
        Height = 13
        Caption = 'Complemento'
      end
      object Label12: TLabel
        Left = 311
        Top = 53
        Width = 32
        Height = 13
        Caption = 'Bairro:'
      end
      object Label13: TLabel
        Left = 473
        Top = 53
        Width = 37
        Height = 13
        Caption = 'Cidade:'
      end
      object edtEndLog: TEdit
        Left = 86
        Top = 23
        Width = 492
        Height = 21
        TabOrder = 0
      end
      object edtEndNumero: TMongoEdit
        Left = 602
        Top = 23
        Width = 35
        Height = 21
        TabOrder = 1
        Text = ''
        MongoCampo = 'iE'
        AutoInc = False
        CampoChave = False
      end
      object edtEndComp: TMongoEdit
        Left = 86
        Top = 50
        Width = 191
        Height = 21
        TabOrder = 2
        Text = ''
        MongoCampo = 'iE'
        AutoInc = False
        CampoChave = False
      end
      object edtEndBairro: TMongoEdit
        Left = 349
        Top = 50
        Width = 101
        Height = 21
        TabOrder = 3
        Text = ''
        MongoCampo = 'iE'
        AutoInc = False
        CampoChave = False
      end
      object edtEndCidade: TMongoEdit
        Left = 516
        Top = 50
        Width = 121
        Height = 21
        TabOrder = 4
        Text = ''
        MongoCampo = 'iE'
        AutoInc = False
        CampoChave = False
      end
    end
  end
  object MongoConexao1: TMongoConexao
    Database = 'zabuulabs'
    Host = 'ds135577.mlab.com'
    Porta = 35577
    Ativar = False
    User = 'delphi'
    Password = 'delphi'
    Authenticate = True
    Left = 568
    Top = 320
  end
  object MongoQuery1: TMongoQuery
    MongoConexao = MongoConexao1
    Ativar = False
    Collection = 'NFe'
    Left = 624
    Top = 320
  end
  object ACBrNFe1: TACBrNFe
    Configuracoes.Geral.SSLLib = libCapicomDelphiSoap
    Configuracoes.Geral.FormatoAlerta = 'TAG:%TAGNIVEL% ID:%ID%/%TAG%(%DESCRICAO%) - %MSG%.'
    Configuracoes.Geral.IncluirQRCodeXMLNFCe = False
    Configuracoes.WebServices.UF = 'SP'
    Configuracoes.WebServices.AguardarConsultaRet = 0
    Configuracoes.WebServices.QuebradeLinha = '|'
    Left = 656
    Top = 320
  end
end

