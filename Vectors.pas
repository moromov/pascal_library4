Unit Vectors;
Interface
uses crt;
const n = 3;
Type vector = array [1..n] of real;
procedure InputV(Var z: vector);
procedure OutputV(z: vector);
procedure AddVectors(x, y: vector; Var z: vector);
function ScalProd(x, y: vector): real;
procedure VectProd(x, y: vector; Var z: vector);
function MixProd(x, y, z: vector): real;
function ModulV(x: vector): real;
procedure ProdRVector(r: real; x: vector; Var y: vector);
procedure VectorsMenu;

Implementation

procedure Wait();
begin
  repeat until keyPressed;
  while keyPressed do Readkey;
end;


procedure InputV(Var z: vector);
Var i: integer;
begin
  for i:= 1 to n do
  begin
    Gotoxy(5*i+5, 5); readln(z[i]);
  end;
  Gotoxy(5, 5); clearline();
end;


procedure OutputV(z: vector);
Var i: integer;
begin
  for i:= 1 to n do
  begin
    Gotoxy(5*i+5, 10); writeln(z[i]); 
  end;
  Wait();
end;


procedure AddVectors(x, y: vector; Var z: vector);
Var i: integer;
begin
  for i:= 1 to n do
    z[i]:= x[i] + y[i]
end;


function ScalProd(x, y: vector): real;
Var S:real; i: integer;
begin
  S:= 0;
  for i:= 1 to n do
    S := S + x[i] * y[i];
  ScalProd := S
end;


procedure VectProd(x, y: vector; Var z: vector);
begin
  z[1]:= x[2]*y[3] - x[3] * y[2];
  z[2]:= x[3]*y[1] - x[1] * y[3];
  z[3]:= x[1]*y[2] - x[2] * y[1];
end;


function MixProd(x, y, z: vector): real;
Var w: vector;
begin
  VectProd(x, y, w);
  MixProd:= ScalProd(w, z)
end;


function ModulV(x: vector): real;
begin
  ModulV:= sqrt(ScalProd(x, x))
end;


procedure ProdRVector(r: real; x: vector; Var y: vector);
begin
  y[1]:= x[1] * r;
  y[2]:= x[2] * r;
  y[3]:= x[3] * r;
end;


procedure VectorsMenu;
Var mode, r: integer; ok : boolean;
x, y, z, w: vector;
begin
  ok := true;
  while ok do
  begin
  Clrscr;
  writeln('Укажите операцию: ');
    writeln(' 1. Сложение вещественных векторов');
    writeln(' 2. Скалярное произведение векторов');
    writeln(' 3. Векторное произведение векторов');
    writeln(' 4. Смешанное произведение векторов');
    writeln(' 5. Модуль вектора');
    writeln(' 6.Умножение вектора на скаляр');
    writeln('0: Выход');
    Gotoxy(40, 20); readln(mode);
    Gotoxy(40, 20); clearline();
    case mode of
      1: begin Clrscr; InputV(x); InputV(y); AddVectors(x, y, w); OutputV(w); Wait(); end;
      2: begin Clrscr; InputV(x); InputV(y); writeln(ScalProd(x, y)); Wait(); end;
      3: begin Clrscr; InputV(x); InputV(y); VectProd(x, y, w); OutputV(w); Wait(); end;
      4: begin Clrscr; InputV(x); InputV(y); InputV(z); writeln(MixProd(x, y, z)); Wait(); end;
      5: begin Clrscr; InputV(x); writeln(ModulV(x)); Wait(); end;
      6: begin Clrscr; InputV(x); readln(r); ProdRVector(r, x, y); OutputV(y); Wait(); end;
      0: begin ok := false; end;
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

