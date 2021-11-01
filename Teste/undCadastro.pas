unit undCadastro;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, ToolEdit, ExtCtrls, CurrEdit, RXSplit, ComCtrls,
  Buttons, ActnList, IdBaseComponent, IdComponent, IdTCPConnection,
  MaskUtils, IdTCPClient, IdHTTP, DB, RxMemDS, Math, contnrs, undDTO,
  undController, IdMessageClient;

type
  TfrmCadastro = class(TForm)
    pgcadastro: TPageControl;
    tbsDados: TTabSheet;
    tbsPesquisa: TTabSheet;
    pnlDados: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    lblEndereco: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    cmbNome: TComboEdit;
    cmbIdentidade: TComboEdit;
    cmbCPF: TComboEdit;
    cmbEmail: TComboEdit;
    cmbCep: TComboEdit;
    RxSplitter1: TRxSplitter;
    cmbLogradour: TComboEdit;
    cmbNumero: TComboEdit;
    cmbComplemento: TComboEdit;
    cmbBairro: TComboEdit;
    cmbCidade: TComboEdit;
    cobEstado: TComboBox;
    cmbPais: TComboEdit;
    pnlActions: TPanel;
    pnlPesquisa: TPanel;
    lsvPesquisa: TListView;
    Label14: TLabel;
    RxSplitter2: TRxSplitter;
    sbtBusca: TSpeedButton;
    spbGravar: TSpeedButton;
    spbDelete: TSpeedButton;
    spbSair: TSpeedButton;
    Label15: TLabel;
    RxSplitter3: TRxSplitter;
    aclAcoes: TActionList;
    actBusca: TAction;
    actGravar: TAction;
    actRemover: TAction;
    actSair: TAction;
    spbLimpar: TSpeedButton;
    actLimpar: TAction;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    actRetornar: TAction;
    actCapturar: TAction;
    IdHTTP1: TIdHTTP;
    Label16: TLabel;
    cmbFone: TComboEdit;
    procedure actSairExecute(Sender: TObject);
    procedure actLimparExecute(Sender: TObject);
    procedure cmbCepButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actGravarExecute(Sender: TObject);
    procedure actBuscaExecute(Sender: TObject);
    procedure actRemoverExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actRetornarExecute(Sender: TObject);
    procedure actCapturarExecute(Sender: TObject);
  private
    { Private declarations }
    Function validar:boolean;
    Function verificaCPF( valor:string ):boolean;
    procedure loadDTO;
    procedure loadScreen;
    procedure sendMail;
    function geraXML: String;
  public
    { Public declarations }
    CadastroDTO: TCadastroDTO;
    CadastroController: TCadastroController;
    lstRegistros : TObjectList;
  end;

var
  frmCadastro: TfrmCadastro;

implementation

uses ulkJSON, IdSMTP, IdMessage, IdSSLOpenSSL, XMLDoc, XMLIntf;

{$R *.dfm}

Function TfrmCadastro.validar: boolean;
var mensagem: String;
    vrerro : boolean;
begin
  mensagem := 'Informe ou corrija os seguintes dados: '#10#13;
  vrerro := true;

  if length(trim(cmbNome.Text)) <= 0 then
  begin
     mensagem := mensagem + ' - Nome do cliente;'#10#13;
     vrerro := false;
  end;

  if length(trim(cmbCPF.Text)) <= 0 then
  begin
     mensagem := mensagem + ' - Número do CPF;'#10#13;
     vrerro := false;
  end
  else if verificaCPF(trim(cmbCPF.Text)) = false then
       begin
          mensagem := mensagem + ' - Número do CPF inválido;'#10#13;
          vrerro := false;
       end;

  if length(trim(cmbCep.Text)) <= 0 then
  begin
     mensagem := mensagem + ' - Número do CEP;'#10#13;
     vrerro := false;
  end;

  if length(trim(cmbLogradour.Text)) <= 0 then
  begin
     mensagem := mensagem + ' - Logradouro;'#10#13;
     vrerro := false;
  end;

  if length(trim(cmbNumero.Text)) <= 0 then
  begin
     mensagem := mensagem + ' - Número;'#10#13;
     vrerro := false;
  end;

  if length(trim(cmbBairro.Text)) <= 0 then
  begin
     mensagem := mensagem + ' - Bairro;'#10#13;
     vrerro := false;
  end;

  if length(trim(cmbCidade.Text)) <= 0 then
  begin
     mensagem := mensagem + ' - Cidade;'#10#13;
     vrerro := false;
  end;

  if cobEstado.ItemIndex = -1 then
  begin
     mensagem := mensagem + ' - Estado;'#10#13;
     vrerro := false;
  end;

  if length(trim(cmbPais.Text)) <= 0 then
  begin
     mensagem := mensagem + ' - País;'#10#13;
     vrerro := false;
  end;

  if vrerro = false then showMessage(mensagem);
  result := vrerro;
