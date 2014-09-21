unit uTipoPassageiro;

interface

uses uClasseMantemVetor;

type
// TPassageiro é o registro que define um Passageiro, e
// que será lido e gravado no arquivo de passageiros
  TPassageiro = record
    codigoPassageiro : String[5]; // chave primária
    nomePassageiro   : string[30];
    // abaixo, campos referentes às informaçções sobre
    // a viagem reservada para esse passageiro
    codViagem        : string[4];
    cidadeSobe,
    cidadeDesce      : string[3];
    vagao            : byte;
    poltrona         : char;
    fileira          : byte;
  end;

  TEntidadePassageiro = class(TEntidade)
    registro : TPassageiro;
    constructor create(novoRegistro : TPassageiro);
    function paraString : string;
  end;

var
  osPassageiros  : TMantemVetor;
  arqPassageiros : File of TPassageiro;

procedure lerDados(nomeArquivo:string);
procedure gravarDados(nomeArquivo:string);

implementation

{ TEntidadePassageiro }

constructor TEntidadePassageiro.create(novoRegistro: TPassageiro);
begin
  registro := novoRegistro;
  chave    := registro.codigoPassageiro;
end;

function TEntidadePassageiro.paraString: string;
begin
  with registro do
    result := codigoPassageiro+' '+nomePassageiro+' '+
              codViagem+' '+cidadeSobe+' '+cidadeDesce;
end;

procedure lerDados(nomeArquivo:string);
begin
  ///
  ///
end;

procedure gravarDados(nomeArquivo:string);
begin
  ///
  ///
end;

end.
