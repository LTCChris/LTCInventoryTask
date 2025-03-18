unit dm_Inventory;

interface

uses
  System.SysUtils, System.Classes, Sparkle.HttpServer.Module,
  Sparkle.HttpServer.Context, Sparkle.Comp.Server,
  Sparkle.Comp.HttpSysDispatcher, Aurelius.Drivers.Interfaces,
  Aurelius.Comp.Connection, XData.Comp.ConnectionPool, XData.Server.Module,
  XData.Comp.Server, Aurelius.Drivers.SQLite, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.VCLUI.Wait, FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteWrapper.Stat,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.Phys.SQLite;

type
  TServerContainer = class(TDataModule)
    SparkleHttpSysDispatcher: TSparkleHttpSysDispatcher;
    XDataServer: TXDataServer;
    XDataConnectionPool: TXDataConnectionPool;
    AureliusConnection: TAureliusConnection;
    FDConnection: TFDConnection;
    FDPhysSQLiteDriverLink: TFDPhysSQLiteDriverLink;
    FDQuery: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
  end;

var
  ServerContainer: TServerContainer;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TServerContainer.DataModuleCreate(Sender: TObject);
begin
  FDManager.Open;
  FDConnection.Params.Clear;
  FDConnection.Params.DriverID := 'SQLite';
  FDConnection.Params.Database := 'InventoryDB.db';
  FDConnection.Params.Add('Synchronous=Full');
  FDConnection.Params.Add('LockingMode=Normal');
  FDConnection.Params.Add('SharedCache=False');
  FDConnection.Params.Add('UpdateOptions.LockWait=True');
  FDConnection.Params.Add('BusyTimeout=10000');
  FDConnection.Params.Add('SQLiteAdvanced=page_size=4096');

  FDConnection.Open;

  // Create Tables if they don't already exist:
  FDQuery.Connection := FDConnection;
  with FDQuery do
  begin
    SQL.Clear;

    // Create the inventory Table:
    SQL.Add(' CREATE TABLE IF NOT EXISTS "inventory" (');
    SQL.Add(' "Counter" INTEGER NOT NULL,');
    SQL.Add(' "product_code" TEXT NOT NULL UNIQUE,');
    SQL.Add(' "product_name" TEXT,');
    SQL.Add(' "product_quantity" INTEGER NOT NULL DEFAULT 0,');
    SQL.Add(' PRIMARY KEY("Counter" AUTOINCREMENT))');
  end;

  FDQuery.ExecSQL;

  FDQuery.Close;
  FDConnection.Close;
end;

end.
