//
//  AM6ProfileModule.h
//  ReactNativeIOSLibrary
//
//  Created by Spring on 2023/8/28.
//

#import <Foundation/Foundation.h>
#if __has_include(<React/RCTAssert.h>)
#import <React/RCTEventDispatcher.h>
#else
#import <React/RCTEventDispatcher.h>
#endif

@interface AM6ProfileModule : NSObject<RCTBridgeModule>

#define AM6_EVENT_NOTIFY @"event_notify_am6"

#define AM6_ACTION @"action"

#define AM6_TYPE @"type"

#define AM6_DEVICE @"devices"

#define AM6_KEY_MAC @"mac"

#define kACTION_GET_ALL_CONNECTED_DEVICES   @"action_get_all_connected_devices"


//getDeviceInfoAndSetTime
#define ACTION_GET_DEVICE_INFO @"am6_action_getDeviceInfoAndSetTime"

#define AM6_GETDEVICEINFO_KEY_BATTERY @"am6_getDeviceInfo_battery"

#define AM6_GETDEVICEINFO_KEY_BIND_STATUS @"am6_getDeviceInfo_bind_status"

#define AM6_GETDEVICEINFO_KEY_CHARGE @"am6_getDeviceInfo_charge"

#define AM6_GETDEVICEINFO_KEY_FIRMWARE @"am6_getDeviceInfo_firmware_version"

#define AM6_GETDEVICEINFO_KEY_HARDWARE @"am6_getDeviceInfo_hardware_version"

#define AM6_GETDEVICEINFO_KEY_VERSION @"am6_getDeviceInfo_sdk_version"


#define ACTION_SET_USER @"am6_action_setUser"

#define AM6_SET_USERINFO_RESULT @"am6_setUser_result"

#define ACTION_SET_PHONEPLATFORM @"am6_action_setPhonePlatform"

#define ACTION_FIND_DEVICE @"am6_action_findDevice"
#define AM6_FIND_DEVICE_STATUS @"am6_findDevice_status"

#define ACTION_FIND_PHONE @"am6_action_findPhone"
#define AM6_FIND_PHONE_STATUS @"am6_findPhone_status"

#define ACTION_REBOOT_DEVICE @"am6_action_rebootDevice"

#define ACTION_GET_TIME @"am6_action_getTime"
#define AM6_GET_TIME @"am6_getTime_time"
#define AM6_TIME_FORMAT @"am6_getTime_time_format"

#define ACTION_SET_REMINDER @"am6_action_setTargetReminder"
#define AM6_SET_REMINDER_RESULT @"am6_setTargetReminder_result"

#define ACTION_GET_REMINDER @"am6_action_getTargetReminder"
#define AM6_GET_REMINDER_CALORIE @"am6_getTargetReminder_calorie"
#define AM6_GET_REMINDER_ENABLE @"am6_getTargetReminder_enable"
#define AM6_GET_REMINDER_RESULT @"am6_getTargetReminder_result"
#define AM6_GET_REMINDER_STEP @"am6_getTargetReminder_step"

#define ACTION_SET_SENDENTARY @"am6_action_setSedentaryReminder"
#define AM6_SET_SENDENTARY_RESULT @"am6_setSedentaryReminder_result"

#define ACTION_GET_SENDENTARY @"am6_action_getSedentaryReminder"
#define AM6_GET_SENDENTARY_ENDTIME @"am6_getSedentaryReminder_endTime"
#define AM6_GET_SENDENTARY_ENABLE @"am6_getSedentaryReminder_enable"
#define AM6_GET_SENDENTARY_RESULT @"am6_getSedentaryReminder_result"
#define AM6_GET_SENDENTARY_STARTTIME @"am6_getSedentaryReminder_startTime"

#define ACTION_SET_RAISE @"am6_action_setRaiseToLight"
#define AM6_SET_RAISE_RESULT @"am6_setRaiseToLight_result"

#define ACTION_GET_RAISE @"am6_action_getRaiseToLight"
#define AM6_GET_RAISE_ENDTIME @"am6_getRaiseToLight_endTime"
#define AM6_GET_RAISE_ENABLE @"am6_getRaiseToLight_enable"
#define AM6_GET_RAISE_RESULT @"am6_getRaiseToLight_result"
#define AM6_GET_RAISE_STARTTIME @"am6_getRaiseToLight_startTime"

#define ACTION_SET_DONOTDISTURB @"am6_action_setDoNotDisturb"
#define AM6_SET_DONOTDISTURB_RESULT @"am6_setDoNotDisturb_result"

