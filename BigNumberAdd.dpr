program BigNumberAdd;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  BigNumberCl in 'BigNumberCl.pas';
var
  BigNumber: TBigNumberCl;
  vFile: string;
begin
   // Имя файла входных-выходных данных
    vFile := 'numbers.txt';
  try
    BigNumber := TBigNumberCl.Create;
   try
     BigNumber.ReadFromFile(vFile);
     BigNumber.OpAdd;
     BigNumber.WriteToFile(vFile);

     Writeln( 'Ok.');

  except
    on E: Exception do
      Writeln('Error: ' + E.Message);
  end;
  finally
    BigNumber.Free;
  end;
  Readln; //Нажать Enter
end.

