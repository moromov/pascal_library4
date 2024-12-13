Unit CVectors;
Interface
Uses crt,Compl; const n = 3;
Type cvector = array [1..n] of complex;
procedure InputCV(Var a: cvector);
procedure OutputCV(a: cvector);
procedure AddCVector(x, y: cvector; Var z: cvector);
procedure ScalCProd(a, b: cvector; Var S: complex);
procedure VectCProd(a, b: cvector; Var c: cvector);
function MixCProd(a, b, c: cvector): complex;
procedure ProdCVector(c: complex; a: cvector; Var b: cvector);
procedure ProdRVector(c: real; a: cvector; Var b: cvector);
procedure CVectorsMenu;
Implementation


procedure InputCV(Var a: cvector);
Var i: integer;
begin
  ClrScr; // Очистка экрана перед вводом
  writeln('Введите компоненты комплексного вектора:');
  for i := 1 to n do
  begin
    Gotoxy(5, 2 + i); // Позиция строки для каждой компоненты
    write('a[', i, ']: ');
    InputC(a[i]);
  end;
end;


procedure OutputCV(a: cvector);
Var i: integer;
begin
  writeln('Результат:');
  for i := 1 to n do
  begin
    Gotoxy(5, 10 + i); // Измените позицию, чтобы не перекрывать другие строки
    write('a[', i, ']: ');
    OutputC(a[i]); // Здесь вызывается вывод текущего комплексного числа
  end;
end;



procedure AddCVector(x, y: cvector; Var z: cvector);
Var i: integer;
begin
  for i:= 1 to n do
    Add(x[i], y[i], z[i]);
end;


procedure ScalCProd(a, b: cvector; Var S: complex);
Var
  i: integer; p: complex;
begin
  Zero(S); 
  for i := 1 to n do 
  begin
    Mult(a[i], b[i], p); 
    Add(S, p, S);
  end;
end;


procedure VectCProd(a, b: cvector; Var c: cvector);
Var i, j, k: complex; c1, c2: complex;
begin
  Mult(a[2],b[3],c1);
  Mult(a[3],b[2],c2);
  Prod(-1,c2,c2);
  Add(c1,c2,c[1]);
  Mult(a[3],b[1],c1);
  Mult(a[1],b[3],c2);
  Prod(-1, c2, c2);
  Add(c1,c2,c[2]);
  Mult(a[1],b[2],c1);
  Mult(a[2],b[1],c2);
  Prod(-1, c2, c2);
  Add(c1,c2,c[3])
end;


function MixCProd(a, b, c: cvector): complex;
Var d: cvector; S: complex;
begin
  VectCProd(a, b, d);ScalCProd(c, d, S); MixCProd := S;
end;


procedure ProdRVector(c: real; a: cvector; Var b: cvector);
Var i: integer;
begin
  for i:= 1 to n do
    Prod(c, a[i], b[i])
end;


procedure ProdCVector(c: complex; a: cvector; Var b: cvector);
Var i: integer;
begin
  for i:= 1 to n do
    Mult(c, a[i], b[i])
end;


function ModulCV(x: cvector): real;
Var i: integer; S:real;
begin
  S:= 0;
  for i:= 1 to n do
  begin
    S:= S + sqr(x[i].Re) + sqr(x[i].Im);
  end;
  ModulCV := sqrt(S);
end;


procedure Wait();
begin
  repeat until keyPressed;
  while keyPressed do Readkey;
end;


procedure CVectorsMenu;
Var mode: integer; ok: boolean; a, b, c: cvector; s, e: complex; d: real;
begin 
  ok:= true;
  while ok do
  begin
    Clrscr;
    writeln('Укажите режим');
    writeln(' 1: Сложение комплексных векторов');
    writeln(' 2: Скалярное произведение векторов');
    writeln(' 3: Векторное произведение векторов');
    writeln(' 4: Смешанное произведение векторов');
    writeln(' 5: Умножение вектора на действительное число');
    writeln(' 6: Умножение вектора на комплексное число');
    writeln(' 7: Модуль вектора');
    writeln('0: Выход');
    Gotoxy(40, 20); readln(mode);
    Gotoxy(40, 20); clearline();
    case Mode of
      1: begin Clrscr; InputCV(a); InputCV(b); AddCVector(a, b, c); OutputCV(c); Wait(); end;
      2: begin Clrscr; InputCV(a); InputCV(b); ScalCProd(a, b, s); writeln(s); Wait(); end;
      3: begin Clrscr; InputCV(a); InputCV(b); VectCProd(a, b, c); OutputCV(c); Wait(); end;
      4: begin Clrscr; InputCV(a); InputCV(b); InputCV(c); writeln(MixCProd(a, b, c)); Wait(); end;
      5: begin Clrscr; InputCV(a); readln(d); ProdRVector(d, a, b); OutputCV(b); Wait(); end;
      6: begin Clrscr; InputCV(a); InputC(e); ProdCVector(e, a, b); OutputCV(b); Wait(); end;
      7: begin Clrscr; InputCV(a); writeln(ModulCV(a)); Wait(); end;
      0: ok:= false;
    else
      begin
       Gotoxy(30, 21);
       writeln('Ошибка! Повторите ввод!');
       sleep(1000);
      end;
  end;
end;
end;
end.