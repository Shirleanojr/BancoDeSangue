unit uPessoaController;

interface

uses
  uPessoa, SysUtils, Data.SqlExpr;

type
  TPessoaController = class
    private
      FQuery: TSQLQuery;
      FEhEdicao: boolean;
      procedure validarTamanhoNome(psNome: string);
      procedure validarIdadeMenor18Anos(pdtDataNascimento: TDate);
      procedure validarIdadeMaior60Anos(pdtDataNascimento: TDate);
      procedure MontarQueryEdicao(poPessoa: TPessoa);
      procedure MontarQueryInsercao(poPessoa: TPessoa);
    public
      constructor Create;
      destructor Destroy; override;
      function CriarPessoa(const psNome: string; const pdtDataNascimento: TDate; const psTipoSanguineo: string): TPessoa;
      function ValidarDados(const psNome: string; const pdtDataNascimento: TDate; const psTipoSanguineo: string): Boolean;
      function SalvarPessoa(poPessoa: TPessoa): Boolean;
      procedure ExcluirPessoa(const pnID: Integer);
      function ConsultarPessoa(const psNome: string = ''; const psDataNascimentoDe: string = '';
        psDataNascimentoAte: string = ''; const psTipoSanguineo: string = ''): TSQLQuery;
      function BuscarPessoaPeloNome(const psNome: string): TPessoa;
      property ehEdicao: boolean read FEhEdicao write FEhEdicao;
  end;

implementation

uses
  uDMConexao, DateUtils, uValidacaoCadastroException;

{ TPessoaController }


function TPessoaController.BuscarPessoaPeloNome(const psNome: string): TPessoa;
var
  oPessoa: TPessoa;
begin
  FQuery.SQL.Clear;
  FQuery.Params.Clear;

  FQuery.SQL.Add( ' SELECT PES_ID,      ' +
	            '        PES_NOME,        ' +
	            '        PES_DATANASC,    ' +
              '        PES_TIPOSANG     ' +
              '   FROM BS_PESSOA        ' + 
              '  WHERE LOWER(PES_NOME) = LOWER(:nome) ');

  FQuery.ParamByName('nome').AsString := psNome;
  try
    FQuery.Open;

    if (FQuery.IsEmpty) then
    begin
      raise Exception.Create('Nenhum doador encontrado com o nome informado. Por favor verifique os dados informados e tente novamente');
    end;

    oPessoa := TPessoa.Create(
    FQuery.FieldByName('PES_NOME').AsString,
    FQuery.FieldByName('PES_DATANASC').AsDateTime,
    FQuery.FieldByName('PES_TIPOSANG').AsString);
    oPessoa.SetID(FQuery.FieldByName('PES_ID').AsInteger);
    Result := oPessoa;

  except
    on e: Exception do
    begin
      raise Exception.Create('Nenhum doador encontrado com o nome informado. Por favor verifique os dados informados e tente novamente');
    end;
  end;
end;

function TPessoaController.ConsultarPessoa(const psNome,
  psDataNascimentoDe: string; psDataNascimentoAte: string;
  const psTipoSanguineo: string): TSQLQuery;
var
  sComando: string;

const 
  CDT_ZERO = '01/01/1900';
begin
  sComando := ' SELECT PES_ID,          ' +
	            '        PES_NOME,        ' +
	            '        PES_DATANASC,    ' +
              '        PES_TIPOSANG     ' +
              '   FROM BS_PESSOA        ' +
              '   WHERE 1 = 1           ';

  if (psNome <> EmptyStr) then
  begin
    sComando := sComando + ' AND PES_NOME LIKE ' + QuotedStr('%' + psNome + '%');
  end;

  if ((psDataNascimentoDe <> CDT_ZERO) and (psDataNascimentoAte <> CDT_ZERO)) then
  begin
    sComando := sComando + ' AND PES_DATANASC BETWEEN ' + QuotedStr(psDataNascimentoDe) 
    + ' AND ' + QuotedStr(psDataNascimentoAte);
  end
  else if (psDataNascimentoDe <> CDT_ZERO) then
   begin
    sComando := sComando + ' AND PES_DATANASC >= ' + QuotedStr(psDataNascimentoDe);
   end
   else if (psDataNascimentoAte <> CDT_ZERO) then
   begin
    sComando := sComando + ' AND PES_DATANASC <= ' + QuotedStr(psDataNascimentoAte);
   end;

  if (psTipoSanguineo <> EmptyStr) then
  begin
    sComando := sComando + ' AND PES_TIPOSANG = ' + QuotedStr(psTipoSanguineo);
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

