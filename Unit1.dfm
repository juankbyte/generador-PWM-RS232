object Form1: TForm1
  Left = 192
  Top = 124
  Width = 924
  Height = 480
  Caption = 'Controlador 8051 por RS232'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object ComTerminal1: TComTerminal
    Left = 0
    Top = 210
    Width = 908
    Height = 232
    Align = alClient
    Color = clBlack
    ComPort = ComPort
    Emulation = teVT100orANSI
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = 'Fixedsys'
    Font.Style = []
    ScrollBars = ssBoth
    TabOrder = 0
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 17
    Width = 908
    Height = 193
    ActivePage = TabSheet2
    Align = alTop
    TabIndex = 1
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = 'Generador PWM'
      object Label1: TLabel
        Left = 0
        Top = 0
        Width = 900
        Height = 13
        Align = alTop
      end
      object PageControl2: TPageControl
        Left = 0
        Top = 13
        Width = 900
        Height = 152
        ActivePage = TabSheet3
        Align = alClient
        TabIndex = 0
        TabOrder = 0
        object TabSheet3: TTabSheet
          Caption = 'Modifiacion directo'
          object Labelpwm: TLabeledEdit
            Left = 16
            Top = 24
            Width = 193
            Height = 21
            EditLabel.Width = 38
            EditLabel.Height = 13
            EditLabel.Caption = '% PWM'
            LabelPosition = lpAbove
            LabelSpacing = 3
            TabOrder = 0
          end
          object Button1: TButton
            Left = 16
            Top = 48
            Width = 193
            Height = 25
            Caption = 'MODIFICAR'
            TabOrder = 1
            OnClick = Button1Click
          end
        end
        object TabSheet4: TTabSheet
          Caption = 'Modificacion en intervalos de tiempo'
          ImageIndex = 1
          object ProgressBar: TProgressBar
            Left = 0
            Top = 107
            Width = 892
            Height = 17
            Align = alBottom
            Min = 0
            Max = 100
            TabOrder = 0
          end
          object LabelMilSeg: TLabeledEdit
            Left = 8
            Top = 24
            Width = 201
            Height = 21
            EditLabel.Width = 133
            EditLabel.Height = 13
            EditLabel.Caption = 'Intervalo de cambio (milSeg)'
            LabelPosition = lpAbove
            LabelSpacing = 3
            TabOrder = 1
          end
          object RadioGroup: TRadioGroup
            Left = 232
            Top = 8
            Width = 233
            Height = 97
            Caption = '  Al llegar al 100%  '
            Items.Strings = (
              'Detenerse'
              'Reanudar en 0%'
              'Decrementar en intervalos al 0%')
            TabOrder = 2
          end
          object Button2: TButton
            Left = 8
            Top = 49
            Width = 201
            Height = 25
            Caption = 'INICIAR'
            TabOrder = 3
            OnClick = Button2Click
          end
          object Button3: TButton
            Left = 8
            Top = 79
            Width = 201
            Height = 25
            Caption = 'DETENER'
            TabOrder = 4
            OnClick = Button3Click
          end
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Configuracion puerto serie'
      ImageIndex = 1
      object Label2: TLabel
        Left = 40
        Top = 8
        Width = 24
        Height = 13
        Caption = 'COM'
      end
      object Label3: TLabel
        Left = 40
        Top = 56
        Width = 39
        Height = 13
        Caption = 'Baudaje'
      end
      object ComboCom: TComboBox
        Left = 40
        Top = 24
        Width = 145
        Height = 21
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 0
        Text = 'COM1'
        Items.Strings = (
          'COM1'
          'COM2'
          'COM3'
          'COM4'
          'COM5'
          'COM6')
      end
      object ComboBau: TComboBox
        Left = 40
        Top = 72
        Width = 145
        Height = 21
        ItemHeight = 13
        ItemIndex = 14
        TabOrder = 1
        Text = '9600'
        Items.Strings = (
          '110'
          '115200'
          '1200'
          '1280000'
          '14400'
          '19200'
          '2400'
          '256000'
          '300'
          '38400'
          '4800'
          '56000'
          '57600'
          '600'
          '9600')
      end
      object Button4: TButton
        Left = 40
        Top = 112
        Width = 145
        Height = 25
        Caption = 'APLICAR'
        TabOrder = 2
        OnClick = Button4Click
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 908
    Height = 17
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
  end
  object Memo: TMemo
    Left = 80
    Top = 224
    Width = 625
    Height = 177
    Lines.Strings = (
      'Memo')
    TabOrder = 3
  end
  object ComPort: TComPort
    BaudRate = br9600
    Port = 'COM1'
    Parity.Bits = prNone
    StopBits = sbOneStopBit
    DataBits = dbEight
    Events = [evRxChar, evTxEmpty, evRxFlag, evRing, evBreak, evCTS, evDSR, evError, evRLSD, evRx80Full]
    FlowControl.OutCTSFlow = False
    FlowControl.OutDSRFlow = False
    FlowControl.ControlDTR = dtrDisable
    FlowControl.ControlRTS = rtsDisable
    FlowControl.XonXoffOut = False
    FlowControl.XonXoffIn = False
    StoredProps = [spBasic]
    TriggersOnRxChar = False
    Left = 872
    Top = 48
  end
  object TimerEnvio: TTimer
    Tag = 1
    Enabled = False
    OnTimer = TimerEnvioTimer
    Left = 872
    Top = 80
  end
end
