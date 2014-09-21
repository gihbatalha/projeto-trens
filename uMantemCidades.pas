unit uMantemCidades;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, StdCtrls;

type
  TfrmCidades = class(TForm)
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
    edSigla: TEdit;
    edNomeCidade: TEdit;
    Memo1: TMemo;
    btnImprimir: TToolButton;
    ToolButton3: TToolButton;
    procedure btnInicioClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure atualizarTela;
    procedure limparTela;
    procedure testarBotoes;
    procedure btnAnteriorClick(Sender: TObject);
    procedure btnProximoClick(Sender: TObject);
    procedure btnUltimoClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure edSiglaExit(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnProcurarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);


  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCidades: TfrmCidades;

implementation

uses uClasseMantemVetor, uTipoCidade, uPrincipal;

{$R *.dfm}

var
  asCidades   : TMantemVetor;
  arqCidades  : File of TCidade;
  ondeIncluir : integer;
procedure TfrmCidades.atualizarTela;
var
  umaCidade  : TCidade;
  ondeCidade : integer;
begin
  if asCidades.estaVazio then
     limparTela
  else
  with umaCidade do
  begin
    umaCidade := (asCidades.registroAtual
                  as TEntidadeCidade).registro;

    edSigla.Text      := siglaCidade;
    edNomeCidade.Text := nomeCidade;
  end;
  testarBotoes;
end;

procedure TfrmCidades.btnAnteriorClick(Sender: TObject);
begin
  asCidades.retrocederPosicao;
  atualizarTela;
end;

procedure TfrmCidades.btnCancelarClick(Sender: TObject);
begin
  asCidades.ajustarSituacao(navegando);
  atualizarTela;
end;

// Este m�todo exclui o registro que est� sendo exibido
// na tela no momento. Caso seja o �ltimo registro do
// vetor dados, posiciona no que era o pen�ltimo.
// Por fim, exibe o novo registro atual na tela.
procedure TfrmCidades.btnExcluirClick(Sender: TObject);
var indiceDeExclusao : integer;
begin
  If Application.MessageBox(
         'Deseja realmente excluir este registro ?',
	 			  'Confirmation',mb_OKCancel) = mrOk Then
  Begin
    indiceDeExclusao := asCidades.indiceAtual;
    asCidades.excluir(indiceDeExclusao);

    if indiceDeExclusao >= asCidades.qtosRegistros then
       indiceDeExclusao := asCidades.qtosRegistros -1;

    asCidades.posicionarEm(indiceDeExclusao);
    atualizarTela;
  End
end;

// Este m�todo inicia o processo de inclus�o, informando
// o programa que se passou ao modo de inclus�o. Coloca
// o cursor em edSigla para que o usu�rio digite a sigla
// da nova cidade. Ao terminar a digita��o da sigla e o
// cursor ser colocado em outro campo, ser� verificado
// se essa sigla n�o existe. Se n�o existir, pode-se
// digitar o nome da cidade e, quando se pressionar
// btnGravar, guardar o registro no vetor dados.
procedure TfrmCidades.btnIncluirClick(Sender: TObject);
begin
  limparTela;
  // Indica inclus�o aos demais m�todos
  asCidades.ajustarSituacao(Incluindo);
  edSigla.SetFocus;
end;

procedure TfrmCidades.btnInicioClick(Sender: TObject);
begin
  asCidades.posicionarNoPrimeiro;
  atualizarTela
end;

procedure TfrmCidades.btnProcurarClick(Sender: TObject);
begin
  edSigla.Clear;
  edSigla.setFocus;
  asCidades.ajustarSituacao(Pesquisando);
end;

procedure TfrmCidades.btnProximoClick(Sender: TObject);
begin
  asCidades.avancarPosicao;
  atualizarTela;
end;

procedure TfrmCidades.btnSairClick(Sender: TObject);
begin
  close; // fecha o programa mas antes dispara o
         // evento FormClose, que foi programado
         // para salvar os dados de asCidades no
         // arquivo de registros de cidades
end;

procedure TfrmCidades.btnSalvarClick(Sender: TObject);
var novoRegistro : TCidade;
    novaEntidade : TEntidadeCidade;
begin
  if asCidades.situacao = incluindo then
  with novoRegistro do
  begin
    siglaCidade := edSigla.Text;
    nomeCidade  := edNomeCidade.text;
    while length(nomeCidade) < 30 do
      nomeCidade := nomeCidade + ' ';

    novaEntidade := TENtidadeCidade.create(novoRegistro);
    asCidades.incluir(novaEntidade, ondeIncluir);
  end;
  asCidades.ajustarSituacao(navegando);
end;

procedure TfrmCidades.btnUltimoClick(Sender: TObject);
begin
  asCidades.posicionarNoUltimo;
  atualizarTela;
end;

procedure TfrmCidades.edSiglaExit(Sender: TObject);
var cadeia : string;
    ondeExibir : integer;
begin
  cadeia := edSigla.text;
  while length(cadeia) < 4 do
    cadeia := cadeia + ' ';
  if cadeia <> '    ' then
     case asCidades.situacao of
     incluindo :
       if asCidades.haDados(cadeia, ondeIncluir) then
       begin  // se j� existe, cancela inclus�o
         asCidades.ajustarSituacao(navegando);
         ShowMessage('Cidade com sigla j� existente');
         atualizarTela;
       end
       else
         edNomeCidade.SetFocus;
     pesquisando:
     begin
       if not asCidades.haDados(cadeia, ondeExibir) then
         ShowMessage('Sigla n�o existente')
       else
         asCidades.posicionarEm(ondeExibir);
       asCidades.ajustarSituacao(navegando);
       atualizarTela;
     end;
     end;
end;

procedure TfrmCidades.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  uTipoCidade.gravarDados('cidades.dat');
end;

procedure TfrmCidades.FormCreate(Sender: TObject);
begin
  asCidades := TMantemVetor.create;
  uTipoCidade.lerDados('cidades.dat');
  atualizarTela;
end;

//aqui
procedure TfrmCidades.FormShow(Sender: TObject);
begin
  uTipoCidade.lerDados('cidades.dat');
  uTipoCidade.gravarDados('cidades.dat');
end;
//ali

{ Onclick do bot�o incluir



 }
procedure TfrmCidades.limparTela;
begin
  edSigla.Clear;
  edNomeCidade.Clear;
end;

procedure TfrmCidades.testarBotoes;
begin
  btnInicio.Enabled   := true;
  btnAnterior.Enabled := true;
  btnProximo.Enabled  := true;
  btnUltimo.Enabled   := true;

  if asCidades.estaNoInicio then
  begin
    btnInicio.Enabled   := false;
    btnAnterior.Enabled := false;
  end;

  if asCidades.estaNoFim then
  begin
    btnProximo.Enabled  := false;
    btnUltimo.Enabled   := false;
  end;
end;

end.
