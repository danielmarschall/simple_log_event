object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'ViaThinkSoft Simple Event Log Setup'
  ClientHeight = 530
  ClientWidth = 784
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  DesignSize = (
    784
    530)
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 768
    Height = 209
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Status of installation / registration'
    TabOrder = 0
    DesignSize = (
      768
      209)
    object Label1: TLabel
      Left = 24
      Top = 29
      Width = 28
      Height = 13
      Caption = '32-Bit'
    end
    object Label2: TLabel
      Left = 24
      Top = 80
      Width = 28
      Height = 13
      Caption = '64-Bit'
    end
    object Label3: TLabel
      Left = 24
      Top = 142
      Width = 311
      Height = 13
      Caption = 
        'The installation and registration of the DLL files has two reaso' +
        'ns:'
    end
    object Label4: TLabel
      Left = 24
      Top = 161
      Width = 351
      Height = 13
      Caption = 
        '1. It offers a COM Interface for applications to use in order to' +
        ' log events'
    end
    object Label5: TLabel
      Left = 24
      Top = 180
      Width = 504
      Height = 13
      Caption = 
        '2. It is required in the definition of a "Log Event Provider" wh' +
        'ich is required by the Windows Event Viewer'
    end
    object Edit1: TEdit
      Left = 24
      Top = 48
      Width = 720
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      Enabled = False
      TabOrder = 0
      Text = 'Edit1'
    end
    object Button1: TButton
      Left = 581
      Top = 142
      Width = 163
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Re-Install'
      TabOrder = 1
      OnClick = Button1Click
    end
    object Edit2: TEdit
      Left = 24
      Top = 99
      Width = 720
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      Enabled = False
      TabOrder = 2
      Text = 'Edit1'
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 232
    Width = 768
    Height = 290
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = 'Registered Log Sources'
    TabOrder = 1
    DesignSize = (
      768
      290)
    object Label6: TLabel
      Left = 272
      Top = 32
      Width = 371
      Height = 13
      Caption = 
        'Here, you can register Log Event Source names your applications ' +
        'should use.'
    end
    object Label7: TLabel
      Left = 272
      Top = 51
      Width = 297
      Height = 13
      Caption = 'If an application logs an event with an unknown source name,'
    end
    object Label8: TLabel
      Left = 272
      Top = 70
      Width = 353
      Height = 13
      Caption = 
        'you will see an error message in the Windows Event Viewer simila' +
        'r to this:'
    end
    object Label9: TLabel
      Left = 272
      Top = 89
      Width = 382
      Height = 13
      Caption = 
        '                     "The description for Event ID ... from sour' +
        'ce ... cannot be found")'
    end
    object Label10: TLabel
      Left = 272
      Top = 108
      Width = 461
      Height = 13
      Caption = 
        'However, the original message is still readable. But it is still' +
        ' more ccorrect to register the source.'
    end
    object ListBox1: TListBox
      Left = 24
      Top = 32
      Width = 217
      Height = 234
      Anchors = [akLeft, akTop, akBottom]
      ItemHeight = 13
      TabOrder = 0
    end
    object Edit3: TEdit
      Left = 353
      Top = 241
      Width = 136
      Height = 21
      Anchors = [akLeft, akBottom]
      TabOrder = 1
    end
    object Button2: TButton
      Left = 272
      Top = 241
      Width = 75
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = 'Add new:'
      TabOrder = 2
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 272
      Top = 194
      Width = 129
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = 'Delete selected'
      TabOrder = 3
      OnClick = Button3Click
    end
  end
end
