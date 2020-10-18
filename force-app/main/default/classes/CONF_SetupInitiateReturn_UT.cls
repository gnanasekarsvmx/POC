@isTest(SeeAllData=true)
private with sharing class CONF_SetupInitiateReturn_UT
{
    static testMethod void CONF_SetupInitiateReturn_UnitTest() 
    {
        System.currentPageReference().getParameters().put('SVMX_Mode', 'New');
        CONF_SetupInitiateReturn initRetProces = new CONF_SetupInitiateReturn();
        
        RecordType InitRetProcess_Rtype = [select Id from RecordType where Name='Initiate Return Process'and SobjectType='SVMXC__ServiceMax_Processes__c' Limit 1];
        RecordType ExpressionsSrcUpdate_Rtype = [select Id from RecordType where Name='Field Mapping'and SobjectType='SVMXC__ServiceMax_Config_Data__c' Limit 1];
        
        SVMXC__ServiceMax_Processes__c process = new SVMXC__ServiceMax_Processes__c();
        process.RecordTypeId = InitRetProcess_Rtype.Id;
        process.SVMXC__Name__c = 'Process00001';
        process.SVMXC__APL_Perform_Entitlement__c = true;
        process.SVMXC__APL_Perform_Route_Calculations__c = false;
        process.SVMXC__ProcessID__c = 'Process00001';
        process.SVMXC__Description__c = 'Process00001';
        process.SVMXC__APL_Print_RMA_Template__c = 'STOCK';
        process.SVMXC__Source_Object_Name__c = 'SVMXC__RMA_Shipment_Order__c';
        process.SVMXC__Active__c = true;
        process.SVMXC__Parent_Error_Msg__c = 'Process00001';
        process.SVMXC__Child_Error_Msg__c = 'Process00001';
        process.SVMXC__IsStandard__c = true;
        insert process;
        
        List<SVMXC__SFM_Event__c> lstEvent = new List<SVMXC__SFM_Event__c>();
        SVMXC__SFM_Event__c event1 = new SVMXC__SFM_Event__c();
        event1.SVMXC__Event_Type__c = 'Before Entitlement';
        event1.SVMXC__ServiceMax_Process__c = process.Id;
        lstEvent.add(event1);
        SVMXC__SFM_Event__c event2 = new SVMXC__SFM_Event__c();
        event2.SVMXC__Event_Type__c = 'Before Route Calculations';
        event2.SVMXC__ServiceMax_Process__c = process.Id;
        lstEvent.add(event2);
        SVMXC__SFM_Event__c event3 = new SVMXC__SFM_Event__c();
        event3.SVMXC__Event_Type__c = 'Before RMA Generation';
        event3.SVMXC__ServiceMax_Process__c = process.Id;
        lstEvent.add(event3);
        SVMXC__SFM_Event__c event4 = new SVMXC__SFM_Event__c();
        event4.SVMXC__Event_Type__c = 'After RMA Generation';
        event4.SVMXC__ServiceMax_Process__c = process.Id;
        lstEvent.add(event4);
        insert lstEvent;
        
        List<SVMXC__ServiceMax_Config_Data__c> lstConfig = new List<SVMXC__ServiceMax_Config_Data__c>();
        SVMXC__ServiceMax_Config_Data__c configData = new SVMXC__ServiceMax_Config_Data__c();
        configData.SVMXC__Configuration_Type__c = 'HEADER_UPD_ON_ENTITLEMENT';
        configData.SVMXC__Dispatch_Process__c = process.Id;
        configData.SVMXC__Sequence__c = 1;
        configData.RecordTypeId = ExpressionsSrcUpdate_Rtype.Id;
        lstConfig.add(configData);
        SVMXC__ServiceMax_Config_Data__c configData1 = new SVMXC__ServiceMax_Config_Data__c();
        configData1.SVMXC__Configuration_Type__c = 'HEADER_UPD_ON_ROUTE_CALC';
        configData1.SVMXC__Dispatch_Process__c = process.Id;
        configData1.SVMXC__Sequence__c = 2;
        configData1.RecordTypeId = ExpressionsSrcUpdate_Rtype.Id;
        lstConfig.add(configData1);
        SVMXC__ServiceMax_Config_Data__c configData2 = new SVMXC__ServiceMax_Config_Data__c();
        configData2.SVMXC__Configuration_Type__c = 'HEADER_UPD_ON_RMA_GENERATION';
        configData2.SVMXC__Dispatch_Process__c = process.Id;
        configData2.SVMXC__Sequence__c = 3;
        configData2.RecordTypeId = ExpressionsSrcUpdate_Rtype.Id;
        lstConfig.add(configData2);
        SVMXC__ServiceMax_Config_Data__c configData3 = new SVMXC__ServiceMax_Config_Data__c();
        configData3.SVMXC__Configuration_Type__c = 'LINE_UPD_ON_ENTITLEMENT';
        configData3.SVMXC__Dispatch_Process__c = process.Id;
        configData3.SVMXC__Sequence__c = 1;
        configData3.RecordTypeId = ExpressionsSrcUpdate_Rtype.Id;
        lstConfig.add(configData3);
        SVMXC__ServiceMax_Config_Data__c configData4 = new SVMXC__ServiceMax_Config_Data__c();
        configData4.SVMXC__Configuration_Type__c = 'LINE_UPD_ON_ROUTE_CALC';
        configData4.SVMXC__Sequence__c = 2;
        configData4.SVMXC__Dispatch_Process__c = process.Id;
        configData4.RecordTypeId = ExpressionsSrcUpdate_Rtype.Id;
        lstConfig.add(configData4);
        SVMXC__ServiceMax_Config_Data__c configData5 = new SVMXC__ServiceMax_Config_Data__c();
        configData5.SVMXC__Configuration_Type__c = 'LINE_UPD_ON_RMA_GENERATION';
        configData5.SVMXC__Sequence__c = 3;
        configData5.SVMXC__Dispatch_Process__c = process.Id;
        configData5.RecordTypeId = ExpressionsSrcUpdate_Rtype.Id;
        lstConfig.add(configData5);
        insert lstConfig;
        
        System.currentPageReference().getParameters().put('SVMX_Mode', 'Edit');
        System.currentPageReference().getParameters().put('SVMX_RecordId', process.Id);
        
        initRetProces = new CONF_SetupInitiateReturn();
        initRetProces.quickSave();
        initRetProces.saveClose();
        initRetProces.cancel();
        initRetProces.GeneralInfo();
        initRetProces.EntitleConfig();
        initRetProces.RouteCalcConfig();
        initRetProces.RMAConfig();
        initRetProces.srcUpdate();
        initRetProces.srcUpdateLineADDRow();
        initRetProces.srcUpdateLineDeleteRow();
        initRetProces.srcUpdateHdrADDRow();
        initRetProces.srcUpdateHdrDeleteRow();
        initRetProces.HdrADDRowRouteCalcLine();
        initRetProces.HdrDeleteRowRouteCalcLine();
        initRetProces.HdrADDRowRouteCalc();
        initRetProces.HdrDeleteRowRouteCalc();
        initRetProces.HdrADDRowEntitleLine();
        initRetProces.HdrDeleteRowEntitleLine();
        initRetProces.HdrADDRowEntitle();
        initRetProces.HdrDeleteRowEntitle();
        initRetProces.HdrADDRowInitRetLine();
        initRetProces.HdrDeleteRowInitRetLine();
        initRetProces.HdrADDRowInitRet();
        initRetProces.HdrDeleteRowInitRet();
        initRetProces.NewCriteriaRouteCalcLineExp();
        initRetProces.EditCriteriaRouteCalcLineExp();
        initRetProces.onChngRouteCalcLineExp();
        initRetProces.NewCriteriaRouteCalcParentExp();
        initRetProces.EditCriteriaRouteCalcParentExp();
        initRetProces.onChngRouteCalcParentExp();
        initRetProces.NewCriteriaEntitleLineExp();
        initRetProces.EditCriteriaEntitleLineExp();
        initRetProces.onChngEntitleLineExp();
        initRetProces.NewCriteriaEntitleParentExp();
        initRetProces.EditCriteriaEntitleParentExp();
        initRetProces.onChngEntitleParentExp();
        initRetProces.NewCriteriaInitRetLineExp();
        initRetProces.EditCriteriaInitRetLineExp();
        initRetProces.onChngInitRetLineExp();
        initRetProces.NewCriteriaInitRetParentExp();
        initRetProces.EditCriteriaInitRetParentExp();
        initRetProces.onChngInitRetParentExp();
        initRetProces.onChngRouteCalc();
        initRetProces.onChngEntitle();
        
        string str = initRetProces.getdelIndex();
        initRetProces.setdelIndex(str);
        List<SelectOption> lstField = initRetProces.getlstCriteriaInitRet();
        initRetProces.setlstCriteriaInitRet(lstField);
        lstField = initRetProces.getlstCriteriaInitRetLine();
        initRetProces.setlstCriteriaInitRetLine(lstField);
        lstField = initRetProces.getlstObjMapCase();
        initRetProces.setlstObjMapCase(lstField);
        lstField = initRetProces.getlstObjMapCaseLine();
        initRetProces.setlstObjMapCaseLine(lstField);
        lstField = initRetProces.getHdrfldlist();
        lstField = initRetProces.getLinefldList();
        lstField = initRetProces.getOperatorSelectLst();
        lstField = initRetProces.getlstUpdateOperator();
        initRetProces.setlstUpdateOperator(lstField);
        lstField = initRetProces.getlstLoc();
        initRetProces.setlstLoc(lstField);
        lstField = initRetProces.getlstFldUpdCaseWhen();
        initRetProces.setlstFldUpdCaseWhen(lstField);
        lstField = initRetProces.getlstFldUpdCaseLineWhen();
        initRetProces.setlstFldUpdCaseLineWhen(lstField);
        SFM_WrapperDef.SFM_Expression sfmExp = initRetProces.getExpParentInitRet();
        initRetProces.setExpParentInitRet(sfmExp);
        sfmExp = initRetProces.getExpLineInitRet();
        initRetProces.setExpLineInitRet(sfmExp);
        sfmExp = initRetProces.getExpParentEntitle();
        initRetProces.setExpParentEntitle(sfmExp);
        sfmExp = initRetProces.getExpLineEntitle();
        initRetProces.setExpLineEntitle(sfmExp);
        sfmExp = initRetProces.getExpParentRouteCalc();
        initRetProces.setExpParentRouteCalc(sfmExp);
        sfmExp = initRetProces.getExpLineRouteCalc();
        initRetProces.setExpLineRouteCalc(sfmExp);
        sfmExp = initRetProces.getExp();
        initRetProces.setExp(sfmExp);
        str = initRetProces.getsavedExpressionResultId();
        initRetProces.setsavedExpressionResultId(str);
        Integer i = initRetProces.getParentInitRetExpDetailSize();
        i = initRetProces.getLineInitRetExpDetailSize();
        i = initRetProces.getParentEntitleExpDetailSize();
        i = initRetProces.getLineEntitleExpDetailSize();
        i = initRetProces.getParentRouteCalcExpDetailSize();
        i = initRetProces.getLineRouteCalcExpDetailSize();
        i = initRetProces.getSrcUpdateHdrSize();
        i = initRetProces.getsrcUpdateLineSize();
        SVMXC__ServiceMax_Processes__c pro = initRetProces.getInitRetProces();
        initRetProces.setInitRetProces(pro);
        List<SVMXC__ServiceMax_Config_Data__c> lst = initRetProces.getsrcUpdateHdr();
        initRetProces.setsrcUpdateHdr(lst);
        lst = initRetProces.getsrcUpdateLine();
        initRetProces.setsrcUpdateLine(lst);
        List<SVMXC__SFM_Event__c> lstSfmEv = initRetProces.getlstSFMEvent();
        initRetProces.setlstSFMEvent(lstSfmEv);
        
        
        initRetProces.getTAG001();
        initRetProces.getTAG002();
        initRetProces.getTAG003();
        initRetProces.getTAG004();
        initRetProces.getTAG005();
        initRetProces.getTAG006();
        initRetProces.getTAG007();
        initRetProces.getTAG008();
        initRetProces.getTAG009();
        initRetProces.getTAG010();
        initRetProces.getTAG011();
        initRetProces.getTAG012();
        initRetProces.getTAG013();
        initRetProces.getTAG014();
        initRetProces.getTAG015();
        initRetProces.getTAG016();
        initRetProces.getTAG017();
        initRetProces.getTAG018();
        initRetProces.getTAG019();
        initRetProces.getTAG020();
        initRetProces.getTAG021();
        initRetProces.getTAG022();
        initRetProces.getTAG023();
        initRetProces.getTAG024();
        initRetProces.getTAG025();
        initRetProces.getTAG026();
        initRetProces.getTAG027();
        initRetProces.getTAG028();
        initRetProces.getTAG029();
        initRetProces.getTAG030();
        initRetProces.getTAG031();
        initRetProces.getTAG032();
        initRetProces.getTAG033();
        initRetProces.getTAG034();
        initRetProces.getTAG035();
        initRetProces.getTAG036();
        initRetProces.getTAG037();
        initRetProces.getTAG038();
        initRetProces.getTAG039();
        initRetProces.getTAG040();
        initRetProces.getTAG041();
        initRetProces.getTAG042();
        initRetProces.getTAG043();
        initRetProces.getTAG044();
        initRetProces.getTAG045();
        initRetProces.getTAG046();
        initRetProces.getTAG047();
        initRetProces.getTAG048();
        initRetProces.getTAG049();
        initRetProces.getTAG050();
        initRetProces.getTAG051();
        initRetProces.getTAG052();
        initRetProces.getTAG053();
        initRetProces.getTAG054();
        initRetProces.getTAG055();
        initRetProces.getTAG056();
        initRetProces.getTAG057();
        initRetProces.getTAG058();
        initRetProces.getTAG059();
        initRetProces.getTAG073();
        initRetProces.getTAG075();
        initRetProces.getTAG076();
        initRetProces.getTAG077();
        initRetProces.getTAG078();
        initRetProces.getTAG079();
        initRetProces.getTAG080();
        initRetProces.getTAG083();
        initRetProces.getTAG087();
        initRetProces.getTAG088();
        initRetProces.getHLPURL();
        initRetProces.getHLPTITLE();
        
        // Ramachandra. move to dev.
        initRetProces.retrieveExpDetails('A+B');
        initRetProces.fillingSFMEvent( 'namespace', 'clas', 'methd', 'descr', 'eventTyp' );
        initRetProces.submitExp();
    }
}