end;

Function TfrmCadastro.verificaCPF( valor:string ):boolean;
var numero: string;
    Function getDigito(numero:string; inicio:integer):integer;
    var i, soma, peso:integer;
    begin
       soma := 0;
       peso := ifThen(inicio=1,10,11);
       for i := 1 to ifthen(inicio=1,9,10) do
       begin
           soma := soma + ( StrToInt(copy(numero,i,1)) * peso);
           peso := peso - 1;
       end;
       result := ifthen( (11-(soma mod 11)) < 10, (11-(soma mod 11)), 0 );
    end;
begin
  numero := valor;
  if length(trim(numero)) < 11 then
     numero := stringofchar('0',11-Length(trim(numero)))+trim(numero);

  if (length(trim(numero)) > 11) or
     (numero = '00000000000') or
     (numero = '11111111111') or
     (numero = '22222222222') or
     (numero = '33333333333') or
     (numero = '44444444444') or
     (numero = '55555555555') or
     (numero = '66666666666') or
     (numero = '77777777777') or
     (numero = '88888888888') or
     (numero = '99999999999') then
  begin
     result := false;
     exit;
  end;

  result := (copy(numero,10,2) = inttostr(getDigito(numero,1))+inttostr(getDigito(numero,2)))
end;

procedure TfrmCadastro.loadDTO;
begin
  with self.CadastroDTO do
  begin
       CPF         := trim(cmbCPF.Text);
       Nome        := trim(cmbNome.Text);
       RG          := trim(cmbIdentidade.Text);
       Fone        := trim(cmbFone.Text);
       Email       := trim(cmbEmail.Text);
       CEP         := trim(cmbCep.Text);
       Logradouro  := trim(cmbLogradour.Text);
       Numero      := trim(cmbNumero.Text);
       Complemento := trim(cmbComplemento.Text);
       Bairro      := trim(cmbBairro.Text);
       Cidade      := trim(cmbCidade.Text);
       UF          := cobEstado.Items[cobEstado.ItemIndex];
       Pais        := trim(cmbPais.Text); 
  end;
end;

procedure TfrmCadastro.loadScreen;
begin
  cmbCPF.Text         := CadastroDTO.CPF;
  cmbNome.Text        := CadastroDTO.Nome;
  cmbIdentidade.Text  := CadastroDTO.RG;
  cmbFone.Text        := CadastroDTO.Fone;
  cmbEmail.Text       := CadastroDTO.Email;
  cmbCep.Text         := CadastroDTO.CEP;
  cmbLogradour.Text   := CAdastroDTO.Logradouro;
  cmbNumero.Text      := CadastroDTO.Numero;
  cmbComplemento.Text := CadastroDTO.Complemento;
  cmbBairro.Text      := cadastroDTO.Bairro;
  cmbCidade.Text      := CadastroDTO.Cidade;
  cobEstado.ItemIndex := cobEstado.Items.IndexOf(CadastroDTO.UF);
  cmbPais.Text        := CadastroDTO.Pais;

  actGravar.Enabled := true;
  actRemover.Enabled := true;
  actLimpar.Enabled  := true;
end;

procedure TfrmCadastro.actSairExecute(Sender: TObject);
begin
  FreeAndNil(self.CadastroDTO);
  FreeAndNil(self.CadastroController);
  FreeAndNil(lstRegistros);
  Application.Terminate;
end;

procedure TfrmCadastro.actLimparExecute(Sender: TObject);
var i:integer;
begin
  lstRegistros := nil;
  
  For i := 0 to Self.pnlDados.ControlCount-1 do
  begin
      if pnlDados.Controls[i].ClassName = 'TComboEdit' then
         (pnlDados.Controls[i] as TComboEdit).Clear
      else if pnlDados.Controls[i].ClassName = 'TRxCalcEdit' then
              (pnlDados.Controls[i] as TRxCalcEdit).Clear
      else if pnlDados.Controls[i].ClassName = 'TComboBox' then
              (pnlDados.Controls[i] as TComboBox).ItemIndex := -1;
  end;

  actBusca.Enabled := true;
  actGravar.Enabled := true;
  actRemover.Enabled := false;
  actLimpar.Enabled  := true;
  actRetornar.Enabled := true;
  actCapturar.Enabled := true;
  actSair.Enabled := true;
end;

procedure TfrmCadastro.cmbCepButtonClick(Sender: TObject);
var Retorno, url: string;
    js: TlkJSONBase;
