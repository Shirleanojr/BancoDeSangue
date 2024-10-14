unit uDoacaoController;

interface

uses
  uDoacao, SysUtils, Data.SqlExpr;


type
  TDoacaoController = class
    private
      FQuery: TSQLQuery;
      FEhEdicao: boolean;
      procedure MontarQueryInsercao(poDoacao: TDoacao);
      procedure MontarQueryEdicao(poDoacao: TDoacao);
      procedure ValidarIdadeMaior60Anos(pdtDataNascimento: TDate);
      procedure ValidarDataUltimaDoacaoMaior15Dias(pdtDataDoaco: TDate; pIdDoador: Integer);
      procedure ValidarQuantidadeDoacaoMaior1Litro(pdQuantidade: Double);
      procedure ValidarQuantidadeMaiorQueZero(pdQuantidade: Double);
      procedure ValidarCadatroDataFutura(pdtDataDoacao: TDate);
      function BuscarDataUltimaDoacao(const pnIdDoador: Integer): TDate;
    public
      constructor Create;
      destructor Destroy; override;
      function CriarDoacao(const pdtDataDoacao: TDate; const pdQuanditdade: Double; const pnIdDoador: Integer): TDoacao;
      function SalvarDoacao(poDoacao: TDoacao): Boolean;
      function ValidarDados(const pdtDataDoacao: TDate; const pdQuanditdade: Double; const pdtDataNascimentoDoador: TDate; const pIdDoador: Integer): Boolean;
      procedure ExcluirDoacao(const pnID: Integer);
      function ConsultarDoacao(const psNome: string = ''; const psDataDoacaoDe: string = '';
        psDataDoacaoAte: string = ''; const pdQuantidade: Double = 0.0): TSQLQuery;
      property ehEdicao: boolean read FEhEdicao write FEhEdicao;
  end;

implementation

uses
  uValidacaoCadastroException, System.DateUtils, uDMConexao, Data.DB;

{ TDoacaoController }

function TDoacaoController.BuscarDataUltimaDoacao(
  const pnIdDoador: Integer): TDate;
begin
  FQuery.SQL.Clear;
  FQuery.Params.Clear;

  FQuery.SQL.Add(' SELECT DOA_ID, '  +
                 '        MAX(DOA_DATA) AS ULTIMA_DOACAO ' +
                 '   FROM BS_DOACAO           ' +
                 '  WHERE PES_ID = :idDoador  ' +
                 '  GROUP BY DOA_ID');
  FQuery.ParamByName('idDoador').AsInteger := pnIdDoador;
  try
    FQuery.Open;

    if (FQuery.IsEmpty) then
    begin
      raise Exception.Create('Doador informado não encontrado. Verifique os dados ou cadastre um novo doador.');
    end;

    if (FQuery.FieldByName('DOA_ID').AsInteger = 0) then
    begin
      raise Exception.Create('Doador informado não encontrado. Verifique os dados ou cadastre um novo doador.');
    end;

    Result := FQuery.FieldByName('ULTIMA_DOACAO').AsDateTime;
  except
    on e: Exception do
    begin
      raise Exception.Create(e.Message);
    end;
  end;
end;

function TDoacaoController.ConsultarDoacao(const psNome, psDataDoacaoDe: string;
  psDataDoacaoAte: string; const pdQuantidade: Double): TSQLQuery;
var
  sComando,
  sQuantidade: string;
const
 CDT_ZERO = '01/01/1900';
begin
  sComando := ' SELECT D.DOA_ID,   ' +
              '	       D.DOA_DATA, ' +
              '	       D.DOA_QTDE, ' +
              '        P.PES_NOME, ' +
              '        D.PES_ID    ' +
              '   FROM BS_DOACAO D ' +
              '  INNER JOIN BS_PESSOA P ON P.PES_ID = D.PES_ID '+
              '  WHERE 1 = 1       ';


  if (psNome <> EmptyStr) then
  begin
    sComando := sComando + ' AND P.PES_NOME LIKE ' + QuotedStr('%' + psNome + '%');
  end;

  if ((psDataDoacaoDe <> CDT_ZERO) and (psDataDoacaoAte <> CDT_ZERO)) then
  begin
    sComando := sComando + ' AND D.DOA_DATA BETWEEN ' + QuotedStr(psDataDoacaoDe)
    + ' AND ' + QuotedStr(psDataDoacaoAte);
  end
  else if (psDataDoacaoDe <> CDT_ZERO) then
   begin
    sComando := sComando + ' AND D.DOA_DATA >= ' + QuotedStr(psDataDoacaoDe);
   end
   else if (psDataDoacaoAte <> CDT_ZERO) then
   begin
    sComando := sComando + ' AND D.DOA_DATA <= ' + QuotedStr(psDataDoacaoAte);
   end;

   if (pdQuantidade > 0) then
   begin
    sQuantidade := FloatToStr(pdQuantidade).Replace(',', '.');
    sComando := sComando + ' AND D.DOA_QTDE = ' + sQuantidade;
   end;

  FQuery.SQL.Clear;
  FQuery.SQL.Add(sComando);

  try
    FQuery.Open;
    Result := FQuery;
  except
    on e: Exception do
    begin
      raise Exception.Create('Erro ao realizar a consulta: ' + e.Message);
    end;
  end;

end;

constructor TDoacaoController.Create;
begin
  FEhEdicao := False;
  FQuery := TSQLQuery.Create(nil);
  FQuery.SQLConnection := dmConexao.GetConexao;
end;

function TDoacaoController.CriarDoacao(const pdtDataDoacao: TDate;
  const pdQuanditdade: Double; const pnIdDoador: Integer): TDoacao;
