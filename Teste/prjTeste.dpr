program prjTeste;

uses
  Forms,
  undCadastro in 'undCadastro.pas' {frmCadastro},
  undDTO in 'undDTO.pas',
  unddmCadastro in 'unddmCadastro.pas' {dmCadastro: TDataModule},
  undDAO in 'undDAO.pas',
  undController in 'undController.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmCadastro, frmCadastro);
  Application.CreateForm(TdmCadastro, dmCadastro);
  dmCadastro.tbCadastro.Active := true;
  Application.Run;
end.
