unit uPessoa;

interface

uses
  SysUtils;

type
  TPessoa = class
    private
      FId: Integer;
      FNome: string;
      FDataNascimento: TDate;
      FTipoSanguineo: string;
    public
      constructor Create(psNome: string; pdtDataNascimento: TDate; psTipoSanguineo: string);
      function GetID: Integer;
      function GetNome: string;
      function GetDataNascimento: TDate;
      function GetTipoSanguineo: string;
      procedure SetID(const pnID: Integer);
      procedure SetNome(const psNome: string);
      procedure SetDataNascimento(const pdtDataNascimento: TDate);
      procedure SetTipoSanguineo(const psTipoSanguineo: string);
      property ID: Integer read GetID write SetID;
      property Nome: string read GetNome write SetNome;
      property DataNascimento: TDate read GetDataNascimento write SetDataNascimento;
      property TipoSanguineo: string read GetTipoSanguineo write SetTipoSanguineo;
  end;

implementation

{ TPessoa }

constructor TPessoa.Create(psNome: string; pdtDataNascimento: TDate;
  psTipoSanguineo: string);
begin
  FNome := psNome;
  FDataNascimento := pdtDataNascimento;
  FTipoSanguineo := psTipoSanguineo;
end;

function TPessoa.GetDataNascimento: TDate;
begin
  Result := FDataNascimento;
end;

function TPessoa.GetID: Integer;
begin
  Result := FId;
end;

function TPessoa.GetNome: string;
begin
  Result := FNome;
end;

function TPessoa.GetTipoSanguineo: string;
begin
  Result := FTipoSanguineo;
end;

procedure TPessoa.SetDataNascimento(const pdtDataNascimento: TDate);
begin
  FDataNascimento := pdtDataNascimento;
end;

procedure TPessoa.SetID(const pnID: Integer);
begin
  FId := pnID;
end;

procedure TPessoa.SetNome(const psNome: string);
begin
  FNome := psNome;
end;

procedure TPessoa.SetTipoSanguineo(const psTipoSanguineo: string);
begin
  FTipoSanguineo := psTipoSanguineo;
end;

end.