#define ACTION_GET_DONOTDISTURB @"am6_action_getDoNotDisturb"
#define AM6_GET_DONOTDISTURB_ENDTIME @"am6_getDoNotDisturb_endTime"
#define AM6_GET_DONOTDISTURB_ENABLE @"am6_getDoNotDisturb_enable"
#define AM6_GET_DONOTDISTURB_RESULT @"am6_getDoNotDisturb_result"
#define AM6_GET_DONOTDISTURB_STARTTIME @"am6_getDoNotDisturb_startTime"

#define ACTION_SET_WEARHAND @"am6_action_setWearHand"
#define AM6_SET_WEARHAND_RESULT @"am6_setWearHand_result"

#define ACTION_GET_WEARHAND @"am6_action_getWearHand"
#define AM6_GET_WEARHAND_HAND @"am6_getWearHand_hand"
#define AM6_GET_WEARHAND_RESULT @"am6_getWearHand_result"

#define ACTION_SET_ALARMLIST @"am6_action_setAlarmClockList"
#define AM6_SET_ALARMLIST_LIST @"am6_setAlarmClockList_Status"

#define ACTION_GET_ALARMLIST @"am6_action_getAlarmClockList"
#define AM6_GET_ALARMLIST_LIST @"am6_getAlarmClockList_list"
#define AM6_GET_ALARMLIST_ENABLE @"am6_getAlarmClockList_enable"
#define AM6_GET_ALARMLIST_TIME @"am6_getAlarmClockList_time"
#define AM6_GET_ALARMLIST_WEEK @"am6_getAlarmClockList_week"
#define AM6_GET_ALARMLIST_STATUS @"am6_getAlarmClockList_status"



#define ACTION_SET_STARTBIND @"am6_action_startBind"

#define ACTION_SET_BINDSUCCESS @"am6_action_bindUserSuccess"

#define ACTION_SET_BINDFAIL @"am6_action_bindUserFail"

#define ACTION_SET_UNBIND @"am6_action_unbindUser"
#define AM6_SET_UNBIND @"am6_unbindUser_status"

#define ACTION_SYNC_READY @"am6_action_readySyncData"
#define AM6_SYNC_STATUS @"am6_readySyncData_status"

#define ACTION_GET_DAILYDATA @"am6_action_getDailyData"
#define AM6_GET_DAILYDATA @"am6_getDailyData"
#define AM6_GET_DAILYDATA_PO @"am6_getDailyData_bloodOxygen"
#define AM6_GET_DAILYDATA_CALORIE @"am6_getDailyData_calorie"
#define AM6_GET_DAILYDATA_DATE @"am6_getDailyData_date"
#define AM6_GET_DAILYDATA_EFFECTIVESTAND @"am6_getDailyData_effectiveStand"
#define AM6_GET_DAILYDATA_HEARTRATE @"am6_getDailyData_heartRate"
#define AM6_GET_DAILYDATA_MAXHEARTRATE @"am6_getDailyData_maxHeartRate"
#define AM6_GET_DAILYDATA_MAXHEARTRATETIME @"am6_getDailyData_maxHeartRateTime"
#define AM6_GET_DAILYDATA_MEANHEARTRATE @"am6_getDailyData_meanHeartRate"
#define AM6_GET_DAILYDATA_MINHEARTRATE @"am6_getDailyData_minHeartRate"
#define AM6_GET_DAILYDATA_MINHEARTRATETIME @"am6_getDailyData_minHeartRateTime"
#define AM6_GET_DAILYDATA_RESTHEARTRATE @"am6_getDailyData_restHeartRate"
#define AM6_GET_DAILYDATA_STEP @"am6_getDailyData_step"

#define ACTION_GET_STEPDATA @"am6_action_getStepData"
#define AM6_GET_STEPDATA @"am6_getStepData"
#define AM6_GET_STEPDATA_LIST @"am6_getStepData_list"
#define AM6_GET_STEPDATA_DISTANCE @"am6_getStepData_distance"
#define AM6_GET_STEPDATA_CALORIE @"am6_getStepData_calorie"
#define AM6_GET_STEPDATA_STEP @"am6_getStepData_step"
#define AM6_GET_STEPDATA_DATE @"am6_getStepData_date"


#define ACTION_GET_SLEEPDATA @"am6_action_getSleepData"
#define AM6_GET_SLEEPDATA @"am6_getSleepData"
#define AM6_GET_SLEEPDATA_LIST @"am6_getSleepData_list"
#define AM6_GET_SLEEPDATA_DATE @"am6_getSleepData_date"
#define AM6_GET_SLEEPDATA_MODE_DATE @"am6_getSleepData_mode_date"
#define AM6_GET_SLEEPDATA_MODE @"am6_getSleepData_mode"