begin
  try
    url := 'http://viacep.com.br/ws/'+cmbCEP.Text+'/json/';

    IdHTTP1.Request.Accept := 'text/javascript';
    IdHTTP1.Request.ContentType := 'application/json';
    IdHTTP1.Request.ContentEncoding := 'utf-8';

    Retorno := IdHTTP1.Get(url);
    if IdHTTP1.ResponseCode = 200 then
    begin
       js := TlkJSON.ParseText(Retorno);
       cmbLogradour.Text := VarToStr(js.Field['logradouro'].Value);
       cmbComplemento.Text := VartoStr(js.Field['complemento'].Value);
       cmbBairro.Text := VartoStr(js.Field['bairro'].Value);
       cmbCidade.Text := VarToStr(js.Field['localidade'].Value);
       cobEstado.ItemIndex := cobEstado.Items.IndexOf( VarToStr(js.Field['uf'].Value) );
       cmbPais.Text := 'Brasil';
       cmbNumero.SetFocus;
    end
    else
       showMessage('CEP não encontrado!');
  except
    On E:Exception do
       MessageDlg('Erro na recuperação dos dados: '#10#13' - Código: '+inttostr(idHTTP1.ResponseCode),
                  mtError,
                  [mbOK], 0);
  end;
end;

procedure TfrmCadastro.FormCreate(Sender: TObject);
begin
  Self.CadastroDTO := tCAdastroDTO.Create;
  self.CadastroController := TCadastroController.Create;
end;

procedure TfrmCadastro.actGravarExecute(Sender: TObject);
begin
  try
    if self.validar then
    begin
       self.loadDTO;
       self.CadastroController.write(self.CadastroDTO);
       showMessage('Registro gravado com sucesso!');
       if self.geraXML <> '' then
          self.sendMail
       else
          MessageDlg('Erro na geração do XML. E-mail não enviado!', mtWarning, [mbOK], 0);
       self.actLimpar.Execute;
    end;
  except
    On E:Exception do
       ShowMessage(e.Message)
  end;
end;

procedure TfrmCadastro.actBuscaExecute(Sender: TObject);
var
  i: integer;
  lsitem: tListItem;
begin
  self.loadDTO;
  if length(CadastroDTO.CPF) > 0 then
  begin
     CadastroDTO.load( self.CadastroController.getCadastroByCPF(cmbCPF.Text) );
     if length(trim(CadastroDTO.CPF)) > 0 then
        self.loadScreen
     else
        showMessage('Nenhum Registro encontrado!');
  end
  else
  begin
     lstRegistros := self.CadastroController.getCadastroList(CadastroDTO.getCriteria);
     with lstRegistros do
     begin
          self.lsvPesquisa.Clear;
          for i := 0 to Count-1 do
          begin
              lsitem := self.lsvPesquisa.Items.Add;
              lsitem.Caption := FormatMaskText('000\.000\.000\-00;0;',(Items[i] as TCadastroDTO).CPF);
              lsitem.SubItems.add( (Items[i] as TCadastroDTO).Nome );
              lsitem.SubItems.add( (Items[i] as TCadastroDTO).Cidade );
              lsitem.SubItems.add( (items[i] as TCadastroDTO).UF );
          end;
          self.pgcadastro.ActivePageIndex := 1;
     end;
  end;
end;

procedure TfrmCadastro.actRemoverExecute(Sender: TObject);
begin
  if Application.MessageBox('Confirma remoção do registro?','Cadastro',mb_YesNo+mb_IconInformation+mb_DefButton2) = mrYes then
  begin
     if self.CadastroController.remove(cmbCPF.Text) then
     begin
        showMessage('Registro removido com sucesso!');
        actLimpar.Execute;
     end;   
  end;
end;

procedure TfrmCadastro.FormShow(Sender: TObject);
begin
  self.actLimpar.Execute;
  if assigned(self.pgcadastro) then pgcadastro.ActivePageIndex := 0;
end;

procedure TfrmCadastro.actRetornarExecute(Sender: TObject);
begin
  self.pgcadastro.ActivePageIndex := 0;
end;

procedure TfrmCadastro.actCapturarExecute(Sender: TObject);
begin
  if lsvPesquisa.ItemIndex >= 0 then
  begin
     self.CadastroDTO.load( ( lstRegistros[lsvPesquisa.ItemIndex] as TCadastroDTO) );
     self.loadScreen;
     actRetornar.Execute;
  end;
end;

procedure TfrmCadastro.sendMail;
var Socket: TIdSSLIOHandlerSocket;
    SMTP: TIdSMTP;
    eMail: TIdMessage;
