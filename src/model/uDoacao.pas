unit uDoacao;

interface

uses
  SysUtils;

type
  TDoacao = class
    private
      FId: Integer;
      FDataDoacao: TDate;
      FQuantidade: Double;
      FIdDoador: Integer;
    public
      constructor Create(pdtDataDoacao: TDate; pdQuantidade: Double; pnIdDoador: Integer);
      function GetDataDoacao: TDate;
      function GetID: Integer;
      function GetIdDoador: Integer;
      function GetQuantidade: Double;
      procedure SetDataDoacao(const pdtDataDoacao: TDate);
      procedure SetID(const pnID: Integer);
      procedure SetIdDoador(const pnIdDoador: Integer);
      procedure SetQuantidade(const pdQuantidade: Double);
      property ID: Integer read GetID write SetID;
      property DataDoacao: TDate read GetDataDoacao write SetDataDoacao;
      property Quantidade: Double read GetQuantidade write SetQuantidade;
      property IdDoador: Integer read GetIdDoador write SetIdDoador;
  end;

implementation

{ TDoacao }

constructor TDoacao.Create(pdtDataDoacao: TDate; pdQuantidade: Double; pnIdDoador: Integer);
begin
  FDataDoacao := pdtDataDoacao;
  FQuantidade := pdQuantidade;
  FIdDoador := pnIdDoador;
end;

function TDoacao.GetDataDoacao: TDate;
begin
  Result := FDataDoacao;
end;

function TDoacao.GetID: Integer;
begin
  Result := FID;
end;

function TDoacao.GetIdDoador: Integer;
begin
  Result := FIdDoador;
end;

function TDoacao.GetQuantidade: Double;
begin
  Result :=  FQuantidade;
end;

procedure TDoacao.SetDataDoacao(const pdtDataDoacao: TDate);
begin
  FDataDoacao := pdtDataDoacao;
end;

procedure TDoacao.SetID(const pnID: Integer);
begin
  FID := pnID;
end;

procedure TDoacao.SetIdDoador(const pnIdDoador: Integer);
begin
  FIdDoador := pnIdDoador;
end;

procedure TDoacao.SetQuantidade(const pdQuantidade: Double);
begin
  FQuantidade := pdQuantidade;
end;

end.
