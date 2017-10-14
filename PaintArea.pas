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

  // Создаём буфер для рисования
  FBuffer := TBitmap.Create;

  // Переменная для индикации режима "стирания"
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

  // Копируем из буфера на холст окна
  Canvas.StretchDraw(ClientRect, FBuffer);
end;

procedure TPaintArea.Resize;
begin
  inherited;

  // При изменении размера окна изменяем так же размер буфера
  FBuffer.Width := ClientWidth;
  FBuffer.Height := ClientHeight;
end;

procedure TPaintArea.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbRight then
  begin
    // Нажали правую кнопку, переходим в режим "стирания"
    // Сохраняем текуший цвет Карандаша и меняем его на белый
    FEraseMode := True;
    FPenColor := FBuffer.Canvas.Pen.Color;
    FBuffer.Canvas.Pen.Color := clWhite;
  end else
  if Button <> mbLeft then
  begin
    Exit;
  end;

  // Рисуем в буфер
  FBuffer.Canvas.MoveTo(X, Y);
  FBuffer.Canvas.LineTo(X, Y);
  Repaint;
end;

procedure TPaintArea.MouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if not FEraseMode then Exit;

  // Выходим из режима "стирания" и восстанавливаем цвет Карандаша
  FEraseMode := False;
  FBuffer.Canvas.Pen.Color := FPenColor;
end;

procedure TPaintArea.MouseMove(Shift: TShiftState;
  X, Y: Integer);
const
  AllowedStates = [ssLeft, ssRight];

begin
  if (AllowedStates - Shift = AllowedStates) then Exit;

  // Рисуем в буфер
  FBuffer.Canvas.LineTo(X, Y);
  FBuffer.Canvas.MoveTo(X, Y);
  Repaint;
end;

procedure TPaintArea.SaveToFile(const FileName: String);
begin
  // Экспорт получившегося изображения в файл
  FBuffer.SaveToFile(FileName);
end;

end.
