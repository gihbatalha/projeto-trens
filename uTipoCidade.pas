unit uTipoCidade;

interface

uses uClasseMantemVetor, sysUtils;

type
// declaramos o registro de cidades, para termos onde
// armazenar os dados de cada cidade, bem como podermos
// criar um arquivo com esses registros
  TCidade = record
    siglaCidade : string[4];// CPS, GRU, BHZ, SPO, SBO, EFA
    nomeCidade  : string[30];
  end;

// a classe abaixo encapsulará registros TCidade, para
// poder armazená-los no vetor Dados da classe TMantemVetor
// Como TEntidadeCidade é uma herança de TEntidade, o
// vetor Dados de TMantemVetor é compatível e, assim, pode
// armazenar objetos TEntidadeCidade
  TEntidadeCidade = class(TEntidade)  // herança!
    registro : TCidade;
    constructor create(novoRegistro:TCidade);
    function paraString : string;
  end;

var
  asCidades  : TMantemVetor;
  arqCidades : File of TCidade;

procedure lerDados(nomeArquivo : string);
procedure gravarDados(nomeArquivo : string);

implementation

{ TEntidadeCidade }

// o Campo Chave de TEntidadeCidade faz parte dessa
// classe devido ao mecanismo de herança, que incluiu, em
// TEntidadeCidade, todos os atributos e métodos da
// classe ancestral TEntidade
constructor TEntidadeCidade.create(novoRegistro: TCidade);
begin
  registro := novoRegistro;
  chave    := registro.siglaCidade;
end;

function TEntidadeCidade.paraString: string;
begin
  result := registro.siglaCidade+' '+registro.nomeCidade;
end;

procedure CriarArquivoCidades(nomeArquivo : string);
Begin
  AssignFile(arqCidades, nomeArquivo);
  Rewrite(arqCidades);
  CloseFile(arqCidades);
end;

procedure lerDados(nomeArquivo:string);
var registroDeCidade : TCidade;
    novaEntidade     : TEntidadeCidade;
begin
  if not fileExists(nomeArquivo) then
     criarArquivoCidades(nomeArquivo);
  assignFile(arqCidades,nomeArquivo);
  reset(arqCidades);
  while not eof(arqCidades) do
  begin
    read(arqCidades, registroDeCidade);
    // instanciamos um objeto TEntidadeCidade, dentro
    // do qual podemos guardar o registro recém-lido

    novaEntidade := TEntidadeCidade.create(registroDeCidade);
    // colocamos esse objeto no vetor dados de asCidades
    asCidades.incluir(novaEntidade, asCidades.qtosRegistros);
  end;
  closeFile(arqCidades);
end;

procedure gravarDados(nomeArquivo:string);
var entidadeAGravar : TEntidadeCidade;
  indice: Integer;
begin
  assignFile(arqCidades, nomeArquivo);
  rewrite(arqCidades);
  asCidades.iniciarPercursoSequencial;
  while asCidades.podePercorrer do
  begin
    entidadeAGravar := asCidades.registroAtual
                        as TEntidadeCidade;
    write(arqCidades, entidadeAGravar.registro);
  end;

//  for indice := 0 to asCidades.qtosRegistros - 1 do
//  begin
//    entidadeAGravar := asCidades.registro(indice)
//                        as TEntidadeCidade;
//    write(arqCidades, entidadeAGravar.registro);
//  end;

  closeFile(arqCidades);
end;

end.
