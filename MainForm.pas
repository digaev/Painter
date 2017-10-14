unit MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, XPMan, ExtCtrls, StdCtrls, PaintArea, Menus, ComCtrls;

type
  TfrmMain = class(TForm)
    XPManifest1: TXPManifest;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    SaveAs1: TMenuItem;
    N1: TMenuItem;
    Quit1: TMenuItem;
    Pen1: TMenuItem;
    N2: TMenuItem;
    Painter10byNikolayDigaev1: TMenuItem;
    PenMenuItem: TMenuItem;
    StatusBar1: TStatusBar;
    SaveDialog1: TSaveDialog;
    procedure FormCreate(Sender: TObject);
    procedure Quit1Click(Sender: TObject);
    procedure PenMenuItemClick(Sender: TObject);
    procedure SaveAs1Click(Sender: TObject);
  private
    FPaintArea: TPaintArea;
    procedure OnPenChanged(Sender: TObject);
    procedure OnPenDlgClose(Sender: TObject; var Action: TCloseAction);
    procedure UpdateStatusBarText;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses PenDlg;

{$R *.dfm}

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  // Создаём холст
  FPaintArea := TPaintArea.Create(Self);
  FPaintArea.Parent := Self;
  FPaintArea.Align := alClient;

  UpdateStatusBarText;
end;

procedure TfrmMain.Quit1Click(Sender: TObject);
begin
  // Выход из приложения
  Application.Terminate;
end;

procedure TfrmMain.UpdateStatusBarText;
begin
  // Выводим в строку состояния информацию о Карандаше
  StatusBar1.SimpleText := Format('Цвет: %s | Размер: %dpx', [
    ColorToString(FPaintArea.Pen.Color), FPaintArea.Pen.Width
  ]);
end;

procedure TfrmMain.PenMenuItemClick(Sender: TObject);
begin
  // Показываем окно настроек Карандаша
  if DlgPen = nil then
  begin
    DlgPen := TDlgPen.Create(Self);
    DlgPen.Pen := FPaintArea.Pen;
    DlgPen.OnPenChanged := OnPenChanged;
    DlgPen.OnClose := OnPenDlgClose;
  end;

  DlgPen.Visible := PenMenuItem.Checked;
end;

procedure TfrmMain.SaveAs1Click(Sender: TObject);
begin
  // Экспорт изображения в файл
  if SaveDialog1.Execute then
    FPaintArea.SaveToFile(SaveDialog1.FileName);
end;

procedure TfrmMain.OnPenChanged(Sender: TObject);
begin
  UpdateStatusBarText;
end;

procedure TfrmMain.OnPenDlgClose(Sender: TObject; var Action: TCloseAction);
begin
  PenMenuItem.Checked := False;
end;

end.