#define ACTION_GET_HEARTRATE @"am6_action_getHeartRateData"
#define AM6_GET_HEARTRATE @"am6_getHeartRateData"
#define AM6_GET_HEARTRATE_LIST @"am6_getHeartRateData_list"
#define AM6_GET_HEARTRATE_HEARTRATE @"am6_getHeartRateData_heartRate"
#define AM6_GET_HEARTRATE_DATE @"am6_getHeartRateData_date"

#define ACTION_GET_BLOODOXYGEN @"am6_action_getBloodOxygenData"
#define AM6_GET_BLOODOXYGEN @"am6_getBloodOxygenData"
#define AM6_GET_BLOODOXYGEN_BLOODOXYGEN @"am6_getBloodOxygenData_bloodOxygen"
#define AM6_GET_BLOODOXYGEN_DATE @"am6_getBloodOxygenData_date"

#define ACTION_GET_ACTIVITY @"am6_action_getActivityData"
#define AM6_GET_ACTIVITY @"am6_getActivityData"
#define AM6_GET_ACTIVITY_REPORT @"am6_getActivityData_report"
#define AM6_GET_ACTIVITY_ANAEROBICTIME @"am6_getActivityData_anaerobicTime"
#define AM6_GET_ACTIVITY_AVEHEARTRATE @"am6_getActivityData_aveHeartRate"
#define AM6_GET_ACTIVITY_BODYENERGYCOST @"am6_getActivityData_bodyEnergyCost"
#define AM6_GET_ACTIVITY_CARDIOTIME @"am6_getActivityData_cardioTime"
#define AM6_GET_ACTIVITY_ENDDATE @"am6_getActivityData_endDate"
#define AM6_GET_ACTIVITY_ESTIMATED @"am6_getActivityData_estimatedRecoveryTime"
#define AM6_GET_ACTIVITY_FATREDTIME @"am6_getActivityData_fatReductionTime"
#define AM6_GET_ACTIVITY_MAXHEARTRATE @"am6_getActivityData_maxHeartRate"
#define AM6_GET_ACTIVITY_MAXOX @"am6_getActivityData_maxOxygenUptake"
#define AM6_GET_ACTIVITY_MAXPACE @"am6_getActivityData_maxPace"
#define AM6_GET_ACTIVITY_MAXSF @"am6_getActivityData_maxStepFrequency"
#define AM6_GET_ACTIVITY_MINHEARTRATE @"am6_getActivityData_minHeartRate"
#define AM6_GET_ACTIVITY_MINPACE @"am6_getActivityData_minPace"
#define AM6_GET_ACTIVITY_PEAKTIME @"am6_getActivityData_peakTime"
#define AM6_GET_ACTIVITY_STARTDATE @"am6_getActivityData_startDate"
#define AM6_GET_ACTIVITY_TOTLECALORIE @"am6_getActivityData_totalCalorie"
#define AM6_GET_ACTIVITY_TOTLEDISTANCE @"am6_getActivityData_totalDistance"
#define AM6_GET_ACTIVITY_TOTLESTEP @"am6_getActivityData_totalStep"
#define AM6_GET_ACTIVITY_TOTLETIME @"am6_getActivityData_totalTime"
#define AM6_GET_ACTIVITY_TRAININGEF @"am6_getActivityData_trainingEffect"
#define AM6_GET_ACTIVITY_WARMUPTIME @"am6_getActivityData_warmUpTime"

#define AM6_GET_ACTIVITY_DATE @"am6_getActivityData_date"

#define AM6_GET_ACTIVITYPOINT_DATE @"am6_getActivityDataPoint_Date"
#define AM6_GET_ACTIVITYPOINT_CALORIE @"am6_getActivityDataPoint_calorie"
#define AM6_GET_ACTIVITYPOINT_DISTANCE @"am6_getActivityDataPoint_distance"
#define AM6_GET_ACTIVITYPOINT_HEARTRATE @"am6_getActivityDataPoint_heartRate"
#define AM6_GET_ACTIVITYPOINT_STEP @"am6_getActivityDataPoint_step"
#define AM6_GET_ACTIVITYPOINT @"am6_getActivityData_point"


#define ACTION_DELETEDATA @"am6_action_deleteData"
#define AM6_DELETEDATA_RESULT @"am6_deleteData_result"

#define AM6_DISCONNECT_DEVICE @"am6_disconnect_device"

#define ACTION_ERROR_AM6                  @"action_error"

#define ERROR_NUM_AM6                   @"error_num"

#define ERROR_DESCRIPTION_AM6                   @"description"

#define ACTION_DISCONNECT_AM6                  @"disconnect"




+ (void)sendErrorToBridge:(RCTBridge *)bridge eventNotify:(NSString*)eventNotify WithCode:(NSInteger)errorCode mac:(NSString*)mac;

+ (NSData *)md5:(NSString *)hashString;

+(void)sendNoDevice:(RCTBridge *)bridge;
@end

