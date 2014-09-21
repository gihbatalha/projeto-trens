unit uMantemViagens;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ToolWin, Vcl.Grids,
  Vcl.StdCtrls, Vcl.ImgList, uMantemPassageiros, uTipoPassageiro;

type
  TfrmViagens = class(TForm)
    ToolBar1: TToolBar;
    btnInicio: TToolButton;
    btnVoltar: TToolButton;
    btnSeguir: TToolButton;
    btnUltimo: TToolButton;
    btnBuscar: TToolButton;
    ToolButton6: TToolButton;
    btnNovo: TToolButton;
    btnCancelar: TToolButton;
    btnSalvar: TToolButton;
    btnSair: TToolButton;
    ToolButton11: TToolButton;
    btnExcluir: TToolButton;
    PageControl1: TPageControl;
    tbsCadastro: TTabSheet;
    tbsLista: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edViagem: TEdit;
    edTrem: TEdit;
    edQtasCidades: TEdit;
    udQtasCidades: TUpDown;
    stgCidade: TStringGrid;
    lsbPassageiros: TListBox;
    Label4: TLabel;
    imlBotoes: TImageList;
    procedure btnSairClick(Sender: TObject);
    procedure btnInicioClick(Sender: TObject);
    procedure atualizarTela;
    procedure testarBotoes;
    procedure limparTela;
    procedure btnVoltarClick(Sender: TObject);
    procedure btnSeguirClick(Sender: TObject);
    procedure btnUltimoClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edViagemExit(Sender: TObject);
    procedure stgCidadeClick(Sender: TObject);
    procedure stgCidadeSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmViagens: TfrmViagens;

implementation

{$R *.dfm}

uses uClasseMantemVetor, uTipoViagem, uPrincipal;

var
  asViagens   : TMantemVetor;
  arqViagens  : File of TViagem;
  ondeIncluir : integer;
  umPassageiro:TPassageiro;

procedure TfrmViagens.limparTela;
var
i : integer;

begin
    edViagem.Clear;
    edTrem.Clear;
    edQtasCidades.Clear;

    for i := 1 to 12 do
    stgCidade.cells[i,0] := '';

end;

procedure TfrmViagens.stgCidadeSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);

var
  indice : integer;

begin
  for indice := 0 to stgCidade.colCount-1 do
  begin
    umPassageiro := osPassageiros[indice];
    if (umPassageiro.cidadeSobe = stgCidade.Cells[indice,1]) then
     lsbPassageiros.Items := umPassageiro.codigoPassageiro + umPassageiro.nomePassageiro;
  end;

end;

procedure TfrmViagens.testarBotoes;
begin
  btnInicio.Enabled   := true;
  btnVoltar.Enabled := true;
  btnSeguir.Enabled  := true;
  btnUltimo.Enabled   := true;

    if asViagens.estaNoInicio then
  begin
    btnInicio.Enabled   := false;
    btnVoltar.Enabled := false;
  end;

  if asViagens.estaNoFim then
  begin
    btnSeguir.Enabled  := false;
    btnUltimo.Enabled   := false;
  end;
end;

procedure TfrmViagens.atualizarTela;
var
  umaViagem  : TViagem;
  ondeViagem : integer;

  codigoViagem,
  codigoTrem,
  qtasCidades,
  i            : integer;

begin
  if asViagens.estaVazio then
     limparTela
  else
  begin  // buscamos o registro atual, indicado por asViagens.posicaoAtual:
    umaEntidadeViagem  := asViagens.registroAtual as TEntidadeViagem;
    umaViagem          := umaEntidadeViagem.registro;

    // apresentamos na tela os campos do registro de Viagem:
    edViagem.Text     := umaViagem.codigoViagem;
    edTrem.Text       := umaViagem.codigoTrem;
    edQtasCidades.text:= IntToSTr(umaViagem.qtasCidades);

    // lista as cidades no StringGrid
    with stgCidade do
    begin
      umaViagem := (asViagens.registroAtual
                  as TEntidadeViagem).registro;
      for i := 1  to 12 do
      begin
         cells[i,0] := umaViagem.cidadesPorOndePassa[i]
      end;
    end;
  end;
  testarBotoes;
end;

procedure TfrmViagens.btnBuscarClick(Sender: TObject);
begin
  edViagem.Clear;
  edViagem.setFocus;
  asViagens.ajustarSituacao(Pesquisando);
end;

procedure TfrmViagens.btnCancelarClick(Sender: TObject);
begin
  asViagens.ajustarSituacao(navegando);
  atualizarTela;
end;

