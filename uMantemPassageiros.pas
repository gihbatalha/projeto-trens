unit uMantemPassageiros;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, StdCtrls, Grids, ExtCtrls, uTipoCidade;

type
  TfrmPassageiros = class(TForm)
    ToolBar1: TToolBar;
    btnInicio: TToolButton;
    btnAnterior: TToolButton;
    btnProximo: TToolButton;
    btnUltimo: TToolButton;
    ToolButton1: TToolButton;
    btnIncluir: TToolButton;
    btnCancelar: TToolButton;
    btnSalvar: TToolButton;
    btnExcluir: TToolButton;
    btnEditar: TToolButton;
    btnProcurar: TToolButton;
    ToolButton2: TToolButton;
    btnSair: TToolButton;
    PageControl1: TPageControl;
    tbsDados: TTabSheet;
    tbsLista: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    edCodPassageiro: TEdit;
    GroupBox1: TGroupBox;
    LabeledEdit1: TLabeledEdit;
    Label3: TLabel;
    Edit1: TEdit;
    Label4: TLabel;
    Edit2: TEdit;
    Label5: TLabel;
    Edit3: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    edVagao: TEdit;
    edFileira: TEdit;
    edPoltrona: TEdit;
    ToolButton3: TToolButton;
    procedure btnInicioClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure atualizarTela;
    procedure limparTela;
    procedure testarBotoes;
    procedure btnProximoClick(Sender: TObject);
    procedure btnUltimoClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure edCodPassageiroExit(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnProcurarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnAnteriorClick(Sender: TObject);
    Function compararNomes(Lento, Rapido:integer):integer;// devolve -1, 0 ou 1
    Function compararCidadeSobe(Lento, Rapido:integer):integer; // devolve -1, 0 ou 1

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPassageiros: TfrmPassageiros;

implementation

uses uClasseMantemVetor, uTipoPassageiro, uPrincipal;

{$R *.dfm}

var
  ondeIncluir : integer;

Function compararCidadeSobe(Lento, Rapido:integer):integer;
begin
  if asCidades[lento] < asCidades[rapido] then
    result := -1

  else
  if asCidades[lento] > asCidades[rapido] then
    result := 1

    else
    result := 0;
end;


function compararNomes(Lento, Rapido : integer) : integer;
begin
  if osPassageiros[lento] < osPassageiros[rapido] then
    result := -1

  else
  if osPassageiros[lento] > osPassageiros[rapido] then
    result := 1

    else
    result := 0;
end;

procedure TfrmPassageiros.atualizarTela;
begin

  testarBotoes;
end;

procedure TfrmPassageiros.btnAnteriorClick(Sender: TObject);
begin
osPassageiros.retrocederPosicao;
atualizarTela;
end;

procedure TfrmPassageiros.btnCancelarClick(Sender: TObject);
begin
///
end;

// Este método exclui o registro que está sendo exibido
// na tela no momento. Caso seja o último registro do
// vetor dados, posiciona no que era o penúltimo.
// Por fim, exibe o novo registro atual na tela.
procedure TfrmPassageiros.btnExcluirClick(Sender: TObject);
begin
///
end;

// Este método inicia o processo de inclusão, informando
// o programa que se passou ao modo de inclusão. Coloca
// o cursor em edSigla para que o usuário digite a sigla
// da nova Tren. Ao terminar a digitação da sigla e o
// cursor ser colocado em outro campo, será verificado
// se essa sigla não existe. Se não existir, pode-se
// digitar o nome da Tren e, quando se pressionar
// btnGravar, guardar o registro no vetor dados.
procedure TfrmPassageiros.btnIncluirClick(Sender: TObject);
begin
  limparTela;
  // Indica inclusão aos demais métodos
end;

procedure TfrmPassageiros.btnInicioClick(Sender: TObject);
begin
osPassageiros.posicionarNoPrimeiro;
atualizarTela;
end;

procedure TfrmPassageiros.btnProcurarClick(Sender: TObject);
begin
if osPassageiros.haDados(edCodPassageiro.Text, ondeIncluir)then
  atualizarTela;
end;

procedure TfrmPassageiros.btnProximoClick(Sender: TObject);
begin
osPassageiros.avancarPosicao;
atualizarTela;
///
end;

procedure TfrmPassageiros.btnSairClick(Sender: TObject);
begin
  close; // fecha o programa mas antes dispara o
         // evento FormClose, que foi programado
         // para salvar os dados de osTrens no
         // arquivo de registros de Trens
end;

procedure TfrmPassageiros.btnSalvarClick(Sender: TObject);
begin
///
end;

procedure TfrmPassageiros.btnUltimoClick(Sender: TObject);
begin
osPassageiros.posicionarNoUltimo;
atualizarTela;
///
end;

procedure TfrmPassageiros.edCodPassageiroExit(Sender: TObject);
var cadeia : string;
    ondeExibir : integer;
begin
///
end;

procedure TfrmPassageiros.FormClose(Sender: TObject; var Action: TCloseAction);
begin
///
end;

procedure TfrmPassageiros.FormCreate(Sender: TObject);
begin
///
end;

procedure TfrmPassageiros.limparTela;
begin
///
end;

procedure TfrmPassageiros.testarBotoes;
begin
  btnInicio.Enabled   := true;
  btnAnterior.Enabled := true;
  btnProximo.Enabled  := true;
  btnUltimo.Enabled   := true;
///
end;

end.
