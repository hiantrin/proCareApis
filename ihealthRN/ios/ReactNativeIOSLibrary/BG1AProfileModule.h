//
//  BG1AProfileModule.h
//  ReactNativeIOSLibrary
//
//  Created by user on 2019/11/14.
//  Copyright © 2019 daiqingquan. All rights reserved.
//

#import <Foundation/Foundation.h>
#if __has_include(<React/RCTAssert.h>)
#import <React/RCTBridgeModule.h>
#else
#import <React/RCTBridgeModule.h>
#endif


@interface BG1AProfileModule : NSObject<RCTBridgeModule>

#define BG1A_EVENT_NOTIFY @"event_notify_bg1a"

#define BG1A_ACTION @"action"

#define BG1A_TYPE @"type"

#define BG1A_DEVICE @"devices"

#define BG1A_KEY_MAC @"mac"

#define BG1A_KEY_STRIPTYPE @"stripType"




//getdevice_info
#define ACTION_INFO_DEVICE   @"action_get_device_info"

#define BG1A_KEY_SERIALNUMBER @"serialnumber"

#define BG1A_KEY_MANUFACTURE @"manufacture"

#define BG1A_KEY_MODENUMBER @"modenumber"

#define BG1A_KEY_HARDWAREVERSION @"hardwareversion"

#define BG1A_KEY_FIRMWAREVERSION @"firmwareversion"

#define BG1A_KEY_ACCESSORYNAME @"accessoryname"

#define BG1A_KEY_PROTOCOLSTRING @"protocol"

#define BG1A_KEY_LOCALTIME @"info_local_time"

#define BG1A_KEY_HISTORY_STATUS @"info_history_status_bg1a"

#define BG1A_KEY_BATTERY     @"battery"


//setMeasuremode

#define ACTION_SET_MEASURE_MODE @"action_set_measure_mode"

#define BG1A_KEY_STATUS     @"status"

//setTime

#define ACTION_SET_DEVICE_TIME @"action_set_device_time"

//get history

#define ACTION_GET_HISTORY @"action_measure_result_history"


//delete history

#define ACTION_DELETE_HISTORY @"action_delete_history_result"



//Measure

#define ACTION_STRIP_INSERTION_STATUS    @"action_strip_insertion_status"

#define BG1A_KEY_INSERTION_STATUS         @"insertion_status"

#define BG1A_KEY_STRIP_CODE_TYPE         @"strip_code_type"

#define ACTION_GET_BLOOD                @"action_get_blood"

#define ACTION_MEASURE_RESULT         @"action_measure_result"


//Result

#define MEASURE_RESULT @"result"

#define BG1A_RESULT_KEY_TIME @"measure_time_device"

#define BG1A_RESULT_KEY_ERRORNUM @"error_num"

#define BG1A_RESULT_KEY_isResultNeedCalibrate @"measure_time_is_error"

#define BG1A_RESULT_KEY_MODE @"mode"

#define BG1A_RESULT_KEY_HISTORY @"history"








#define OPERATION_DESCRIBE @"describe"

#define kACTION_GET_ALL_CONNECTED_DEVICES   @"action_get_all_connected_devices"





#define ACTION_ERROR_BG1A                   @"action_error"

#define ERROR_NUM_BG1A                   @"error_num"

#define ERROR_DESCRIPTION_BG1A                   @"error_description"




@end

