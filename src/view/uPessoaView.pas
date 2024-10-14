unit uPessoaView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroPadrao, System.ImageList,
  Vcl.ImgList, Vcl.ComCtrls, Vcl.DBCGrids, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.DBCtrls, Data.DB, Vcl.Imaging.pngimage, Vcl.Mask, uDMConexao,
  uPessoaController, Data.FMTBcd, Data.SqlExpr, Datasnap.DBClient,
  Datasnap.Provider;

type
  TfrmPessoaView = class(TfrmCadastroPadrao)
    dsPessoa: TDataSource;
    txtID: TDBText;
    txtNome: TDBText;
    txtDataNascimento: TDBText;
    txtTipoSanguineo: TDBText;
    imgBtnEditar: TImage;
    imgBtnExcluir: TImage;
    edtPesquisaNome: TLabeledEdit;
    dtpkPesquisaDataNascimentoDe: TDateTimePicker;
    cbPesquisaTipoSanguineo: TComboBox;
    lblPesquisaTipoSanguineo: TLabel;
    edtCadastroNome: TLabeledEdit;
    dtpkCadastroDataNascimento: TDateTimePicker;
    lblCadastroDataNascimento: TLabel;
    cbCadastroTipoSanguineo: TComboBox;
    lblCadastroTipoSanguineo: TLabel;
    StaticText1: TStaticText;
    edtCadastroID: TLabeledEdit;
    qryConsulta: TSQLQuery;
    qryConsultaPES_ID: TIntegerField;
    qryConsultaPES_NOME: TStringField;
    qryConsultaPES_DATANASC: TSQLTimeStampField;
    qryConsultaPES_TIPOSANG: TStringField;
    dtpkPesquisaDataNascimentoAte: TDateTimePicker;
    lblAte: TLabel;
    gbDataNascimento: TGroupBox;
    cdsPessoa: TClientDataSet;
    dspPessoa: TDataSetProvider;
    cdsPessoaPES_ID: TIntegerField;
    cdsPessoaPES_NOME: TStringField;
    cdsPessoaPES_DATANASC: TSQLTimeStampField;
    cdsPessoaPES_TIPOSANG: TStringField;
    procedure btnCadastrarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure imgBtnEditarClick(Sender: TObject);
    procedure imgBtnExcluirClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
  private
    FPessoaController: TPessoaController;
    procedure Salvar;
    procedure Editar;
    procedure Excluir;
    procedure Consultar;
    procedure CarregarTipoSanguineo;
    procedure LimparTela;
  public
    { Public declarations }
  end;

var
  frmPessoaView: TfrmPessoaView;

implementation

uses
  uPessoa, uMensagemNotificacao;

{$R *.dfm}

procedure TfrmPessoaView.btnCadastrarClick(Sender: TObject);
begin
  inherited;
  ExibirTabCadastro;
end;

procedure TfrmPessoaView.btnCancelarClick(Sender: TObject);
begin
  inherited;
  pgCadastro.ActivePage := tsConsulta;
  tsCadastro.TabVisible := false;
end;

procedure TfrmPessoaView.btnPesquisarClick(Sender: TObject);
begin
  inherited;
  Consultar;
end;

procedure TfrmPessoaView.btnSalvarClick(Sender: TObject);
begin
  inherited;
  salvar;
end;

procedure TfrmPessoaView.CarregarTipoSanguineo;
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


procedure TfrmPessoaView.Consultar;
begin
  try
   qryConsulta :=  FPessoaController.ConsultarPessoa(
      edtPesquisaNome.Text,
      DateToStr(dtpkPesquisaDataNascimentoDe.Date),
      DateToStr(dtpkPesquisaDataNascimentoAte.Date),
      cbPesquisaTipoSanguineo.SelText);

    if (not qryConsulta.IsEmpty) then
    begin
      dspPessoa.DataSet := qryConsulta;
      dsPessoa.DataSet.Refresh;
      LimparTela;
    end;
  except
    on e: Exception do
    begin
      TMensagemNotificacao
        .Create('ERRO: ' + e.Message, ttp_Erro)
        .Show;
    end;
  end;
end;

procedure TfrmPessoaView.Editar;
begin
  edtCadastroID.Text := dsPessoa.DataSet.FieldByName('PES_ID').AsString;
  edtCadastroNome.Text := dsPessoa.DataSet.FieldByName('PES_NOME').AsString;
  dtpkCadastroDataNascimento.Date := dsPessoa.DataSet.FieldByName('PES_DATANASC').AsDateTime;
  cbCadastroTipoSanguineo.Text := dsPessoa.DataSet.FieldByName('PES_TIPOSANG').AsString;
  FPessoaController.ehEdicao := True;
  ExibirTabCadastro;
end;

procedure TfrmPessoaView.Excluir;
begin
  try
    FPessoaController.ExcluirPessoa(dsPessoa.DataSet.FieldByName('PES_ID').AsInteger);
    dsPessoa.DataSet.Refresh;
  except
    on e: Exception do
    begin
      TMensagemNotificacao
        .Create('Erro ao tentar excluir pessoa:' + e.Message, ttp_Erro)
        .Show;
    end;
  end;

end;

procedure TfrmPessoaView.FormCreate(Sender: TObject);
begin
  inherited;
  FPessoaController := TPessoaController.Create;
  cdsPessoa.open;
end;

procedure TfrmPessoaView.FormDestroy(Sender: TObject);
begin
  inherited;
  cdsPessoa.Close;
  FreeAndNil(FPessoaController);
end;

procedure TfrmPessoaView.FormShow(Sender: TObject);
begin
  inherited;
  dsPessoa.DataSet.open;
  CarregarTipoSanguineo;
end;

procedure TfrmPessoaView.imgBtnEditarClick(Sender: TObject);
begin
  inherited;
  Editar;
end;

procedure TfrmPessoaView.imgBtnExcluirClick(Sender: TObject);
begin
  inherited;
  Excluir;
end;

procedure TfrmPessoaView.LimparTela;
begin
  edtPesquisaNome.Clear;
  dtpkPesquisaDataNascimentoDe.Date := StrToDate('01/01/1900');
  dtpkPesquisaDataNascimentoAte.Date := StrToDate('01/01/1900');
  cbPesquisaTipoSanguineo.SelText := 'Selecione...';
end;

procedure TfrmPessoaView.Salvar;
var
  oPessoa: TPessoa;
begin
  try
    if FPessoaController.ValidarDados(edtCadastroNome.Text,
                    dtpkCadastroDataNascimento.Date,
                    cbCadastroTipoSanguineo.Text) then
    begin
      oPessoa := FPessoaController.CriarPessoa(
                        edtCadastroNome.Text,
                        dtpkCadastroDataNascimento.Date,
                        cbCadastroTipoSanguineo.Text);

      if (edtCadastroID.Text <> EmptyStr) then
      begin
        oPessoa.SetID(strToInt(edtCadastroID.Text));
      end;

      try
        if (FPessoaController.SalvarPessoa(oPessoa)) then
        begin
          TMensagemNotificacao
            .Create('Dados salvos com sucesso', ttp_Sucesso)
            .Show;

          pgCadastro.ActivePage := tsConsulta;
          tsCadastro.TabVisible := false;
          dsPessoa.DataSet.Refresh;
        end;

      except
        on e: Exception do
        begin
          TMensagemNotificacao
            .Create('Falha ao tentar cadastrar pessoa: ' + e.Message, ttp_Erro)
            .Show;
        end;
      end;
    end;
  finally
    FreeAndNil(oPessoa);
  end;
end;


end.
