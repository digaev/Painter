unit PaintArea;

interface

uses
  Windows, Messages, Graphics, Controls, Classes;

type
  TPaintArea = class(TGraphicControl)
  private
    FBuffer: TBitmap;
    FEraseMode: Boolean;
    FPenColor: TColor;
    function GetPen: TPen;
  protected
    procedure Paint; override;
    procedure Resize; override;
    procedure MouseDown(Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState;
      X, Y: Integer); override;
  public
    property Pen: TPen read GetPen;
    procedure SaveToFile(const FileName: String);
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

implementation

{ TPaintArea }

constructor TPaintArea.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  // ������ ����� ��� ���������
  FBuffer := TBitmap.Create;

  // ���������� ��� ��������� ������ "��������"
  FEraseMode := False;
end;

destructor TPaintArea.Destroy;
begin
  inherited;

  FBuffer.Free;
end;

function TPaintArea.GetPen: TPen;
begin
  Result := FBuffer.Canvas.Pen;
end;

procedure TPaintArea.Paint;
begin
  inherited;

  // �������� �� ������ �� ����� ����
  Canvas.StretchDraw(ClientRect, FBuffer);
end;

procedure TPaintArea.Resize;
begin
  inherited;

  // ��� ��������� ������� ���� �������� ��� �� ������ ������
  FBuffer.Width := ClientWidth;
  FBuffer.Height := ClientHeight;
end;

procedure TPaintArea.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbRight then
  begin
    // ������ ������ ������, ��������� � ����� "��������"
    // ��������� ������� ���� ��������� � ������ ��� �� �����
    FEraseMode := True;
    FPenColor := FBuffer.Canvas.Pen.Color;
    FBuffer.Canvas.Pen.Color := clWhite;
  end else
  if Button <> mbLeft then
  begin
    Exit;
  end;

  // ������ � �����
  FBuffer.Canvas.MoveTo(X, Y);
  FBuffer.Canvas.LineTo(X, Y);
  Repaint;
end;

procedure TPaintArea.MouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if not FEraseMode then Exit;

  // ������� �� ������ "��������" � ��������������� ���� ���������
  FEraseMode := False;
  FBuffer.Canvas.Pen.Color := FPenColor;
end;

procedure TPaintArea.MouseMove(Shift: TShiftState;
  X, Y: Integer);
const
  AllowedStates = [ssLeft, ssRight];

begin
  if (AllowedStates - Shift = AllowedStates) then Exit;

  // ������ � �����
  FBuffer.Canvas.LineTo(X, Y);
  FBuffer.Canvas.MoveTo(X, Y);
  Repaint;
end;

procedure TPaintArea.SaveToFile(const FileName: String);
begin
  // ������� ������������� ����������� � ����
  FBuffer.SaveToFile(FileName);
end;

end.