begin
  Socket := TIdSSLIOHandlerSocket.Create(Self);
  SMTP   := TIdSMTP.Create(Self);
  eMail  := TIdMessage.Create(Self);

  if Not FileExists(CadastroDTO.CPF+'.xml') then
  begin
     MessageDlg('Arquivo xml não encontrado!', mtWarning, [mbOK], 0);
     Exit;
  end;

  try
    Screen.Cursor := crHourGlass;
    Socket.SSLOptions.Method := sslvSSLv23;
    Socket.SSLOptions.Mode   := sslmClient;

    SMTP.IOHandler := Socket;
    SMTP.AuthenticationType := atLogin;
    SMTP.Port := 465;
    SMTP.Host := 'smtp.gmail.com';
    SMTP.Username := 'paulo.campos.arquivos@gmail.com';
    SMTP.Password := 'ncc1701d';

    try
      SMTP.Connect;
      SMTP.Authenticate;
    except
      on E:Exception do
      begin
         MessageDlg('Erro na conexão com o servidor de e-mail: '#10#13+E.Message, mtWarning, [mbOK], 0);
         Exit;
      end;
    end;

    with eMail do
    begin
         From.Address := 'paulo.campos.arquivos@gmail.com';
         From.Name    := 'Paulo César';
         ReplyTo.EMailAddresses := eMail.From.Address;
         Recipients.EMailAddresses := CadastroDTO.Email;
         MessageParts.Clear;
         TIdAttachment.Create(MessageParts, tFileName(CadastroDTO.CPF+'.xml'));
         Subject := 'Confirmação de Registro do seu cadastro ';
         Body.Add( 'Este e-mail confirma o registro do seu cadastro: ');
         Body.Add('       Nome: '+CadastroDTO.Nome);
         Body.add('        CPF: '+FormatMaskText('000\.000\.000\-00;0;',CadastroDTO.CPF));
         Body.Add('         RG: '+CadastroDTO.RG);
         Body.add('       Fone: '+FormatMaskText('\(00\)0000\-0000;0;',CadastroDTO.Fone));
         Body.add('     E-mail: '+CadastroDTO.Email);
         Body.add('        CEP: '+FormatMaskText('00\.000\-000;0;', CadastroDTO.CEP));
         Body.Add(' Logradouro: '+CadastroDTO.Logradouro);
         Body.add('     Número: '+CadastroDTO.Numero);
         Body.add('Complemento: '+CadastroDTO.Complemento);
         Body.add('     Bairro: '+CadastroDTO.Bairro);
         Body.add('     Cidade: '+CadastroDTO.Cidade);
         Body.add('     Estado: '+CadastroDTO.UF);
         Body.add('       País: '+CadastroDTO.Pais);
         Body.add('Cordialmente. ');
    end;

    try
      SMTP.Send(eMail);
      MessageDlg('Mensagem enviada com sucesso', mtInformation, [mbOK], 0);
      SMTP.Disconnect;
    except
      On E:Exception do
         MessageDlg('Erro no envio da mensagem: '#10#13+e.Message, mtWarning, [mbOK], 0);
    end;
  finally
    Screen.Cursor := crDefault;
    freeandnil(eMail);
    freeAndNil(SMTP);
    freeAndNil(Socket);
  end;
end;

Function TfrmCadastro.geraXML: String;
var
  vrDoc : TXMLDocument;
  NodeTabela, NodeRegistro: IXMLNode;
begin
  vrDoc := TXMLDocument.Create(self);
  try
    try
      vrDoc.Active := true;
      NodeTabela   := vrDoc.AddChild('Cadastro');
      NodeRegistro := NodeTabela.AddChild('Registro');
      With NodeRegistro do
      begin
           ChildValues['CPF']         := CadastroDTO.CPF;
           ChildValues['Nome']        := CadastroDTO.Nome;
           ChildValues['RG']          := CadastroDTO.RG;
           ChildValues['Fone']        := CadastroDTO.Fone;
           ChildValues['Email']       := CadastroDTO.Email;
           ChildValues['CEP']         := CadastroDTO.CEP;
           ChildValues['Logradouro']  := CadastroDTO.Logradouro;
           ChildValues['Numero']      := CadastroDTO.Numero;
           ChildValues['Complemento'] := CadastroDTO.Complemento;
           ChildValues['Bairro']      := CadastroDTO.Bairro;
           ChildValues['Cidade']      := CadastroDTO.Cidade;
           ChildValues['Estado']      := CadastroDTO.UF;
           ChildValues['Pais']        := CadastroDTO.Pais;
      end;
      vrDoc.XML.SaveToFile(CadastroDTO.CPF+'.xml');
      result := CadastroDTO.CPF+'.xml';
    Except
      On E:Exception do
      begin
         MessageDlg('Erro na geração do XML: '#10#13+E.Message,mtError,[mbOk],0);
         result := '';
      end;
    end;
  finally
    vrDoc.Free;
  end;
end;

end.

