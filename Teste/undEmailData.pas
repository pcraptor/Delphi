unit undEmailData;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, ToolEdit, Buttons;

type
  TfrmEmail = class(TForm)
    GroupBox1: TGroupBox;
    ComboEdit1: TComboEdit;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    btnOk: TBitBtn;
    btnCancela: TBitBtn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmEmail: TfrmEmail;

implementation

{$R *.dfm}

end.
