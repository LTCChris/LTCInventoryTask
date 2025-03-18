program InventoryAPIServer;

uses
  Vcl.Forms,
  dm_Inventory in 'dm_Inventory.pas' {ServerContainer: TDataModule},
  frm_MainForm in 'frm_MainForm.pas' {MainForm},
  InventoryService in 'InventoryService.pas',
  Types_Vars_Inventory in 'Types_Vars_Inventory.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TServerContainer, ServerContainer);
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
