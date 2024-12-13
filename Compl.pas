Unit Compl;
Interface
uses crt;
Type complex = record
  Re, Im: real;
  end;
procedure InputC(Var a: complex);
procedure OutputC(Var a: complex);
procedure Add(Var a, b: complex; Var c: complex);
procedure Mult(u, w: complex; Var z: complex);
procedure Inversion(z: complex; Var w: complex);
procedure DiversionZ (u, v: complex; Var w:complex);
procedure Codj(z: complex; Var w: complex);
procedure Prod(a: real; z: complex; Var w:complex);
procedure Zero(Var z: complex);
procedure One(Var z: complex);
function Modul(z: complex): real;
procedure ExpC(z: complex; Var w: complex);
procedure CosC(z: complex; Var w: complex);
procedure SinC(z: complex; Var w: complex);
procedure ComplMenu;

Implementation
const eps = 0.001;

procedure InputC(Var a: complex);
begin
  ClrScr;                           
  Gotoxy(5, 5); writeln('Введите Re:');
  Gotoxy(20, 5); readln(a.Re);
  Gotoxy(5, 6); writeln('Введите Im:');
  Gotoxy(20, 6); readln(a.Im);
end;


procedure OutputC(Var a: complex);
begin
  ClrScr;                             
  Gotoxy(5, 5); writeln('Результат:');
  Gotoxy(20, 5); writeln('Re: ', a.Re:0:3);
  Gotoxy(20, 6); writeln('Im: ', a.Im:0:3);
end;

procedure Add(Var a, b: complex; Var c: complex);
begin
  c.Re := a.Re + b.Re;
  c.Im := a.Im + b.Im;
end;


procedure Mult(u, w: complex; Var z: complex);
  begin
    z.Re := u.Re * w.Re - u.Im * w.Im;
    z.Im := u.Re * w.Im + u.Im * w.Re;
end;


procedure Inversion(z: complex; Var w: complex);
Var q: real;
begin
  q := sqr(z.Re) + sqr(z.Im);
  w.Re := z.Re / q;
  w.Im := - z.Im / q;
end;


procedure DiversionZ (u, v: complex; Var w:complex);
   Var z: complex;
  begin
  Inversion(v, z); Mult(u, z, w);
end;


procedure Codj(z: complex; Var w: complex);
begin
  w.Re := z.Re;
  w.Im := -z.Im;
end;


procedure Prod(a: real; z: complex; Var w:complex);
begin
  w.Re := a * z.Re;
  w.Im := a * z.Im;
end;


procedure Zero(Var z: complex);
begin
  z.Re := 0;
  z.Im := 0;
end;

procedure One(Var z: complex);
begin
  z.Re := 1;
  z.Im := 0;
end;

function Modul(z: complex): real;
begin
  Modul:= sqrt(sqr(z.Re)+sqr(z.Im))
end;


procedure ExpC(z: complex; Var w: complex);
const eps = 0.001;
Var k: integer; p, S: complex;
begin
  k:= 0; One(p); One(S);
  while Modul(p) >= eps do
  begin
    k:= k + 1; Mult(p, z, p); Prod(1/k, p, p);
    Add(S, p, S)
  end;
  w:= S
end;

procedure CosC(z: complex; Var w: complex);
Var k: integer; p, S, z2: complex;
begin
  k:= 0; One(p); One(S); Mult(z, z, z2);
  while Modul(p) >= eps do
  begin
    k:= k + 1; Mult(p, z2, p);
    Prod(-1/(2*k) * (2*k - 1), p, p);
    Add(S, p, S);
  end;
  w:= S;
end;


procedure SinC(z:Complex; var w:Complex);
const eps=0.001;
var k:integer; p,s,z2:Complex;

begin
  k:=0; p:=z; s:=p; Mult(z, z, z2);
  while Modul(p)>=eps do
  begin
    k:=k+2;
    Mult(p, z2, p);
    Prod(-1/(k*(k+1)), p, p);
    Add(s, p, s);
  end;
  w:=s;
end;

procedure Wait();
begin
  repeat until keyPressed;
  while keyPressed do Readkey;
end;


procedure ComplMenu();
Var mode: integer; a, b, c: complex; r: real; ok: boolean;
begin
  ok:= true;
  while ok do
  begin
    Clrscr;
    writeln('Укажите операцию: ');
    writeln(' 1. Сложение комплексных чисел ');
    writeln(' 2. Умножение комплексных чисел');
    writeln(' 3. Инверсия комплексного числа');
    writeln(' 4. Деление комплексных чисел');
    writeln(' 5. Вычисление комплексного сопряжённого числа');
    writeln(' 6. Умножение комплексного числа на действительное');
    writeln(' 7. Обнуление комплексного числа');
    writeln(' 8. Объединичивание комплексного числа');
    writeln(' 9. Модуль комплексного числа');
    writeln(' 10. Экспонента комплексного числа');
    writeln(' 11. Косинус комплексного числа');
    writeln(' 12. Синус комплексного числа');
    writeln('0. Выход ');
    Gotoxy(40, 20); readln(mode);
    Gotoxy(40, 20); clearline();
    case mode of
      1: begin Clrscr; InputC(a); Clrscr; InputC(b); Add(a, b, c); OutputC(c); Wait(); end;
      2: begin Clrscr; InputC(a); Clrscr; InputC(b); Mult(a, b, c); OutputC(c); Wait(); end;
      3: begin Clrscr; InputC(a); Inversion(a, b); OutputC(b); Wait(); end;
      4: begin Clrscr; InputC(a); InputC(b); DiversionZ(a, b, c); OutputC(c); Wait(); end;
      5: begin Clrscr; InputC(a); Codj(a, b); OutputC(b);Wait(); end;
      6: begin Clrscr; readln(r); InputC(b); Prod(r, b, c); OutputC(c); Wait(); end;
      7: begin Clrscr; InputC(a); Zero(a); OutputC(a); Wait(); end;
      8: begin Clrscr; InputC(a); One(a); OutputC(a); Wait(); end;
      9: begin Clrscr; InputC(a); writeln(Modul(a)); Wait(); end;
      10: begin Clrscr; InputC(a); ExpC(a, b); OutputC(b); Wait() end;
      11: begin Clrscr; InputC(a); CosC(a, b); OutputC(b); Wait(); end;
      12: begin Clrscr; InputC(a); SinC(a, b); OutputC(b); Wait(); end;
      0: begin ok:= false; end;
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