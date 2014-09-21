unit uClasseMantemVetor;

interface

uses SysUtils;

type        // 0           1          2             3          4
  TSituacao = (navegando, incluindo, pesquisando, editando,  excluindo);

  TEntidade = class
    chave : string;
  end;

  TFuncaoDeOrdenacao = function (lento, rapido:integer):integer;

  TMantemVetor = class
    public
      Constructor create;

      procedure incluirAposFinal(novo : TEntidade);
      procedure alterar(novo: TEntidade; posicao: integer);
      Procedure incluir(novo: TEntidade; posicao : integer);
      Procedure excluir(posicao:integer);
      Procedure Ordenar;
      procedure posicionarNoPrimeiro;
      procedure retrocederPosicao;
      procedure avancarPosicao;
      procedure posicionarNoUltimo;
      procedure iniciarPercursoSequencial;
      procedure ajustarSituacao(novaSituacao : TSituacao);
      procedure posicionarEm(qualPosicao:integer);
      procedure listagemAlternativa(comparar : TFuncaoDeOrdenacao);

      function haDados(chaveProcurada:string; var onde:integer):boolean;
      function registroAtual : TEntidade;
      function estaVazio     : boolean;
      function estaNoInicio  : boolean;
      function estaNoFim     : boolean;
      function podePercorrer : boolean;
      function situacao      : TSituacao;
      function indiceAtual   : integer;
      function qtosRegistros : integer;
    protected
      situacaoAtual : TSituacao;
      posicaoAtual  : integer;
      dados         : Array of TEntidade;
      qtosDados     : Integer;
  end;

implementation

{ TMantemVetor }

procedure TMantemVetor.alterar(novo: TEntidade; posicao: integer);
begin
  // verifica se o índice de alteração é válido
  if (posicao >= 0) and (posicao < qtosDados)  then
    // armazena no vetor o novo dado, passado como
    // parâmetro, na posição também indicada como
    // parâmetro; isso substitui o conteúdo anterior
    // desse registro.
    dados[posicao] := novo;
end;

procedure TMantemVetor.avancarPosicao;
begin
  if posicaoAtual < qtosDados-1 then
     inc(posicaoAtual);       // avança para índice seguinte
end;

procedure TMantemVetor.ajustarSituacao(novaSituacao: TSituacao);
begin
  situacaoAtual := novaSituacao;
end;

constructor TMantemVetor.create;
begin
  qtosDados     := 0;
  posicaoAtual  := -1;
  situacaoAtual := navegando;
  setLength(dados,0);
end;

function TMantemVetor.estaNoFim: boolean;
begin
  estaNoFim := posicaoAtual >= qtosDados-1;
end;

function TMantemVetor.estaNoInicio: boolean;
begin
  estaNoInicio := posicaoAtual <= 0;
end;

function TMantemVetor.estaVazio: boolean;
begin
  estaVazio := qtosDados = 0;
end;

procedure TMantemVetor.excluir(posicao: integer);
var
  indice: Integer;
begin
   // verifica a validade da posição a ser excluída
  if (posicao >= 0) and (posicao <= qtosDados-1) then
  begin
    dec(qtosDados);

    // desloca para trás os elementos seguintes
    // àquele que se deseja excluir. Dessa forma
    // esse elemento é substituido pelo que vinha
    // no índice seguinte:
    for indice := posicao to qtosDados-1 do
        dados[indice] := dados[indice+1];

    // reduz o tamanho físico do vetor dados
    setLength(dados, qtosDados);

    // ajusta o índice do elemento atual caso
    // tenha sido excluído o elemento que ficava
    // no último índice do vetor:
    if posicaoAtual >= qtosDados then
       posicaoAtual := qtosDados - 1;
  end;
end;

procedure TMantemVetor.listagemAlternativa(comparar : TFuncaoDeOrdenacao);
var Lento, rapido : integer;
    auxiliar : TEntidade;

begin
  for Lento := 0 to qtosDados-1 do
    for Rapido := Lento + 1 to qtosDados-1 do
       if comparar(lento, rapido) > 0 then
       Begin
        Auxiliar      := Dados[Lento];
        Dados[Lento]  := Dados[Rapido];
        Dados[Rapido] := Auxiliar;
       End
end;

function TMantemVetor.haDados(chaveProcurada: string;
  var onde: integer): boolean;
