unit main;

interface

uses
 windows, messages, sysutils, classes, graphics, controls, svcmgr, dialogs,
 menus, ExtCtrls;

type
 tFileMon = class(tservice)
    procedure ServiceStop(sender: tservice; var stopped: boolean);
    procedure ServiceStart(sender: tservice; var started: boolean);
 private
 public
    function getservicecontroller: TServiceController; override;
 end;

var
 FileMon: tFileMon;

implementation

uses aboutform;

{$r *.dfm}

procedure servicecontroller(ctrlcode: dword); stdcall;
begin
 FileMon.controller(ctrlcode);
end;

function tFileMon.getservicecontroller: TServiceController;
begin
 result:=servicecontroller;
end;

procedure tFileMon.ServiceStart(sender: tservice; var started: boolean);
begin
 started:=true;
 fabout.Log('---------------------------------------',False);
 fabout.Log('Started service');
end;

procedure tFileMon.ServiceStop(sender: tservice; var stopped: boolean);
begin
 fabout.Log('Stopped service');
 fabout.Log('',False);
 stopped:=True;
end;

end.
