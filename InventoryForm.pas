unit InventoryForm;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.Forms, WEBLib.Dialogs;

type
  TForm_Inv = class(TWebForm)
    procedure WebFormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_Inv: TForm_Inv;

implementation

{$R *.dfm}

procedure TForm_Inv.WebFormCreate(Sender: TObject);
begin
  {$IFDEF PAS2JS}
   // Javascript code can be written between asm .. end; blocks
   asm
      alert('JS code is running');

   end;
  {$ENDIF}
end;

end.