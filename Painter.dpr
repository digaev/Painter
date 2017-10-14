program Painter;

uses
  Forms,
  MainForm in 'MainForm.pas' {frmMain},
  PenDlg in 'PenDlg.pas' {DlgPen},
  PaintArea in 'PaintArea.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
