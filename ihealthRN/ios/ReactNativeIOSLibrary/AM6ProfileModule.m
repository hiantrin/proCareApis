//
//  AM6ProfileModule.m
//  ReactNativeIOSLibrary
//
//  Created by Spring on 2023/8/28.
//

#import "AM6ProfileModule.h"
#import "AMMacroFile.h"

#import <CommonCrypto/CommonHMAC.h>
#import <CommonCrypto/CommonCryptor.h>
#import <zlib.h>


@implementation AM6ProfileModule


RCT_EXPORT_MODULE()

#pragma mark
#pragma mark - constantsToExport


- (NSDictionary *)constantsToExport
{
    return @{
             AM6_ACTION:AM6_ACTION,
             AM6_DEVICE:AM6_DEVICE,
             AM6_KEY_MAC:AM6_KEY_MAC,
             AM6_TYPE:AM6_TYPE,
             
             @"ACTION_GET_ALL_CONNECTED_DEVICES":kACTION_GET_ALL_CONNECTED_DEVICES,
            
             @"ACTION_GET_DEVICE_INFO":ACTION_GET_DEVICE_INFO,
             @"AM6_GETDEVICEINFO_KEY_BATTERY":AM6_GETDEVICEINFO_KEY_BATTERY,
             @"AM6_GETDEVICEINFO_KEY_BIND_STATUS":AM6_GETDEVICEINFO_KEY_BIND_STATUS,
             @"AM6_GETDEVICEINFO_KEY_CHARGE":AM6_GETDEVICEINFO_KEY_CHARGE,
             @"AM6_GETDEVICEINFO_KEY_FIRMWARE":AM6_GETDEVICEINFO_KEY_FIRMWARE,
             @"AM6_GETDEVICEINFO_KEY_HARDWARE":AM6_GETDEVICEINFO_KEY_HARDWARE,
             @"AM6_GETDEVICEINFO_KEY_VERSION":AM6_GETDEVICEINFO_KEY_VERSION,
             
             @"ACTION_SET_USER":ACTION_SET_USER,
             @"AM6_SET_USERINFO_RESULT":AM6_SET_USERINFO_RESULT,
             
             @"ACTION_SET_PHONEPLATFORM":ACTION_SET_PHONEPLATFORM,
             @"ACTION_FIND_DEVICE":ACTION_FIND_DEVICE,
             @"AM6_FIND_DEVICE_STATUS":AM6_FIND_DEVICE_STATUS,
             
             @"ACTION_FIND_PHONE":ACTION_FIND_PHONE,
             @"AM6_FIND_PHONE_STATUS":AM6_FIND_PHONE_STATUS,
             
             @"ACTION_REBOOT_DEVICE":ACTION_REBOOT_DEVICE,
             
             @"ACTION_GET_TIME":ACTION_GET_TIME,
             @"AM6_GET_TIME":AM6_GET_TIME,
             @"AM6_TIME_FORMAT":AM6_TIME_FORMAT,
             @"ACTION_SET_REMINDER":ACTION_SET_REMINDER,
             @"AM6_SET_REMINDER_RESULT":AM6_SET_REMINDER_RESULT,
             
             @"ACTION_GET_REMINDER":ACTION_GET_REMINDER,
             @"AM6_GET_REMINDER_CALORIE":AM6_GET_REMINDER_CALORIE,
             @"AM6_GET_REMINDER_ENABLE":AM6_GET_REMINDER_ENABLE,
             @"AM6_GET_REMINDER_RESULT":AM6_GET_REMINDER_RESULT,
             @"AM6_GET_REMINDER_STEP":AM6_GET_REMINDER_STEP,
             
             @"ACTION_SET_SENDENTARY":ACTION_SET_SENDENTARY,
             @"AM6_SET_SENDENTARY_RESULT":AM6_SET_SENDENTARY_RESULT,
             @"ACTION_GET_SENDENTARY":ACTION_GET_SENDENTARY,
             @"AM6_GET_SENDENTARY_ENDTIME":AM6_GET_SENDENTARY_ENDTIME,
             @"AM6_GET_SENDENTARY_ENABLE":AM6_GET_SENDENTARY_ENABLE,
             @"AM6_GET_SENDENTARY_RESULT":AM6_GET_SENDENTARY_RESULT,
             @"AM6_GET_SENDENTARY_STARTTIME":AM6_GET_SENDENTARY_STARTTIME,
             
             @"ACTION_SET_RAISE":ACTION_SET_RAISE,
             @"AM6_SET_RAISE_RESULT":AM6_SET_RAISE_RESULT,
             @"ACTION_GET_RAISE":ACTION_GET_RAISE,
             @"AM6_GET_RAISE_ENDTIME":AM6_GET_RAISE_ENDTIME,
             @"AM6_GET_RAISE_ENABLE":AM6_GET_RAISE_ENABLE,
             @"AM6_GET_RAISE_RESULT":AM6_GET_RAISE_RESULT,
             @"AM6_GET_RAISE_STARTTIME":AM6_GET_RAISE_STARTTIME,
             
             @"ACTION_SET_DONOTDISTURB":ACTION_SET_DONOTDISTURB,
             @"AM6_SET_DONOTDISTURB_RESULT":AM6_SET_DONOTDISTURB_RESULT,
             
             @"ACTION_GET_DONOTDISTURB":ACTION_GET_DONOTDISTURB,
             @"AM6_GET_DONOTDISTURB_ENDTIME":AM6_GET_DONOTDISTURB_ENDTIME,
             @"AM6_GET_DONOTDISTURB_ENABLE":AM6_GET_DONOTDISTURB_ENABLE,
             @"AM6_GET_DONOTDISTURB_RESULT":AM6_GET_DONOTDISTURB_RESULT,
             @"AM6_GET_DONOTDISTURB_STARTTIME":AM6_GET_DONOTDISTURB_STARTTIME,
             
             @"ACTION_SET_WEARHAND":ACTION_SET_WEARHAND,
             @"AM6_SET_WEARHAND_RESULT":AM6_SET_WEARHAND_RESULT,
             
             @"ACTION_GET_WEARHAND":ACTION_GET_WEARHAND,
             @"AM6_GET_WEARHAND_HAND":AM6_GET_WEARHAND_HAND,
             @"AM6_GET_WEARHAND_RESULT":AM6_GET_WEARHAND_RESULT,
             
             @"ACTION_SET_ALARMLIST":ACTION_SET_ALARMLIST,
             @"AM6_SET_ALARMLIST_LIST":AM6_SET_ALARMLIST_LIST,
             @"ACTION_GET_ALARMLIST":ACTION_GET_ALARMLIST,
             @"AM6_GET_ALARMLIST_LIST":AM6_GET_ALARMLIST_LIST,
             @"AM6_GET_ALARMLIST_ENABLE":AM6_GET_ALARMLIST_ENABLE,
             @"AM6_GET_ALARMLIST_TIME":AM6_GET_ALARMLIST_TIME,
             @"AM6_GET_ALARMLIST_WEEK":AM6_GET_ALARMLIST_WEEK,
             @"AM6_GET_ALARMLIST_STATUS":AM6_GET_ALARMLIST_STATUS,
             
             @"ACTION_SET_STARTBIND":ACTION_SET_STARTBIND,
             @"ACTION_SET_BINDSUCCESS":ACTION_SET_BINDSUCCESS,
             @"ACTION_SET_BINDFAIL":ACTION_SET_BINDFAIL,
             @"ACTION_SET_UNBIND":ACTION_SET_UNBIND,
             @"AM6_SET_UNBIND":AM6_SET_UNBIND,
             
             @"ACTION_SYNC_READY":ACTION_SYNC_READY,
             @"AM6_SYNC_STATUS":AM6_SYNC_STATUS,
             
             @"ACTION_GET_DAILYDATA":ACTION_GET_DAILYDATA,
             @"AM6_GET_DAILYDATA":AM6_GET_DAILYDATA,
             @"AM6_GET_DAILYDATA_PO":AM6_GET_DAILYDATA_PO,
             @"AM6_GET_DAILYDATA_CALORIE":AM6_GET_DAILYDATA_CALORIE,
             @"AM6_GET_DAILYDATA_DATE":AM6_GET_DAILYDATA_DATE,
             @"AM6_GET_DAILYDATA_EFFECTIVESTAND":AM6_GET_DAILYDATA_EFFECTIVESTAND,
             @"AM6_GET_DAILYDATA_HEARTRATE":AM6_GET_DAILYDATA_HEARTRATE,
             @"AM6_GET_DAILYDATA_MAXHEARTRATE":AM6_GET_DAILYDATA_MAXHEARTRATE,
             @"AM6_GET_DAILYDATA_MAXHEARTRATETIME":AM6_GET_DAILYDATA_MAXHEARTRATETIME,
             @"AM6_GET_DAILYDATA_MEANHEARTRATE":AM6_GET_DAILYDATA_MEANHEARTRATE,
             @"AM6_GET_DAILYDATA_MINHEARTRATE":AM6_GET_DAILYDATA_MINHEARTRATE,
             @"AM6_GET_DAILYDATA_MINHEARTRATETIME":AM6_GET_DAILYDATA_MINHEARTRATETIME,
             @"AM6_GET_DAILYDATA_RESTHEARTRATE":AM6_GET_DAILYDATA_RESTHEARTRATE,
             @"AM6_GET_DAILYDATA_STEP":AM6_GET_DAILYDATA_STEP,
             
             @"ACTION_GET_STEPDATA":ACTION_GET_STEPDATA,
             @"AM6_GET_STEPDATA":AM6_GET_STEPDATA,
             @"AM6_GET_STEPDATA_LIST":AM6_GET_STEPDATA_LIST,
             @"AM6_GET_STEPDATA_DISTANCE":AM6_GET_STEPDATA_DISTANCE,
             @"AM6_GET_STEPDATA_CALORIE":AM6_GET_STEPDATA_CALORIE,
             @"AM6_GET_STEPDATA_STEP":AM6_GET_STEPDATA_STEP,
             @"AM6_GET_STEPDATA_DATE":AM6_GET_STEPDATA_DATE,
             
             @"ACTION_GET_SLEEPDATA":ACTION_GET_SLEEPDATA,
             @"AM6_GET_SLEEPDATA":AM6_GET_SLEEPDATA,
             @"AM6_GET_SLEEPDATA_LIST":AM6_GET_SLEEPDATA_LIST,
             @"AM6_GET_SLEEPDATA_DATE":AM6_GET_SLEEPDATA_DATE,
             @"AM6_GET_SLEEPDATA_MODE_DATE":AM6_GET_SLEEPDATA_MODE_DATE,
             @"AM6_GET_SLEEPDATA_MODE":AM6_GET_SLEEPDATA_MODE,
             
             @"ACTION_GET_HEARTRATE":ACTION_GET_HEARTRATE,
             @"AM6_GET_HEARTRATE":AM6_GET_HEARTRATE,
             @"AM6_GET_HEARTRATE_LIST":AM6_GET_HEARTRATE_LIST,
             @"AM6_GET_HEARTRATE_HEARTRATE":AM6_GET_HEARTRATE_HEARTRATE,
             @"AM6_GET_HEARTRATE_DATE":AM6_GET_HEARTRATE_DATE,
             
             @"ACTION_GET_BLOODOXYGEN":ACTION_GET_BLOODOXYGEN,
             @"AM6_GET_BLOODOXYGEN":AM6_GET_BLOODOXYGEN,
             @"AM6_GET_BLOODOXYGEN_BLOODOXYGEN":AM6_GET_BLOODOXYGEN_BLOODOXYGEN,
             @"AM6_GET_BLOODOXYGEN_DATE":AM6_GET_BLOODOXYGEN_DATE,
             
             @"ACTION_GET_ACTIVITY":ACTION_GET_ACTIVITY,
             @"AM6_GET_ACTIVITY":AM6_GET_ACTIVITY,
             @"AM6_GET_ACTIVITY_REPORT":AM6_GET_ACTIVITY_REPORT,
             @"AM6_GET_ACTIVITY_ANAEROBICTIME":AM6_GET_ACTIVITY_ANAEROBICTIME,
             @"AM6_GET_ACTIVITY_AVEHEARTRATE":AM6_GET_ACTIVITY_AVEHEARTRATE,
             @"AM6_GET_ACTIVITY_BODYENERGYCOST":AM6_GET_ACTIVITY_BODYENERGYCOST,
             @"AM6_GET_ACTIVITY_CARDIOTIME":AM6_GET_ACTIVITY_CARDIOTIME,
             @"AM6_GET_ACTIVITY_ENDDATE":AM6_GET_ACTIVITY_ENDDATE,
             @"AM6_GET_ACTIVITY_ESTIMATED":AM6_GET_ACTIVITY_ESTIMATED,
             @"AM6_GET_ACTIVITY_FATREDTIME":AM6_GET_ACTIVITY_FATREDTIME,
             @"AM6_GET_ACTIVITY_MAXHEARTRATE":AM6_GET_ACTIVITY_MAXHEARTRATE,
             @"AM6_GET_ACTIVITY_MAXOX":AM6_GET_ACTIVITY_MAXOX,
             @"AM6_GET_ACTIVITY_MAXPACE":AM6_GET_ACTIVITY_MAXPACE,
             @"AM6_GET_ACTIVITY_MAXSF":AM6_GET_ACTIVITY_MAXSF,
             @"AM6_GET_ACTIVITY_MINHEARTRATE":AM6_GET_ACTIVITY_MINHEARTRATE,
             @"AM6_GET_ACTIVITY_MINPACE":AM6_GET_ACTIVITY_MINPACE,
             @"AM6_GET_ACTIVITY_PEAKTIME":AM6_GET_ACTIVITY_PEAKTIME,
             @"AM6_GET_ACTIVITY_STARTDATE":AM6_GET_ACTIVITY_STARTDATE,
             @"AM6_GET_ACTIVITY_TOTLECALORIE":AM6_GET_ACTIVITY_TOTLECALORIE,
             @"AM6_GET_ACTIVITY_TOTLEDISTANCE":AM6_GET_ACTIVITY_TOTLEDISTANCE,
             @"AM6_GET_ACTIVITY_TOTLESTEP":AM6_GET_ACTIVITY_TOTLESTEP,
             @"AM6_GET_ACTIVITY_TOTLETIME":AM6_GET_ACTIVITY_TOTLETIME,
             @"AM6_GET_ACTIVITY_TRAININGEF":AM6_GET_ACTIVITY_TRAININGEF,
             @"AM6_GET_ACTIVITY_WARMUPTIME":AM6_GET_ACTIVITY_WARMUPTIME,
             
             @"AM6_GET_ACTIVITY_DATE":AM6_GET_ACTIVITY_DATE,
             @"AM6_GET_ACTIVITYPOINT_DATE":AM6_GET_ACTIVITYPOINT_DATE,
             @"AM6_GET_ACTIVITYPOINT_CALORIE":AM6_GET_ACTIVITYPOINT_CALORIE,
             @"AM6_GET_ACTIVITYPOINT_DISTANCE":AM6_GET_ACTIVITYPOINT_DISTANCE,
             @"AM6_GET_ACTIVITYPOINT_HEARTRATE":AM6_GET_ACTIVITYPOINT_HEARTRATE,
             @"AM6_GET_ACTIVITYPOINT_STEP":AM6_GET_ACTIVITYPOINT_STEP,
             @"AM6_GET_ACTIVITYPOINT":AM6_GET_ACTIVITYPOINT,
             
             @"ACTION_DELETEDATA":ACTION_DELETEDATA,
             @"AM6_DELETEDATA_RESULT":AM6_DELETEDATA_RESULT,
             @"AM6_DISCONNECT_DEVICE":AM6_DISCONNECT_DEVICE,
             
             @"ACTION_ERROR_AM6":ACTION_ERROR_AM6,
             @"ERROR_NUM_AM6":ERROR_NUM_AM6,
             @"ERROR_DESCRIPTION_AM6":ERROR_DESCRIPTION_AM6,
             @"ACTION_DISCONNECT_AM6":ACTION_DISCONNECT_AM6,
             
             };
};


