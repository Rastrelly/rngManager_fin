unit uRngMan;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  ComCtrls, Spin, TAGraph, TASeries;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Chart1: TChart;
    Label4: TLabel;
    serVals: TLineSeries;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Panel1: TPanel;
    seMin: TSpinEdit;
    seMax: TSpinEdit;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  outVals:array of integer;

implementation

{$R *.lfm}

{ TForm1 }

//quicksort via https://www.thoughtco.com/implementing-quicksort-sorting-algorithm-in-delphi-1058220
procedure QuickSort(var A: array of Integer; iLo, iHi: Integer) ;
 var
   Lo, Hi, Pivot, T: Integer;
 begin
   Lo := iLo;
   Hi := iHi;
   Pivot := A[(Lo + Hi) div 2];
   repeat
     while A[Lo] < Pivot do Inc(Lo) ;
     while A[Hi] > Pivot do Dec(Hi) ;
     if Lo <= Hi then
     begin
       T := A[Lo];
       A[Lo] := A[Hi];
       A[Hi] := T;
       Inc(Lo) ;
       Dec(Hi) ;
     end;
   until Lo > Hi;
   if Hi > iLo then QuickSort(A, iLo, Hi) ;
   if Lo < iHi then QuickSort(A, Lo, iHi) ;
 end;

procedure TForm1.Button1Click(Sender: TObject);
var min,max,cVal,i:integer;
begin
  min:=seMin.Value;
  max:=seMax.Value;
  cVal:=Random(max-min+1)+min;
  outVals:=concat(outVals,[cVal]);
  QuickSort(outVals,low(outVals),high(outVals));
  serVals.Clear;
  for i:=0 to High(outVals) do
      serVals.Add(outVals[i]);
  Label1.Caption:=inttostr(cVal);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Randomize;
end;

end.

