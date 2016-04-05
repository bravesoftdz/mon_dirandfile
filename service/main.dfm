object FileMon: TFileMon
  OldCreateOrder = False
  AllowPause = False
  DisplayName = 'FileMonintor'
  Interactive = True
  OnStart = ServiceStart
  OnStop = ServiceStop
  Left = 192
  Top = 110
  Height = 150
  Width = 215
end
