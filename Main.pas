Uses  crt, Compl, CMatr, Vectors, CVectors;
Var Mode: integer;
    OK: boolean;
Begin
  OK := True;
  while Ok do
  begin
    Clrscr;
    writeln('Укажите режим');
    writeln(' 1: Комплексные числа');
    writeln(' 2: Комплексные матрицы');
    writeln(' 3: Вещественные векторы');
    writeln(' 4: Комплексные векторы');
    writeln(' 0: Выход');
    GoToXY(40,20); readln(Mode);
    GoToXY(40,20); Clrscr;
    case Mode of
      1: ComplMenu;
      2: MatrixMenu;
      3: VectorsMenu;
      4: CVectorsMenu;
      0: Ok := false;
    else
    begin
      Gotoxy(30, 21);
      writeln('Ошибка! Повторите ввод!');
      sleep(1000)
    end;
    end;
  end;
end.