var
  inicio, fim : integer;
  achou       : boolean;
begin
  Achou := False;
  Inicio := 0;
  Fim := qtosDados-1;
  While (not achou) and (inicio <= fim) do
  Begin
    Onde := (inicio + fim) div 2; // cálculo do meio do trecho sob pesquisa

    with dados[onde] do
     if chave = chaveProcurada then
        achou := true  // chave do meio do trecho igual à procurada
     else
       if chave > chaveProcurada then
          Fim := onde - 1    // chave do meio do trecho maior que a procurada
       else
         Inicio := onde + 1; // chave do meio do trecho menor que a procurada
  End;

  If not achou then  // chave não existe
     Onde := inicio; // posição em que se poderá incluir a nova chave

  haDados := achou;
end;

procedure TMantemVetor.incluir(novo: TEntidade; posicao: integer);
var
  indice: Integer;
begin
  // verifica se o índice de inclusão é válido
  if (posicao >= 0) and (posicao <= qtosDados)  then
  begin
    // ampliar o tamanho do vetor para que caiba
    // mais um novo elemento
    setLength(dados, qtosDados+1);

    // desloca para a frente os elementos que ficam
    // após a posição de inclusão
    for indice := qtosDados-1 downto posicao do
        dados[indice+1] := dados[indice];

    // armazena no vetor o novo dado, passado como
    // parêmtro, na posição também indicada como
    // parâmetro
    dados[posicao] := novo;

    // mantém correta a contagem de posições usadas
    inc(qtosDados);
  end;
end;

procedure TMantemVetor.incluirAposFinal(novo: TEntidade);
begin
  setLength(dados, qtosDados+1);  // expande o vetor; índices passam a ir de 0 até qtosDados

  dados[qtosDados] := novo;       // nova posiçao criada (última) recebe o TEntidade novo

  inc(qtosDados);                 // informa que há mais uma posição em uso
end;

function TMantemVetor.indiceAtual: integer;
begin
  indiceAtual := posicaoAtual; // acesso para consulta
end;                           // pela aplicação

procedure TMantemVetor.Ordenar;
Var Lento, Rapido : Integer;
    auxiliar      : TEntidade;
Begin
  for Lento := 0 to qtosDados-1 Do
      for Rapido := Lento + 1 to qtosDados-1 do
          If Dados[Lento].chave > Dados[Rapido].chave Then
          Begin
            Auxiliar      := Dados[Lento];
            Dados[Lento]  := Dados[Rapido];
            Dados[Rapido] := Auxiliar;
          End
end;

procedure TMantemVetor.posicionarEm(qualPosicao: integer);
begin
  // verifica se a posição passada como parâmetro é
  // um índice válido do vetor dados e, se for, atualiza
  // o valor do índice de acesso atual (posicaoAtual):
  if (qualPosicao >= 0) and (qualPosicao < qtosDados) then
     posicaoAtual := qualPosicao;
end;

procedure TMantemVetor.posicionarNoPrimeiro;
begin
  posicaoAtual := 0;

  if estaVazio then
     posicaoAtual := -1;
end;

procedure TMantemVetor.posicionarNoUltimo;
begin
  posicaoAtual := qtosDados - 1;
end;

function TMantemVetor.qtosRegistros: integer;
begin
  qtosRegistros := qtosDados;  // acesso para consulta
end;

procedure TMantemVetor.iniciarPercursoSequencial;
begin
  posicaoAtual := -1; // posiciona antes do primeiro
end;                  // índice do vetor dados

function TMantemVetor.podePercorrer: boolean;
begin
  inc(posicaoAtual);                              // avança para próximo índice
  podePercorrer := posicaoAtual <= qtosDados-1;   // verifica se índice saiu do vetor
end;

function TMantemVetor.registroAtual: TEntidade;
begin
  if (posicaoAtual >= 0) and (posicaoAtual < qtosDados) then
    result := dados[posicaoAtual]
  else
    result := nil; // nil ==> "vazio", não instanciado
end;

procedure TMantemVetor.retrocederPosicao;
begin
  if posicaoAtual >= 0 then
     dec(posicaoAtual);     // posiciona no índice anterior
end;

function TMantemVetor.situacao: TSituacao;
begin
  situacao := situacaoAtual; // acesso para consulta
end;

end.
