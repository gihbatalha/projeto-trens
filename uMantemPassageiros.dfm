object frmPassageiros: TfrmPassageiros
  Left = 0
  Top = 0
  Caption = 'Manuten'#231#227'o de Passageiros'
  ClientHeight = 324
  ClientWidth = 667
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
    667
    324)
  PixelsPerInch = 96
  TextHeight = 13
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 667
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
    object ToolButton1: TToolButton
      Left = 0
      Top = 0
      Width = 1
      Caption = 'ToolButton1'
      ImageIndex = 4
      Style = tbsSeparator
    end
    object btnInicio: TToolButton
      Left = 1
      Top = 0
      Caption = 'In'#237'cio'
      ImageIndex = 7
      OnClick = btnInicioClick
    end
    object btnAnterior: TToolButton
      Left = 60
      Top = 0
      Caption = 'Anterior'
      ImageIndex = 1
      OnClick = btnAnteriorClick
    end
    object btnProximo: TToolButton
      Left = 119
      Top = 0
      Caption = 'Pr'#243'ximo'
      ImageIndex = 8
      OnClick = btnProximoClick
    end
    object btnUltimo: TToolButton
      Left = 178
      Top = 0
      Caption = #218'ltimo'
      ImageIndex = 0
      OnClick = btnUltimoClick
    end
    object btnProcurar: TToolButton
      Left = 237
      Top = 0
      Caption = 'Procurar'
      ImageIndex = 2
      OnClick = btnProcurarClick
    end
    object ToolButton3: TToolButton
      Left = 296
      Top = 0
      Width = 8
      Caption = 'ToolButton3'
      ImageIndex = 10
      Style = tbsSeparator
    end
    object btnIncluir: TToolButton
      Left = 304
      Top = 0
      Caption = 'Incluir'
      ImageIndex = 6
      OnClick = btnIncluirClick
    end
    object btnEditar: TToolButton
      Left = 363
      Top = 0
      Caption = 'Editar'
      ImageIndex = 5
    end
    object btnExcluir: TToolButton
      Left = 422
      Top = 0
      Caption = 'Excluir'
      ImageIndex = 4
      OnClick = btnExcluirClick
    end
    object btnCancelar: TToolButton
      Left = 481
      Top = 0
      Caption = 'Cancelar'
      ImageIndex = 3
      OnClick = btnCancelarClick
    end
    object btnSalvar: TToolButton
      Left = 540
      Top = 0
      Caption = 'Salvar'
      ImageIndex = 10
      OnClick = btnSalvarClick
    end
    object ToolButton2: TToolButton
      Left = 599
      Top = 0
      Width = 8
      Caption = 'ToolButton2'
      ImageIndex = 9
      Style = tbsSeparator
    end
    object btnSair: TToolButton
      Left = 607
      Top = 0
      Caption = 'Sair'
      ImageIndex = 9
      OnClick = btnSairClick
    end
  end
  object PageControl1: TPageControl
    Left = 9
    Top = 55
    Width = 664
    Height = 264
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
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
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Cadastro'
      object Label1: TLabel
        Left = 3
        Top = 16
        Width = 48
        Height = 18
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Caption = 'C'#243'digo:'
      end
      object Label2: TLabel
        Left = 3
        Top = 48
        Width = 44
        Height = 18
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Caption = 'Nome:'
      end
      object edCodPassageiro: TEdit
        Left = 63
        Top = 13
        Width = 81
        Height = 26
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        MaxLength = 6
        TabOrder = 0
        Text = 'edCodPass'
        OnExit = edCodPassageiroExit
      end
      object edQtosVagoes: TEdit
        Left = 63
        Top = 44
        Width = 267
        Height = 26
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        MaxLength = 2
        TabOrder = 1
        Text = 'edNomePassageiro'
      end
      object GroupBox1: TGroupBox
        Left = 2
        Top = 73
        Width = 601
        Height = 130
        Caption = 'Viagem reservada '
        TabOrder = 2
        object Label3: TLabel
          Left = 6
          Top = 61
          Width = 69
          Height = 18
          Caption = 'Da cidade:'
        end
        object Label4: TLabel
          Left = 300
          Top = 61
          Width = 86
          Height = 18
          Caption = 'At'#233' a cidade:'
        end
        object Label5: TLabel
          Left = 6
          Top = 98
          Width = 41
          Height = 18
          Caption = 'Trem:'
        end
        object Label6: TLabel
          Left = 171
          Top = 98
          Width = 46
          Height = 18
          Caption = 'Vag'#227'o:'
        end
        object Label7: TLabel
          Left = 300
          Top = 98
          Width = 40
          Height = 18
          Caption = 'Fileira:'
        end
        object Label8: TLabel
          Left = 440
          Top = 98
          Width = 57
          Height = 18
          Caption = 'Poltrona:'
        end
        object LabeledEdit1: TLabeledEdit
          Left = 57
          Top = 24
          Width = 103
          Height = 26
          EditLabel.Width = 43
          EditLabel.Height = 18
          EditLabel.Caption = 'C'#243'digo'
          LabelPosition = lpLeft
          TabOrder = 0
          Text = 'edCodViagem'
        end
        object Edit1: TEdit
          Left = 86
          Top = 61
          Width = 184
          Height = 26
          TabOrder = 1
          Text = 'edCidadeSobe'
        end
        object Edit2: TEdit
          Left = 398
          Top = 61
          Width = 190
          Height = 26
          TabOrder = 2
          Text = 'edCidadeDesce'
        end
        object Edit3: TEdit
          Left = 67
          Top = 98
          Width = 93
          Height = 26
          TabOrder = 3
          Text = 'edCodTrem'
        end
        object edVagao: TEdit
          Left = 220
          Top = 98
          Width = 68
          Height = 26
          TabOrder = 4
          Text = 'edVagao'
        end
        object edFileira: TEdit
          Left = 349
          Top = 98
          Width = 71
          Height = 26
          TabOrder = 5
          Text = 'edFileira'
        end
        object edPoltrona: TEdit
          Left = 508
          Top = 98
          Width = 80
          Height = 26
          TabOrder = 6
          Text = 'edPoltrona'
        end
      end
    end
    object tbsLista: TTabSheet
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Lista'
      ImageIndex = 1
    end
  end
end
