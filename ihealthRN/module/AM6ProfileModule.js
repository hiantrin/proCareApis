'use strict';


var {NativeModules} = require('react-native');

var RCTModule = NativeModules.AM6ProfileModule

/**
 * @module AM6ProfileModule
 */
module.exports = {
 
  Action_getDeviceInfoAndSetTime: RCTModule.Action_getDeviceInfoAndSetTime,
  GetDeviceInfo_Battery: RCTModule.GetDeviceInfo_Battery,
  GetDeviceInfo_Hardware_Version: RCTModule.GetDeviceInfo_Hardware_Version,
  GetDeviceInfo_SDK_Version: RCTModule.GetDeviceInfo_SDK_Version,
  GetDeviceInfo_Firmware_Version: RCTModule.GetDeviceInfo_Firmware_Version,
  GetDeviceInfo_Bind_Status: RCTModule.GetDeviceInfo_Bind_Status,
  GetDeviceInfo_MTU: RCTModule.GetDeviceInfo_MTU,
  GetDeviceInfo_Charge: RCTModule.GetDeviceInfo_Charge,

  Action_SetUserInfo: RCTModule.Action_SetUserInfo,
  SetUser_Result: RCTModule.SetUser_Result,

  Action_Ble_ConnectionUpdate: RCTModule.Action_Ble_ConnectionUpdate,
  Action_SetPhonePlatform: RCTModule.Action_SetPhonePlatform,

  Action_NotifyMessage: RCTModule.Action_NotifyMessage,
  NotifyMessage_Result: RCTModule.NotifyMessage_Result,

  Action_RejectCall: RCTModule.Action_RejectCall,
  RejectCall_Result: RCTModule.RejectCall_Result,
  
  Action_FindDevice: RCTModule.Action_FindDevice,
  FindDevice_Status: RCTModule.FindDevice_Status,

  Action_FindPhone: RCTModule.Action_FindPhone,
  FindPhone_Status: RCTModule.FindPhone_Status,

  Action_AppExitBackground: RCTModule.Action_AppExitBackground,

  Action_GetTime: RCTModule.Action_GetTime,
  GetTime_Time: RCTModule.GetTime_Time,
  GetTime_Time_Format: RCTModule.GetTime_Time_Format,

  Action_SetTargetReminder: RCTModule.Action_SetTargetReminder,
  SetTargetReminder_Result: RCTModule.SetTargetReminder_Result,

  Action_GetTargetReminder: RCTModule.Action_GetTargetReminder,
  GetTargetReminder_Result: RCTModule.GetTargetReminder_Result,
  GetTargetReminder_Enable: RCTModule.GetTargetReminder_Enable,
  GetTargetReminder_Calorie: RCTModule.GetTargetReminder_Calorie,
  GetTargetReminder_Step: RCTModule.GetTargetReminder_Step,

  Action_SetSedentaryReminder: RCTModule.Action_SetSedentaryReminder,
  SetSedentaryReminder_Result: RCTModule.SetSedentaryReminder_Result,

  Action_GetSedentaryReminder: RCTModule.Action_GetSedentaryReminder,
  GetSedentaryReminder_Result: RCTModule.GetSedentaryReminder_Result,
  GetSedentaryReminder_Enable: RCTModule.GetSedentaryReminder_Enable,
  GetSedentaryReminder_StartTime: RCTModule.GetSedentaryReminder_StartTime,
  GetSedentaryReminder_EndTime: RCTModule.GetSedentaryReminder_EndTime,

  Action_SetRaiseToLight: RCTModule.Action_SetRaiseToLight,
  SetRaiseToLight_Result: RCTModule.SetRaiseToLight_Result,

  Action_GetRaiseToLight: RCTModule.Action_GetRaiseToLight,
  GetRaiseToLight_Result: RCTModule.GetRaiseToLight_Result,
  GetRaiseToLight_Enable: RCTModule.GetRaiseToLight_Enable,
  GetRaiseToLight_StartTime: RCTModule.GetRaiseToLight_StartTime,
  GetRaiseToLight_EndTime: RCTModule.GetRaiseToLight_EndTime,

  Action_SetDoNotDisturb: RCTModule.Action_SetDoNotDisturb,
  SetDoNotDisturb_Result: RCTModule.SetDoNotDisturb_Result,

  Action_GetDoNotDisturb: RCTModule.Action_GetDoNotDisturb,
  GetDoNotDisturb_Result: RCTModule.GetDoNotDisturb_Result,
  GetDoNotDisturb_Enable: RCTModule.GetDoNotDisturb_Enable,
  GetDoNotDisturb_StartTime: RCTModule.GetDoNotDisturb_StartTime,
  GetDoNotDisturb_EndTime: RCTModule.GetDoNotDisturb_EndTime,

  Action_SetWearHand: RCTModule.Action_SetWearHand,
  SetWearHand_Result: RCTModule.SetWearHand_Result,

  Action_GetWearHand: RCTModule.Action_GetWearHand,
  GetWearHand_Result: RCTModule.GetWearHand_Result,
  GetWearHand_Hand: RCTModule.GetWearHand_Hand,

  Action_GetAlarmClockList: RCTModule.Action_GetAlarmClockList,
  GetAlarmClockList_List: RCTModule.GetAlarmClockList_List,
  GetAlarmClockList_Status: RCTModule.GetAlarmClockList_Status,
  GetAlarmClockList_Enable: RCTModule.GetAlarmClockList_Enable,
  GetAlarmClockList_Time: RCTModule.GetAlarmClockList_Time,
  GetAlarmClockList_Week: RCTModule.GetAlarmClockList_Week,

  Action_SetAlarmClockList: RCTModule.Action_SetAlarmClockList,
  SetAlarmClockList_Status: RCTModule.SetAlarmClockList_Status,

  Action_StartBind: RCTModule.Action_StartBind,
  Action_BindUserSuccess: RCTModule.Action_BindUserSuccess,
  Action_BindUserFail: RCTModule.Action_BindUserFail,
  Action_UnbindUser: RCTModule.Action_UnbindUser,
  UnbindUser_Status: RCTModule.UnbindUser_Status,

  Action_GetDailyData: RCTModule.Action_GetDailyData,
  GetDailyData_Date: RCTModule.GetDailyData_Date,
  GetDailyData_Step: RCTModule.GetDailyData_Step,
  GetDailyData_Calorie: RCTModule.GetDailyData_Calorie,
  GetDailyData_BloodOxygen: RCTModule.GetDailyData_BloodOxygen,
  GetDailyData_HeartRate: RCTModule.GetDailyData_HeartRate,
  GetDailyData_MinHeartRate: RCTModule.GetDailyData_MinHeartRate,
  GetDailyData_MaxHeartRate: RCTModule.GetDailyData_MaxHeartRate,
  GetDailyData_MeanHeartRate: RCTModule.GetDailyData_MeanHeartRate,
  GetDailyData_RestHeartRate: RCTModule.GetDailyData_RestHeartRate,
  GetDailyData_MinHeartRateTime: RCTModule.GetDailyData_MinHeartRateTime,
  GetDailyData_MaxHeartRateTime: RCTModule.GetDailyData_MaxHeartRateTime,
  GetDailyData_EffectiveStand: RCTModule.GetDailyData_EffectiveStand,
  
  Action_GetStepData: RCTModule.Action_GetStepData,
  GetStepData_Date: RCTModule.GetStepData_Date,
  GetStepData_List: RCTModule.GetStepData_List,
  GetStepData_Step: RCTModule.GetStepData_Step,
  GetStepData_Calorie: RCTModule.GetStepData_Calorie,
  GetStepData_Distance: RCTModule.GetStepData_Distance,

  Action_GetSleepData: RCTModule.Action_GetSleepData,
  GetSleepData_Date: RCTModule.GetSleepData_Date,
  GetSleepData_List: RCTModule.GetSleepData_List,
  GetSleepData_Mode: RCTModule.GetSleepData_Mode,
  GetSleepData_Mode_Date: RCTModule.GetSleepData_Mode_Date,

  Action_GetHeartRateData: RCTModule.Action_GetHeartRateData,
  GetHeartRateData_Date: RCTModule.GetHeartRateData_Date,
  GetHeartRateData_List: RCTModule.GetHeartRateData_List,
  GetHeartRateData_HeartRate: RCTModule.GetHeartRateData_HeartRate,
  
  Action_GetBloodOxygenData: RCTModule.Action_GetBloodOxygenData,
  GetBloodOxygenData_List: RCTModule.GetBloodOxygenData_List,
  GetBloodOxygenData_Date: RCTModule.GetBloodOxygenData_Date,
 GetBloodOxygenData_BloodOxygen: RCTModule.GetBloodOxygenData_BloodOxygen,

  Action_GetActivityData: RCTModule.Action_GetActivityData,
  GetActivityData_Date: RCTModule.GetActivityData_Date,

  GetActivityData_Point: RCTModule.GetActivityData_Point,
  GetActivityDataPoint_Date: RCTModule.GetActivityDataPoint_Date,
  GetActivityDataPoint_Calorie: RCTModule.GetActivityDataPoint_Calorie,
  GetActivityDataPoint_Step: RCTModule.GetActivityDataPoint_Step,
  GetActivityDataPoint_HeartRate: RCTModule.GetActivityDataPoint_HeartRate,
  GetActivityDataPoint_Distance: RCTModule.GetActivityDataPoint_Distance,

  GetActivityData_Report: RCTModule.GetActivityData_Report,
  GetActivityData_AnaerobicTime: RCTModule.GetActivityData_AnaerobicTime,
  GetActivityData_AveHeartRate: RCTModule.GetActivityData_AveHeartRate,
  GetActivityData_BodyEnergyCost: RCTModule.GetActivityData_BodyEnergyCost,
  GetActivityData_CardioTime: RCTModule.GetActivityData_CardioTime,
  GetActivityData_DataType: RCTModule.GetActivityData_DataType,
  GetActivityData_EndDate: RCTModule.GetActivityData_EndDate,
  GetActivityData_EstimatedRecoveryTime: RCTModule.GetActivityData_EstimatedRecoveryTime,
  GetActivityData_FatReductionTime: RCTModule.GetActivityData_FatReductionTime,
  GetActivityData_MaxHeartRate: RCTModule.GetActivityData_MaxHeartRate,
  GetActivityData_MaxOxygenUptake: RCTModule.GetActivityData_MaxOxygenUptake,
  GetActivityData_MaxPace: RCTModule.GetActivityData_MaxPace,
  GetActivityData_MaxStepFrequency: RCTModule.GetActivityData_MaxStepFrequency,
  GetActivityData_MinHeartRate: RCTModule.GetActivityData_MinHeartRate,
  GetActivityData_MinPace: RCTModule.GetActivityData_MinPace,
  GetActivityData_PeakTime: RCTModule.GetActivityData_PeakTime,
  GetActivityData_StartDate: RCTModule.GetActivityData_StartDate,
  GetActivityData_TimeZone: RCTModule.GetActivityData_TimeZone,
  GetActivityData_TotalCalorie: RCTModule.GetActivityData_TotalCalorie,
  GetActivityData_TotalDistance: RCTModule.GetActivityData_TotalDistance,
  GetActivityData_TotalStep: RCTModule.GetActivityData_TotalStep,
  GetActivityData_TotalTime: RCTModule.GetActivityData_TotalTime,
  GetActivityData_TrainingEffect: RCTModule.GetActivityData_TrainingEffect,
  GetActivityData_Type: RCTModule.GetActivityData_Type,
  GetActivityData_TypeDescription: RCTModule.GetActivityData_TypeDescription,
  GetActivityData_Version: RCTModule.GetActivityData_Version,
  GetActivityData_WarmUpTime: RCTModule.GetActivityData_WarmUpTime,

  Action_ReadySyncData: RCTModule.Action_ReadySyncData,
  ReadySyncData_Status: RCTModule.ReadySyncData_Status,

  Action_DeleteData: RCTModule.Action_DeleteData,
  DeleteData_Result: RCTModule.DeleteData_Result,

  Action_RequestSyncData: RCTModule.Action_RequestSyncData,


}
