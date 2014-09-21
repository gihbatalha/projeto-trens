program pTrem;

uses
  Forms,
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  uTipoTrem in 'uTipoTrem.pas',
  uMantemPassageiros in 'uMantemPassageiros.pas' {frmPassageiros},
  uTipoPassageiro in 'uTipoPassageiro.pas',
  uMantemTrens in 'uMantemTrens.pas' {frmTrens},
  uTipoCidade in 'uTipoCidade.pas',
  uClasseMantemVetor in 'uClasseMantemVetor.pas',
  uTipoViagem in 'uTipoViagem.pas',
  uMantemViagens in 'uMantemViagens.pas' {frmViagens},
  uMantemCidades in 'uMantemCidades.pas' {frmCidades};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TfrmPassageiros, frmPassageiros);
  Application.CreateForm(TfrmTrens, frmTrens);
  Application.CreateForm(TfrmCidades, frmCidades);
  Application.CreateForm(TfrmViagens, frmViagens);
  Application.CreateForm(TfrmCidades, frmCidades);
  Application.Run;
end.
