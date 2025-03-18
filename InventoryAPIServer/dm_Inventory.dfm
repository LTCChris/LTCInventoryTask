object ServerContainer: TServerContainer
  OnCreate = DataModuleCreate
  Height = 210
  Width = 431
  object SparkleHttpSysDispatcher: TSparkleHttpSysDispatcher
    Active = True
    Left = 72
    Top = 16
  end
  object XDataServer: TXDataServer
    BaseUrl = 'http://+:2001/tms/xdata'
    Dispatcher = SparkleHttpSysDispatcher
    Pool = XDataConnectionPool
    EntitySetPermissions = <>
    Left = 216
    Top = 16
  end
  object XDataConnectionPool: TXDataConnectionPool
    Connection = AureliusConnection
    Left = 216
    Top = 72
  end
  object AureliusConnection: TAureliusConnection
    DriverName = 'SQLite'
    Left = 216
    Top = 128
  end
  object FDConnection: TFDConnection
    Left = 344
    Top = 24
  end
  object FDPhysSQLiteDriverLink: TFDPhysSQLiteDriverLink
    Left = 344
    Top = 80
  end
  object FDQuery: TFDQuery
    Connection = FDConnection
    Left = 344
    Top = 136
  end
end