constructor TPessoaController.Create;
begin
  inherited;
  FEhEdicao := false;
  FQuery := TSQLQuery.Create(nil);
  FQuery.SQLConnection := dmConexao.GetConexao;
end;

function TPessoaController.CriarPessoa(const psNome: string;
  const pdtDataNascimento: TDate; const psTipoSanguineo: string): TPessoa;
begin
  Result := TPessoa.Create(psNome, pdtDataNascimento, psTipoSanguineo);
end;


destructor TPessoaController.Destroy;
begin
  FreeAndNil(FQuery);
  inherited;
end;

procedure TPessoaController.ExcluirPessoa(const pnID: Integer);
begin

  if (pnId <= 0) then
  begin
    raise Exception.Create('ID deve ser maior que zero');
  end;

  FQuery.SQL.Clear;
  FQuery.Params.Clear;

  FQuery.SQL.Add('DELETE FROM BS_PESSOA WHERE PES_ID = :ID');
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

procedure TPessoaController.MontarQueryEdicao(poPessoa: TPessoa);
begin
  FQuery.SQL.Clear;
  FQuery.Params.Clear;

  FQuery.SQL.Add('UPDATE BS_PESSOA SET PES_NOME = :nome, PES_DATANASC = :dataNascimento,'
    + 'PES_TIPOSANG = :tipoSanguineo WHERE PES_ID = :ID');

  FQuery.ParamByName('nome').AsString := poPessoa.GetNome;
  FQuery.ParamByName('dataNascimento').asDate := poPessoa.GetDataNascimento;
  FQuery.ParamByName('tipoSanguineo').asString := poPessoa.GetTipoSanguineo;
  FQuery.ParamByName('ID').AsInteger := poPessoa.GetID;
end;

procedure TPessoaController.MontarQueryInsercao(poPessoa: TPessoa);
begin
  FQuery.SQL.Clear;
  FQuery.Params.Clear;

  FQuery.SQL.Add('INSERT INTO BS_PESSOA (PES_NOME, PES_DATANASC, PES_TIPOSANG) '
      + 'VALUES (:nome, :dataNascimento, :tipoSanguineo)');

  FQuery.ParamByName('nome').AsString := poPessoa.GetNome;
  FQuery.ParamByName('dataNascimento').asDate := poPessoa.GetDataNascimento;
  FQuery.ParamByName('tipoSanguineo').asString := poPessoa.GetTipoSanguineo;
end;

function TPessoaController.SalvarPessoa(poPessoa: TPessoa): Boolean;
begin
  MontarQueryInsercao(poPessoa);

  if (ehEdicao) then
  begin
    MontarQueryEdicao(poPessoa);
  end;

  try
    FQuery.ExecSQL;
    Result := true;
  except
    on e: Exception do
    begin
      raise Exception.Create('Erro ao salvar o registro no banco:' + e.Message );
    end;
  end;

end;

function TPessoaController.ValidarDados(const psNome: string;
  const pdtDataNascimento: TDate; const psTipoSanguineo: string): Boolean;
begin
    try
    validarTamanhoNome(psNome);
    validarIdadeMenor18Anos(pdtDataNascimento);
    validarIdadeMaior60Anos(pdtDataNascimento);
    Result := true;
  except
    on e: EValidacaoCadatroException do
    begin
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TPessoaController.validarIdadeMaior60Anos(pdtDataNascimento: TDate);
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

procedure TPessoaController.validarIdadeMenor18Anos(pdtDataNascimento: TDate);
var
  anoNascimento,
  anoAtual: integer;
begin
  anoNascimento := YearOf(pdtDataNascimento);
  anoAtual := YearOf(now);

  if ((anoAtual - anoNascimento) < 18) then
  begin
    raise EValidacaoCadatroException.Create('Idade mínima para cadastro é 18 anos');
  end;
end;

procedure TPessoaController.validarTamanhoNome(psNome: string);
begin
  if (psNome.Length <= 5) then
  begin
    raise EValidacaoCadatroException.Create('Nome deve ter no mínimo 5 caracteres');
  end;
end;

end.
