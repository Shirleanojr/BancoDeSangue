object dmConexao: TdmConexao
  OnCreate = DataModuleCreate
  Height = 480
  Width = 640
  object conConexao: TSQLConnection
    ConnectionName = 'Devart SQL Server'
    DriverName = 'DevartSQLServer'
    LoginPrompt = False
    Params.Strings = (
      'BlobSize=-1'
      'SchemaOverride=%.dbo'
      'HostName='
      'DataBase='
      'DriverName='
      'User_Name='
      'Password='
      'LongStrings=True'
      'EnableBCD=True'
      'FetchAll=True'
      'UseUnicode=True'
      'IPVersion=IPv4')
    Left = 40
    Top = 24
  end
  object tbPessoa: TSQLTable
    MaxBlobSize = -1
    SQLConnection = conConexao
    TableName = 'BS_PESSOA'
    Left = 40
    Top = 112
    object tbPessoaPES_ID: TIntegerField
      FieldName = 'PES_ID'
    end
    object tbPessoaPES_NOME: TStringField
      FieldName = 'PES_NOME'
      Size = 100
    end
    object tbPessoaPES_DATANASC: TSQLTimeStampField
      FieldName = 'PES_DATANASC'
    end
    object tbPessoaPES_TIPOSANG: TStringField
      FieldName = 'PES_TIPOSANG'
      FixedChar = True
      Size = 2
    end
  end
  object tbDoacao: TSQLTable
    MaxBlobSize = -1
    SQLConnection = conConexao
    TableName = 'BS_DOACAO'
    Left = 128
    Top = 112
    object tbDoacaoDOA_ID: TIntegerField
      FieldName = 'DOA_ID'
    end
    object tbDoacaoDOA_DATA: TSQLTimeStampField
      FieldName = 'DOA_DATA'
    end
    object tbDoacaoDOA_QTDE: TFMTBCDField
      FieldName = 'DOA_QTDE'
      Precision = 18
      Size = 2
    end
    object tbDoacaoPES_ID: TIntegerField
      FieldName = 'PES_ID'
    end
  end
end
