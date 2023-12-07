//
//  AM5ProfileModule.h
//  ReactNativeIOSLibrary
//
//  Created by daiqingquan on 2016/12/4.
//  Copyright © 2016年 daiqingquan. All rights reserved.
//

#import <Foundation/Foundation.h>
#if __has_include(<React/RCTAssert.h>)
#import <React/RCTBridgeModule.h>
#else
#import <React/RCTBridgeModule.h>
#endif
@interface AM5ProfileModule : NSObject<RCTBridgeModule>


#define kACTION_ERROR              @"ACTION_ERROR"

#define ERROR_NUM   @"ERROR_NUM"

#define ERROR_DESCRIPTION   @"description"

#define kACTION_USER_BIND              @"action_user_bind"

#define kACTION_USER_UNBIND              @"action_user_unbind"

#define kACTION_FUNCTION_SUPPORT              @"ACTION_FUNCTION_SUPPORT"

#define kACTION_BASIC_INFO              @"action_basic_info"

#define MAC_ADDRESS              @"mac"

#define BASIC_BATTSTATUS              @"battStatus"

#define BASIC_DEIVCEID              @"deivceId"

#define BASIC_ENERGE              @"energe"

#define BASIC_FIRMWAREVERSION              @"firmwareVersion"

#define BASIC_MODE              @"mode"

#define BASIC_PAIRFLAG              @"pairFlag"

#define BASIC_REBOOT              @"reboot"

#define kACTION_LIVE_DATA              @"action_live_data"

#define LIVE_DATA_HEARTRATE              @"heartRate"

#define LIVE_DATA_STEP              @"totalStep"

#define LIVE_DATA_DISTANCES              @"totalDistances"

#define LIVE_DATA_ACTIVETIME              @"activeTime"

#define LIVE_DATA_CALORIE              @"calorie"


#define kACTION_ACTIVITY_COUNT              @"action_live_count"

#define kACTION_SET_TIME              @"TIME"

#define kACTION_SET_ALARM              @"action_basic_info"

#define kACTION_SET_GOAL              @"action_basic_info"

#define kACTION_SET_LONG_SIT              @"action_basic_info"

#define kACTION_SET_USER_INFO              @"USER_INFO"

#define kACTION_SET_UNIT              @"UNIT"

#define kACTION_SET_HAND_WEAR_MODE              @"HAND_MODE"

#define kACTION_SET_UP_HAND_GESTURE              @"action_basic_info"

#define kACTION_SET_HEART_RATE_INTERVAL              @"action_basic_info"

#define kACTION_SET_HEART_RATE_MEASURE_MODE              @"action_basic_info"

#define kACTION_SET_ONE_KEY_RESET              @"action_basic_info"

#define kACTION_SET_NOT_DISTURB              @"action_basic_info"

#define kACTION_SET_SPORT_MODE              @"action_basic_info"

#define OPERATION_RESULT              @"action_basic_info"

#define OPERATION_ACTION              @"action_basic_info"

#define kACTION_NOTICE_COMMING_CALL              @"action_basic_info"

#define kACTION_NOTICE_COMMING_CALL_STOP              @"action_basic_info"

#define kACTION_NOTICE_NEW_MESSAGE              @"action_basic_info"

#define kACTION_SYNC_ACTIVITY              @"action_basic_info"

#define kACTION_SYNC_ACTIVITY_DATA             @"action_basic_info"

#define kACTION_SYNC_CONFIG              @"action_basic_info"

#define kACTION_SYNC_HEALTH_DATA              @"action_sync_health_data"

#define kACTION_SYNC_HEALTH_DATA_SPORT              @"action_sync_health_data_sport"

#define kACTION_SYNC_HEALTH_DATA_SLEEP              @"action_sync_health_data_sleep"

#define kACTION_SYNC_HEALTH_DATA_HEART_RATE              @"action_sync_health_data_heart_rate"

#define kACTION_SYNC_HEALTH_DATA_BLOOD_PRESSURE              @"action_basic_info"

#define OPERATION_STATUS   @"status"

#define TYPE   @"type"

#define DATA   @"data"

#define PROGRESS @"PROGRESS"

#define RESULT @"result"


#define kACTION_GET_ALL_CONNECTED_DEVICES   @"ACTION_GET_ALL_CONNECTED_DEVICES"

@end
