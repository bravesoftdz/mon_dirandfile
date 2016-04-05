unit aboutform;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ExtCtrls, Grids, strutils, AppEvnts, CoolTrayIcon,
  StdCtrls, DB, ADODB;

type
  Tfabout = class(TForm)
    ApplicationEvents1: TApplicationEvents;
    ListBox1: TListBox;
    ADO: TADOConnection;
    Timer1: TTimer;
    procedure LogException(Sender: TObject; E: Exception);
    procedure ADOAfterConnect(Sender: TObject);
    procedure ADOAfterDisconnect(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Log(Str:String;St:Boolean=True);
    procedure WMUSERONE(var Msg: TMessage); message WM_USER+101;
  end;

var
  fabout: Tfabout;

implementation

Uses Sanningthread;

var
 Thread : array of TScandirandFilethread;

{$R *.dfm}

function GetCurrentUserName: string;
const
 cnMaxUserNameLen = 254;
var
 sUserName: string;
 dwUserNameLen: DWORD;
begin
 dwUserNameLen := cnMaxUserNameLen - 1;
 SetLength(sUserName, cnMaxUserNameLen);
 GetUserName(PChar(sUserName), dwUserNameLen);
 SetLength(sUserName, dwUserNameLen);
 Result := trim(sUserName);
end;

function GetDriveFreeSpace(root: String): Int64;
var
 freeToCaller, totalBytes, freeBytes:Int64;
begin
 if GetDiskFreeSpaceEx(PAnsiChar(root), freeToCaller, totalBytes,
  PLargeInteger(Addr(freeBytes))) <> FALSE then
  GetDriveFreeSpace := freeBytes
 else
  GetDriveFreeSpace := -1;
end;

procedure Tfabout.WMUSERONE(var Msg: TMessage);
var
 m: PMyMsg;
 suser:string;
begin
 m := Pointer(Msg.WParam);
 suser := GetCurrentUserName;
 if (m.podiya='Added') or (m.podiya='Removed') then //писать только при Добавлении и Удалении
  try ADO.Execute('INSERT INTO [tbl] ([SUser],[SDate],[SDeistvie],[SType],[SPath]) VALUES ('+
   QuotedStr(suser)+','+QuotedStr(m.edate+' '+m.etime)+','+QuotedStr(m.podiya)+','+
   QuotedStr(m.tip)+','+QuotedStr(m.povn)+');');
  except end;
  dispose(m);
end;

procedure Tfabout.LogException(Sender: TObject; E: Exception);
var
 LogFile: TextFile;
begin
 try
  AssignFile(LogFile,ExtractFilePath(ParamStr(0))+'error_log.log');
  if FileExists(ExtractFilePath(ParamStr(0))+'error_log.log') then Append(LogFile) else Rewrite(LogFile);
  Writeln(LogFile,DateTimeToStr(Now)+': '+E.Message);
  CloseFile(LogFile);
 except end;
end;

procedure Tfabout.Log(Str:String;St:Boolean=True);
var
 LogFile: TextFile;
begin
 try
  AssignFile(LogFile,ExtractFilePath(ParamStr(0))+'log.log');
  if FileExists(ExtractFilePath(ParamStr(0))+'log.log') then Append(LogFile) else Rewrite(LogFile);
  if St then Writeln(LogFile,DateTimeToStr(Now)+': '+Str) else Writeln(LogFile,Str);
  CloseFile(LogFile);
 except end;
end;

procedure Tfabout.ADOAfterConnect(Sender: TObject);
begin
 fabout.Log('Connect BD');
end;

procedure Tfabout.ADOAfterDisconnect(Sender: TObject);
begin
 fabout.Log('Disconnect BD');
end;

function GetDriveHard:Boolean;
var
 W:DWORD;
 Root:String;
 I:Integer;
begin
 fabout.ListBox1.Items.Clear;
 W:=GetLogicalDrives;
 Root:='#:\';
 for I:=0 to 25 do begin
  Root[1]:=Char(Ord('A')+i);
  if (W and (1 shl i))>0 then
   if GetDriveType(Pchar(Root))=DRIVE_FIXED then fabout.ListBox1.Items.Add(Root);
 end;
 Result:=Boolean(fabout.ListBox1.Items.Count>0);
end;

procedure SetBDSpaceHard(root:string;dt:TDateTime);
begin
 with fabout do begin
  ADO.Execute('INSERT INTO [tm] ([root],[stime],[free_space]) VALUES ('+
   QuotedStr(root)+','+QuotedStr(DateTimeToStr(dt))+','+QuotedStr(IntToStr(GetDriveFreeSpace(root)))+');');
 end; //with
end;

procedure Tfabout.FormCreate(Sender: TObject);
var
 i:integer;
begin
 ADO.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+ExtractFilePath(ParamStr(0))+'1.mdb;Persist Security Info=False';
 ADO.Open;
 if GetDriveHard then begin
  SetLength(Thread,ListBox1.Items.Count);
  for i:=0 to ListBox1.Items.Count-1 do Thread[i] := nil;
  for i:=0 to ListBox1.Items.Count-1 do begin
   if Thread[i] = nil then
    Thread[i] := TScandirandFilethread.Create(False,ListBox1.Items[i], true,fabout.Handle);
  end; //for
 end; //if
end;

procedure Tfabout.FormClose(Sender: TObject; var Action: TCloseAction);
var
 i:integer;
begin
 for i:=0 to ListBox1.Items.Count-1 do if Thread[i]<>nil then Thread[i].Terminate;
end;

procedure Tfabout.Timer1Timer(Sender: TObject);
var
 H,M,S,A:Word;
 i:integer;
begin
 DecodeTime(Now,H,M,S,A);
 if (H in [0..23]) and (M=0) and (S=0) then begin
  for i:=0 to ListBox1.Items.Count-1 do SetBDSpaceHard(ListBox1.Items[i],Now);
 end; //if
end;

end.

