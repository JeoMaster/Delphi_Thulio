object FormMatch: TFormMatch
  Left = 0
  Top = 0
  Caption = 'Match -> Comparison, Logical, Match, etc....'
  ClientHeight = 169
  ClientWidth = 684
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    684
    169)
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 10
    Top = 7
    Width = 190
    Height = 25
    Caption = 'Match ID'
    TabOrder = 0
    OnClick = Button1Click
  end
  object edID: TEdit
    Left = 206
    Top = 9
    Width = 464
    Height = 21
    Anchors = [akLeft, akTop, akRight, akBottom]
    AutoSelect = False
    AutoSize = False
    TabOrder = 1
    ExplicitWidth = 785
  end
  object Button2: TButton
    Left = 10
    Top = 38
    Width = 190
    Height = 25
    Caption = 'Match Valor > 10'
    TabOrder = 2
    OnClick = Button2Click
  end
  object edGT: TEdit
    Left = 206
    Top = 40
    Width = 464
    Height = 21
    Anchors = [akLeft, akTop, akRight, akBottom]
    AutoSelect = False
    AutoSize = False
    TabOrder = 3
    ExplicitWidth = 785
  end
  object Button3: TButton
    Left = 10
    Top = 70
    Width = 190
    Height = 25
    Caption = 'Valor > 10 and Valor < 30'
    TabOrder = 4
    OnClick = Button3Click
  end
  object Edit1: TEdit
    Left = 206
    Top = 72
    Width = 464
    Height = 21
    Anchors = [akLeft, akTop, akRight, akBottom]
    AutoSelect = False
    AutoSize = False
    TabOrder = 5
    ExplicitWidth = 785
  end
  object Button4: TButton
    Left = 10
    Top = 101
    Width = 190
    Height = 25
    Caption = 'OR'
    TabOrder = 6
    OnClick = Button4Click
  end
  object Edit2: TEdit
    Left = 206
    Top = 103
    Width = 464
    Height = 21
    Anchors = [akLeft, akTop, akRight, akBottom]
    AutoSelect = False
    AutoSize = False
    TabOrder = 7
    ExplicitWidth = 785
  end
  object Button5: TButton
    Left = 10
    Top = 132
    Width = 190
    Height = 25
    Caption = 'Regex (p/ seatle)'
    TabOrder = 8
    OnClick = Button5Click
  end
  object Edit3: TEdit
    Left = 206
    Top = 134
    Width = 464
    Height = 21
    Anchors = [akLeft, akTop, akRight, akBottom]
    AutoSelect = False
    AutoSize = False
    TabOrder = 9
    ExplicitWidth = 785
  end
end
