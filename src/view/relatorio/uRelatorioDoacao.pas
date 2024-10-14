unit uRelatorioDoacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uRelatorioPadrao, Data.FMTBcd, Data.DB,
  Data.SqlExpr, ppParameter, ppDesignLayer, ppBands, ppPrnabl, ppClass, ppCtrls,
  ppCache, ppProd, ppReport, ppComm, ppRelatv, ppDB, ppDBPipe, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Imaging.pngimage, uDMConexao, ppStrtch, ppTableGrid;

type
  TfrmRelatorioDoacao = class(TfrmRelatorioPadrao)
    rgRelatorios: TRadioGroup;
    Image1: TImage;
    qryConsultaRelatorioTipoSanguíneo: TStringField;
    qryConsultaRelatorioQuantidade: TIntegerField;
    ppTitleBand1: TppTitleBand;
    ppLabel1: TppLabel;
    ppLabel2: TppLabel;
    ppLabel3: TppLabel;
    ppTableCell3: TppTableCell;
    ppDBText1: TppDBText;
    ppDBText2: TppDBText;
    ppLabel4: TppLabel;
    ppDBCalc1: TppDBCalc;
    procedure Image1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelatorioDoacao: TfrmRelatorioDoacao;

implementation

{$R *.dfm}

procedure TfrmRelatorioDoacao.Image1Click(Sender: TObject);
begin
  inherited;
  ppReport1.Print;
end;

end.
