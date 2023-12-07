package com.ihealth.ihealthlibrary;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.module.annotations.ReactModule;
import com.ihealth.communication.control.Am6Profile;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Nullable;

@ReactModule(name = "AM6ProfileModule")
public class AM6ProfileModule extends ReactContextBaseJavaModule {

    private static final String modelName = "AM6ProfileModule";
    private static final String TAG = "AM6ProfileModule";

    public AM6ProfileModule(ReactApplicationContext reactContext) {
        super(reactContext);
    }

    @Override
    public String getName() {
        return modelName;
    }

    @Nullable
    @Override
    public Map<String, Object> getConstants() {
        Map<String, Object> constants = new HashMap<>();
        constants.put("Action_getDeviceInfoAndSetTime", Am6Profile.Action_getDeviceInfoAndSetTime);
        constants.put("GetDeviceInfo_Battery", Am6Profile.GetDeviceInfo_Battery);
        constants.put("GetDeviceInfo_Hardware_Version", Am6Profile.GetDeviceInfo_Hardware_Version);
        constants.put("GetDeviceInfo_SDK_Version", Am6Profile.GetDeviceInfo_SDK_Version);
        constants.put("GetDeviceInfo_Firmware_Version", Am6Profile.GetDeviceInfo_Firmware_Version);
        constants.put("GetDeviceInfo_Bind_Status", Am6Profile.GetDeviceInfo_Bind_Status);
        constants.put("GetDeviceInfo_MTU", Am6Profile.GetDeviceInfo_MTU);
        constants.put("GetDeviceInfo_Charge", Am6Profile.GetDeviceInfo_Charge);

        constants.put("Action_SetUserInfo", Am6Profile.Action_SetUserInfo);
        constants.put("SetUser_Result", Am6Profile.SetUser_Result);

        constants.put("Action_Ble_ConnectionUpdate", Am6Profile.Action_Ble_ConnectionUpdate);
        constants.put("Action_SetPhonePlatform", Am6Profile.Action_SetPhonePlatform);

        constants.put("Action_NotifyMessage", Am6Profile.Action_NotifyMessage);
        constants.put("NotifyMessage_Result", Am6Profile.NotifyMessage_Result);

        constants.put("Action_RejectCall", Am6Profile.Action_RejectCall);
        
        constants.put("Action_FindDevice", Am6Profile.Action_FindDevice);
        constants.put("FindDevice_Status", Am6Profile.FindDevice_Status);

        constants.put("Action_FindPhone", Am6Profile.Action_FindPhone);
        constants.put("FindPhone_Status", Am6Profile.FindPhone_Status);

        constants.put("Action_AppExitBackground", Am6Profile.Action_AppExitBackground);

        constants.put("Action_GetTime", Am6Profile.Action_GetTime);
        constants.put("GetTime_Time", Am6Profile.GetTime_Time);
        constants.put("GetTime_Time_Format", Am6Profile.GetTime_Time_Format);

        constants.put("Action_SetTargetReminder", Am6Profile.Action_SetTargetReminder);
        constants.put("SetTargetReminder_Result", Am6Profile.SetTargetReminder_Result);

        constants.put("Action_GetTargetReminder", Am6Profile.Action_GetTargetReminder);
        constants.put("GetTargetReminder_Result", Am6Profile.GetTargetReminder_Result);
        constants.put("GetTargetReminder_Enable", Am6Profile.GetTargetReminder_Enable);
        constants.put("GetTargetReminder_Calorie", Am6Profile.GetTargetReminder_Calorie);
        constants.put("GetTargetReminder_Step", Am6Profile.GetTargetReminder_Step);

        constants.put("Action_SetSedentaryReminder", Am6Profile.Action_SetSedentaryReminder);
        constants.put("SetSedentaryReminder_Result", Am6Profile.SetSedentaryReminder_Result);

        constants.put("Action_GetSedentaryReminder", Am6Profile.Action_GetSedentaryReminder);
        constants.put("GetSedentaryReminder_Result", Am6Profile.GetSedentaryReminder_Result);
        constants.put("GetSedentaryReminder_Enable", Am6Profile.GetSedentaryReminder_Enable);
        constants.put("GetSedentaryReminder_StartTime", Am6Profile.GetSedentaryReminder_StartTime);
        constants.put("GetSedentaryReminder_EndTime", Am6Profile.GetSedentaryReminder_EndTime);

        constants.put("Action_SetRaiseToLight", Am6Profile.Action_SetRaiseToLight);
        constants.put("SetRaiseToLight_Result", Am6Profile.SetRaiseToLight_Result);

        constants.put("Action_GetRaiseToLight", Am6Profile.Action_GetRaiseToLight);
        constants.put("GetRaiseToLight_Result", Am6Profile.GetRaiseToLight_Result);
        constants.put("GetRaiseToLight_Enable", Am6Profile.GetRaiseToLight_Enable);
        constants.put("GetRaiseToLight_StartTime", Am6Profile.GetRaiseToLight_StartTime);
        constants.put("GetRaiseToLight_EndTime", Am6Profile.GetRaiseToLight_EndTime);

        constants.put("Action_SetDoNotDisturb", Am6Profile.Action_SetDoNotDisturb);
        constants.put("SetDoNotDisturb_Result", Am6Profile.SetDoNotDisturb_Result);

        constants.put("Action_GetDoNotDisturb", Am6Profile.Action_GetDoNotDisturb);
        constants.put("GetDoNotDisturb_Result", Am6Profile.GetDoNotDisturb_Result);
        constants.put("GetDoNotDisturb_Enable", Am6Profile.GetDoNotDisturb_Enable);
        constants.put("GetDoNotDisturb_StartTime", Am6Profile.GetDoNotDisturb_StartTime);
        constants.put("GetDoNotDisturb_EndTime", Am6Profile.GetDoNotDisturb_EndTime);

        constants.put("Action_SetWearHand", Am6Profile.Action_SetWearHand);
        constants.put("SetWearHand_Result", Am6Profile.SetWearHand_Result);

        constants.put("Action_GetWearHand", Am6Profile.Action_GetWearHand);
        constants.put("GetWearHand_Result", Am6Profile.GetWearHand_Result);
        constants.put("GetWearHand_Hand", Am6Profile.GetWearHand_Hand);

        constants.put("Action_GetAlarmClockList", Am6Profile.Action_GetAlarmClockList);
        constants.put("GetAlarmClockList_List", Am6Profile.GetAlarmClockList_List);
        constants.put("GetAlarmClockList_Status", Am6Profile.GetAlarmClockList_Status);
        constants.put("GetAlarmClockList_Enable", Am6Profile.GetAlarmClockList_Enable);
        constants.put("GetAlarmClockList_Time", Am6Profile.GetAlarmClockList_Time);
        constants.put("GetAlarmClockList_Week", Am6Profile.GetAlarmClockList_Week);

        constants.put("Action_SetAlarmClockList", Am6Profile.Action_SetAlarmClockList);
        constants.put("SetAlarmClockList_Status", Am6Profile.SetAlarmClockList_Status);

        constants.put("Action_StartBind", Am6Profile.Action_StartBind);
        constants.put("Action_BindUserSuccess", Am6Profile.Action_BindUserSuccess);
        constants.put("Action_BindUserFail", Am6Profile.Action_BindUserFail);
        constants.put("Action_UnbindUser", Am6Profile.Action_UnbindUser);
        constants.put("UnbindUser_Status", Am6Profile.UnbindUser_Status);

        constants.put("Action_GetDailyData", Am6Profile.Action_GetDailyData);
        constants.put("GetDailyData_Date", Am6Profile.GetDailyData_Date);
        constants.put("GetDailyData_Step", Am6Profile.GetDailyData_Step);
        constants.put("GetDailyData_Calorie", Am6Profile.GetDailyData_Calorie);
        constants.put("GetDailyData_BloodOxygen", Am6Profile.GetDailyData_BloodOxygen);
        constants.put("GetDailyData_HeartRate", Am6Profile.GetDailyData_HeartRate);
        constants.put("GetDailyData_MinHeartRate", Am6Profile.GetDailyData_MinHeartRate);
        constants.put("GetDailyData_MaxHeartRate", Am6Profile.GetDailyData_MaxHeartRate);
        constants.put("GetDailyData_MeanHeartRate", Am6Profile.GetDailyData_MeanHeartRate);
        constants.put("GetDailyData_RestHeartRate", Am6Profile.GetDailyData_RestHeartRate);
        constants.put("GetDailyData_MinHeartRateTime", Am6Profile.GetDailyData_MinHeartRateTime);
        constants.put("GetDailyData_MaxHeartRateTime", Am6Profile.GetDailyData_MaxHeartRateTime);
        constants.put("GetDailyData_EffectiveStand", Am6Profile.GetDailyData_EffectiveStand);
        
        constants.put("Action_GetStepData", Am6Profile.Action_GetStepData);
        constants.put("GetStepData_Date", Am6Profile.GetStepData_Date);
        constants.put("GetStepData_List", Am6Profile.GetStepData_List);
        constants.put("GetStepData_Step", Am6Profile.GetStepData_Step);
        constants.put("GetStepData_Calorie", Am6Profile.GetStepData_Calorie);
        constants.put("GetStepData_Distance", Am6Profile.GetStepData_Distance);

        constants.put("Action_GetSleepData", Am6Profile.Action_GetSleepData);
        constants.put("GetSleepData_Date", Am6Profile.GetSleepData_Date);
        constants.put("GetSleepData_List", Am6Profile.GetSleepData_List);
        constants.put("GetSleepData_Mode", Am6Profile.GetSleepData_Mode);
        constants.put("GetSleepData_Mode_Date", Am6Profile.GetSleepData_Mode_Date);

        constants.put("Action_GetHeartRateData", Am6Profile.Action_GetHeartRateData);
        constants.put("GetHeartRateData_Date", Am6Profile.GetHeartRateData_Date);
        constants.put("GetHeartRateData_List", Am6Profile.GetHeartRateData_List);
        constants.put("GetHeartRateData_HeartRate", Am6Profile.GetHeartRateData_HeartRate);
        
        constants.put("Action_GetBloodOxygenData", Am6Profile.Action_GetBloodOxygenData);
        constants.put("GetBloodOxygenData_List", Am6Profile.GetBloodOxygenData_List);
        constants.put("GetBloodOxygenData_Date", Am6Profile.GetBloodOxygenData_Date);
        constants.put("GetBloodOxygenData_BloodOxygen", Am6Profile.GetBloodOxygenData_BloodOxygen);

        constants.put("Action_GetActivityData", Am6Profile.Action_GetActivityData);
        constants.put("GetActivityData_Date", Am6Profile.GetActivityData_Date);

        constants.put("GetActivityData_Point", Am6Profile.GetActivityData_Point);
        constants.put("GetActivityDataPoint_Date", Am6Profile.GetActivityDataPoint_Date);
        constants.put("GetActivityDataPoint_Calorie", Am6Profile.GetActivityDataPoint_Calorie);
        constants.put("GetActivityDataPoint_Step", Am6Profile.GetActivityDataPoint_Step);
        constants.put("GetActivityDataPoint_HeartRate", Am6Profile.GetActivityDataPoint_HeartRate);
        constants.put("GetActivityDataPoint_Distance", Am6Profile.GetActivityDataPoint_Distance);

        constants.put("GetActivityData_Report", Am6Profile.GetActivityData_Report);
        constants.put("GetActivityData_AnaerobicTime", Am6Profile.GetActivityData_AnaerobicTime);
        constants.put("GetActivityData_AveHeartRate", Am6Profile.GetActivityData_AveHeartRate);
        constants.put("GetActivityData_BodyEnergyCost", Am6Profile.GetActivityData_BodyEnergyCost);
        constants.put("GetActivityData_CardioTime", Am6Profile.GetActivityData_CardioTime);
        constants.put("GetActivityData_DataType", Am6Profile.GetActivityData_DataType);
        constants.put("GetActivityData_EndDate", Am6Profile.GetActivityData_EndDate);
        constants.put("GetActivityData_EstimatedRecoveryTime", Am6Profile.GetActivityData_EstimatedRecoveryTime);
        constants.put("GetActivityData_FatReductionTime", Am6Profile.GetActivityData_FatReductionTime);
        constants.put("GetActivityData_MaxHeartRate", Am6Profile.GetActivityData_MaxHeartRate);
        constants.put("GetActivityData_MaxOxygenUptake", Am6Profile.GetActivityData_MaxOxygenUptake);
        constants.put("GetActivityData_MaxPace", Am6Profile.GetActivityData_MaxPace);
        constants.put("GetActivityData_MaxStepFrequency", Am6Profile.GetActivityData_MaxStepFrequency);
        constants.put("GetActivityData_MinHeartRate", Am6Profile.GetActivityData_MinHeartRate);
        constants.put("GetActivityData_MinPace", Am6Profile.GetActivityData_MinPace);
        constants.put("GetActivityData_PeakTime", Am6Profile.GetActivityData_PeakTime);
        constants.put("GetActivityData_StartDate", Am6Profile.GetActivityData_StartDate);
        constants.put("GetActivityData_TimeZone", Am6Profile.GetActivityData_TimeZone);
        constants.put("GetActivityData_TotalCalorie", Am6Profile.GetActivityData_TotalCalorie);
        constants.put("GetActivityData_TotalDistance", Am6Profile.GetActivityData_TotalDistance);
        constants.put("GetActivityData_TotalStep", Am6Profile.GetActivityData_TotalStep);
        constants.put("GetActivityData_TotalTime", Am6Profile.GetActivityData_TotalTime);
        constants.put("GetActivityData_TrainingEffect", Am6Profile.GetActivityData_TrainingEffect);
        constants.put("GetActivityData_Type", Am6Profile.GetActivityData_Type);
        constants.put("GetActivityData_TypeDescription", Am6Profile.GetActivityData_TypeDescription);
        constants.put("GetActivityData_Version", Am6Profile.GetActivityData_Version);
        constants.put("GetActivityData_WarmUpTime", Am6Profile.GetActivityData_WarmUpTime);

        constants.put("Action_ReadySyncData", Am6Profile.Action_ReadySyncData);
        constants.put("ReadySyncData_Status", Am6Profile.ReadySyncData_Status);

        constants.put("Action_DeleteData", Am6Profile.Action_DeleteData);
        constants.put("DeleteData_Result", Am6Profile.DeleteData_Result);

        constants.put("Action_RequestSyncData", Am6Profile.Action_RequestSyncData);

        return constants;
    }
}