inherited frmDoacaoView: TfrmDoacaoView
  Caption = 'Doacao'
  StyleElements = [seFont, seClient, seBorder]
  OnDestroy = FormDestroy
  TextHeight = 15
  inherited pgCadastro: TPageControl
    inherited tsConsulta: TTabSheet
      inherited pnlConsulta: TPanel
        Height = 105
        ExplicitHeight = 105
        inherited btnPesquisar: TSpeedButton
          Left = 420
          Top = 22
          OnClick = btnPesquisarClick
          ExplicitLeft = 420
          ExplicitTop = 22
        end
        inherited btnFechar: TSpeedButton
          Top = 22
          ExplicitTop = 22
        end
        inherited btnCadastrar: TSpeedButton
          Top = 22
          ExplicitTop = 22
        end
        object edtPesquisaNome: TLabeledEdit
          Left = 11
          Top = 22
          Width = 386
          Height = 23
          EditLabel.Width = 36
          EditLabel.Height = 15
          EditLabel.Caption = 'Nome:'
          TabOrder = 0
          Text = ''
        end
        object gbDataNascimento: TGroupBox
          Left = 11
          Top = 51
          Width = 269
          Height = 49
          Caption = 'Data de Nascimento'
          TabOrder = 1
          object lblAte: TLabel
            Left = 128
            Top = 22
            Width = 16
            Height = 15
            Caption = 'at'#233
          end
          object dtpkPesquisaDataDoacaoAte: TDateTimePicker
            Left = 155
            Top = 18
            Width = 107
            Height = 23
            Cursor = crHandPoint
            Date = 2.000000000000000000
            Time = 2.000000000000000000
            TabOrder = 1
          end
          object dtpkPesquisaDataDoacaoDe: TDateTimePicker
            Left = 15
            Top = 18
            Width = 107
            Height = 23
            Cursor = crHandPoint
            Date = 2.000000000000000000
            Time = 2.000000000000000000
            TabOrder = 0
          end
        end
        object edtPesquisaQuantidade: TLabeledEdit
          Left = 295
          Top = 69
          Width = 102
          Height = 23
          EditLabel.Width = 62
          EditLabel.Height = 15
          EditLabel.Caption = 'Quantidade'
          TabOrder = 2
          Text = ''
        end
      end
      inherited pnlDados: TPanel
        Top = 105
        Height = 449
        ExplicitTop = 105
        ExplicitHeight = 449
        inherited grdConsulta: TDBCtrlGrid
          Height = 412
          DataSource = dsDoacao
          PanelHeight = 41
          ExplicitTop = 39
          ExplicitHeight = 412
          object txtID: TDBText
            Left = 54
            Top = 6
            Width = 60
            Height = 24
            Alignment = taCenter
            DataField = 'DOA_ID'
            DataSource = dsDoacao
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          object txtNomeDoador: TDBText
            Left = 128
            Top = 6
            Width = 230
            Height = 24
            Alignment = taCenter
            DataField = 'PES_NOME'
            DataSource = dsDoacao
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          object txtDataDoacao: TDBText
            Left = 381
            Top = 6
            Width = 180
            Height = 24
            Alignment = taCenter
            DataField = 'DOA_DATA'
            DataSource = dsDoacao
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          object txtQuantidade: TDBText
            Left = 581
            Top = 6
            Width = 80
            Height = 24
            Alignment = taCenter
            DataField = 'DOA_QTDE'
            DataSource = dsDoacao
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          object imgBtnEditar: TImage
            Left = 694
            Top = 6
            Width = 24
            Height = 24
            Picture.Data = {
              0954506E67496D61676589504E470D0A1A0A0000000D49484452000000180000
              00180806000000E0773DF80000000473424954080808087C0864880000000970
              485973000000AA000000AA01060A704F0000001974455874536F667477617265
              007777772E696E6B73636170652E6F72679BEE3C1A000002AB4944415478DADD
              965B4814611480CFF967676F9A569617582D08BA3C859AB96A177D885E829520
              CA8722DD95320AEAB1277B308A8A20300ADD45A9A81EB38C884C2BD94B591488
              86599A66E04304E5B693733BFDB34214E6EEACFAD47919F867F8BEF39F39FF9C
              412282C508DC7428D361D5EA75D156079A761F496D9682FE315C0CC1926D752B
              55B205F5A559F95A71859D0D0F4CB3B1610554B9282EE076A7DDAAD6808E25B3
              3263F02C16F2DF4C084731048ABE46DE7F0CF5ECBCF8BA78EF96227C18B88ECE
              525FB106D4C510C6F95E5ECFDE3B754BA1C0B57FC22B1AB2558B1ED4D7E6ACA2
              AC74642F2748DED720D2B215C04686C0DA71E32BDADDDE76448AC64281A32995
              E50FB8DC542D82288078FEA1CAFA3E73C961D1F2F481228CBE0B18020909AB62
              91D648EAF0DC02B9C963059B65E6864E7189D03BC278E9A750518B0C01098C15
              46832D6F4CC3053DA4AFCBCDFF0B6E04AFB1D8DCADB1476FA3A4CA5BA7436DFD
              2909D2DDF5399A9505E786F770F8E06F78FC159A15CCC0059E798ECB2CDCB460
              BE705382F4CDB5B99A9D1FA279C0930AE207D009FDBC155DF2E9EA94E1490536
              77BD8721DDB1BA32E4A90B7BAD94E948099E549056EEBDB273A3E4FD2E31EAFB
              910D714986C3343CA960F976EFA74B07BFB8769746C1732E4F3624D20697C09E
              0C9982271438CA6A570308A38317C7E1FDA4089DAFD2A0E57106A0C8BE69AA92
              10EE747BB7F04FE80E29E26F4C20F0F910A1C52290CE6B2EF36B4F4C61772DAA
              D6117DD13699286B67B9F73811AB96C2AD95730AD2CA7D853AA10749EF921C05
              11EA695493952325C142E27F11A0470AFBAB0C418480DA7F860357174BC01BE4
              369F84A37C129E447B59DD01DEAD67F98038C388F52D888C2410D22E203C01A0
              AD97C26D1F112A4F591CD3137BB8E0087FA464410200A3D33AF9CFC365E9796B
              AFB1F00B4031EC92A0C0DDEB0000000049454E44AE426082}
            Transparent = True
            OnClick = imgBtnEditarClick
          end
          object imgBtnExcluir: TImage
            Left = 762
            Top = 6
            Width = 24
            Height = 24
            Picture.Data = {
              0954506E67496D61676589504E470D0A1A0A0000000D49484452000000180000
              00180806000000E0773DF80000000473424954080808087C0864880000000970
              485973000000B1000000B101C62D498D0000001974455874536F667477617265
              007777772E696E6B73636170652E6F72679BEE3C1A000002344944415478DAED
              563D681441147E6F66372746CD053C4D61238AC42E70609088C60B2206D42E8D
              48208220168A7F4DD22858486C14ACF40A11116C44A222A870FE40404D691454
              6C849853D0530EBCDB99797EBB9B4293CB6E38AD248F9DE57B336FE69B796FF7
              BD6182483EEF97ED8AA32C3C444CEBD0E553731290D07B612AAED2950B3C3111
              70B8F867971D23919D4D2EDA5844EEE7BCEF7B78BAABEF14939C5BC0941F68E3
              337833DAF2540EA2935CEE2A4C026F4CB4647A4A9E1B5075A5050FA99F22D6BB
              89812D29049321413DC5E75566BD41C81EC28CE1988F4E13EBCB60790B756952
              4C4202493968C9B219D0E24FC76B47E232819FABF9C12DE0AD89879F4320F486
              145D2547513F2B796DC88C6BE70FFD6E663C5754967B947067D4A140EE6810EF
              CE64029267C43C5C6D73CF5BBFA9DD69818C7C987563CB2ADC2DC267A1F6A410
              847E9087E2CB7E0AD4D44208C47007627F1DDF7F5FBA8BE6129445E81A331D07
              7E3063B203C1388F8983C0B9BF2260A147CEF23EF6E493901C8EC7F99273DE6A
              D6E606C60B8B048B04FF3B01B429622922338D00DFC57F1B26BC7E113903A283
              30EE48236894AE5F6087DB95321F81B3942C5F8D6E5DE3D9EA13E0FCACB160BE
              8263911EFA9718FF653D535F9BB47A4BADE5432D633691933B50F59F9EA05728
              99851300A30DE63AB4C7F0DF3B98CE533304298AD6036CA33061CF768FC8B1B8
              E8DBB6DBD077D1BF957BB9ACDB1B5528E9EDF5BE54F41104EE00C53B6AFEDA82
              13E3FA736565BBBDC8A592F905F0C8BDB759C88A0A0000000049454E44AE4260
              82}
            Transparent = True
            OnClick = imgBtnExcluirClick
          end
        end
        inherited hcCabecalho: THeaderControl
          Sections = <
            item
              ImageIndex = -1
              Width = 50
            end
            item
              Alignment = taCenter
              ImageIndex = -1
              MaxWidth = 70
              MinWidth = 70
              Text = 'ID'
              Width = 70
            end
            item
              Alignment = taCenter
              ImageIndex = -1
              MaxWidth = 250
              MinWidth = 250
              Text = 'Doador'
              Width = 250
            end
            item
              Alignment = taCenter
              ImageIndex = -1
              MaxWidth = 200
              MinWidth = 200
              Text = 'Data Doacao'
              Width = 200
            end
            item
              Alignment = taCenter
              ImageIndex = -1
              MaxWidth = 100
              MinWidth = 100
              Text = 'Quantidade'
              Width = 100
            end
            item
              Alignment = taCenter
              ImageIndex = -1
              MaxWidth = 70
              MinWidth = 70
              Text = 'Editar'
              Width = 70
            end
            item
              Alignment = taCenter
              ImageIndex = -1
              MaxWidth = 70
              MinWidth = 70
              Text = 'Excluir'
              Width = 70
            end>
        end
      end
    end
    inherited tsCadastro: TTabSheet
      inherited pnlHeader: TPanel
        inherited btnSalvar: TSpeedButton
          Left = 688
          Width = 78
          OnClick = btnSalvarClick
          ExplicitLeft = 688
          ExplicitWidth = 78
        end
        inherited btnCancelar: TSpeedButton
          Left = 772
          ExplicitLeft = 772
        end
        object StaticText1: TStaticText
          Left = 16
          Top = 16
          Width = 526
          Height = 67
          Alignment = taCenter
          Caption = 'Cadastro de Doa'#231#227'o'
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBrown
          Font.Height = -48
          Font.Name = 'JetBrains Mono'
          Font.Style = [fsBold, fsItalic]
          ParentColor = False
          ParentFont = False
          TabOrder = 0
        end
      end
      inherited pnlMain: TPanel
        object lblCadastroDataNascimento: TLabel
          Left = 16
          Top = 133
          Width = 70
          Height = 15
          Caption = 'Data Doacao '
        end
        object edtCadastroID: TLabeledEdit
          Left = 16
          Top = 40
          Width = 57
          Height = 23
          EditLabel.Width = 14
          EditLabel.Height = 15
          EditLabel.Caption = 'ID:'
          Enabled = False
          ReadOnly = True
          TabOrder = 0
          Text = ''
        end
        object edtCadastroNome: TLabeledEdit
          Left = 16
          Top = 96
          Width = 250
          Height = 23
          EditLabel.Width = 36
          EditLabel.Height = 15
          EditLabel.Caption = 'Nome:'
          TabOrder = 1
          Text = ''
        end
        object dtpkCadastroDataDoacao: TDateTimePicker
          Left = 16
          Top = 152
          Width = 186
          Height = 23
          Date = 2.000000000000000000
          Time = 2.000000000000000000
          TabOrder = 2
        end
        object edtCadastroQuantidade: TLabeledEdit
          Left = 16
          Top = 200
          Width = 121
          Height = 23
          EditLabel.Width = 62
          EditLabel.Height = 15
          EditLabel.Caption = 'Quantidade'
          TabOrder = 3
          Text = ''
        end
      end
    end
  end
  inherited ilIconesBotoes: TImageList
    Left = 760
    Top = 216
  end
  object dspDoacao: TDataSetProvider
    DataSet = qryConsulta
    Left = 764
    Top = 275
  end
  object cdsDoacao: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspDoacao'
    Left = 764
    Top = 331
    object cdsDoacaoDOA_ID: TIntegerField
      FieldName = 'DOA_ID'
    end
    object cdsDoacaoDOA_DATA: TSQLTimeStampField
      FieldName = 'DOA_DATA'
    end
    object cdsDoacaoDOA_QTDE: TFMTBCDField
      FieldName = 'DOA_QTDE'
      Precision = 18
      Size = 2
    end
    object cdsDoacaoPES_ID: TIntegerField
      FieldName = 'PES_ID'
    end
    object cdsDoacaoPES_NOME: TStringField
      FieldName = 'PES_NOME'
      Size = 100
    end
  end
  object dsDoacao: TDataSource
    DataSet = cdsDoacao
    Left = 764
    Top = 395
  end
  object qryConsulta: TSQLQuery
    Active = True
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'SELECT '
      #9'D.DOA_ID,'
      #9'D.DOA_DATA,'
      #9'D.DOA_QTDE,'
      #9'P.PES_NOME,'
      #9'D.PES_ID'
      ' FROM BS_DOACAO D'
      ' INNER JOIN BS_PESSOA P ON P.PES_ID = D.PES_ID'
      ' WHERE 1 = 1;')
    SQLConnection = dmConexao.conConexao
    Left = 764
    Top = 459
    object qryConsultaDOA_ID: TIntegerField
      FieldName = 'DOA_ID'
    end
    object qryConsultaDOA_DATA: TSQLTimeStampField
      FieldName = 'DOA_DATA'
    end
    object qryConsultaDOA_QTDE: TFMTBCDField
      FieldName = 'DOA_QTDE'
      Precision = 18
      Size = 2
    end
    object qryConsultaPES_NOME: TStringField
      FieldName = 'PES_NOME'
      Size = 100
    end
    object qryConsultaPES_ID: TIntegerField
      FieldName = 'PES_ID'
    end
  end
end
