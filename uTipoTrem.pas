unit uTipoTrem;

interface

uses uClasseMantemVetor, sysutils;

type
  TReserva = record
    codViagem     : string[5];
    codPassageiro : string[6];
  end;

  TVagao = record
    qtasPessoas : byte; // 0 a 56
    poltrona    : array['A'..'D', 1..14 ] of TReserva;
  end;

// TTrem � o registro que define um trem, e
// que ser� lido e gravado no arquivo de trens
  TTrem = record
    codTrem    : String[6]; // chave prim�ria
    qtosVagoes : byte;      // 1 a 10
    vagao      : array[1..10] of TVagao;
  end;

// a classe abaixo encapsular� registros TTrem, para
// poder armazen�-los no vetor Dados da classe TMantemVetor
// Como TEntidadeTrem � uma heran�a de TEntidade, o
// vetor Dados de TMantemVetor � compat�vel e, assim,
// pode armazenar objetos TEntidadeTrem
  TEntidadeTrem = class(TEntidade)  // heran�a!
    registro : TTrem;
    constructor create(novoRegistro:TTrem);
    function paraString : string;
  end;

var
  osTrens         : TMantemVetor;
  arqTrens        : File of TTrem;
  umTrem          : TTrem;
  umVagao         : TVagao;
  umaEntidadeTrem : TEntidadeTrem;

procedure lerDados(nomeArquivo:string);
procedure gravarDados(nomeArquivo:string);

implementation

{ TEntidadeTrem }

// o Campo Chave de TEntidadeTrem faz parte dessa
// classe devido ao mecanismo de heran�a, que incluiu,
// em TEntidadeTrem, todos os atributos e m�todos da
// classe ancestral TEntidade
constructor TEntidadeTrem.create(novoRegistro: TTrem);
begin
  registro := novoRegistro;
  chave    := novoRegistro.codTrem;
end;

function TEntidadeTrem.paraString: string;
begin
  result := registro.CodTrem+' '+
            intToStr(registro.qtosVagoes);
end;

procedure lerDados(nomeArquivo:string);
var
  registroLido : TTrem;         // registro de avi�o lido do arquivo de avi�es
  novaEntidade : TEntidadeTrem; // compat�vel com TEntidade, pode ser armazenada no vetor "dados"
begin
  assignFile(arqTrens, nomeArquivo);

  if not fileExists(nomeArquivo) then
  begin
    rewrite(arqTrens);    // cria o arquivo, vazio, no disco
    closeFile(arqTrens);  // fecha o arquivo para ser aberto (para leitura) depois
  end;

  reset(arqTrens);    // abre o arquivo para leitura. Se ele acabou de ser criado,
                     // dar� EOF logo em seguida e nada ser� lido.
                     // Se, por outro lado, houver trens para ler, eles ser�o
                     // lidos e armazenados no vetor "dados" do objeto.

  osTrens := TMantemVetor.create;  // instancia objeto osTrens para podermos
                                    // us�-lo para guardar trens lidos do
                                    // arquivo e/ou inclu�dos pelo usu�rio

  while not eof(arqTrens) do
  begin
    read(arqTrens, registroLido);

    // agora colocaremos o registroLido no vetor "dados" do objeto osTrens
    // Antes, precisamos encapsular o registro lido num objeto compat�vel com TEntidade,
    // ou seja, num objeto da classe TEntidadeTrem:

    novaEntidade := TEntidadeTrem.create(registroLido);  // cria objeto na mem�ria contendo,
                                                          // o registro de trem lido
    osTrens.incluirAposFinal(novaEntidade);
  end;

  closeFile(arqTrens); // n�o se esque�a de fechar arquivos ap�s terminar seu uso
  osTrens.posicionarNoPrimeiro;
end;

procedure gravarDados(nomeArquivo:string);
begin
  assignFile(arqTrens,nomeArquivo);
  rewrite(arqTrens);

  osTrens.iniciarPercursoSequencial;
  while osTrens.podePercorrer do
  begin
    umTrem := (osTrens.registroAtual as TEntidadeTrem).registro;

    write(arqTrens, umTrem);
  end;

  closeFile(arqTrens);
end;

end.
