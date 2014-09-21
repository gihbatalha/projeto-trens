unit uTipoViagem;

interface

uses uClasseMantemVetor, sysutils;

type
// TViagem é o registro que define uma viagem, e
// que será lido e gravado no arquivo de viagens
    TViagem = record
    codigoViagem : String[4]; // chave primária
    codigoTrem   : string[6];
    qtasCidades  : byte;      // 1 a 12
    cidadesPorOndePassa : array[1..12] of string[4];
  end;

  // a classe abaixo encapsulará registros TTrem, para
// poder armazená-los no vetor Dados da classe TMantemVetor
// Como TEntidadeTrem é uma herança de TEntidade, o
// vetor Dados de TMantemVetor é compatível e, assim,
// pode armazenar objetos TEntidadeTrem
  TEntidadeViagem = class(TEntidade)  // herança!
    registro : TViagem;
    constructor create(novoRegistro:TViagem);
    //function paraString : string;
  end;

var
  asViagens   : TMantemVetor;
  arqViagem   : File of TViagem;
  umaEntidadeViagem : TEntidadeViagem;

procedure lerDados(nomeArquivo:string);
procedure gravarDados(nomeArquivo:string);

implementation

{ TEntidadeViagem }

// o Campo Chave de TEntidadeViagem faz parte dessa
// classe devido ao mecanismo de herança, que incluiu, em
// TEntidadeViagem, todos os atributos e métodos da
// classe ancestral TEntidade
constructor TEntidadeViagem.create(novoRegistro: TViagem);
begin
  registro := novoRegistro;
  chave    := registro.codigoViagem;
end;

{
function TEntidadeViagem.paraString: string;
begin
  result := registro.codigoViagem+' '+registro.nomeCidade;
end;
}

procedure CriarArquivoViagens(nomeArquivo : string);
Begin
  AssignFile(arqViagem, nomeArquivo);
  Rewrite(arqViagem);
  CloseFile(arqViagem);
end;

procedure lerDados(nomeArquivo:string);
var registroDeViagem : TViagem;
    novaEntidade     : TEntidadeViagem;
begin
  if not fileExists(nomeArquivo) then
     criarArquivoViagens(nomeArquivo);
  assignFile(arqViagem,nomeArquivo);
  reset(arqViagem);
  while not eof(arqViagem) do
  begin
    read(arqViagem, registroDeViagem);
    // instanciamos um objeto TEntidadeViagem, dentro
    // do qual podemos guardar o registro recém-lido

    novaEntidade := TEntidadeViagem.create(registroDeViagem);
    // colocamos esse objeto no vetor dados de asViagens
    asViagens.incluir(novaEntidade, asViagens.qtosRegistros);
  end;
  closeFile(arqViagem);
end;

procedure gravarDados(nomeArquivo:string);
var entidadeAGravar : TEntidadeViagem;
  indice: Integer;
begin
  assignFile(arqViagem, nomeArquivo);
  rewrite(arqViagem);
  asViagens.iniciarPercursoSequencial;
  while asViagens.podePercorrer do
  begin
    entidadeAGravar := asViagens.registroAtual
                        as TEntidadeViagem;
    write(arqViagem, entidadeAGravar.registro);
  end;

//  for indice := 0 to asViagens.qtosRegistros - 1 do
//  begin
//    entidadeAGravar := asViagens.registro(indice)
//                        as TEntidadeViagem;
//    write(arqViagens, entidadeAGravar.registro);
//  end;

  closeFile(arqViagem);
end;

end.
