unit uMensagemNotificacao;

interface

uses
  Vcl.Dialogs;

type
  TTipoNotificacao = (ttp_Sucesso, ttp_Erro);

  TMensagemNotificacao = class
    private
      FTipo: TTipoNotificacao;
      FMensagem: string;
      FTaskDialog: TTaskDialog;
      procedure criarMensagem;
    public
      constructor Create(psMensagem: string; psTipo: TTipoNotificacao);
      destructor Destroy; override;
      procedure Show;
  end;

implementation

uses
  System.SysUtils;

{ TMensagemNotificao }

constructor TMensagemNotificacao.Create(psMensagem: string;
  psTipo: TTipoNotificacao);
begin
  FTipo := psTipo;
  FMensagem := psMensagem;
  FTaskDialog := TTaskDialog.Create(nil);
end;

procedure TMensagemNotificacao.criarMensagem;
var
  sCaption: string;
  oIcone: TTaskDialogIcon;
begin

  case FTipo of
    ttp_Sucesso:
    begin
      sCaption := 'Sucesso';
      oIcone := tdiInformation;
    end;

    ttp_Erro:
    begin
      sCaption := 'Erro';
      oIcone := tdiError;
    end;
  end;

  FTaskDialog.Caption := sCaption;
  FTaskDialog.Title := sCaption;
  FTaskDialog.Text := FMensagem;
  FTaskDialog.CommonButtons := [tcbOk];
  FTaskDialog.MainIcon := oIcone;
end;

destructor TMensagemNotificacao.Destroy;
begin
  FreeAndNil(FTaskDialog);
  inherited;
end;

procedure TMensagemNotificacao.Show;
begin
  criarMensagem;
  FTaskDialog.Execute;
end;

end.