+ (BOOL)requiresMainQueueSetup
{
    return YES;
}

+ (NSString*)descriptionForErrorCode:(NSInteger)errorCode{
    switch (errorCode) {
        case AM6DeviceError_WrongUserIDInput:
            return @"Wrong UserID Input";
        case AM6DeviceError_GetDataFailError:
            return @"Get Data Fail Error";
        case AM6DeviceError_SetTimeFaild:
            return @"Set Time Faild";
        case AM6DeviceError_InputParameterError:
            return @"InputParameterError";
        case AM6DeviceError_Unknown:
            return @"Error Unknown";
        case AM6DeviceError_CommunicationTimeout:
            return @"Communication Timeout";
        case AM6DeviceError_ReceivedCommandError:
            return @"Received Command Error";
        case AM6DeviceError_ActionFail:
            return @"Action Fail";
        case AM6DeviceError_TooBusy:
            return @"Device Too Busy";
        case 404:
            return @"iOS does not support this API";
        case 900:
            return @"iOS doesn't support disconnect normal BT devices";
    }
    return @"unknown error";
}

+ (void)sendErrorToBridge:(RCTBridge *)bridge eventNotify:(NSString*)eventNotify WithCode:(NSInteger)errorCode mac:(NSString*)mac{
    NSDictionary*  errorDict;
    
    
    if(errorCode==AM6DeviceError_DeviceDisconnect || errorCode==AM6DeviceConnectError_Disconnect){
        
    
        errorDict = @{
            AM6_ACTION:ACTION_ERROR_AM6,
            ERROR_DESCRIPTION_AM6:[self descriptionForErrorCode:errorCode],
            AM6_TYPE:@"AM6",
            AM6_KEY_MAC:mac,
                      };
    
    }else{
        
        
       errorDict = @{
           AM6_ACTION:ACTION_ERROR_AM6,
           ERROR_NUM_AM6:@(errorCode),
           ERROR_DESCRIPTION_AM6:[self descriptionForErrorCode:errorCode],
           AM6_TYPE:@"AM6",
           AM6_KEY_MAC:mac,
            };

    
    }
    
    [self sendEventToBridge:bridge eventNotify:eventNotify WithDict:errorDict];
}

+ (void)sendEventToBridge:(RCTBridge *)bridge eventNotify:(NSString*)eventNotify WithDict:(NSDictionary*)dict{
    [bridge.eventDispatcher sendDeviceEventWithName:eventNotify body:dict];
}


+ (NSData *)md5:(NSString *)hashString{
    
    NSData *data = [hashString dataUsingEncoding:NSUTF8StringEncoding];
    // 计算md5
    unsigned char *digest;
    digest = (unsigned char *)malloc(CC_MD5_DIGEST_LENGTH);
    
    CC_MD5([data bytes], (CC_LONG)[data length], digest);
    NSData *md5Data = [NSData dataWithBytes:digest length:CC_MD5_DIGEST_LENGTH];
    free(digest);
    
    return md5Data;
}

+(void)sendNoDevice:(RCTBridge *)bridge{
    
    
    NSDictionary* deviceInfo = @{AM6_ACTION:ACTION_ERROR_AM6,ERROR_DESCRIPTION_AM6:ACTION_DISCONNECT_AM6};
    [bridge.eventDispatcher sendDeviceEventWithName:AM6_EVENT_NOTIFY body:deviceInfo];
    
}


@end
