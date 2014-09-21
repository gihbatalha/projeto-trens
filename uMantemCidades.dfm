object frmCidades: TfrmCidades
  Left = 0
  Top = 0
  Caption = 'Manuten'#231#227'o de Cidades'
  ClientHeight = 245
  ClientWidth = 786
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    786
    245)
  PixelsPerInch = 96
  TextHeight = 13
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 786
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
      ImageIndex = 11
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
    object ToolButton3: TToolButton
      Left = 598
      Top = 0
      Width = 8
      Caption = 'ToolButton3'
      ImageIndex = 10
      Style = tbsSeparator
    end
    object btnImprimir: TToolButton
      Left = 606
      Top = 0
      Caption = 'Imprimir'
      ImageIndex = 5
    end
    object ToolButton2: TToolButton
      Left = 665
      Top = 0
      Width = 8
      Caption = 'ToolButton2'
      ImageIndex = 9
      Style = tbsSeparator
    end
    object btnSair: TToolButton
      Left = 673
      Top = 0
      Caption = 'Sair'
      ImageIndex = 9
      OnClick = btnSairClick
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 39
    Width = 783
    Height = 203
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
        Left = 24
        Top = 16
        Width = 33
        Height = 18
        Caption = 'Sigla:'
      end
      object Label2: TLabel
        Left = 24
        Top = 48
        Width = 111
        Height = 18
        Caption = 'Nome da cidade:'
      end
      object edSigla: TEdit
        Left = 141
        Top = 13
        Width = 44
        Height = 26
        MaxLength = 4
        TabOrder = 0
        OnExit = edSiglaExit
      end
      object edNomeCidade: TEdit
        Left = 141
        Top = 45
        Width = 196
        Height = 26
        MaxLength = 30
        TabOrder = 1
      end
    end
    object tbsLista: TTabSheet
      Caption = 'Lista'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Memo1: TMemo
        Left = 2
        Top = 2
        Width = 502
        Height = 169
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
  end
end