// Este método exclui o registro que está sendo exibido
// na tela no momento. Caso seja o último registro do
// vetor dados, posiciona no que era o penúltimo.
// Por fim, exibe o novo registro atual na tela.
procedure TfrmViagens.btnExcluirClick(Sender: TObject);
var indiceDeExclusao : integer;
begin
  If Application.MessageBox(
         'Deseja realmente excluir este registro ?',
	 			  'Confirmation',mb_OKCancel) = mrOk Then
  Begin
    indiceDeExclusao := asViagens.indiceAtual;
    asViagens.excluir(indiceDeExclusao);

    if indiceDeExclusao >= asViagens.qtosRegistros then
       indiceDeExclusao := asViagens.qtosRegistros -1;

    asViagens.posicionarEm(indiceDeExclusao);
    atualizarTela;
  End
end;


procedure TfrmViagens.btnInicioClick(Sender: TObject);
begin
asViagens.posicionarNoPrimeiro;
atualizarTela;
end;

// Este método inicia o processo de inclusão, informando
// o programa que se passou ao modo de inclusão. Coloca
// o cursor em edViagem para que o usuário digite o código
// da nova viagem. Ao terminar a digitação do código e o
// cursor ser colocado em outro campo, será verificado
// se esse código não existe. Se não existir, pode-se
// digitar o nome da cidade e, quando se pressionar
// btnSalvar, guardar o registro no vetor dados.
procedure TfrmViagens.btnNovoClick(Sender: TObject);
begin
  limparTela;
  // Indica inclusão aos demais métodos
  asViagens.ajustarSituacao(Incluindo);
  edViagem.SetFocus;
end;

procedure TfrmViagens.btnSairClick(Sender: TObject);
begin
Close;   // fecha o programa mas antes dispara o
         // evento FormClose, que foi programado
         // para salvar os dados de asCidades no
         // arquivo de registros de cidades
end;

procedure TfrmViagens.btnSalvarClick(Sender: TObject);
var novoRegistro : TViagem;
    novaEntidade : TEntidadeViagem;
    indice,
    ondeEsta : integer;
begin
  if asViagens.situacao = incluindo then
  with novoRegistro do
  begin
    codigoViagem := edViagem.Text;
    codigoTrem   := edTrem.text;
    qtasCidades  := StrToInt(edQtasCidades.Text);

    while length(codigoViagem) < 4 do
      codigoViagem := '0' + codigoViagem;

     while length(codigoTrem) < 6 do
      codigoTrem := '0' + codigoViagem;

    novaEntidade := TEntidadeViagem.create(novoRegistro);
    asViagens.incluir(novaEntidade, ondeIncluir);
  end;

  for indice := 0 to stgCidade.colCount - 1 do
    if not (asViagens.haDados(stgCidade.cells[1,indice], ondeEsta)) then
    begin
       showMessage('Cidade inválida!');
    end;

  asViagens.ajustarSituacao(navegando);
end;

procedure TfrmViagens.btnSeguirClick(Sender: TObject);
begin
  asViagens.avancarPosicao;
  atualizarTela;
end;

procedure TfrmViagens.btnUltimoClick(Sender: TObject);
begin
  asViagens.posicionarNoUltimo;
  atualizarTela;
end;

procedure TfrmViagens.btnVoltarClick(Sender: TObject);
begin
  asViagens.retrocederPosicao;
  atualizarTela;
end;

procedure TfrmViagens.edViagemExit(Sender: TObject);
var cadeia : string;
    ondeExibir : integer;
begin
  cadeia := edViagem.text;
  while length(cadeia) < 4 do
    cadeia := cadeia + '0';
  if cadeia <> '0000' then
     case asViagens.situacao of
     incluindo :
       if asViagens.haDados(cadeia, ondeIncluir) then
       begin  // se já existe, cancela inclusão
         asViagens.ajustarSituacao(navegando);
         ShowMessage('Viagem com código já existente');
         atualizarTela;
       end
       else
         edTrem.SetFocus;
     pesquisando:
     begin
       if not asViagens.haDados(cadeia, ondeExibir) then
         ShowMessage('Código não existente')
       else
         asViagens.posicionarEm(ondeExibir);
       asViagens.ajustarSituacao(navegando);
       atualizarTela;
     end;
     end;
end;

procedure TfrmViagens.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  uTipoViagem.gravarDados('cidades.dat');
end;

procedure TfrmViagens.FormCreate(Sender: TObject);
begin
  asViagens := TMantemVetor.create;
  uTipoViagem.lerDados('cidades.dat');
  atualizarTela;
end;

procedure TfrmViagens.FormShow(Sender: TObject);
begin
  uTipoViagem.lerDados('cidades.dat');
  uTipoViagem.gravarDados('cidades.dat');
end;

end.
