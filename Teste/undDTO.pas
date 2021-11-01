unit undDTO;

interface

uses sysutils;

Type
   TCadastroDTO = class
    private
       nrCPF        : string;
       dsNome       : string;
       dsRG         : string;
       nrFone       : string;
       dsEmail      : string;
       nrCep        : string;
       dsLogradouro : string;
       dsNumero     : string;
       dsComplemento: string;
       dsBairro     : string;
       dsCidade     : string;
       dsUF         : string;
       dsPais       : string;
    protected
    { protected declarations }
    public
       function getCriteria: string;
       procedure load(DTO:TCadastroDTO);
    published
       Property CPF:string read nrCPF write nrCPF;
       Property Nome:string read dsNome write dsNome;
       Property RG:string read dsRG write dsRG;
       Property Fone:string read nrFone write nrFone;
       Property Email:string read dsEmail write dsEmail;
       Property CEP:string read nrCep write nrCep;
       Property Logradouro:string read dsLogradouro write dsLogradouro;
       Property Numero:string read dsNumero write dsNumero;
       Property Complemento:string read dsComplemento write dsComplemento;
       Property Bairro:string read dsBairro write dsBairro;
       Property Cidade:string read dsCidade write dsCidade;
       Property UF:string read dsUF write dsUF;
       Property Pais:string read dsPais write dsPais;
   end;

implementation

function TCadastroDTO.getCriteria: string;
begin
  result := '';

  if Length(trim(self.CPF)) > 0 then
     if length(result) > 0 then
        result := result + ' AND nr_CPF = '+QuotedStr(self.CPF)
     else
        result := result + 'nr_CPF = '+QuotedStr(self.CPF);

  if Length(trim(self.Nome)) > 0 then
     if length(result) > 0 then
        result := result + ' AND ds_nome LIKE '+QuotedStr('*'+Self.Nome+'*')
     else
        result := result + 'ds_nome LIKE '+QuotedStr('*'+Self.Nome+'*');

  if Length(trim(self.dsRG)) > 0 then
     if length(result) > 0 then
        result := result + ' AND nr_RG LIKE '+QuotedStr('*'+Self.dsRG+'*')
     else
        result := result + 'nr_RG LIKE '+QuotedStr('*'+Self.dsRG+'*');

  if length(trim(self.dsEmail)) > 0 then
     if length(result) > 0 then
        result := result + ' AND ds_Email LIKE '+QuotedStr('*'+self.Email+'*')
     else
        result := result + 'ds_Email LIKE '+QuotedStr('*'+self.Email+'*');

  if length(trim(self.nrCep)) > 0 then
     if length(result) > 0 then
        result := result + ' AND nr_CEP LIKE '+QuotedStr('*'+self.CEP+'*')
     else
        result := result + 'nr_CEP LIKE '+QuotedStr('*'+self.CEP+'*');

  if length(trim(self.dsLogradouro)) > 0 then
     if length(result) > 0 then
        result := result + ' AND ds_Logradouro LIKE '+QuotedStr('*'+Self.Logradouro+'*')
     else
        result := result + 'ds_Logradouro LIKE '+QuotedStr('*'+Self.Logradouro+'*');

   if Length(trim(self.Bairro)) > 0 then
      if length(result) > 0 then
         result := result + ' AND ds_Bairro LIKE '+QuotedStr('*'+self.Bairro+'*')
      else
         result := result + 'ds_Bairro LIKE '+QuotedStr('*'+self.Bairro+'*');

   if Length(trim(self.Cidade)) > 0 then
      if length(result) > 0 then
         result := result + ' AND ds_Cidade LIKE '+QuotedStr('*'+self.Cidade+'*')
      else
         result := result + 'ds_Cidade LIKE '+QuotedStr('*'+self.Cidade+'*');

   if Length(trim(self.UF)) > 0 then
      if length(result) > 0 then
         result := result + ' AND ds_Estado = '+QuotedStr(self.UF)
      else
         result := result + 'ds_Estado = '+QuotedStr(self.UF);

   if Length(trim(self.Pais)) > 0 then
      if length(result) > 0 then
         result := result + ' AND ds_Pais LIKE '+QuotedStr('*'+self.Pais+'*')
      else
         result := result + 'ds_Pais LIKE '+QuotedStr('*'+self.Pais+'*');
end;

procedure tCadastroDTO.load(DTO:TCadastroDTO);
Begin
   Self.CPF         := DTO.CPF;
   Self.Nome        := DTO.Nome;
   Self.RG          := DTO.RG;
   Self.Fone        := DTO.Fone;
   Self.Email       := DTO.Email;
   Self.CEP         := DTO.CEP;
   Self.Logradouro  := DTO.Logradouro;
   Self.Numero      := DTO.Numero;
   Self.Complemento := DTO.Complemento;
   Self.Bairro      := DTO.Bairro;
   Self.Cidade      := DTO.Cidade;
   Self.UF          := DTO.UF;
   Self.Pais        := DTO.Pais;
end;

end.
 