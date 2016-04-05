Set objShellApp = CreateObject("Shell.Application")

ServiceName = "FileMon"

If objShellApp.IsServiceRunning(ServiceName) Then
  MsgBox "Сервис " & ServiceName & " запущен!", vbInformation
Else
  MsgBox "Сервис " & ServiceName & " НЕ запущен!", vbInformation
End If