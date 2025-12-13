program SortLab5;

type
  TIntArray = array of integer;
  TCompare = function(x, y: integer): boolean;

function CmpAsc(x, y: integer): boolean;
begin
  CmpAsc := x < y;
end;

function CmpDesc(x, y: integer): boolean;
begin
  CmpDesc := x > y;
end;

procedure InsertionSort(var a: TIntArray; cmp: TCompare);
var
  j, key: integer;
begin
  for var i := 1 to High(a) do
  begin
    key := a[i];
    j := i - 1;
    while (j >= 0) and cmp(key, a[j]) do
    begin
      a[j + 1] := a[j];
      Dec(j);
    end;
    a[j + 1] := key;
  end;
end;

procedure QuickSort(var a: TIntArray; l, r: integer; cmp: TCompare);
var
  i, j, p, t: integer;
begin
  i := l;
  j := r;
  p := a[(l + r) div 2];
  repeat
    while cmp(a[i], p) do Inc(i);
    while cmp(p, a[j]) do Dec(j);
    if i <= j then
    begin
      t := a[i];
      a[i] := a[j];
      a[j] := t;
      Inc(i);
      Dec(j);
    end;
  until i > j;

  if l < j then QuickSort(a, l, j, cmp);
  if i < r then QuickSort(a, i, r, cmp);
end;

var
  f: text;
  n: integer;
  a, b: TIntArray;

begin
  Assign(f, 'input.txt');
  Reset(f);
  Read(f, n);
  SetLength(a, n);
  for var i := 0 to n - 1 do
    Read(f, a[i]);
  Close(f);

  SetLength(b, n);
  for var i := 0 to n - 1 do
    b[i] := a[i];

  InsertionSort(a, CmpAsc);
  QuickSort(b, 0, n - 1, CmpAsc);

  Assign(f, 'output_insert.txt');
  Rewrite(f);
  for var i := 0 to n - 1 do
    Write(f, a[i], ' ');
  Close(f);

  Assign(f, 'output_quick.txt');
  Rewrite(f);
  for var i := 0 to n - 1 do
    Write(f, b[i], ' ');
  Close(f);
  
  Writeln('Результат сортировки вставками:');
  for var i := 0 to n - 1 do
    Write(a[i], ' ');
  Writeln;

  Writeln('Результат быстрой сортировки:');
  for var i := 0 to n - 1 do
    Write(b[i], ' ');
  Writeln;
end.
