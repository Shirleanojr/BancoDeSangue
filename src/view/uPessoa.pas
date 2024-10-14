unit uPessoa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroPadrao, System.ImageList,
  Vcl.ImgList, Vcl.ComCtrls, Vcl.DBCGrids, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.DBCtrls, Data.DB, dmConexao, Vcl.Imaging.pngimage, Vcl.Mask;

type
  TfrmPessoa = class(TfrmCadastroPadrao)
    dsBS_PESSOA: TDataSource;
    Image1: TImage;
    txtID: TDBText;
    txtNome: TDBText;
    txtDataNascimento: TDBText;
    txtTipoSanguineo: TDBText;
    imgBtnEditar: TImage;
    imgBtnExcluir: TImage;
    Splitter1: TSplitter;
    edtPesquisaNome: TLabeledEdit;
    dtpkPesquisaDataNascimento: TDateTimePicker;
    lblPesquisaDataNascimento: TLabel;
    cbPesquisaTipoSanguineo: TComboBox;
    lblPesquisaTipoSanguineo: TLabel;
    edtCadastroNome: TLabeledEdit;
    DateTimePicker1: TDateTimePicker;
    lblCadastroDataNascimento: TLabel;
    cbCadastroTipoSanguineo: TComboBox;
    lblCadastroTipoSanguineo: TLabel;
    StaticText1: TStaticText;
    procedure FormCreate(Sender: TObject);
    procedure btnCadastrarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
  private
    procedure CarregarTipoSanguineo;
  public
    { Public declarations }
  end;

var
  frmPessoa: TfrmPessoa;

implementation

{$R *.dfm}

procedure TfrmPessoa.btnCadastrarClick(Sender: TObject);
begin
  inherited;
  tsCadastro.TabVisible := True;
  pgCadastro.ActivePage := tsCadastro;
end;

procedure TfrmPessoa.btnCancelarClick(Sender: TObject);
begin
  inherited;
  pgCadastro.ActivePage := tsConsulta;
  tsCadastro.TabVisible := false;
end;

procedure TfrmPessoa.CarregarTipoSanguineo;
var
  slTipoSanguineo: TStringList;
begin
  try
    slTipoSanguineo := TStringList.Create;
    slTipoSanguineo.CommaText := 'A+, A-, B+, B-, O+, O-';

    cbPesquisaTipoSanguineo.Items := slTipoSanguineo;
    cbCadastroTipoSanguineo.Items := slTipoSanguineo;
  finally
    FreeAndNil(slTipoSanguineo);
  end;
end;

procedure TfrmPessoa.FormCreate(Sender: TObject);
begin
  inherited;
  dsBS_PESSOA.DataSet.open;
  CarregarTipoSanguineo;
end;

end.
