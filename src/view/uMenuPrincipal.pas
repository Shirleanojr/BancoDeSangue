unit uMenuPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, uPessoaView, uDoacaoView, uRelatorioDoacao;

type
  TfrmMenuPrincipal = class(TForm)
    mnMenuPrincipal: TMainMenu;
    mniSistema: TMenuItem;
    mniSistemaSair: TMenuItem;
    nmiArquivo: TMenuItem;
    mniArquivoPessoa: TMenuItem;
    mniProcesso: TMenuItem;
    mniProcessoDoacao: TMenuItem;
    mniRelatorio: TMenuItem;
    mniRelatorioDoacao: TMenuItem;
    procedure mniArquivoPessoaClick(Sender: TObject);
    procedure mniProcessoDoacaoClick(Sender: TObject);
    procedure mniRelatorioDoacaoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMenuPrincipal: TfrmMenuPrincipal;

implementation


{$R *.dfm}


procedure TfrmMenuPrincipal.mniArquivoPessoaClick(Sender: TObject);
var
  oCadPessoa: TfrmPessoaView;
begin
  oCadPessoa := TfrmPessoaView.Create(nil);
  oCadPessoa.Show;
end;

procedure TfrmMenuPrincipal.mniProcessoDoacaoClick(Sender: TObject);
var
  oCadDoacao: TfrmDoacaoView;
begin
   oCadDoacao := TfrmDoacaoView.Create(nil);
   oCadDoacao.Show;
end;

procedure TfrmMenuPrincipal.mniRelatorioDoacaoClick(Sender: TObject);
var
  oRelatorio: TfrmRelatorioDoacao;
begin
  oRelatorio := TfrmRelatorioDoacao.Create(nil);
  oRelatorio.Show;
end;

end.
