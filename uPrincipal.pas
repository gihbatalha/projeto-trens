unit uPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ImgList, ComCtrls;

type
  TfrmPrincipal = class(TForm)
    MainMenu1: TMainMenu;
    Cadastro1: TMenuItem;
    Reservas1: TMenuItem;
    Consultas1: TMenuItem;
    Sobre1: TMenuItem;
    Sair1: TMenuItem;
    Cidades1: TMenuItem;
    Viagens1: TMenuItem;
    rens1: TMenuItem;
    Passageiros1: TMenuItem;
    N1: TMenuItem;
    Sair2: TMenuItem;
    imlBotoes: TImageList;
    MonthCalendar1: TMonthCalendar;
    procedure Cidades1Click(Sender: TObject);
    procedure Passageiros1Click(Sender: TObject);
    procedure Viagens1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses uMantemCidades, uMantemPassageiros, uMantemViagens,
  uTipoCidade, uTipoPassageiro, uTipoViagem;

{$R *.dfm}

procedure TfrmPrincipal.Cidades1Click(Sender: TObject);
begin
  if frmCidades = nil then  // não foi criado ainda?
     Application.CreateForm(TFrmCidades, frmCidades);
  frmCidades.show;
end;


procedure TfrmPrincipal.Passageiros1Click(Sender: TObject);
begin
   if frmPassageiros = nil then  // não foi criado ainda?
     Application.CreateForm(TfrmPassageiros, frmPassageiros);
  frmPassageiros.show;
end;

procedure TfrmPrincipal.Viagens1Click(Sender: TObject);
begin
  if frmViagens = nil then // não foi criado ainda?
    Application.CreateForm(TfrmViagens, frmViagens);
  frmViagens.Show;
end;

end.
