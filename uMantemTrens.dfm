object frmTrens: TfrmTrens
  Left = 0
  Top = 0
  Caption = 'Manuten'#231#227'o de Trens'
  ClientHeight = 311
  ClientWidth = 741
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  DesignSize = (
    741
    311)
  PixelsPerInch = 96
  TextHeight = 13
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 741
    Height = 37
    AutoSize = True
    ButtonHeight = 37
    ButtonWidth = 59
    Caption = 'ToolBar1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    Images = frmPrincipal.imlBotoes
    ParentFont = False
    ShowCaptions = True
    TabOrder = 0
    object btnInicio: TToolButton
      Left = 0
      Top = 0
      Caption = 'In'#237'cio'
      ImageIndex = 7
      OnClick = btnInicioClick
    end
    object btnAnterior: TToolButton
      Left = 59
      Top = 0
      Caption = 'Anterior'
      ImageIndex = 1
      OnClick = btnAnteriorClick
    end
    object btnProximo: TToolButton
      Left = 118
      Top = 0
      Caption = 'Pr'#243'ximo'
      ImageIndex = 8
      OnClick = btnProximoClick
    end
    object btnUltimo: TToolButton
      Left = 177
      Top = 0
      Caption = #218'ltimo'
      ImageIndex = 0
      OnClick = btnUltimoClick
    end
    object ToolButton1: TToolButton
      Left = 236
      Top = 0
      Width = 8
      Caption = 'ToolButton1'
      ImageIndex = 4
      Style = tbsSeparator
    end
    object btnIncluir: TToolButton
      Left = 244
      Top = 0
      Caption = 'Incluir'
      ImageIndex = 6
      OnClick = btnIncluirClick
    end
    object btnEditar: TToolButton
      Left = 303
      Top = 0
      Caption = 'Editar'
      ImageIndex = 5
    end
    object btnCancelar: TToolButton
      Left = 362
      Top = 0
      Caption = 'Cancelar'
      ImageIndex = 3
      OnClick = btnCancelarClick
    end
    object btnSalvar: TToolButton
      Left = 421
      Top = 0
      Caption = 'Salvar'
      ImageIndex = 10
      OnClick = btnSalvarClick
    end
    object btnExcluir: TToolButton
      Left = 480
      Top = 0
      Caption = 'Excluir'
      ImageIndex = 4
      OnClick = btnExcluirClick
    end
    object btnProcurar: TToolButton
      Left = 539
      Top = 0
      Caption = 'Procurar'
      ImageIndex = 2
      OnClick = btnProcurarClick
    end
    object ToolButton2: TToolButton
      Left = 598
      Top = 0
      Width = 8
      Caption = 'ToolButton2'
      ImageIndex = 9
      Style = tbsSeparator
    end
    object btnSair: TToolButton
      Left = 606
      Top = 0
      Caption = 'Sair'
      ImageIndex = 9
      OnClick = btnSairClick
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 39
    Width = 739
    Height = 269
    ActivePage = tbsDados
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object tbsDados: TTabSheet
      Caption = 'Cadastro'
      object Label1: TLabel
        Left = 3
        Top = 16
        Width = 48
        Height = 18
        Caption = 'C'#243'digo:'
      end
      object Label2: TLabel
        Left = 3
        Top = 48
        Width = 69
        Height = 18
        Caption = '# Vag'#245'es:'
      end
      object Label3: TLabel
        Left = 3
        Top = 80
        Width = 82
        Height = 18
        Caption = 'Vag'#227'o atual:'
      end
      object edCodTrem: TEdit
        Left = 89
        Top = 13
        Width = 81
        Height = 26
        MaxLength = 6
        TabOrder = 0
        OnExit = edCodTremExit
      end
      object edQtosVagoes: TEdit
        Left = 89
        Top = 45
        Width = 38
        Height = 26
        MaxLength = 2
        TabOrder = 1
        Text = '1'
      end
      object udQtosTrens: TUpDown
        Left = 127
        Top = 45
        Width = 16
        Height = 26
        Associate = edQtosVagoes
        Min = 1
        Max = 10
        Position = 1
        TabOrder = 2
      end
      object edVagaoAtual: TEdit
        Left = 89
        Top = 77
        Width = 38
        Height = 26
        MaxLength = 2
        TabOrder = 3
        Text = '1'
      end
      object udVagaoAtual: TUpDown
        Left = 127
        Top = 77
        Width = 16
        Height = 26
        Associate = edVagaoAtual
        Min = 1
        Max = 10
        Position = 1
        TabOrder = 4
      end
      object stgVagaoAtual: TStringGrid
        Left = 3
        Top = 104
        Width = 725
        Height = 130
        ColCount = 15
        DefaultColWidth = 47
        TabOrder = 5
      end
    end
    object tbsLista: TTabSheet
      Caption = 'Lista'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
    end
  end
end
