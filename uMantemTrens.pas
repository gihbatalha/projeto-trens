unit uMantemTrens;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, StdCtrls, Grids;

type
  TfrmTrens = class(TForm)
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
    edCodTrem: TEdit;
    udQtosTrens: TUpDown;
    Label3: TLabel;
    edVagaoAtual: TEdit;
    udVagaoAtual: TUpDown;
    stgVagaoAtual: TStringGrid;
    edQtosVagoes : TEdit;
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
    procedure edCodTremExit(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnProcurarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    //procedure edQtosVagoesChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmTrens: TfrmTrens;

implementation

uses uClasseMantemVetor, uTipoTrem, uPrincipal, uTIpoPassageiro;

{$R *.dfm}

var
  ondeIncluir : integer;

procedure TfrmTrens.atualizarTela;
var
  umTrem  : TTrem;
  ondeTrem : integer;

  fileira  : integer;
  poltrona : char;
begin
  if osTrens.estaVazio then
     limparTela
  else
  begin  // buscamos o registro atual, indicado por osTrens.posicaoAtual:
    umaEntidadeTrem := osTrens.registroAtual as TEntidadeTrem;
    umTrem          := umaEntidadeTrem.registro;
    // apresentamos na tela os campos do registro de Trem:
    edCodTrem.Text        := umTrem.codTrem;

    // lista as fileiras
    with stgVagaoAtual do
    begin
      RowCount   := 0;     // para limpar tudo
      RowCount   := 4+1;  // +1 para o cabe�alho
      cells[0,0] := 'Fileira#';
      cells[0,1] := 'A';
      cells[0,2] := 'B';
      cells[0,3] := 'C';
      cells[0,4] := 'D';
      //for fileira := 1 to 10 do
         // for poltrona := 'A' to 'D' do           // exibe na c�lula
          //  cells[ord(poltrona)-64,fileira] := umVagao.poltrona[ord(poltrona)-64,fileira];
    end;
  end;
  testarBotoes;
  //sbMensagem.Panels[0].Text := 'Situa��o: Navegando';
  //sbMensagem.Panels[1].Text := 'Mensagem: Registro '+intToStr(osTrens.indiceAtual+1)+
                                          //  '/'+intToStr(osTrens.qtosRegistros);
  edCodTrem.ReadOnly:= true;
end;

procedure TfrmTrens.btnAnteriorClick(Sender: TObject);
begin
  osTrens.retrocederPosicao;
  atualizarTela;
end;

procedure TfrmTrens.btnCancelarClick(Sender: TObject);
begin
  osTrens.ajustarSituacao(navegando);  // para o que estava fazendo antes e volta � navega��o
  atualizarTela;
end;

procedure TfrmTrens.btnEditarClick(Sender: TObject);
begin
  osTrens.ajustarSituacao(editando);
  edCodTrem.ReadOnly := true;                         // impede mudan�a de sigla
 // sbMensagem.Panels[0].text := 'Situa��o: Editando';
  //sbMensagem.Panels[1].text := 'Mensagem: Altere as informa��es desejadas e, depois, pressione [Salvar]';

  edQtosVagoes.SetFocus;
end;

// Este m�todo exclui o registro que est� sendo exibido
// na tela no momento. Caso seja o �ltimo registro do
// vetor dados, posiciona no que era o pen�ltimo.
// Por fim, exibe o novo registro atual na tela.
procedure TfrmTrens.btnExcluirClick(Sender: TObject);
var indiceDeExclusao : integer;
begin
  if messageDlg('Deseja realmente excluir esse Avi�o?',mtConfirmation, mbOkCancel,0)
     = idOk then
  begin
    osTrens.excluir(osTrens.indiceAtual);
    atualizarTela;
  end;
end;

// Este m�todo inicia o processo de inclus�o, informando
// o programa que se passou ao modo de inclus�o. Coloca
// o cursor em edCodTrem para que o usu�rio digite a c�digo
// do novo Trem. Ao terminar a digita��o da c�digo e o
// cursor ser colocado em outro campo, ser� verificado
// se essa c�digo n�o existe. Se n�o existir, pode-se
// digitar o nome do Trem e, quando se pressionar
// btnGravar, guardar o registro no vetor dados.
procedure TfrmTrens.btnIncluirClick(Sender: TObject);
begin
  limparTela;
  osTrens.ajustarSituacao(incluindo);    // coloca o objeto em modo de inclus�o

  edCodTrem.ReadOnly := false;          // libera o edCodTrem para digita��o
  edCodTrem.SetFocus;

  //sbMensagem.Panels[0].text := 'Situa��o: Incluindo';
 // sbMensagem.Panels[1].text := 'Mensagem: Digite o c�digo do novo trem.';
end;

procedure TfrmTrens.btnInicioClick(Sender: TObject);
begin
  osTrens.posicionarNoPrimeiro;
  atualizarTela;
end;

procedure TfrmTrens.btnProcurarClick(Sender: TObject);
begin
  osTrens.ajustarSituacao(pesquisando);
  edCodTrem.Clear;
  edCodTrem.ReadOnly := false;  // para podermos digitar o Codigo procurado
  edCodTrem.SetFocus;
  //sbMensagem.Panels[0].Text := 'Situa��o: Pesquisando';
  //sbMensagem.Panels[1].Text := 'Mensagem: Digite o C�digo do Trem procurado e, depois, pressione [Tab]';
end;

procedure TfrmTrens.btnProximoClick(Sender: TObject);
begin
  osTrens.avancarPosicao;
  atualizarTela;
end;

procedure TfrmTrens.btnSairClick(Sender: TObject);
begin
  close; // fecha o programa mas antes dispara o
         // evento FormClose, que foi programado
         // para salvar os dados de osTrens no
         // arquivo de registros de Trens
end;

procedure TfrmTrens.btnSalvarClick(Sender: TObject);
var novoRegistro : TTrem;
    novaEntidade : TEntidadeTrem;
    aux          : string;
begin
  if osTrens.situacao in [incluindo, editando] then
  begin
  // montamos um registro (umTrem) com os dados que foram digitados nos campos
  // da tela
    umTrem.codTrem    := edCodTrem.Text;

    aux := edQtosVagoes.Text;
    umTrem.qtosVagoes := StrToInt(aux);

    aux := edVagaoAtual.Text;
    //umTrem.vagao := StrToInt(aux);


  // criamos um objeto compat�vel com TEntidade, contendo o registro de Passageiro
  // para, em seguida, armazenar esse objeto no vetor "dados" de osPassageiros:
    umaEntidadeTrem   := TEntidadeTrem.create(umTrem);

    case osTrens.situacao of
    incluindo :
      begin
        osTrens.incluir(umaEntidadeTrem, ondeIncluir);  // ondeIncluir => definido na pesquisa bin�ria
                                                        // osTrens.haDados(cadeia, ondeIncluir)
        osTrens.posicionarEm(ondeIncluir);            // reposiciona o registro atual na posi��o de inclus�o
      end;

    editando  : osTrens.alterar(umaEntidadeTrem, osTrens.indiceAtual); // indiceAtual devolve o valor
                                                                    // de osTrens.posicaoAtual,
                                                                    // que � o lugar do vetor
                                                                    // "dados" onde est� o Trem
                                                                    // cujos dados foram alterados
    end;
    osTrens.ajustarSituacao(navegando);
    atualizarTela;
  end;
end;

procedure TfrmTrens.btnUltimoClick(Sender: TObject);
begin
  osTrens.posicionarNoUltimo;
  atualizarTela;
end;

procedure TfrmTrens.edCodTremExit(Sender: TObject);
var cadeia : string;
    ondeExibir : integer;

  procedure tratarInclusao;
  begin
    if osTrens.haDados(cadeia, ondeIncluir) then  // se existe, n�o pode incluir
    begin
      ShowMessage('C�digo j� existe.'+#13+
                  'N�o podemos inclu�-lo novamente');
      osTrens.ajustarSituacao(navegando);   // cancela a inclus�o e volta a navegar
      atualizarTela;                         // mostra na tela o registro anterior
    end
    else   // a sigla n�o existe, portanto continuamos o processo de inclus�o
    begin
      edQtosVagoes.SetFocus;
      //sbMensagem.Panels[1].text := 'Mensagem: digite as demais informa��es sobre o Trem'
    end;
  end;

  procedure tratarPesquisa;
  var
    ondeExibir : integer;
  begin
    if not osTrens.haDados(cadeia, ondeExibir) then
    begin
      ShowMessage('C�digo n�o existe.'+#13+
                  'N�o podemos exibir seus dados');
      osTrens.ajustarSituacao(navegando);   // cancela a pesquisa e volta a navegar
      atualizarTela;
    end
    else   // a sigla existe, portanto acessamos seus dados e os exibimos na tela
    begin
      osTrens.posicionarEm(ondeExibir);
      atualizarTela;
    end;
  end;

begin
  cadeia := edCodTrem.Text;
  while length(cadeia) < 6 do
     cadeia := cadeia + ' ';
  if cadeia <> '      ' then
     case osPassageiros.situacao of
       incluindo : tratarInclusao;
       pesquisando: tratarPesquisa;
     end;
end;

procedure TfrmTrens.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  uTipoTrem.gravarDados('Trens.dat');
  freeAndNil(frmTrens);
end;

procedure TfrmTrens.FormCreate(Sender: TObject);
begin
  uTipoTrem.lerDados('Trens.dat');
  uTipoPassageiro.lerDados('passageiros.dat');
  atualizarTela;
end;

procedure TfrmTrens.limparTela;
var
  fileira,
  poltrona: byte;
begin
  edCodTrem.Clear;
  stgVagaoAtual.Cells[0,1] := 'A';
  stgVagaoAtual.Cells[0,2] := 'B';
  stgVagaoAtual.Cells[0,3] := 'C';
  stgVagaoAtual.Cells[0,4] := 'D';

  for fileira := 1 to 10 do
  begin
    stgVagaoAtual.Cells[0,fileira] := intToStr(fileira);
    for poltrona := 1 to 4 do
      stgVagaoAtual.Cells[poltrona, fileira] := '';
  end;
end;

procedure TfrmTrens.testarBotoes;
begin
  btnInicio.Enabled   := true;
  btnAnterior.Enabled := true;
  btnProximo.Enabled  := true;
  btnUltimo.Enabled   := true;

  if osTrens.estaNoInicio then
  begin
    btnInicio.Enabled   := false;
    btnAnterior.Enabled := false;
  end;

  if osTrens.estaNoFim then
  begin
    btnProximo.Enabled  := false;
    btnUltimo.Enabled   := false;
  end;
end;

end.
