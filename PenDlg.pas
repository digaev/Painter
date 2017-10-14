unit PenDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ColorGrd, ComCtrls;

type
  TDlgPen = class(TForm)
    Button1: TButton;
    Button2: TButton;
    GroupBox1: TGroupBox;
    ColorPicker: TColorGrid;
    GroupBox2: TGroupBox;
    tbPenWidth: TTrackBar;
    procedure FormCreate(Sender: TObject);
    procedure ColorPickerChange(Sender: TObject);
    procedure tbPenWidthChange(Sender: TObject);
  private
    FPen: TPen;
    FOnPenChanged: TNotifyEvent;
  public
    property Pen: TPen read FPen write FPen;
    property OnPenChanged: TNotifyEvent read FOnPenChanged write FOnPenChanged;
  end;

var
  DlgPen: TDlgPen;

implementation

{$R *.dfm}

procedure TDlgPen.FormCreate(Sender: TObject);
begin
  ColorPicker.Align := alClient;
end;

procedure TDlgPen.ColorPickerChange(Sender: TObject);
begin
  if FPen <> nil then
  begin
    FPen.Color := ColorPicker.ForegroundColor;

    if @FOnPenChanged <> nil then FOnPenChanged(Self);
  end;
end;

procedure TDlgPen.tbPenWidthChange(Sender: TObject);
begin
  if FPen <> nil then
  begin
    FPen.Width := tbPenWidth.Position;

    if @FOnPenChanged <> nil then FOnPenChanged(Self);
  end;
end;

end.
