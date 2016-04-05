object fabout: Tfabout
  Left = 215
  Top = 123
  Width = 123
  Height = 113
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
  object ListBox1: TListBox
    Left = 0
    Top = 0
    Width = 115
    Height = 79
    Align = alClient
    ItemHeight = 13
    TabOrder = 0
  end
  object ApplicationEvents1: TApplicationEvents
    OnException = LogException
    Left = 8
    Top = 44
  end
  object ADO: TADOConnection
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=1.mdb;Persist Secur' +
      'ity Info=False'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    AfterConnect = ADOAfterConnect
    AfterDisconnect = ADOAfterDisconnect
    Left = 8
    Top = 12
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 76
    Top = 8
  end
end
