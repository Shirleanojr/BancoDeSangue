object frmMenuPrincipal: TfrmMenuPrincipal
  Left = 0
  Top = 0
  Caption = 'Banco de Sangue'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = mnMenuPrincipal
  Position = poScreenCenter
  WindowState = wsMaximized
  TextHeight = 15
  object mnMenuPrincipal: TMainMenu
    Left = 520
    Top = 320
    object mniSistema: TMenuItem
      Caption = 'Sistema'
      object mniSistemaSair: TMenuItem
        Caption = 'Sair'
      end
    end
    object nmiArquivo: TMenuItem
      Caption = 'Arquivo'
      object mniArquivoPessoa: TMenuItem
        Caption = 'Pessoa'
        OnClick = mniArquivoPessoaClick
      end
    end
    object mniProcesso: TMenuItem
      Caption = 'Processo'
      object mniProcessoDoacao: TMenuItem
        Caption = 'Doa'#231#227'o'
        OnClick = mniProcessoDoacaoClick
      end
    end
    object mniRelatorio: TMenuItem
      Caption = 'Relat'#243'rio'
      object mniRelatorioDoacao: TMenuItem
        Caption = 'Doa'#231#227'o'
        OnClick = mniRelatorioDoacaoClick
      end
    end
  end
end
