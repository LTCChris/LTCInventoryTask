unit InventoryService;

interface

uses
  dm_Inventory,
  //
  Types_Vars_Inventory,
  //
  XData.Server.Module,
  XData.Service.Common,
  //
  System.SysUtils, Generics.Collections;

type
  [ServiceContract]
  IInventoryService = interface(IInvokable)
    ['{B255CB55-D2D1-4AA0-B56A-F336D75C6550}']
    [HttpGet] function Sum(A, B: double): double;
    // By default, any service operation responds to (is invoked by) a POST request from the client.
    function EchoString(Value: string): string;
    //
    [HttpGet] function GetInventoryList: TList< tclsInventoryItem>;
  end;

  [ServiceImplementation]
  TInventoryService = class(TInterfacedObject, IInventoryService)
  private
    //Example API functions
    function Sum(A, B: double): double;
    function EchoString(Value: string): string;
    // Starting API function
    function GetInventoryList: TList< tclsInventoryItem>;
  end;

implementation

// Function example for getting list of items from the inventory table
function TInventoryService.GetInventoryList: TList<tclsInventoryItem>;
var
  clsInventoryItem: tclsInventoryItem;
begin
  Result := TList<tclsInventoryItem>.Create;
  TXDataOperationContext.Current.Handler.ManagedObjects.Add(Result);

  // opens the connection component
  ServerContainer.FDConnection.Open;

  with ServerContainer.FDQuery do
  begin
    SQL.Clear;
    SQL.Add('SELECT * FROM inventory');
  end;
  ServerContainer.FDQuery.Open;

  // loop through items found from select query and create item object to add to result list
  while not ServerContainer.FDQuery.eof do
  begin
    clsInventoryItem := tclsInventoryItem.Create;
    TXDataOperationContext.Current.Handler.ManagedObjects.Add(clsInventoryItem);

    clsInventoryItem.productCode := ServerContainer.FDQuery.FieldByName('product_code').AsString;
    clsInventoryItem.productName := ServerContainer.FDQuery.FieldByName('product_name').AsString;
    clsInventoryItem.productQuantity := ServerContainer.FDQuery.FieldByName('product_quantity').AsInteger;

    Result.Add(clsInventoryItem);
    ServerContainer.FDQuery.Next;
  end;

  ServerContainer.FDQuery.Close;
  ServerContainer.FDConnection.Close;
end;

function TInventoryService.Sum(A, B: double): double;
begin
  Result := A + B;
end;

function TInventoryService.EchoString(Value: string): string;
begin
  Result := Value;
end;

initialization
  RegisterServiceType(TypeInfo(IInventoryService));
  RegisterServiceType(TInventoryService);

end.
