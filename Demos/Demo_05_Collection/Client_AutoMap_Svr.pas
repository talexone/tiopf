unit Client_AutoMap_Svr;

interface

procedure RegisterMappings ;

implementation
uses
   tiOPFManager
  ,tiClassToDBMap_BOM
  ,Client_BOM
  ;

procedure RegisterMappings ;
begin
  //                                              Class,   Table,    Property,     Column,       Special Info
  gTIOPFManager.ClassDBMappingMgr.RegisterMapping(TClient, 'Client', 'OID',        'OID',        [pktDB] );
  gTIOPFManager.ClassDBMappingMgr.RegisterMapping(TClient, 'Client', 'ClientName', 'Client_Name'         );
  gTIOPFManager.ClassDBMappingMgr.RegisterMapping(TClient, 'Client', 'ClientID',   'Client_ID'           );
  gTIOPFManager.ClassDBMappingMgr.RegisterCollection(TClients, TClient);
end ;
end.