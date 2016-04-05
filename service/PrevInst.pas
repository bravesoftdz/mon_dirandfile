unit PrevInst;

interface

uses Windows;

  function mt(nm:string):boolean;

implementation

function mt(nm:string):boolean;
var
  hMutex: integer;
begin
  result := false;
  hMutex := CreateMutex(nil, TRUE, Pchar(nm));
  if GetLastError <> 0 then result := true;
  ReleaseMutex(hMutex);
end;

end.
