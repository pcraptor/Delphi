unit undDAO;

interface

uses SysUtils, Contnrs, undDTO, unddmCadastro;

Type
   TCadastroDAO = class
    private
    protected
    { protected declarations }
    public
      Function getCadastroByCPF( valor:String ): TCadastroDTO;
      Function getCadastroList( criteria:String ): TObjectList;
      Function write( DTO:TCadastroDTO ): boolean;
      Function remove( valor: string ): boolean;
   end;

implementation

uses DB;

Function tCadastroDAO.getCadastroByCPF(valor:string): TCadastroDTO;
begin
  result := TCadastroDTO.Create;

  if dmCadastro.tbCadastro.Locate('nr_CPF',valor,[loCaseInsensitive]) then
  begin
     result.CPF        := dmCadastro.tbCadastro.FieldByName('nr_CPF').AsString;
     result.Nome       := dmCadastro.tbCadastro.FieldByName('ds_Nome').AsString;
     result.RG         := dmCadastro.tbCadastro.FieldByName('nr_RG').AsString;
     result.Fone       := dmCadastro.tbCadastro.FieldByName('nr_Fone').AsString;
     result.Email      := dmCadastro.tbCadastro.FieldByName('ds_Email').AsString;
     result.CEP        := dmCadastro.tbCadastro.FieldByName('nr_CEP').AsString;
     result.Logradouro := dmCadastro.tbCadastro.FieldByName('ds_Logradouro').AsString;
     result.Numero     := dmCadastro.tbCadastro.FieldByName('ds_Numero').AsString;
     result.Complemento:= dmCadastro.tbCadastro.FieldByName('ds_Complemento').AsString;
     result.Bairro     := dmCadastro.tbCadastro.FieldByName('ds_Bairro').AsString;
     result.Cidade     := dmCadastro.tbCadastro.FieldByName('ds_Cidade').AsString;
     result.UF         := dmCadastro.tbCadastro.FieldByName('ds_Estado').AsString;
     result.Pais       := dmCadastro.tbCadastro.FieldByName('ds_Pais').AsString;
  end;
end;

Function tCadastroDAO.getCadastroList(criteria:string): TObjectList;
var
  Dto: TCadastroDTO;
begin
  result := tObjectList.Create(True);
  dmCadastro.tbCadastro.FilterOptions := [foCaseInsensitive];
  dmCadastro.tbCadastro.Filtered := false;
  dmCadastro.tbCadastro.Filter := criteria;
  dmCadastro.tbCadastro.Filtered := true;

  if dmCadastro.tbCadastro.RecordCount > 0 then
  begin
     while not dmCadastro.tbCadastro.Eof do
     begin
           dto := TCadastroDTO.Create;

           dto.CPF        := dmCadastro.tbCadastro.FieldByName('nr_CPF').AsString;
           dto.Nome       := dmCadastro.tbCadastro.FieldByName('ds_Nome').AsString;
           dto.RG         := dmCadastro.tbCadastro.FieldByName('nr_RG').AsString;
           dto.Fone       := dmCadastro.tbCadastro.FieldByName('nr_Fone').AsString;
           dto.Email      := dmCadastro.tbCadastro.FieldByName('ds_Email').AsString;
           dto.CEP        := dmCadastro.tbCadastro.FieldByName('nr_CEP').AsString;
           dto.Logradouro := dmCadastro.tbCadastro.FieldByName('ds_Logradouro').AsString;
           dto.Numero     := dmCadastro.tbCadastro.FieldByName('ds_Numero').AsString;
           dto.Complemento:= dmCadastro.tbCadastro.FieldByName('ds_Complemento').AsString;
           dto.Bairro     := dmCadastro.tbCadastro.FieldByName('ds_Bairro').AsString;
           dto.Cidade     := dmCadastro.tbCadastro.FieldByName('ds_Cidade').AsString;
           dto.UF         := dmCadastro.tbCadastro.FieldByName('ds_Estado').AsString;
           dto.Pais       := dmCadastro.tbCadastro.FieldByName('ds_Pais').AsString;

           result.Add(dto);

           dmCadastro.tbCadastro.Next;
     end;
  end;
  dmCadastro.tbCadastro.Filtered := false;
end;

Function tCadastroDAO.write(DTO:TCadastroDTO):boolean;
begin
  try
    if getCadastroByCPF(DTO.CPF).CPF <> '' then
       dmCadastro.tbCadastro.Edit
    else
       dmCadastro.tbCadastro.Append;

    With dmCadastro.tbCadastro do
    begin
         FieldByName('nr_CPF').AsString         := DTO.CPF;
         FieldByName('ds_Nome').AsString        := DTO.Nome;
         FieldByName('nr_RG').AsString          := DTO.RG;
         FieldByName('nr_Fone').AsString        := DTO.Fone;
         FieldByName('ds_Email').AsString       := DTO.Email;
         FieldByName('nr_CEP').AsString         := DTO.CEP;
         FieldByName('ds_Logradouro').AsString  := DTO.Logradouro;
         FieldByName('ds_Numero').AsString      := DTO.Numero;
         FieldByName('ds_Complemento').AsString := DTO.Complemento;
         FieldByName('ds_Bairro').AsString      := DTO.Bairro;
         FieldByName('ds_Cidade').AsString      := DTO.Cidade;
         FieldByName('ds_Estado').AsString      := DTO.UF;
         FieldByName('ds_Pais').AsString        := DTO.Pais;
    end;
    result := true;
  Except
    On E:Exception Do
    Begin
       raise Exception.Create('Erro na gravação do registro: '#10#13+E.message);
       result := false;
    end;
  end;
end;

Function tCadastroDAO.remove(valor:string):boolean;
begin
  try
    if getCadastroByCPF(valor).CPF <> '' then
    begin
       dmCadastro.tbCadastro.Delete;
       result := true;
    end
    else
       result := false;
  Except
    On E:Exception do
    begin
       raise Exception.Create('Erro na deleção do registro: '#10#13+E.Message);
       result := false;
    end;
  End;     
end;
end.
