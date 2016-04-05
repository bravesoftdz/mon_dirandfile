object Form1: TForm1
  Left = 192
  Top = 107
  Width = 870
  Height = 640
  Caption = #1057#1083#1077#1078#1077#1085#1080#1077' '#1079#1072' '#1087#1072#1087#1082#1072#1084#1080' '#1080' '#1092#1072#1081#1083#1072#1084#1080
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Pathforsrc: TLabeledEdit
    Left = 16
    Top = 24
    Width = 329
    Height = 21
    EditLabel.Width = 165
    EditLabel.Height = 13
    EditLabel.Caption = #1055#1091#1090#1100' '#1082' '#1080#1089#1089#1083#1077#1076#1091#1077#1084#1086#1081' '#1076#1080#1088#1077#1082#1090#1086#1088#1080#1080
    TabOrder = 0
    Text = 'D:\'
  end
  object Button1: TButton
    Left = 16
    Top = 88
    Width = 75
    Height = 25
    Caption = #1057#1090#1072#1088#1090
    TabOrder = 1
    OnClick = Button1Click
  end
  object SubDirs: TCheckBox
    Left = 16
    Top = 56
    Width = 137
    Height = 17
    Caption = #1042#1082#1083#1102#1095#1072#1103' '#1087#1086#1076#1082#1072#1090#1072#1083#1086#1075#1080
    TabOrder = 2
  end
  object EventGrid: TStringGrid
    Left = 8
    Top = 128
    Width = 833
    Height = 465
    ColCount = 6
    DefaultRowHeight = 18
    FixedCols = 0
    RowCount = 24
    TabOrder = 3
    ColWidths = (
      38
      62
      56
      59
      73
      534)
  end
  object XPManifest1: TXPManifest
    Left = 560
    Top = 32
  end
end
