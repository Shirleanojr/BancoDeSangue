unit uCadastroPadrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.WinXPanels, Vcl.Mask, Vcl.Buttons, Vcl.ComCtrls, System.ImageList,
  Vcl.ImgList, Vcl.DBCGrids;

type
  TfrmCadastroPadrao = class(TForm)
    pnlHeader: TPanel;
    pnlMain: TPanel;
    ilIconesBotoes: TImageList;
    btnSalvar: TSpeedButton;
    btnCancelar: TSpeedButton;
    pgCadastro: TPageControl;
    tsCadastro: TTabSheet;
    tsConsulta: TTabSheet;
    pnlConsulta: TPanel;
    btnPesquisar: TSpeedButton;
    btnFechar: TSpeedButton;
    pnlDados: TPanel;
    grdConsulta: TDBCtrlGrid;
    btnCadastrar: TSpeedButton;
    hcCabecalho: THeaderControl;
    Splitter1: TSplitter;
    procedure btnFecharClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnCadastrarClick(Sender: TObject);
  private

  protected
    procedure ExibirTabCadastro(pbExibir: boolean = true);
  public
  end;

var
  frmCadastroPadrao: TfrmCadastroPadrao;

implementation

{$R *.dfm}

procedure TfrmCadastroPadrao.btnCadastrarClick(Sender: TObject);
begin
  ExibirTabCadastro;
end;

procedure TfrmCadastroPadrao.btnCancelarClick(Sender: TObject);
begin
  ExibirTabCadastro(false);
  pgCadastro.ActivePage := tsConsulta;
end;

procedure TfrmCadastroPadrao.btnFecharClick(Sender: TObject);
begin
  Close;
end;


procedure TfrmCadastroPadrao.ExibirTabCadastro(pbExibir: boolean);
begin
  tsCadastro.TabVisible := pbExibir;

  if (pbExibir) then
  begin
    pgCadastro.ActivePage := tsCadastro;
  end;
end;

procedure TfrmCadastroPadrao.FormCreate(Sender: TObject);
begin
  tsCadastro.TabVisible := false;
end;


end.