begin
  Result := TDoacao.Create(pdtDataDoacao, pdQuanditdade, pnIdDoador);
end;

destructor TDoacaoController.Destroy;
begin
  FreeAndNil(FQuery);
  inherited;
end;

procedure TDoacaoController.ExcluirDoacao(const pnID: Integer);
begin
  if (pnID <= 0) then
  begin
    raise Exception.Create('ID deve ser maior que zero');
  end;

  FQuery.SQL.Clear;
  FQuery.Params.Clear;

  FQuery.SQL.Add('DELETE FROM BS_DOACAO WHERE DOA_ID = :ID');
  FQuery.ParamByName('ID').AsInteger := pnID;

  try
    FQuery.ExecSQL;
  except
    on e: Exception do
    begin
      raise Exception.Create('Erro ao tentar deletar o ID: ' + intToStr(pnID)
       + ' | ' + e.Message);
    end;
  end;
end;

procedure TDoacaoController.MontarQueryEdicao(poDoacao: TDoacao);
begin
  FQuery.SQL.Clear;
  FQuery.Params.Clear;

  FQuery.SQL.Add('UPDATE BS_DOACAO SET DOA_DATA = :dataDoacao, DOA_QTDE = :quantidade,'
    + 'PES_ID = :IdDoador WHERE DOA_ID = :ID');

  FQuery.ParamByName('dataDoacao').asDate := poDoacao.GetDataDoacao;
  FQuery.ParamByName('quantidade').AsFloat := poDoacao.GetQuantidade;
  FQuery.ParamByName('IdDoador').AsInteger := poDoacao.GetIdDoador;
  FQuery.ParamByName('ID').AsInteger := poDoacao.GetID;
end;

procedure TDoacaoController.MontarQueryInsercao(poDoacao: TDoacao);
begin
  FQuery.SQL.Clear;
  FQuery.Params.Clear;

  FQuery.SQL.Add('INSERT INTO BS_DOACAO (DOA_DATA, DOA_QTDE, PES_ID) '
      + 'VALUES (:dataDoacao, :quantidade, :IdDoador)');

  FQuery.ParamByName('dataDoacao').asDate := poDoacao.GetDataDoacao;
  FQuery.ParamByName('quantidade').AsFloat := poDoacao.GetQuantidade;
  FQuery.ParamByName('IdDoador').AsInteger := poDoacao.GetIdDoador;
end;

function TDoacaoController.SalvarDoacao(poDoacao: TDoacao): Boolean;
begin
  MontarQueryInsercao(poDoacao);

  if (ehEdicao) then
  begin
    MontarQueryEdicao(poDoacao);
  end;

  try
    FQuery.ExecSQL;
    Result := true;
  except
    on e: Exception do
    begin
      raise Exception.Create('Erro ao salvar o registro no banco: ' + e.Message );
    end;
  end;
end;

procedure TDoacaoController.ValidarCadatroDataFutura(pdtDataDoacao: TDate);
begin
  if (pdtDataDoacao > Now) then
  begin
    raise EValidacaoCadatroException.Create('Não é possível inserir uma doação data futura.');
  end;
end;

function TDoacaoController.ValidarDados(const pdtDataDoacao: TDate;
  const pdQuanditdade: Double; const pdtDataNascimentoDoador: TDate; const pIdDoador: Integer): Boolean;
begin
  try
    ValidarIdadeMaior60Anos(pdtDataNascimentoDoador);
    ValidarDataUltimaDoacaoMaior15Dias(pdtDataDoacao, pIdDoador);
    ValidarQuantidadeDoacaoMaior1Litro(pdQuanditdade);
    ValidarQuantidadeMaiorQueZero(pdQuanditdade);
    ValidarCadatroDataFutura(pdtDataDoacao);
    Result := True;
  except
    on e: EValidacaoCadatroException do
    begin
      raise Exception.Create(e.Message);
    end;

  end;
end;

procedure TDoacaoController.ValidarDataUltimaDoacaoMaior15Dias(
  pdtDataDoaco: TDate; pIdDoador: Integer);
var
  dtUltimaDoacao: TDate;
const
  CDT_ZERO_SQL  = '30/12/1899';
begin
  dtUltimaDoacao := BuscarDataUltimaDoacao(pIdDoador);

  if(dtUltimaDoacao = strToDate(CDT_ZERO_SQL)) then
  begin
    exit;
  end;

  if ((pdtDataDoaco - dtUltimaDoacao) < 15) then
  begin
    raise EValidacaoCadatroException.Create('Doação só é permitida em um período '
       + 'mínimo de 15 dias desde a ultima doação');
  end;
end;

procedure TDoacaoController.ValidarIdadeMaior60Anos(pdtDataNascimento: TDate);
var
  anoNascimento,
  anoAtual: integer;
begin
  anoNascimento := YearOf(pdtDataNascimento);
  anoAtual := YearOf(now);

    if ((anoAtual - anoNascimento) > 60) then
  begin
    raise EValidacaoCadatroException.Create('Idade maxima para cadastro é 60 anos');
  end;

end;

procedure TDoacaoController.ValidarQuantidadeDoacaoMaior1Litro(
  pdQuantidade: Double);
begin
  if (pdQuantidade > 1) then
  begin
    raise EValidacaoCadatroException.Create('Quantidade máxima permitida para doação é de 1 LITRO');
  end;
end;

procedure TDoacaoController.ValidarQuantidadeMaiorQueZero(pdQuantidade: Double);
begin
  if (pdQuantidade <= 0) then
  begin
    raise EValidacaoCadatroException.Create('Quantidade deve ser maior que 0');
  end;
end;

end.
