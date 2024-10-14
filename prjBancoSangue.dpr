program prjBancoSangue;

uses
  Vcl.Forms,
  uMenuPrincipal in 'src\view\uMenuPrincipal.pas' {frmMenuPrincipal},
  uCadastroPadrao in 'src\view\padrao\uCadastroPadrao.pas' {frmCadastroPadrao},
  uPessoaView in 'src\view\uPessoaView.pas' {frmPessoaView},
  uPessoa in 'src\model\uPessoa.pas',
  uPessoaController in 'src\controller\uPessoaController.pas',
  uDMConexao in 'src\infra\conexao\uDMConexao.pas' {dmConexao: TDataModule},
  uValidacaoCadastroException in 'src\exception\uValidacaoCadastroException.pas',
  uMensagemNotificacao in 'src\infra\util\uMensagemNotificacao.pas',
  uDoacaoView in 'src\view\uDoacaoView.pas' {frmDoacaoView},
  uDoacaoController in 'src\controller\uDoacaoController.pas',
  uDoacao in 'src\model\uDoacao.pas',
  uRelatorioPadrao in 'src\view\padrao\uRelatorioPadrao.pas' {frmRelatorioPadrao},
  uRelatorioDoacao in 'src\view\relatorio\uRelatorioDoacao.pas' {frmRelatorioDoacao};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Banco de Sangue';
  Application.CreateForm(TfrmMenuPrincipal, frmMenuPrincipal);
  Application.CreateForm(TdmConexao, dmConexao);
  Application.CreateForm(TfrmRelatorioPadrao, frmRelatorioPadrao);
  Application.CreateForm(TfrmRelatorioDoacao, frmRelatorioDoacao);
  Application.Run;
end.
