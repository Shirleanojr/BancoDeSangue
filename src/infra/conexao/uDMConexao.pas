unit uDMConexao;

interface

uses
  System.SysUtils, System.Classes, DBXDevartSQLServer, Data.FMTBcd,
  Datasnap.DBClient, Datasnap.Provider, Data.DB, Data.SqlExpr;

type
  TdmConexao = class(TDataModule)
    conConexao: TSQLConnection;
    tbPessoa: TSQLTable;
    tbPessoaPES_ID: TIntegerField;
    tbPessoaPES_NOME: TStringField;
    tbPessoaPES_DATANASC: TSQLTimeStampField;
    tbPessoaPES_TIPOSANG: TStringField;
    tbDoacao: TSQLTable;
    tbDoacaoDOA_ID: TIntegerField;
    tbDoacaoDOA_DATA: TSQLTimeStampField;
    tbDoacaoDOA_QTDE: TFMTBCDField;
    tbDoacaoPES_ID: TIntegerField;
    procedure DataModuleCreate(Sender: TObject);
  private
    FHostName,
    FDataBaseName,
    FUserName,
    FPassword: string;
    procedure LerArquivoIni;
  public
    function GetConexao: TSQLConnection;
    property Conexao: TSQLConnection read GetConexao;
  end;

var
  dmConexao: TdmConexao;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses
  System.IniFiles, VCL.Forms;

{$R *.dfm}



procedure TdmConexao.DataModuleCreate(Sender: TObject);
begin
  LerArquivoIni;
  conConexao.Params.Values['HostName'] := FHostName;
  conConexao.Params.Values['DataBase'] := FDataBaseName;
  conConexao.Params.Values['User_Name'] := FUserName;
  conConexao.Params.Values['Password'] := FPassword;
  conConexao.Connected := true;
end;

function TdmConexao.GetConexao: TSQLConnection;
begin
  Result := conConexao;
end;

procedure TdmConexao.LerArquivoIni;
var
  oIni: TIniFile;
  sPath: string;
begin
  sPath := ChangeFileExt(ExtractFilePath(Application.Exename) + ExtractFileName(Application.ExeName), '') + '.ini';
  oIni := TIniFile.Create(sPath);
  try
    FHostName := oIni.ReadString('DATABASE', 'HOSTNAME', '');
    FDataBaseName := oIni.ReadString('DATABASE', 'DATABASENAME', '');
    FUserName := oIni.ReadString('DATABASE', 'USERNAME', '');
    FPassword := oIni.ReadString('DATABASE', 'PASSWORD', '');
  finally
    FreeAndNil(oIni);
  end;
end;

end.
