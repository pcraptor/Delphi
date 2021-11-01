unit undController;

interface

uses Contnrs, unddmCadastro, undDTO, undDAO;

Type TCadastroController = class
      Private
         CadastroDAO: TCadastroDAO;
      Public
         Constructor Create;
         Destructor Destroy; override;

         Function getCadastroByCPF( valor:String ): TCadastroDTO;
         Function getCadastroList(criteria:string): TObjectList;
         Function write( DTO:TCadastroDTO ): boolean;
         Function remove( valor: string ): boolean;

     end;

implementation

uses SysUtils;

Constructor TCadastroController.Create;
begin
  inherited;
  Self.CadastroDAO := TCadastroDAO.Create;
end;

Destructor TCadastroController.Destroy;
begin
  FreeAndNil(CadastroDAO);
  inherited;
end;

Function TCadastroController.getCadastroByCPF( valor:String ): TCadastroDTO;
begin
  result := CadastroDAO.getCadastroByCPF(valor);
end;

function TCadastroController.getCadastroList(
  criteria: string): TObjectList;
begin
  result := CadastroDAO.getCadastroList(criteria);
end;

Function TCadastroController.write( DTO:TCadastroDTO ): boolean;
begin
  result := CadastroDAO.write(DTO);
end;

Function TCadastroController.remove( valor: string ): boolean;
begin
  result := CadastroDAO.remove(valor);
end;

end.
 