unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CPort, CPortCtl, ExtCtrls, ComCtrls, StdCtrls;

type
  TForm1 = class(TForm)
    ComTerminal1: TComTerminal;
    ComPort: TComPort;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Panel1: TPanel;
    TimerEnvio: TTimer;
    LabelMilSeg: TLabeledEdit;
    Labelpwm: TLabeledEdit;
    Button1: TButton;
    ProgressBar: TProgressBar;
    PageControl2: TPageControl;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    RadioGroup: TRadioGroup;
    Label1: TLabel;
    Button2: TButton;
    ComboCom: TComboBox;
    Label2: TLabel;
    ComboBau: TComboBox;
    Label3: TLabel;
    Memo: TMemo;
    Button3: TButton;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure TimerEnvioTimer(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
    porcentajeProcesado: Integer;

    function ConvertirPorcentaje(porcentaje: integer): String;
    function DecToBin(val:integer):string;

    procedure EnviarPuertoRS232(str: String);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var porcentajeStr, comando: string; porcentajeInt: Integer;
begin
  porcentajeInt := strToIntDef(Labelpwm.Text,-1);
  if  (porcentajeInt >= 0) and (porcentajeInt <= 100) then
  begin
    comando := 'p';
    EnviarPuertoRS232(comando);
    porcentajeStr := ConvertirPorcentaje(porcentajeInt);
    EnviarPuertoRS232(porcentajeStr);
  end;
end;

function TForm1.DecToBin(val:integer):string;
var cociente, resto:integer; binario:string;
begin
  cociente:= val div 2;
  resto:= val mod 2;
  if cociente<2 then
    binario:=IntToStr(cociente)+IntToStr(resto)
  else
    binario:=DecToBin(cociente)+IntToStr(resto);

  DecToBin:=binario;
end;

function TForm1.ConvertirPorcentaje(porcentaje: integer): String;
var i: integer;
begin
  porcentaje := 255 - (porcentaje*255) div 100;
  Result := DecToBin(porcentaje);
  for i := length(Result)+1 to 8 do
    Result := '0' + Result;
end;

procedure TForm1.Button2Click(Sender: TObject);
var miliSeg: Integer;
begin
  miliSeg := StrToIntDef(LabelMilSeg.Text,-1);
//  LabelMilSeg.Text := ConvertirPorcentaje(strToint(LabelMilSeg.Text));
  if (miliSeg <> -1) then
  begin
    ProgressBar.Position := 0;
    ProgressBar.Repaint;
    porcentajeProcesado := 0;
    TimerEnvio.Interval := miliSeg;
    TimerEnvio.Enabled := True;
  end;
end;

procedure TForm1.TimerEnvioTimer(Sender: TObject);
begin

  EnviarPuertoRS232('p');
  EnviarPuertoRS232(IntToSTr(porcentajeProcesado) + ' = '+ ConvertirPorcentaje(porcentajeProcesado));
  ProgressBar.Position := porcentajeProcesado;
  ProgressBar.Repaint;
  
  if porcentajeProcesado = 100 then
  begin
    case RadioGroup.ItemIndex of
      0:  // Detener el contador
          TimerEnvio.Enabled := False;
      1:  // Reanudar en cero
         porcentajeProcesado := 0;
      2: // Decrementar a 0%
         begin
           TimerEnvio.Tag := -1;
           porcentajeProcesado := 99;
         end;
    else TimerEnvio.Enabled := False;
    end;

  end else if (porcentajeProcesado = 0) then begin
    TimerEnvio.Tag := 1;
    porcentajeProcesado := 1;
  end else
    porcentajeProcesado := porcentajeProcesado + TimerEnvio.Tag;
                          
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  TimerEnvio.Enabled := FALSE;
end;

procedure TForm1.EnviarPuertoRS232(str: String);
begin
  //ComPort.Write(str, length(str));
  Memo.Lines.Add(str);
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  ComPort.Port := ComboCom.Text;
  ComPort.BaudRate := TBaudRate(StrToIntDef(ComboBau.Text, 9600));
  ComPort.Open;
end;

end.
