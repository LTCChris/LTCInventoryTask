program InventoryProj;

uses
  Vcl.Forms,
  WEBLib.Forms,
  InventoryForm in 'InventoryForm.pas' {Form_Inv: TWebForm} {*.html};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm_Inv, Form_Inv);
  Application.Run;
end.
