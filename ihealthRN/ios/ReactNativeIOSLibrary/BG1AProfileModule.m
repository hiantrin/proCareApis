//
//  BG1AProfileModule.m
//  ReactNativeIOSLibrary
//
//  Created by user on 2019/11/14.
//  Copyright © 2019 daiqingquan. All rights reserved.
//

#import "BG1AProfileModule.h"

@implementation BG1AProfileModule

RCT_EXPORT_MODULE()

#pragma mark
#pragma mark - constantsToExport


- (NSDictionary *)constantsToExport
{
    return @{
             BG1A_ACTION:BG1A_ACTION,
             BG1A_DEVICE:BG1A_DEVICE,
             BG1A_KEY_MAC:BG1A_KEY_MAC,
             BG1A_TYPE:BG1A_TYPE,
             
             @"ACTION_INFO_DEVICE"            :ACTION_INFO_DEVICE,
             @"BG1A_KEY_SERIALNUMBER"        :BG1A_KEY_SERIALNUMBER,
             @"BG1A_KEY_MANUFACTURE"         :BG1A_KEY_MANUFACTURE,
             @"BG1A_KEY_MODENUMBER"          :BG1A_KEY_MODENUMBER,
             @"BG1A_KEY_HARDWAREVERSION"     :BG1A_KEY_HARDWAREVERSION,
             @"BG1A_KEY_FIRMWAREVERSION"     :BG1A_KEY_FIRMWAREVERSION,
             @"BG1A_KEY_ACCESSORYNAME"       :BG1A_KEY_ACCESSORYNAME,
             @"BG1A_KEY_PROTOCOLSTRING"      :BG1A_KEY_PROTOCOLSTRING,
             @"BG1A_KEY_LOCALTIME"           :BG1A_KEY_LOCALTIME,
             @"BG1A_KEY_HISTORY_STATUS"      :BG1A_KEY_HISTORY_STATUS,
             @"BG1A_KEY_BATTERY"             :BG1A_KEY_BATTERY,
             
             @"ACTION_GET_HISTORY"           :ACTION_GET_HISTORY,
             
             @"ACTION_DELETE_HISTORY"        :ACTION_DELETE_HISTORY,
             
             @"BG1A_KEY_STRIPTYPE"           :BG1A_KEY_STRIPTYPE,
             
             
             @"ACTION_SET_MEASURE_MODE"      :ACTION_SET_MEASURE_MODE,
             @"BG1A_KEY_STATUS"              :BG1A_KEY_STATUS,
             
             @"ACTION_SET_DEVICE_TIME"       :ACTION_SET_DEVICE_TIME,
             
             @"ACTION_STRIP_INSERTION_STATUS":ACTION_STRIP_INSERTION_STATUS,
             
             @"BG1A_KEY_INSERTION_STATUS"    :BG1A_KEY_INSERTION_STATUS,
             @"BG1A_KEY_STRIP_CODE_TYPE"     :BG1A_KEY_STRIP_CODE_TYPE,
             @"ACTION_GET_BLOOD"             :ACTION_GET_BLOOD,
             @"ACTION_MEASURE_RESULT"        :ACTION_MEASURE_RESULT,
             @"MEASURE_RESULT"               :MEASURE_RESULT,
             
             @"BG1A_RESULT_KEY_TIME"         :BG1A_RESULT_KEY_TIME,
             @"BG1A_RESULT_KEY_ERRORNUM"     :BG1A_RESULT_KEY_ERRORNUM,
             @"BG1A_RESULT_KEY_isResultNeedCalibrate":BG1A_RESULT_KEY_isResultNeedCalibrate,
             @"BG1A_RESULT_KEY_MODE"         :BG1A_RESULT_KEY_MODE,
             @"BG1A_RESULT_KEY_HISTORY"      :BG1A_RESULT_KEY_HISTORY,
             
             @"DESCRIBE":OPERATION_DESCRIBE,
             @"ACTION_GET_ALL_CONNECTED_DEVICES":kACTION_GET_ALL_CONNECTED_DEVICES,

             @"ACTION_ERROR_BG1A"                :ACTION_ERROR_BG1A,
             @"ERROR_NUM_BG1A"                :ERROR_NUM_BG1A,
             @"ERROR_DESCRIPTION_BG1A"                :ERROR_DESCRIPTION_BG1A,
             
             };
};


+ (BOOL)requiresMainQueueSetup
{
    return YES;
}

@end
