unit uDoacaoView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroPadrao, System.ImageList,
  Vcl.ImgList, Vcl.ComCtrls, Vcl.DBCGrids, Vcl.Buttons, Vcl.ExtCtrls,
  Data.FMTBcd, Data.SqlExpr, Data.DB, Datasnap.DBClient, Datasnap.Provider,
  uDMConexao, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Imaging.pngimage, Vcl.Mask, uDoacaoController;

type
  TfrmDoacaoView = class(TfrmCadastroPadrao)
    dspDoacao: TDataSetProvider;
    cdsDoacao: TClientDataSet;
    dsDoacao: TDataSource;
    qryConsulta: TSQLQuery;
    cdsDoacaoDOA_ID: TIntegerField;
    cdsDoacaoDOA_DATA: TSQLTimeStampField;
    cdsDoacaoDOA_QTDE: TFMTBCDField;
    cdsDoacaoPES_ID: TIntegerField;
    txtID: TDBText;
    qryConsultaDOA_ID: TIntegerField;
    qryConsultaDOA_DATA: TSQLTimeStampField;
    qryConsultaDOA_QTDE: TFMTBCDField;
    qryConsultaPES_NOME: TStringField;
    qryConsultaPES_ID: TIntegerField;
    txtNomeDoador: TDBText;
    txtDataDoacao: TDBText;
    txtQuantidade: TDBText;
    imgBtnEditar: TImage;
    imgBtnExcluir: TImage;
    edtPesquisaNome: TLabeledEdit;
    gbDataNascimento: TGroupBox;
    lblAte: TLabel;
    dtpkPesquisaDataDoacaoAte: TDateTimePicker;
    dtpkPesquisaDataDoacaoDe: TDateTimePicker;
    StaticText1: TStaticText;
    edtCadastroID: TLabeledEdit;
    edtCadastroNome: TLabeledEdit;
    lblCadastroDataNascimento: TLabel;
    dtpkCadastroDataDoacao: TDateTimePicker;
    edtCadastroQuantidade: TLabeledEdit;
    edtPesquisaQuantidade: TLabeledEdit;
    cdsDoacaoPES_NOME: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure imgBtnEditarClick(Sender: TObject);
    procedure imgBtnExcluirClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
  private
    FDoacaoController: TDoacaoController;
    procedure Salvar;
    procedure Editar;
    procedure Excluir;
    procedure Consultar;
    procedure LimparTela;
  public
    { Public declarations }
  end;

var
  frmDoacaoView: TfrmDoacaoView;

implementation

uses
  uPessoa, uDoacao, uPessoaController, uMensagemNotificacao;

{$R *.dfm}

procedure TfrmDoacaoView.btnCancelarClick(Sender: TObject);
begin
  inherited;
  FDoacaoController.ehEdicao := False;
  LimparTela;
end;

procedure TfrmDoacaoView.btnPesquisarClick(Sender: TObject);
begin
  inherited;
  Consultar;
end;

procedure TfrmDoacaoView.btnSalvarClick(Sender: TObject);
begin
  inherited;
  Salvar;
end;

procedure TfrmDoacaoView.Consultar;
var
  dQuantidade: Double;
begin
  try
    dQuantidade := 0;

    if (edtPesquisaQuantidade.Text <> EmptyStr) then
    begin
      dQuantidade := strToFloat(edtPesquisaQuantidade.Text);
    end;


   qryConsulta :=  FDoacaoController.ConsultarDoacao(
      edtPesquisaNome.Text,
      DateToStr(dtpkPesquisaDataDoacaoDe.Date),
      DateToStr(dtpkPesquisaDataDoacaoAte.Date),
      dQuantidade);


    if (not qryConsulta.IsEmpty) then
    begin
      dspDoacao.DataSet := qryConsulta;
      dsDoacao.DataSet.Refresh;
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

procedure TfrmDoacaoView.Editar;
begin
  edtCadastroID.Text := dsDoacao.DataSet.FieldByName('DOA_ID').AsString;
  edtCadastroNome.text := dsDoacao.DataSet.FieldByName('PES_NOME').AsString;
  dtpkCadastroDataDoacao.Date := dsDoacao.DataSet.FieldByName('DOA_DATA').AsDateTime;
  edtCadastroQuantidade.Text := dsDoacao.DataSet.FieldByName('DOA_QTDE').AsString;
  FDoacaoController.ehEdicao := True;
  ExibirTabCadastro;
end;

procedure TfrmDoacaoView.Excluir;
begin
  try
    FDoacaoController.ExcluirDoacao(dsDoacao.DataSet.FieldByName('DOA_ID').AsInteger);
    dsDoacao.DataSet.Refresh;
  except
    on e: Exception do
    begin
      TMensagemNotificacao
        .Create('Erro ao tentar excluir pessoa:' + e.Message, ttp_Erro)
        .Show;
    end;
  end;
end;

procedure TfrmDoacaoView.FormCreate(Sender: TObject);
begin
  inherited;
  FDoacaoController := TDoacaoController.Create;
  cdsDoacao.Open;
end;

procedure TfrmDoacaoView.FormDestroy(Sender: TObject);
begin
  inherited;
  cdsDoacao.Close;
  FreeAndNil(FDoacaoController);
end;

procedure TfrmDoacaoView.imgBtnEditarClick(Sender: TObject);
begin
  inherited;
  Editar;
end;

procedure TfrmDoacaoView.imgBtnExcluirClick(Sender: TObject);
begin
  inherited;
  Excluir;
end;

procedure TfrmDoacaoView.LimparTela;
begin
  edtPesquisaNome.Clear;
  dtpkPesquisaDataDoacaoDe.Date := StrToDate('01/01/1900');
  dtpkPesquisaDataDoacaoAte.Date := StrToDate('01/01/1900');
  edtPesquisaQuantidade.Clear;

  edtCadastroID.Clear;
  edtCadastroNome.Clear;
  dtpkCadastroDataDoacao.Date := StrToDate('01/01/1900');
  edtCadastroQuantidade.Clear;
end;

procedure TfrmDoacaoView.Salvar;
var
  oDoacao: TDoacao;
  oPessoa: TPessoa;
  oPessoaController: TPessoaController;
begin
  try
    oPessoaController := TPessoaController.Create;

    try

     oPessoa := oPessoaController.BuscarPessoaPeloNome(edtCadastroNome.Text);

      if FDoacaoController.ValidarDados(dtpkCadastroDataDoacao.Date,
            StrToFloat(edtCadastroQuantidade.Text), oPessoa.GetDataNascimento, oPessoa.GetID) then
      begin
        oDoacao := FDoacaoController.CriarDoacao(
                          dtpkCadastroDataDoacao.Date,
                          StrToFloat(edtCadastroQuantidade.Text),
                          oPessoa.GetID);

        if (edtCadastroID.Text <> EmptyStr) then
        begin
          oDoacao.setId(strToInt(edtCadastroID.Text));
        end;


        if (FDoacaoController.SalvarDoacao(oDoacao)) then
        begin
          TMensagemNotificacao
            .Create('Dados salvos com sucesso', ttp_Sucesso)
            .Show;

          pgCadastro.ActivePage := tsConsulta;
          tsCadastro.TabVisible := false;
          dsDoacao.DataSet.Refresh;
        end;
      end;
    except
      on e: Exception do
      begin
        TMensagemNotificacao
          .Create('Falha ao tentar cadastrar pessoa: ' + e.Message, ttp_Erro)
          .Show;
      end;
     end;
  finally
    FreeAndNil(oPessoa);
  end;
end;

end.
