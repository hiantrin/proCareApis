//
//  AM5Module.m
//  ReactNativeIOSLibrary
//
//  Created by daiqingquan on 2016/12/4.
//  Copyright © 2016年 daiqingquan. All rights reserved.
//

#import "AM5Module.h"
#import "AM5.h"
#import "AM5Controller.h"
#import "AM5ProfileModule.h"
#import "AM5Header.h"
@implementation AM5Module{


    NSMutableDictionary*resultDic;

}

#define EVENT_NOTIFY @"event_notify_am5"
#define kMAC_KEY        @"mac"
#define kACTION_KEY     @"action"

@synthesize bridge = _bridge;

RCT_EXPORT_MODULE()


#pragma mark
#pragma mark - constantsToExport
- (NSDictionary *)constantsToExport
{
    return @{ @"Event_Notify": EVENT_NOTIFY };
    
}

+ (BOOL)requiresMainQueueSetup
{
    return YES;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(AM5*)getAM5WithMac:(NSString*)mac{
    
    AM5Controller *controller = [AM5Controller shareAM5Controller];
    NSArray *poDeviceArray = [controller getAllCurrentAM5Instace];
    
    for(AM5 *tempAM5 in poDeviceArray){
        if([mac isEqualToString:tempAM5.serialNumber]){
            
            return tempAM5;
            break;
        }
    }
    
    return nil;
}

#pragma mark
#pragma mark - Method

RCT_EXPORT_METHOD(getAllConnectedDevices){
    
    
    NSArray*AM5array= [[AM5Controller shareAM5Controller] getAllCurrentAM5Instace];
    
    NSMutableArray*deviceMacArray=[NSMutableArray array];
    
    for (int i=0; i<[AM5array count]; i++) {
        
        AM5*am5=[AM5array objectAtIndex:i];
        
        [deviceMacArray addObject:am5.serialNumber];
        
    }
    
    NSDictionary* deviceInfo = @{kACTION_KEY:kACTION_GET_ALL_CONNECTED_DEVICES,@"devices":deviceMacArray};
    
    [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
    
    
}

#pragma mark 绑定
RCT_EXPORT_METHOD(bindDevice:(nonnull NSString *)mac){
    
    
    if ([self getAM5WithMac:mac]) {
        __weak typeof(self) weakSelf = self;
        
        
        [[self getAM5WithMac:mac] commandBindingDevice:^(BOOL result) {
        
        NSLog(@"BindingDevice:%d",result);
            
            [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:@{
                                                            kMAC_KEY:mac,
                                                            kACTION_KEY:kACTION_USER_BIND,
                                                            OPERATION_STATUS:@3,
                                                            TYPE:@"AM5",
                                                            ERROR_DESCRIPTION:@"no error"
                                                            }];
        
    } DiaposeErrorBlock:^(AM5DeviceError errorID) {
        
    }];
        
       
}

}
#pragma mark 解除绑定
RCT_EXPORT_METHOD(unBindDevice:(nonnull NSString *)mac){
    
    
    if ([self getAM5WithMac:mac]) {
        __weak typeof(self) weakSelf = self;
        
        
        [[self getAM5WithMac:mac] commandUnBindingDevice:^(BOOL result) {
        
        NSLog(@"BindingDevice:%d",result);
            
            [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:@{
                                                            kMAC_KEY:mac,
                                                            kACTION_KEY:kACTION_USER_UNBIND,
                                                            OPERATION_STATUS:@3,
                                                            TYPE:@"AM5",
                                                            ERROR_DESCRIPTION:@"no error"
                                                            }];
        
    } DiaposeErrorBlock:^(AM5DeviceError errorID) {
        
    }];
        
       
}

}

#pragma mark 获取设备信息
RCT_EXPORT_METHOD(getBasicInfo:(nonnull NSString *)mac){
//Mode:Device mode    BatteryStatus:Battery status  BatteryLevel:Battery level RebootFlag:Whether to restart  BindTimeStr:Binding timestamp  BindState:Binding status
    
    if ([self getAM5WithMac:mac]) {
        __weak typeof(self) weakSelf = self;
        
        
        [[self getAM5WithMac:mac] commandGetDeviceInfo:^(NSMutableDictionary *DeviceInfo) {
            
            NSLog(@"DeviceINfo:%@",DeviceInfo);
            [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:@{
                                                            kMAC_KEY:mac,
                                                            kACTION_KEY:kACTION_BASIC_INFO,
                                                            TYPE:@"AM5",
                                                            BASIC_BATTSTATUS:[DeviceInfo valueForKey:@"BatteryStatus"],
                                                            BASIC_DEIVCEID:@"7041",
                                                            BASIC_ENERGE:[DeviceInfo valueForKey:@"BatteryLevel"],
                                                            BASIC_FIRMWAREVERSION:@"40",
                                                            BASIC_MODE:[DeviceInfo valueForKey:@"Mode"],
                                                            BASIC_PAIRFLAG:[DeviceInfo valueForKey:@"BindState"],
                                                            BASIC_REBOOT:[DeviceInfo valueForKey:@"RebootFlag"],
                                                            
                                                            }];
            
        } DiaposeErrorBlock:^(AM5DeviceError errorID) {
            
            
            
        }];
        
       
}

}

#pragma mark 设置时间
RCT_EXPORT_METHOD(setTime:(nonnull NSString *)mac){
    
    
    if ([self getAM5WithMac:mac]) {
        __weak typeof(self) weakSelf = self;
        
        
        [[self getAM5WithMac:mac] commandSetCurrentTime:^(BOOL result) {
            if (result==YES) {
                NSLog(@"SetCurrentTimeSucess");
            }else{
                
                NSLog(@"SetCurrentTimeFaild");
            }
            
            [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:@{
                                                            kMAC_KEY:mac,
                                                            kACTION_KEY:kACTION_SET_TIME,
                                                            TYPE:@"AM5",
                                                            RESULT:@1
                                                            }];
            
            
        } DiaposeErrorBlock:^(AM5DeviceError errorID) {
            
        }];
        
       
}

}
#pragma mark 设置用户信息
RCT_EXPORT_METHOD(setUserInfo:(nonnull NSString *)mac :(nonnull NSNumber *)year:(nonnull NSNumber *)month:(nonnull NSNumber *)day:(nonnull NSNumber *)weight:(nonnull NSNumber *)height :(nonnull NSNumber *)gender){

    if ([self getAM5WithMac:mac]) {
        
        __weak typeof(self) weakSelf = self;
        
        IDOSetUserInfoBuletoothModel * userModel= [IDOSetUserInfoBuletoothModel currentModel];
        
        userModel.year=[year integerValue];
        
        userModel.month=[month integerValue];
        
        userModel.day=[day integerValue];
        
        userModel.weight=[weight integerValue];
        
        userModel.height=[height integerValue];
        
        userModel.gender=[gender integerValue];
        
        
        [[self getAM5WithMac:mac] commandSetUserInfo:userModel setResult:^(BOOL result) {
            
            [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:@{
                                                            kMAC_KEY:mac,
                                                            kACTION_KEY:kACTION_SET_USER_INFO,
                                                            TYPE:@"AM5",
                                                            RESULT:@1
                                                            }];
            
        } DiaposeErrorBlock:^(AM5DeviceError errorID) {
            
        }];
        
    
    }
}

#pragma mark 设置单位
RCT_EXPORT_METHOD(setUnit:(nonnull NSString *)mac :(nonnull NSNumber *)type :(nonnull NSNumber *)unit){

    if ([self getAM5WithMac:mac]) {
        
        __weak typeof(self) weakSelf = self;
        
        IDOSetUnitInfoBluetoothModel * unitInfo = [IDOSetUnitInfoBluetoothModel currentModel];
        
        if ([type intValue]==0) {
            unitInfo.distanceUnit =[unit integerValue];
        }else if ([type intValue]==1) {
            unitInfo.weightUnit =[unit integerValue];
        }else {
            unitInfo.tempUnit =[unit integerValue];
        }
        
        [[self getAM5WithMac:mac] commandSetUnit:unitInfo setResult:^(BOOL result) {
            
            [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:@{
                                                            kMAC_KEY:mac,
                                                            kACTION_KEY:kACTION_SET_UNIT,
                                                            TYPE:@"AM5",
                                                            RESULT:@1
                                                            }];
            
        } DiaposeErrorBlock:^(AM5DeviceError errorID) {
            
        }];
    
    }
}

#pragma mark Hand Wear Mode
RCT_EXPORT_METHOD(setHandWearMode:(nonnull NSString *)mac :(nonnull NSNumber *)model){

    if ([self getAM5WithMac:mac]) {
        
        __weak typeof(self) weakSelf = self;
        
        IDOSetLeftOrRightInfoBuletoothModel * leftOrRightModel = [IDOSetLeftOrRightInfoBuletoothModel currentModel];
        
        if ([model intValue]==1) {
            leftOrRightModel.isRight=YES;
        }else{
            
            leftOrRightModel.isRight=NO;
        }
        
        
        
        [[self getAM5WithMac:mac] commandSetLeftRightHand:leftOrRightModel setResult:^(BOOL result) {
            
            [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:@{
                                                            kMAC_KEY:mac,
                                                            kACTION_KEY:kACTION_SET_HAND_WEAR_MODE,
                                                            TYPE:@"AM5",
                                                            RESULT:@1
                                                            }];
            
        } DiaposeErrorBlock:^(AM5DeviceError errorID) {
            
        }];
    
    }
}

#pragma mark 获取live数据
RCT_EXPORT_METHOD(getLiveData:(nonnull NSString *)mac){

//Step:Step count Calorie:Calorie  Distances:distance ActiveTime:Duration of activity HeartRate:Heart rate
    if ([self getAM5WithMac:mac]) {
        
        __weak typeof(self) weakSelf = self;
        
        [[self getAM5WithMac:mac] commandGetLiveData:^(NSMutableDictionary *liveDataDic) {
            
            NSLog(@"liveDataDic:%@",liveDataDic);
            
            [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:@{
                                                            kMAC_KEY:mac,
                                                            kACTION_KEY:kACTION_LIVE_DATA,
                                                            TYPE:@"AM5",
                                                            LIVE_DATA_HEARTRATE:[liveDataDic valueForKey:@"HeartRate"],
                                                            LIVE_DATA_STEP:[liveDataDic valueForKey:@"Step"],
                                                            LIVE_DATA_CALORIE:[liveDataDic valueForKey:@"Calorie"],
                                                            LIVE_DATA_DISTANCES:[liveDataDic valueForKey:@"Distances"],
                                                            LIVE_DATA_ACTIVETIME:[liveDataDic valueForKey:@"ActiveTime"],
                                                            }];
            
        } DiaposeErrorBlock:^(AM5DeviceError errorID) {
            
        }];
    
    }
}

#pragma mark Sync health data from device

//syncActivityDataDic
//{
//    head =     {
//        day = 3;
//        "items_count" = 96;
//        "key_word" = 0;
//        length = 16;
//        "minute_offset" = 0;
//        month = 9;
//        "packets_count" = 34;
//        "per_minute" = 15;
//        reserved = 0;
//        serial = 1;
//        "total_active_time" = 0;
//        "total_cal" = 0;
//        "total_distances" = 0;
//        "total_step" = 0;
//        year = 2021;
//    };
//    items =     (
//                {
//            "active_time" = 0;
//            calories = 0;
//            distance = 0;
//            mode = 0;
//            "sport_count" = 0;
//        },
//                {
//            "active_time" = 0;
//            calories = 0;
//            distance = 0;
//            mode = 0;
//            "sport_count" = 0;
//        },
//                {
//            "active_time" = 0;
//            calories = 0;
//            distance = 0;
//            mode = 0;
//            "sport_count" = 0;
//        },
//
//    );
//    type = "sport_step";
//}
//
//syncHeartRateDataDic:{
//    head =     {
//        "aerobic_mins" = 0;
//        "aerobic_threshold" = 154;
//        "anaerobic_mins" = 0;
//        "anaerobic_threshold" = 0;
//        "burn_fat_mins" = 0;
//        "burn_fat_threshold" = 132;
//        day = 3;
//        "items_count" = 0;
//        length = 16;
//        "limit_mins" = 0;
//        "limit_threshold" = 198;
//        "minute_offset" = 0;
//        month = 9;
//        "packets_count" = 2;
//        serial = 1;
//        "silent_heart_rate" = 62;
//        "user_max_hr" = 0;
//        "warm_up_mins" = 0;
//        "warm_up_threshold" = 0;
//        year = 2021;
//    };
//    items =     (
//    );
//    "offset_type" = minute;
//    type = "heart_rate";
//}
//
//syncSleepDataDic:{
//    head =     {
//        day = 0;
//        "deep_sleep_count" = 0;
//        "deep_sleep_minute" = 0;
//        "end_time_hour" = 0;
//        "end_time_minute" = 0;
//        "items_count" = 0;
//        length = 16;
//        "light_sleep_count" = 0;
//        "ligth_sleep_minute" = 0;
//        month = 0;
//        "packet_count" = 2;
//        serial = 1;
//        "sleep_item_count" = 0;
//        "sleep_score" = 0;
//        "total_minute" = 0;
//        "wake_count" = 0;
//        year = 0;
//    };
//    items =     (
//    );
//    type = sleep;
//}

RCT_EXPORT_METHOD(syncHealthData:(nonnull NSString *)mac){

    if ([self getAM5WithMac:mac]) {
        
        __weak typeof(self) weakSelf = self;
        
        [[self getAM5WithMac:mac] commandSyncData:^(NSDictionary *syncDataDic) {
            
            NSLog(@"syncHeartRateDataDic:%@",syncDataDic);
            
            [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:@{
                                                            kMAC_KEY:mac,
                                                            kACTION_KEY:kACTION_SYNC_HEALTH_DATA_HEART_RATE,
                                                            TYPE:@"AM5",
                                                            DATA:syncDataDic,
                                                            }];
            
        } syncSleepData:^(NSDictionary *syncDataDic) {
            
            NSLog(@"syncSleepDataDic:%@",syncDataDic);
            
            [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:@{
                                                            kMAC_KEY:mac,
                                                            kACTION_KEY:kACTION_SYNC_HEALTH_DATA_SLEEP,
                                                            TYPE:@"AM5",
                                                            DATA:syncDataDic,
                                                            }];
            
        } syncActivityData:^(NSDictionary *syncDataDic) {
            
            NSLog(@"syncActivityDataDic:%@",syncDataDic);
            
            [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:@{
                                                            kMAC_KEY:mac,
                                                            kACTION_KEY:kACTION_SYNC_HEALTH_DATA_SPORT,
                                                            TYPE:@"AM5",
                                                            DATA:syncDataDic,
                                                            }];
            
        } syncDataProgress:^(NSNumber *syncDataProgress) {
            
            NSLog(@"syncDataProgress:%@",syncDataProgress);
            
            [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:@{
                                                            kMAC_KEY:mac,
                                                            kACTION_KEY:kACTION_SYNC_HEALTH_DATA,
                                                            TYPE:@"AM5",
                                                            PROGRESS:syncDataProgress,
                                                            OPERATION_STATUS:@3,
                                                            }];
            
        } syncDataSuccess:^{
            
            NSLog(@"syncDataSuccess");
            
        } DiaposeErrorBlock:^(AM5DeviceError errorID) {
            
        }];
    
    }
}

RCT_EXPORT_METHOD(stopSyncHealthData:(nonnull NSString *)mac){
    
    __weak typeof(self) weakSelf = self;
    
    if ([self getAM5WithMac:mac]!=nil) {
        
       
      [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:@{
                                                            kMAC_KEY:mac,
                                                            kACTION_KEY:kACTION_NOTICE_COMMING_CALL_STOP,
                                                            TYPE:@"AM5"
                                                            }];
        
    }else{
        
        
        
    }
    
    
    
}

RCT_EXPORT_METHOD(reboot:(nonnull NSString *)mac){
    
    __weak typeof(self) weakSelf = self;
    
    if ([self getAM5WithMac:mac]!=nil) {
        
        [[self getAM5WithMac:mac] commandSetAppReboot:^(BOOL result) {
            
            [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:@{
                                                            kMAC_KEY:mac,
                                                            kACTION_KEY:BASIC_REBOOT,
                                                            TYPE:@"AM5"
                                                            }];
            
            
        } DiaposeErrorBlock:^(AM5DeviceError errorID) {
            
        }];
        
    }else{
        
        
        
    }
    
    
    
}


RCT_EXPORT_METHOD(disconnect:(nonnull NSString *)mac){
    
    
    if ([self getAM5WithMac:mac]!=nil) {
        
        [[self getAM5WithMac:mac] commandAM5Disconnect];
        
    }else{
        
        
        
    }
    
    
    
}





@end
