program BigNumberAdd;

{$APPTYPE CONSOLE}

uses
  SysUtils, System,
  BigNumberCl in 'BigNumberCl.pas';
var
  BigNumber: TBigNumberCl;
  vFile: string;
begin
   // Имя файла входных-выходных данных
  if ParamCount  < 1
  then   vFile := 'numbers.txt'    //по умолчанию
  else  vFile := ParamStr(1);
  try
    BigNumber := TBigNumberCl.Create;
   try
     BigNumber.ReadFromFile(vFile);
     BigNumber.OpAdd;
     BigNumber.WriteToFile(vFile);

     Writeln( 'Ok. ' + BigNumber.FResult );

  except
    on E: Exception do
      Writeln('Error: ' + E.Message);
  end;
  finally
    BigNumber.Free;
  end;
  Readln; //Нажать Enter
end.

