unit BigNumberCl;
 
interface
  uses   SysUtils , Math ;


type
  TBigNumberCl = class
  private
    FNumber1, FNumber2 , FResult: string;
  public
    procedure ReadFromFile(const FileName: string);
    procedure OpAdd;
    procedure WriteToFile(const FileName: string);
    procedure Destroy;
  end;

implementation
   { TBigNumberCl }

procedure TBigNumberCl.ReadFromFile(const FileName: string);
var
  F: TextFile;
begin
  AssignFile(F, FileName);
  Reset(F);
  try
    Readln(F, FNumber1);
    Readln(F, FNumber2);
  finally
    CloseFile(F);
  end;
end;

function ReverseString(const S: string): string;
var
  i: Integer;
begin
  Result := '';
  for i := Length(S) downto 1 do
    Result := Result + S[i];
end;

procedure TBigNumberCl.OpAdd;
var
  RevNum1, RevNum2: string;
  i, Carry, Digit1, Digit2, Sum: Integer;
  MaxLength: Integer;
begin
  // Удаляем пробелы и проверяем на пустые строки
  FNumber1 := Trim(FNumber1);
  FNumber2 := Trim(FNumber2);

  if (FNumber1 = '') or (FNumber2 = '') then
  begin
    FResult := '0';
    Exit;
  end;
  // Развернуть строки для удобства сложения
  RevNum1 := ReverseString(FNumber1);
  RevNum2 := ReverseString(FNumber2);

  // максимальная длина
 MaxLength := Max(Length(RevNum1), Length(RevNum2));

  // Дополнить строки нулями до одинаковой длины
  while Length(RevNum1) < MaxLength do
    RevNum1 := RevNum1 + '0';
  while Length(RevNum2) < MaxLength do
    RevNum2 := RevNum2 + '0';

  FResult := '';
  Carry := 0;

  // Складываем по цифрам
  for i := 1 to MaxLength do
  begin
    Digit1 := StrToInt(RevNum1[i]);
    Digit2 := StrToInt(RevNum2[i]);
    Sum := Digit1 + Digit2 + Carry;

    if Sum >= 10 then
    begin
      FResult := IntToStr(Sum - 10) + FResult;
      Carry := 1;
    end
    else
    begin
      FResult := IntToStr(Sum) + FResult;
      Carry := 0;
    end;
  end;

  // перенос добавляем в начало
  if Carry > 0 then
    FResult := '1' + FResult;
end;

procedure TBigNumberCl.WriteToFile(const FileName: string);
var
  F: TextFile;
begin
  AssignFile(F, FileName);
  Append(F);
  try
    Writeln(F, FResult);
  finally
    CloseFile(F);
  end;
end;

end.
