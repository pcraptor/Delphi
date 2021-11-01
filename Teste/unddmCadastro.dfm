object dmCadastro: TdmCadastro
  OldCreateOrder = False
  OnDestroy = DataModuleDestroy
  Left = 63891
  Top = 117
  Height = 171
  Width = 215
  object tbCadastro: TRxMemoryData
    FieldDefs = <>
    Left = 40
    Top = 20
    object tbCadastronr_CPF: TStringField
      FieldName = 'nr_CPF'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Size = 11
    end
    object tbCadastrods_nome: TStringField
      FieldName = 'ds_nome'
      Size = 100
    end
    object tbCadastronr_RG: TStringField
      FieldName = 'nr_RG'
    end
    object tbCadastrods_Email: TStringField
      FieldName = 'ds_Email'
      Size = 100
    end
    object tbCadastronr_CEP: TStringField
      FieldName = 'nr_CEP'
      Size = 8
    end
    object tbCadastrods_Logradouro: TStringField
      FieldName = 'ds_Logradouro'
      Size = 200
    end
    object tbCadastrods_numero: TStringField
      FieldName = 'ds_numero'
      Size = 10
    end
    object tbCadastrods_Complemento: TStringField
      FieldName = 'ds_Complemento'
      Size = 50
    end
    object tbCadastrods_Bairro: TStringField
      FieldName = 'ds_Bairro'
      Size = 80
    end
    object tbCadastrods_Cidade: TStringField
      FieldName = 'ds_Cidade'
      Size = 100
    end
    object tbCadastrods_Estado: TStringField
      FieldName = 'ds_Estado'
      Size = 2
    end
    object tbCadastrods_Pais: TStringField
      FieldName = 'ds_Pais'
      Size = 80
    end
    object tbCadastronr_Fone: TStringField
      FieldName = 'nr_Fone'
    end
  end
  object RxDBFilter1: TRxDBFilter
    DataSource = DataSource1
    Options = [foCaseInsensitive]
    Left = 106
    Top = 18
  end
  object DataSource1: TDataSource
    DataSet = tbCadastro
    Left = 78
    Top = 72
  end
end
