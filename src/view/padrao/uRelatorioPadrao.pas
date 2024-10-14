unit uRelatorioPadrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ppPrnabl, ppClass, ppCtrls, ppBands,
  ppCache, ppDesignLayer, ppParameter, ppProd, ppReport, ppComm, ppRelatv, ppDB,
  ppDBPipe, Vcl.ExtCtrls, Data.FMTBcd, Data.DB, Data.SqlExpr;

type
  TfrmRelatorioPadrao = class(TForm)
    ppdbConexaoRelatorio: TppDBPipeline;
    pnlPrincipal: TPanel;
    qryConsultaRelatorio: TSQLQuery;
    dsConsultaRelatorio: TDataSource;
    ppReport1: TppReport;
    ppParameterList1: TppParameterList;
    ppDesignLayers1: TppDesignLayers;
    ppDesignLayer1: TppDesignLayer;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppFooterBand1: TppFooterBand;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelatorioPadrao: TfrmRelatorioPadrao;

implementation

{$R *.dfm}

end.
