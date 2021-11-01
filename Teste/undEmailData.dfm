object frmEmail: TfrmEmail
  Left = 288
  Top = 127
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsDialog
  Caption = 'Envio de E-Mail'
  ClientHeight = 108
  ClientWidth = 442
  Color = 11986126
  Ctl3D = False
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 442
    Height = 73
    Align = alTop
    Caption = ' Para envio dos E-mails informe  '
    TabOrder = 0
    object Label1: TLabel
      Left = 10
      Top = 20
      Width = 116
      Height = 15
      Caption = 'Usu'#225'rio de conex'#227'o:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 87
      Top = 43
      Width = 39
      Height = 15
      Caption = 'Senha:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ComboEdit1: TComboEdit
      Left = 131
      Top = 18
      Width = 298
      Height = 21
      NumGlyphs = 1
      TabOrder = 0
      Text = 'ComboEdit1'
    end
    object Edit1: TEdit
      Left = 131
      Top = 41
      Width = 127
      Height = 21
      TabOrder = 1
      Text = 'Edit1'
    end
  end
  object btnOk: TBitBtn
    Left = 121
    Top = 76
    Width = 95
    Height = 25
    TabOrder = 1
    Kind = bkOK
  end
  object btnCancela: TBitBtn
    Left = 217
    Top = 76
    Width = 95
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 2
    Kind = bkCancel
  end
end
