unit unddmCadastro;

interface

uses
  SysUtils, Classes, DB, RxMemDS, DBFilter;

type
  TdmCadastro = class(TDataModule)
    tbCadastro: TRxMemoryData;
    tbCadastronr_CPF: TStringField;
    tbCadastrods_nome: TStringField;
    tbCadastronr_RG: TStringField;
    tbCadastrods_Email: TStringField;
    tbCadastronr_CEP: TStringField;
    tbCadastrods_Logradouro: TStringField;
    tbCadastrods_numero: TStringField;
    tbCadastrods_Complemento: TStringField;
    tbCadastrods_Bairro: TStringField;
    tbCadastrods_Cidade: TStringField;
    tbCadastrods_Estado: TStringField;
    tbCadastrods_Pais: TStringField;
    tbCadastronr_Fone: TStringField;
    RxDBFilter1: TRxDBFilter;
    DataSource1: TDataSource;
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmCadastro: TdmCadastro;

implementation

{$R *.dfm}

procedure TdmCadastro.DataModuleDestroy(Sender: TObject);
begin
  tbCadastro.Active := false;
end;

end.
