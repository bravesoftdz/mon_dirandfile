unit MonDirAndFile;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, ExtCtrls, XPMan;

type
  TForm1 = class(TForm)
    Pathforsrc: TLabeledEdit;
    Button1: TButton;
    SubDirs: TCheckBox;
    EventGrid: TStringGrid;
    XPManifest1: TXPManifest;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure WMUSERONE(var Msg: TMessage); message WM_USER+101;

  end;

var
  Form1: TForm1;
  j:integer;
implementation
Uses Sanningthread;
var
Thread1 : TScandirandFilethread = nil;
Thread2 : TScandirandFilethread = nil;
{$R *.dfm}

procedure TForm1.WMUSERONE(var Msg: TMessage);
var
    m: PMyMsg;
    i:integer;
begin
 m := Pointer(Msg.WParam);
 i:=0;
if j<eventgrid.RowCount then
if (m.podiya='Added') or (m.podiya='Removed') then begin
Eventgrid.RowCount:=EventGrid.RowCount+1;
EventGrid.Cells[i,j]:=inttostr(j);
EventGrid.Cells[i+1,j]:=m.edate;
EventGrid.Cells[i+2,j]:=m.etime;
EventGrid.Cells[i+3,j]:=m.podiya;
EventGrid.Cells[i+4,j]:=m.tip;
EventGrid.Cells[i+5,j]:=m.povn;
inc(j);
end;
dispose(m);
end;


procedure TForm1.FormCreate(Sender: TObject);
begin
j:=1;
Subdirs.Checked:=true;
EventGrid.Cells[0,0]:='№ п\п';
EventGrid.Cells[1,0]:='Дата';
EventGrid.Cells[2,0]:='Время';
EventGrid.Cells[3,0]:='Действие';
Eventgrid.Cells[4,0]:='Тип';
EventGrid.Cells[5,0]:='Путь и имя';
end;
 ///////////////////////////

 ///////////////////////////
procedure TForm1.Button1Click(Sender: TObject);
begin
  if Thread1 = nil then begin
    button1.Caption := 'Стоп';
    Thread1 := TScandirandFilethread.Create(False,'C:\', SubDirs.Checked,FOrm1.Handle);
  end else begin
    Button1.Caption := 'Старт';
    Thread1.Terminate;
    Thread1 := nil;
   end;
  if Thread2 = nil then begin
    button1.Caption := 'Стоп';
    Thread2 := TScandirandFilethread.Create(False,'D:\', SubDirs.Checked,FOrm1.Handle);
  end else begin
    Button1.Caption := 'Старт';
    Thread2.Terminate;
    Thread2 := nil;
   end;
end;


procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
if Thread1 <> nil then Thread1.Terminate;
if Thread2 <> nil then Thread2.Terminate;
end;

end.
