Unit CMatr;
Interface
uses crt, Compl; const n = 2; eps = 0.001;
Type matrix = array [1..n, 1..n] of complex;
procedure InputMatrix(Var a: matrix);
procedure OutputMatrix(c: matrix);
procedure AddMatrix(a, b: matrix; var c: matrix);
procedure MultMatrix(a, b: matrix; Var c: matrix);
procedure ProdRMatrix(r:real; a: matrix; Var b:matrix);
procedure ProdCMatrix(c:complex; a:matrix;  Var b:matrix);
procedure ZeroMatrix(Var a: matrix);
procedure OneMatrix(Var a: matrix);
function NormMatrix(a: matrix): real;
function ExpMatrix(a: matrix): matrix;
procedure MatrixMenu;

Implementation

procedure InputMatrix(Var a: matrix);
Var i, j: integer;
begin
for i:= 1 to n do
  for j:= 1 to n do
    begin
    Gotoxy(3, 5); readln(a[i, j].Re);
    Gotoxy(6, 5); readln(a[i, j].Im);
    Gotoxy(3, 5); clearline();
    Gotoxy(6, 5); clearline();
    Gotoxy(i*8+10, j*2); writeln(a[i, j].Re, ' ', a[i, j].Im);
    end;
for i:= 1 to n do
  for j:= 1 to n do
    begin;
    Gotoxy(i*8, j*2); clearline();
    end;
end;

procedure OutputMatrix(c: matrix);
Var i, j: integer;
begin
  for i:= 1 to n do
     for j:= 1 to n do
     begin
       Gotoxy(i*8, j*2);
       writeln(c[i, j].Re, ' ', c[i, j].Im)
     end;
end;


procedure AddMatrix(a, b: matrix; var c: matrix);
var i, j: integer;
begin
  for i := 1 to n do
    for j := 1 to n do
    begin
      Add(a[i, j], b[i, j], c[i, j])
    end;
end;


procedure MultMatrix(a, b: matrix; Var c: matrix);
Var i, j, k: integer; p, S: complex;
begin
  for i:= 1 to n do
    for j:= 1 to n do
    begin
      Zero(S);
      for k:= 1 to n do
      begin
        Mult(a[i, k], b[k, j], p);
        Add(S, p, S)
      end;
      c[i, j]:= S
    end;
end;


procedure ProdRMatrix(r:real; a: matrix; Var b:matrix);
Var i, j: integer;
begin
  for i:=1 to n do
    for j:=1 to n do
      Prod(r, a[i, j], b[i, j])
end;


procedure ProdCMatrix(c:complex; a:matrix; Var b:matrix);
Var i, j: integer;
begin
for i:=1 to n do
  for j:=1 to n do
    Mult(a[i, j], c, b[i, j])  
end;


procedure ZeroMatrix(Var a: matrix);
var 
  i, j: integer; z: complex;
begin
  for i := 1 to n do
    for j := 1 to n do
    begin
      Zero(a[i, j]) 
    end;
end;


procedure OneMatrix(Var a: matrix);
var 
  i, j: integer;
begin
  ZeroMatrix(a);
  for i := 1 to n do
    begin
      j:= i;
      One(a[i, j]);
    end;
end;

function NormMatrix(a: matrix): real;
Var i, j: integer; z, S: real;
begin
  z:= 0;
  for i:= 1 to n do
  begin
    S:= 0;
    for j:= 1 to n do
      begin
      S:= S + Modul(a[i, j]);
      if S > z then z:= S
      end;
  NormMatrix:= z
  end;
end;


function ExpMatrix(a: matrix): matrix;
Var k: integer; p, S: matrix;
begin
  k:= 0; OneMatrix(p); OneMatrix(S);
  while NormMatrix(p) >= eps do
  begin
    k:= k + 1; MultMatrix(p, a, p);
    ProdRMatrix(1/k, p, p);
    AddMatrix(S, p, S)
  end;
  ExpMatrix := S;
end;
procedure Wait;
begin
  repeat until keyPressed;
  while keyPressed do readKey
end;


procedure MatrixMenu;
Var mode: integer; ok: boolean; a, b, c: matrix; d: real; e: complex;
begin 
  ok := true;
  while ok do
  begin
    Clrscr;
    writeln('Укажите операцию: ');
    writeln(' 1. Сложение матриц');
    writeln(' 2. Перемножение матриц');
    writeln(' 3. Умножение матрицы на действительное число');
    writeln(' 4. Умножение матрицы на комплексное число');
    writeln(' 5. Обнуление матрицы');
    writeln(' 6. Объеденичивание матрицы');
    writeln(' 7.Вычисление нормы матрицы');
    writeln(' 8. Вычисление экспоненты матрицы');
    writeln('0. Выход');
    Gotoxy(40, 20); readln(mode);
    Gotoxy(40, 20); clearline();
    case mode of
      1: begin Clrscr; InputMatrix(a); InputMatrix(b); AddMatrix(a, b, c); OutputMatrix(c); Wait(); end;
      2: begin Clrscr; InputMatrix(a); InputMatrix(b); MultMatrix(a, b, c); OutputMatrix(c);Wait(); end;
      3: begin Clrscr; InputMatrix(a); readln(d); ProdRMatrix(d, a, b); OutputMatrix(b); Wait(); end;
      4: begin Clrscr; InputMatrix(a); InputC(e); ProdCMatrix(e, a, b); OutputMatrix(b); Wait(); end;
      5: begin Clrscr; InputMatrix(a); ZeroMatrix(a); OutputMatrix(a); Wait(); end;
      6: begin Clrscr; InputMatrix(a); OneMatrix(a); OutputMatrix(a);Wait(); end;
      7: begin Clrscr; InputMatrix(a); writeln(NormMatrix(a)); Wait(); end;
      8: begin Clrscr; InputMatrix(a); OutputMatrix(ExpMatrix(a)); Wait(); end;
      0: begin ok:= false end
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