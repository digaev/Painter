object frmMain: TfrmMain
  Left = 229
  Top = 257
  Width = 873
  Height = 554
  Caption = 'Painter'
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 484
    Width = 865
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object XPManifest1: TXPManifest
    Left = 368
    Top = 72
  end
  object MainMenu1: TMainMenu
    Left = 288
    Top = 64
    object File1: TMenuItem
      Caption = '&'#1060#1072#1081#1083
      object SaveAs1: TMenuItem
        Caption = '&'#1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1082#1072#1082'...'
        ShortCut = 24659
        OnClick = SaveAs1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Quit1: TMenuItem
        Caption = '&'#1042#1099#1093#1086#1076
        ShortCut = 16465
        OnClick = Quit1Click
      end
    end
    object Pen1: TMenuItem
      Caption = '&'#1048#1085#1089#1090#1088#1091#1084#1077#1085#1090#1099
      object PenMenuItem: TMenuItem
        AutoCheck = True
        Caption = '&'#1050#1072#1088#1072#1085#1076#1072#1096
        OnClick = PenMenuItemClick
      end
    end
    object N2: TMenuItem
      Caption = '?'
      object Painter10byNikolayDigaev1: TMenuItem
        Caption = 'Painter 1.0 (c) '#1053#1080#1082#1086#1083#1072#1081' '#1044#1080#1075#1072#1077#1074' 2017'
        Enabled = False
      end
    end
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'bmp'
    Filter = #1048#1079#1086#1073#1088#1072#1078#1077#1085#1080#1103' (*.bmp)|*.bmp|'#1042#1089#1077' '#1092#1072#1081#1083#1099' (*.*)|*.*'
    Left = 168
    Top = 72
  end
end
