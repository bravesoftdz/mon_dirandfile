Set objShellApp = CreateObject("Shell.Application")

ServiceName = "FileMon"

If objShellApp.IsServiceRunning(ServiceName) Then
  MsgBox "������ " & ServiceName & " �������!", vbInformation
Else
  MsgBox "������ " & ServiceName & " �� �������!", vbInformation
End If