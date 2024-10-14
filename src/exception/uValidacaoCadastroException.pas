unit uValidacaoCadastroException;

interface

  uses
    SysUtils;

type
  EValidacaoCadatroException = class(Exception)
    public
      constructor Create(const msg: string); reintroduce;
  end;

implementation

{ EValidacaoCadatroException }

constructor EValidacaoCadatroException.Create(const msg: string);
begin
  inherited Create(msg);
end;

end.
