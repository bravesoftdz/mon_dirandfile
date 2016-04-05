unit SanningThread;

interface

uses
  Classes,Windows,SysUtils,Messages;

type
PMyMsg=^TMyMsg;
    TMyMsg=record
       scor:String;   //передача скороченого шляху
       povn:String;   //передача повного шляху
       podiya:String;  //передача шляху з подією
       edate:string;
       etime:string;
       tip:string;
    end;

TScandirandFilethread = class(TThread)
 private
    { Private declarations }
    Dir : string;
    SubDirs : Boolean;
    FWND: HWND;
  protected
    procedure Execute; override;
   public
    constructor Create(CreateSuspended : Boolean; const _Dir : string; _SubDirs : Boolean;Wnd: HWND);
  end;

implementation

constructor TScandirandFilethread.Create;
begin
  inherited Create(CreateSuspended);
  FWND := Wnd;
  Dir := _Dir;
  SubDirs := _SubDirs;
end;

procedure TScandirandFilethread.Execute;
type
  FILE_NOTIFY_INFORMATION = record
    NextEntryOffset: DWORD;
    Action: DWORD;
    FileNameLength: DWORD;
    FileName: array [0..0] of WCHAR;
  end;

var
  hDir : THandle;
  Buf : pointer;
  Returned, BufSize : dword;
  adr : DWORD;
  fni : ^FILE_NOTIFY_INFORMATION absolute adr;
  s : string;
  ws : WideString;
  m: PMyMsg;
const
  wcs                   = SizeOf(WideChar); // = 2
  FILE_LIST_DIRECTORY   = ($0001); // directory

begin
  hDir := CreateFile(PChar(Dir),
                     FILE_LIST_DIRECTORY,
                     FILE_SHARE_READ or FILE_SHARE_DELETE or FILE_SHARE_WRITE,
                     nil,
                     OPEN_EXISTING,
                     FILE_FLAG_BACKUP_SEMANTICS,
                     0);

  if hDir = INVALID_HANDLE_VALUE then Exit;

  BufSize := 16*1024*1024; // 16 метров - так навсякий пожарный :)
  GetMem(Buf, BufSize);

  repeat
    if ReadDirectoryChangesW(hDir, Buf, BufSize, SubDirs,
       FILE_NOTIFY_CHANGE_FILE_NAME or
       FILE_NOTIFY_CHANGE_DIR_NAME or
       {FILE_NOTIFY_CHANGE_ATTRIBUTES or}
       FILE_NOTIFY_CHANGE_SIZE or
       FILE_NOTIFY_CHANGE_LAST_WRITE or
       {FILE_NOTIFY_CHANGE_LAST_ACCESS or }
       FILE_NOTIFY_CHANGE_CREATION {or
       FILE_NOTIFY_CHANGE_SECURITY}
       , @Returned, nil, nil) then
    begin
      Adr := Cardinal(Buf);
      while Adr < (Cardinal(Buf) + Returned) do
      begin
        case fni^.Action of
          FILE_ACTION_ADDED            : s := 'Added';
          FILE_ACTION_REMOVED          : s := 'Removed';
          FILE_ACTION_MODIFIED         : s := 'Modified';
          FILE_ACTION_RENAMED_OLD_NAME : s := 'Renamed from';
          FILE_ACTION_RENAMED_NEW_NAME : s := 'Renamed to';
          else s := '0x' + IntToHex(fni^.Action, 8);
        end;
        SetLength(ws, fni^.FileNameLength div wcs);
        Move(fni^.FileName, ws[1],fni^.FileNameLength);
        ////////////////////////////////////////////////////
        New(m);
        m.podiya:=s;
        m.povn:=Dir+ws; //
        if fileexists(m.povn) then
        m.tip:='file' else
         if directoryexists(m.povn) then
           m.tip:='folder';
        m.edate:=datetostr(Date);
        m.etime:=timetostr(Time);
        PostMessage(FWND,WM_USER+101,Integer(m),0);
        ////////////////////////////////////////////////////
        Inc(adr, fni^.FileNameLength - wcs + SizeOf(fni^));
      end;
    end;
  until False;
  CloseHandle(hDir);
  FreeMem(Buf);
end;

end.
