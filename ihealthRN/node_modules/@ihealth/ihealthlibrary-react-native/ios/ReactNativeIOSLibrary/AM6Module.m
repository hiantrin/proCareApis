//
//  AM6Module.m
//  ReactNativeIOSLibrary
//
//  Created by Spring on 2023/8/28.
//

#import "AM6Module.h"

#import "AM6.h"
#import "AM6Controller.h"
#import "AM6ProfileModule.h"
#define DEVICE_TYPE   @"AM6"


@interface AM6Module()


@property (weak, nonatomic) NSString* deviceMac;


@end

@implementation AM6Module

@synthesize bridge = _bridge;


RCT_EXPORT_MODULE()


#pragma mark
#pragma mark - constantsToExport
- (NSDictionary *)constantsToExport
{
    return @{ @"Event_Notify": AM6_EVENT_NOTIFY };
    
}

+ (BOOL)requiresMainQueueSetup
{
    return YES;
}

#pragma mark
#pragma mark - Init
-(id)init
{
    if (self=[super init])
    {
        
        [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(am6StartFindPhoneNoti:) name:@"AM6StartFindPhoneNoti" object:nil];
        [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(am6StopFindPhoneNoti:) name:@"AM6StopFindPhoneNoti" object:nil];
        
    }
    return self;
}

-(AM6*)getAM6WithMac:(NSString*)mac{
    
    AM6Controller *controller = [AM6Controller shareAM6Controller];
    NSArray *amDeviceArray = [controller getAllCurrentAM6Instace];
    
    for(AM6 *tempAM6 in amDeviceArray){
        if([mac isEqualToString:tempAM6.serialNumber]){
            
            self.deviceMac=[mac copy];
            
            return tempAM6;
            break;
        }
    }
    
    return nil;
}

#pragma mark
#pragma mark - Method

RCT_EXPORT_METHOD(getAllConnectedDevices){
    
    
    NSArray*am6array= [[AM6Controller shareAM6Controller] getAllCurrentAM6Instace];
    
    NSMutableArray*deviceMacArray=[NSMutableArray array];
    
    for (int i=0; i<[am6array count]; i++) {
        
        AM6*am6=[am6array objectAtIndex:i];
        
        [deviceMacArray addObject:am6.serialNumber];
        
    }
    
    NSDictionary* deviceInfo = @{AM6_ACTION:kACTION_GET_ALL_CONNECTED_DEVICES,AM6_DEVICE:deviceMacArray};
    
    [self.bridge.eventDispatcher sendDeviceEventWithName:AM6_EVENT_NOTIFY body:deviceInfo];
    
    
}


RCT_EXPORT_METHOD(getDeviceInfoAndSyncTime:(nonnull NSString *)mac :(int)flag){
    
    if ([self getAM6WithMac:mac]!=nil) {
        
        __weak typeof(self) weakSelf = self;
        
        [[self getAM6WithMac:mac] queryDeviceInfoAndSyncTimeWithSuccess:^{
            
            [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:AM6_EVENT_NOTIFY body:@{
                                           AM6_ACTION:ACTION_GET_DEVICE_INFO,
                                           AM6_KEY_MAC:mac,
                                           AM6_TYPE:DEVICE_TYPE,
                                           AM6_GETDEVICEINFO_KEY_BATTERY:@([weakSelf getAM6WithMac:mac].battery),
                                           AM6_GETDEVICEINFO_KEY_BIND_STATUS:@([weakSelf getAM6WithMac:mac].bindStatus),
                                           AM6_GETDEVICEINFO_KEY_CHARGE:@([weakSelf getAM6WithMac:mac].isCharging),
                                           AM6_GETDEVICEINFO_KEY_FIRMWARE:[weakSelf getAM6WithMac:mac].firmwareVersion,
                                           AM6_GETDEVICEINFO_KEY_HARDWARE:[weakSelf getAM6WithMac:mac].hardwareVersion,
                                           AM6_GETDEVICEINFO_KEY_VERSION:[weakSelf getAM6WithMac:mac].sdkFirmwareVersion,
                                       }];
            
        } fail:^(int error) {
            
            [AM6ProfileModule sendErrorToBridge:weakSelf.bridge eventNotify:AM6_EVENT_NOTIFY WithCode:error mac:mac];
            
        }];
    }else{
        
        [AM6ProfileModule sendNoDevice:self.bridge];
        
    }
    
}



RCT_EXPORT_METHOD(setUserInfo:(nonnull NSString *)mac :(nonnull NSString *)userID :(int)gender :(int)age :(int)height :(int)weight){
    
    if ([self getAM6WithMac:mac]!=nil) {
        
        __weak typeof(self) weakSelf = self;
        
        [[self getAM6WithMac:mac] setUserInfoWithUserIdMD5:[AM6ProfileModule md5:userID] gender:gender age:age height:height weight:weight success:^{
            
            [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:AM6_EVENT_NOTIFY body:@{
                                           AM6_ACTION:ACTION_SET_USER,
                                           AM6_KEY_MAC:mac,
                                           AM6_TYPE:DEVICE_TYPE,
                                           AM6_SET_USERINFO_RESULT:@1,
                                       }];
            
        } fail:^(int error) {
            
            if(error==AM6DeviceError_WrongUserIDInput){
                
                [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:AM6_EVENT_NOTIFY body:@{
                                               AM6_ACTION:ACTION_SET_USER,
                                               AM6_KEY_MAC:mac,
                                               AM6_TYPE:DEVICE_TYPE,
                                               AM6_SET_USERINFO_RESULT:@0,
                                           }];
                
            }else{
              
                [AM6ProfileModule sendErrorToBridge:weakSelf.bridge eventNotify:AM6_EVENT_NOTIFY WithCode:error  mac:mac];
                
            }
            
           
        }];
    }else{
        
        [AM6ProfileModule sendNoDevice:self.bridge];
        
    }
    
}

RCT_EXPORT_METHOD(setPhonePlatform:(nonnull NSString *)mac){
    
    if ([self getAM6WithMac:mac]!=nil) {
        
        __weak typeof(self) weakSelf = self;
        
        [[self getAM6WithMac:mac] setPlatformWithSuccess:^{
            
            [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:AM6_EVENT_NOTIFY body:@{
                                           AM6_ACTION:ACTION_SET_PHONEPLATFORM,
                                           AM6_KEY_MAC:mac,
                                           AM6_TYPE:DEVICE_TYPE,
                                       }];
            
        } fail:^(int error) {
            [AM6ProfileModule sendErrorToBridge:weakSelf.bridge eventNotify:AM6_EVENT_NOTIFY WithCode:error  mac:mac];
        }];
    }else{
        
        [AM6ProfileModule sendNoDevice:self.bridge];
        
    }
    
}
RCT_EXPORT_METHOD(findDevice:(nonnull NSString *)mac :(int)flag){
    
    if ([self getAM6WithMac:mac]!=nil) {
        
        __weak typeof(self) weakSelf = self;
        
        [[self getAM6WithMac:mac] findDevice:flag success:^{
            
            [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:AM6_EVENT_NOTIFY body:@{
                                           AM6_ACTION:ACTION_FIND_DEVICE,
                                           AM6_KEY_MAC:mac,
                                           AM6_TYPE:DEVICE_TYPE,
                                           AM6_FIND_DEVICE_STATUS:@1,
                                       }];
            
            
        } fail:^(int error) {
            
            [AM6ProfileModule sendErrorToBridge:weakSelf.bridge eventNotify:AM6_EVENT_NOTIFY WithCode:error  mac:mac];
            
        }];
    }else{
        
        [AM6ProfileModule sendNoDevice:self.bridge];
        
    }
    
}

- (void)am6StartFindPhoneNoti:(NSNotification *)noti{
    
    [self.bridge.eventDispatcher sendDeviceEventWithName:AM6_EVENT_NOTIFY body:@{
                                   AM6_ACTION:ACTION_FIND_PHONE,
                                   AM6_KEY_MAC:[[noti userInfo] valueForKey:AM6_KEY_MAC],
                                   AM6_TYPE:DEVICE_TYPE,
                                   AM6_FIND_PHONE_STATUS:@0
                               }];
}

- (void)am6StopFindPhoneNoti:(NSNotification *)noti{
    
    [self.bridge.eventDispatcher sendDeviceEventWithName:AM6_EVENT_NOTIFY body:@{
                                   AM6_ACTION:ACTION_FIND_PHONE,
                                   AM6_KEY_MAC:[[noti userInfo] valueForKey:AM6_KEY_MAC],
                                   AM6_TYPE:DEVICE_TYPE,
                                   AM6_FIND_PHONE_STATUS:@1
                               }];
}


RCT_EXPORT_METHOD(notifyMessage:(nonnull NSString *)mac :(int)time :(int)enable :(int)flag :(nonnull NSString *)title :(nonnull NSString *)detail){
    
    [AM6ProfileModule sendErrorToBridge:self.bridge eventNotify:AM6_EVENT_NOTIFY WithCode:404 mac:mac];
    
}


RCT_EXPORT_METHOD(rebootDevice:(nonnull NSString *)mac){
    
    if ([self getAM6WithMac:mac]!=nil) {
        
        __weak typeof(self) weakSelf = self;
        
        NSString*deviceMAC=[[self getAM6WithMac:mac].serialNumber copy];
        
        [[self getAM6WithMac:mac] rebootDeviceWithSuccess:^{
            
            [self.bridge.eventDispatcher sendDeviceEventWithName:AM6_EVENT_NOTIFY body:@{
                                           AM6_ACTION:ACTION_REBOOT_DEVICE,
                                           AM6_KEY_MAC:deviceMAC,
                                           AM6_TYPE:DEVICE_TYPE,
                                       }];
            
        } fail:^(int error) {
            
            [AM6ProfileModule sendErrorToBridge:weakSelf.bridge eventNotify:AM6_EVENT_NOTIFY WithCode:error  mac:mac];
            
        }];
    }else{
        
        [AM6ProfileModule sendNoDevice:self.bridge];
        
    }
    
}

RCT_EXPORT_METHOD(getTime:(nonnull NSString *)mac){
    
    if ([self getAM6WithMac:mac]!=nil) {
        
        __weak typeof(self) weakSelf = self;
        
        [[self getAM6WithMac:mac] queryDeviceTimeWithSuccess:^{
            
            [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:AM6_EVENT_NOTIFY body:@{
                                           AM6_ACTION:ACTION_GET_TIME,
                                           AM6_KEY_MAC:mac,
                                           AM6_TYPE:DEVICE_TYPE,
                                           AM6_GET_TIME:[weakSelf getAM6WithMac:mac].deviceTime,
                                           AM6_TIME_FORMAT:@([weakSelf getAM6WithMac:mac].is12HoursFormat),
                                        
                                       }];
            
        } fail:^(int error) {
            
            [AM6ProfileModule sendErrorToBridge:weakSelf.bridge eventNotify:AM6_EVENT_NOTIFY WithCode:error  mac:mac];
        }];
    }else{
        
        [AM6ProfileModule sendNoDevice:self.bridge];
    }
    
}

RCT_EXPORT_METHOD(setTargetRemind:(nonnull NSString *)mac :(BOOL)enable :(NSInteger)calorie :(NSInteger)steps){
    
    if ([self getAM6WithMac:mac]!=nil) {
        
        __weak typeof(self) weakSelf = self;
        
        [[self getAM6WithMac:mac] setGoalReminderEnable:enable calorie:calorie steps:steps success:^{
            
            [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:AM6_EVENT_NOTIFY body:@{
                                           AM6_ACTION:ACTION_SET_REMINDER,
                                           AM6_KEY_MAC:mac,
                                           AM6_TYPE:DEVICE_TYPE,
                                           AM6_SET_REMINDER_RESULT:@1
                                        
                                       }];
            
        } fail:^(int error) {
            [AM6ProfileModule sendErrorToBridge:weakSelf.bridge eventNotify:AM6_EVENT_NOTIFY WithCode:error  mac:mac];
        }];
        
    }else{
        
        [AM6ProfileModule sendNoDevice:self.bridge];
    }
    
}

RCT_EXPORT_METHOD(getTargetRemind:(nonnull NSString *)mac){
    
    if ([self getAM6WithMac:mac]!=nil) {
        
        __weak typeof(self) weakSelf = self;
        
        [[self getAM6WithMac:mac] queryGoalReminderWithSuccess:^{
            
            [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:AM6_EVENT_NOTIFY body:@{
                                           AM6_ACTION:ACTION_GET_REMINDER,
                                           AM6_KEY_MAC:mac,
                                           AM6_TYPE:DEVICE_TYPE,
                                           AM6_GET_REMINDER_RESULT:@1,
                                           AM6_GET_REMINDER_STEP:@([weakSelf getAM6WithMac:mac].stepsGoal),
                                           AM6_GET_REMINDER_CALORIE:@([weakSelf getAM6WithMac:mac].caloGoal),
                                           AM6_GET_REMINDER_ENABLE:@([weakSelf getAM6WithMac:mac].isActivityGoalOn),
                                       }];
            
        } fail:^(int error) {
            [AM6ProfileModule sendErrorToBridge:weakSelf.bridge eventNotify:AM6_EVENT_NOTIFY WithCode:error  mac:mac];
        }];
    }else{
        
        [AM6ProfileModule sendNoDevice:self.bridge];
    }
    
}

RCT_EXPORT_METHOD(setSedentaryRemind:(nonnull NSString *)mac :(BOOL)enable :(NSInteger)start :(NSInteger)end){
    
    if ([self getAM6WithMac:mac]!=nil) {
        
        __weak typeof(self) weakSelf = self;
        
        [[self getAM6WithMac:mac] setStretchReminderEnable:enable start:start end:end success:^{
            
            [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:AM6_EVENT_NOTIFY body:@{
                                           AM6_ACTION:ACTION_SET_SENDENTARY,
                                           AM6_KEY_MAC:mac,
                                           AM6_TYPE:DEVICE_TYPE,
                                           AM6_SET_SENDENTARY_RESULT:@1
                                        
                                       }];
            
        } fail:^(int error) {
            [AM6ProfileModule sendErrorToBridge:weakSelf.bridge eventNotify:AM6_EVENT_NOTIFY WithCode:error  mac:mac];
        }];
        
    }else{
        
        [AM6ProfileModule sendNoDevice:self.bridge];
    }
    
}

RCT_EXPORT_METHOD(getSedentaryRemind:(nonnull NSString *)mac){
    
    if ([self getAM6WithMac:mac]!=nil) {
        
        __weak typeof(self) weakSelf = self;
        
        [[self getAM6WithMac:mac] queryStretchReminderWithSuccess:^{
            [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:AM6_EVENT_NOTIFY body:@{
                                           AM6_ACTION:ACTION_GET_SENDENTARY,
                                           AM6_KEY_MAC:mac,
                                           AM6_TYPE:DEVICE_TYPE,
                                           AM6_GET_SENDENTARY_RESULT:@1,
                                           AM6_GET_SENDENTARY_STARTTIME:@([weakSelf getAM6WithMac:mac].stretchReminderStartTime),
                                           AM6_GET_SENDENTARY_ENDTIME:@([weakSelf getAM6WithMac:mac].stretchReminderEndTime),
                                           AM6_GET_SENDENTARY_ENABLE:@([weakSelf getAM6WithMac:mac].isStretchReminderOn),
                                       }];
        } fail:^(int error) {
            [AM6ProfileModule sendErrorToBridge:weakSelf.bridge eventNotify:AM6_EVENT_NOTIFY WithCode:error  mac:mac];
        }];
    }else{
        
        [AM6ProfileModule sendNoDevice:self.bridge];
    }
    
}


RCT_EXPORT_METHOD(setRaiseToLightRemind:(nonnull NSString *)mac :(BOOL)enable :(NSInteger)start :(NSInteger)end){
    
    if ([self getAM6WithMac:mac]!=nil) {
        
        __weak typeof(self) weakSelf = self;
        
        [[self getAM6WithMac:mac] setRaiseWakeEnable:enable start:start end:end success:^{
            
            [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:AM6_EVENT_NOTIFY body:@{
                                           AM6_ACTION:ACTION_SET_RAISE,
                                           AM6_KEY_MAC:mac,
                                           AM6_TYPE:DEVICE_TYPE,
                                           AM6_SET_RAISE_RESULT:@1
                                        
                                       }];
            
        } fail:^(int error) {
            [AM6ProfileModule sendErrorToBridge:weakSelf.bridge eventNotify:AM6_EVENT_NOTIFY WithCode:error  mac:mac];
        }];
        
    }else{
        
        [AM6ProfileModule sendNoDevice:self.bridge];
    }
    
}

RCT_EXPORT_METHOD(getRaiseToLightRemind:(nonnull NSString *)mac){
    
    if ([self getAM6WithMac:mac]!=nil) {
        
        __weak typeof(self) weakSelf = self;
        
        [[self getAM6WithMac:mac] queryRaiseWakeWithSuccess:^{
            [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:AM6_EVENT_NOTIFY body:@{
                                           AM6_ACTION:ACTION_GET_RAISE,
                                           AM6_KEY_MAC:mac,
                                           AM6_TYPE:DEVICE_TYPE,
                                           AM6_GET_RAISE_RESULT:@1,
                                           AM6_GET_RAISE_STARTTIME:@([weakSelf getAM6WithMac:mac].raiseToWakeStartTime),
                                           AM6_GET_RAISE_ENDTIME:@([weakSelf getAM6WithMac:mac].raiseToWakeEndTime),
                                           AM6_GET_RAISE_ENABLE:@([weakSelf getAM6WithMac:mac].isRaiseToWakeOn),
                                       }];
        } fail:^(int error) {
            [AM6ProfileModule sendErrorToBridge:weakSelf.bridge eventNotify:AM6_EVENT_NOTIFY WithCode:error  mac:mac];
        }];
    }else{
        
        [AM6ProfileModule sendNoDevice:self.bridge];
    }
    
}

RCT_EXPORT_METHOD(setDoNotDisturbMode:(nonnull NSString *)mac :(BOOL)enable :(NSInteger)start :(NSInteger)end){
    
    if ([self getAM6WithMac:mac]!=nil) {
        
        __weak typeof(self) weakSelf = self;
        
        [[self getAM6WithMac:mac] setNotDisturbEnable:enable start:start end:end success:^{
            
            [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:AM6_EVENT_NOTIFY body:@{
                                           AM6_ACTION:ACTION_SET_DONOTDISTURB,
                                           AM6_KEY_MAC:mac,
                                           AM6_TYPE:DEVICE_TYPE,
                                           AM6_SET_DONOTDISTURB_RESULT:@1
                                        
                                       }];
            
        } fail:^(int error) {
            [AM6ProfileModule sendErrorToBridge:weakSelf.bridge eventNotify:AM6_EVENT_NOTIFY WithCode:error  mac:mac];
        }];
        
    }else{
        
        [AM6ProfileModule sendNoDevice:self.bridge];
    }
    
}

RCT_EXPORT_METHOD(getDoNotDisturbMode:(nonnull NSString *)mac){
    
    if ([self getAM6WithMac:mac]!=nil) {
        
        __weak typeof(self) weakSelf = self;
        
        [[self getAM6WithMac:mac] queryNotDisturbWithSuccess:^{
            [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:AM6_EVENT_NOTIFY body:@{
                                           AM6_ACTION:ACTION_GET_DONOTDISTURB,
                                           AM6_KEY_MAC:mac,
                                           AM6_TYPE:DEVICE_TYPE,
                                           AM6_GET_DONOTDISTURB_RESULT:@1,
                                           AM6_GET_DONOTDISTURB_STARTTIME:@([weakSelf getAM6WithMac:mac].doNotDisturbStartTime),
                                           AM6_GET_DONOTDISTURB_ENDTIME:@([weakSelf getAM6WithMac:mac].doNotDisturbEndTime),
                                           AM6_GET_DONOTDISTURB_ENABLE:@([weakSelf getAM6WithMac:mac].isDoNotDisturbOn),
                                       }];
        } fail:^(int error) {
            [AM6ProfileModule sendErrorToBridge:weakSelf.bridge eventNotify:AM6_EVENT_NOTIFY WithCode:error  mac:mac];
        }];
    }else{
        
        [AM6ProfileModule sendNoDevice:self.bridge];
    }
    
}

RCT_EXPORT_METHOD(setWearHand:(nonnull NSString *)mac :(NSInteger)hand){
    
    if ([self getAM6WithMac:mac]!=nil) {
        
        __weak typeof(self) weakSelf = self;
        
        [[self getAM6WithMac:mac] setWearHand:hand success:^{
            
            [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:AM6_EVENT_NOTIFY body:@{
                                           AM6_ACTION:ACTION_SET_WEARHAND,
                                           AM6_KEY_MAC:mac,
                                           AM6_TYPE:DEVICE_TYPE,
                                           AM6_SET_WEARHAND_RESULT:@1
                                        
                                       }];
            
        } fail:^(int error) {
            [AM6ProfileModule sendErrorToBridge:weakSelf.bridge eventNotify:AM6_EVENT_NOTIFY WithCode:error  mac:mac];
        }];
        
    }else{
        
        [AM6ProfileModule sendNoDevice:self.bridge];
    }
    
}

RCT_EXPORT_METHOD(getWearHand:(nonnull NSString *)mac){
    
    if ([self getAM6WithMac:mac]!=nil) {
        
        __weak typeof(self) weakSelf = self;
        
        [[self getAM6WithMac:mac] queryWearHandWithSuccess:^{
            [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:AM6_EVENT_NOTIFY body:@{
                                           AM6_ACTION:ACTION_GET_WEARHAND,
                                           AM6_KEY_MAC:mac,
                                           AM6_TYPE:DEVICE_TYPE,
                                           AM6_GET_WEARHAND_RESULT:@1,
                                           AM6_GET_WEARHAND_HAND:@([weakSelf getAM6WithMac:mac].wristHand),
                    
                                       }];
        } fail:^(int error) {
            [AM6ProfileModule sendErrorToBridge:weakSelf.bridge eventNotify:AM6_EVENT_NOTIFY WithCode:error  mac:mac];
        }];
    }else{
        
        [AM6ProfileModule sendNoDevice:self.bridge];
    }
    
}

//If the passed list is an empty string, it means deleting all alarm clocks in AM6

RCT_EXPORT_METHOD(setAlarmClockList:(nonnull NSString *)mac :(nonnull NSString *)list){
    
    if ([self getAM6WithMac:mac]!=nil) {
        
        __weak typeof(self) weakSelf = self;
        
        
        if(list.length==0){
            
            [[self getAM6WithMac:mac] setAlartList:[NSArray array] success:^{
                
                [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:AM6_EVENT_NOTIFY body:@{
                                               AM6_ACTION:ACTION_SET_ALARMLIST,
                                               AM6_KEY_MAC:mac,
                                               AM6_TYPE:DEVICE_TYPE,
                                               AM6_SET_ALARMLIST_LIST:@1,
                        
                                           }];
                
                
            } fail:^(int error) {
                [AM6ProfileModule sendErrorToBridge:weakSelf.bridge eventNotify:AM6_EVENT_NOTIFY WithCode:error  mac:mac];
            }];
            
            return;
            
        }
        
        
        
        NSArray*array=[list componentsSeparatedByString:@";"];
        
        if(array.count==0){
           
            [AM6ProfileModule sendErrorToBridge:weakSelf.bridge eventNotify:AM6_EVENT_NOTIFY WithCode:AM6DeviceError_InputParameterError mac:mac];
            
            return;
        }
        
        NSMutableArray *mArr = [NSMutableArray new];
        
        for (int i=0; i<array.count; i++) {
            
            NSArray*tempArray=[[array objectAtIndex:i] componentsSeparatedByString:@":"];
            
            if(tempArray.count!=3){
                
                [AM6ProfileModule sendErrorToBridge:weakSelf.bridge eventNotify:AM6_EVENT_NOTIFY WithCode:AM6DeviceError_InputParameterError mac:mac];
                
                return;
                
            }else{
                
                AM6AlarmModel *model = [AM6AlarmModel new];
                
                model.isOn=[[tempArray objectAtIndex:0] boolValue];
                
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
                dateFormatter.dateFormat = @"HHmm";
                dateFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US"];
                
                NSArray*repeatArray=[[tempArray objectAtIndex:1] componentsSeparatedByString:@"-"];
    
                
                uint8_t mode=0;
                
                for (int j=0; j<7; j++) {
                    
                    if ([[repeatArray objectAtIndex:j] intValue]) {
                        mode |= (0x01 << j);
                    } else {
                        mode &= ~(0x01 << j);
                    }
                }
                
                model.repeatMode=mode;
               
                struct AM6DateStruct alarmDate = {0};
               
                alarmDate.hour=[[tempArray objectAtIndex:2] intValue]/60;
                alarmDate.min=[[tempArray objectAtIndex:2] intValue]%60;
                model.date=alarmDate;
                
                [mArr addObject:model];
            }
            
           
           
        }
        
        
        [[self getAM6WithMac:mac] setAlartList:mArr success:^{
            
            [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:AM6_EVENT_NOTIFY body:@{
                                           AM6_ACTION:ACTION_SET_ALARMLIST,
                                           AM6_KEY_MAC:mac,
                                           AM6_TYPE:DEVICE_TYPE,
                                           AM6_SET_ALARMLIST_LIST:@1,
                    
                                       }];
            
            
        } fail:^(int error) {
            [AM6ProfileModule sendErrorToBridge:weakSelf.bridge eventNotify:AM6_EVENT_NOTIFY WithCode:error  mac:mac];
        }];
        
    }else{
        
        [AM6ProfileModule sendNoDevice:self.bridge];
    }
    
}

RCT_EXPORT_METHOD(getAlarmClockList:(nonnull NSString *)mac){
    
    if ([self getAM6WithMac:mac]!=nil) {
        
        __weak typeof(self) weakSelf = self;
        
        [[self getAM6WithMac:mac] queryAlarmListWithSuccess:^{
            
            NSMutableArray*alarmArray=[[weakSelf getAM6WithMac:mac].alarmList copy];
            
            NSMutableArray*alarmArrayResult=[NSMutableArray array];
            
            for (int i=0; i<alarmArray.count; i++) {
                
                NSMutableDictionary*alarmDic=[NSMutableDictionary dictionary];
                
                AM6AlarmModel*model=[alarmArray objectAtIndex:i];
                
                [alarmDic setValue:@(model.isOn) forKey:AM6_GET_ALARMLIST_ENABLE];
                [alarmDic setValue:@(model.date.hour*60+model.date.min) forKey:AM6_GET_ALARMLIST_TIME];
                uint8_t mode=model.repeatMode;
                NSMutableArray *mArr = [NSMutableArray new];
                for (uint8_t i=0; i<7; i++) {
                    if ((mode>>i & 0x01) == 0x01) {
                       
                        [mArr addObject:@1];
                    }else{
                        
                        [mArr addObject:@0];
                    }
                }
                
                [alarmDic setValue:mArr forKey:AM6_GET_ALARMLIST_WEEK];
                
                [alarmArrayResult addObject:alarmDic];
                
            }
            
            [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:AM6_EVENT_NOTIFY body:@{
                                           AM6_ACTION:ACTION_GET_ALARMLIST,
                                           AM6_KEY_MAC:mac,
                                           AM6_TYPE:DEVICE_TYPE,
                                           AM6_GET_ALARMLIST_LIST:alarmArrayResult,
                                           AM6_GET_ALARMLIST_STATUS:@1,
                                       }];
        } fail:^(int error) {
            [AM6ProfileModule sendErrorToBridge:weakSelf.bridge eventNotify:AM6_EVENT_NOTIFY WithCode:error  mac:mac];
        }];
    }else{
        
        [AM6ProfileModule sendNoDevice:self.bridge];
    }
    
}


RCT_EXPORT_METHOD(startBind:(nonnull NSString *)mac){
    
    if ([self getAM6WithMac:mac]!=nil) {
        
        __weak typeof(self) weakSelf = self;
        
      
        
        [[self getAM6WithMac:mac] sendStartBindWithSuccess:^{
            [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:AM6_EVENT_NOTIFY body:@{
                                           AM6_ACTION:ACTION_SET_STARTBIND,
                                           AM6_KEY_MAC:mac,
                                           AM6_TYPE:DEVICE_TYPE,
                    
                                       }];
        } fail:^(int error) {
            [AM6ProfileModule sendErrorToBridge:weakSelf.bridge eventNotify:AM6_EVENT_NOTIFY WithCode:error  mac:mac];
        }];
        
    }else{
        
        [AM6ProfileModule sendNoDevice:self.bridge];
    }
    
}

RCT_EXPORT_METHOD(bindUserSuccess:(nonnull NSString *)mac :(nonnull NSString *)userID){
    
    if ([self getAM6WithMac:mac]!=nil) {
        
        __weak typeof(self) weakSelf = self;
        
      
        
        [[self getAM6WithMac:mac] sendSuccessBindWithUserId:[AM6ProfileModule md5:userID] success:^{
            
            [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:AM6_EVENT_NOTIFY body:@{
                                           AM6_ACTION:ACTION_SET_BINDSUCCESS,
                                           AM6_KEY_MAC:mac,
                                           AM6_TYPE:DEVICE_TYPE,
                    
                                       }];
        } fail:^(int error) {
            [AM6ProfileModule sendErrorToBridge:weakSelf.bridge eventNotify:AM6_EVENT_NOTIFY WithCode:error  mac:mac];
        }];
        
    }else{
        
        [AM6ProfileModule sendNoDevice:self.bridge];
    }
    
}

RCT_EXPORT_METHOD(bindUserFail:(nonnull NSString *)mac){
    
    if ([self getAM6WithMac:mac]!=nil) {
        
        __weak typeof(self) weakSelf = self;
        
        [[self getAM6WithMac:mac] sendFailBindWithSuccess:^{
            
            [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:AM6_EVENT_NOTIFY body:@{
                                           AM6_ACTION:ACTION_SET_BINDFAIL,
                                           AM6_KEY_MAC:mac,
                                           AM6_TYPE:DEVICE_TYPE,
                    
                                       }];
        } fail:^(int error) {
            [AM6ProfileModule sendErrorToBridge:weakSelf.bridge eventNotify:AM6_EVENT_NOTIFY WithCode:error  mac:mac];
        }];
        
    }else{
        
        [AM6ProfileModule sendNoDevice:self.bridge];
    }
    
}

RCT_EXPORT_METHOD(unBindUser:(nonnull NSString *)mac :(nonnull NSString *)userID){
    
    if ([self getAM6WithMac:mac]!=nil) {
        
        __weak typeof(self) weakSelf = self;
        
      
        
        [[self getAM6WithMac:mac] sendUnbindWithUserId:[AM6ProfileModule md5:userID] success:^{
            [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:AM6_EVENT_NOTIFY body:@{
                                           AM6_ACTION:ACTION_SET_UNBIND,
                                           AM6_KEY_MAC:mac,
                                           AM6_TYPE:DEVICE_TYPE,
                                           AM6_SET_UNBIND:@1,
                                       }];
        } fail:^(int error) {
            
            if(error == AM6DeviceError_ActionFail){
                
                [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:AM6_EVENT_NOTIFY body:@{
                                               AM6_ACTION:ACTION_SET_UNBIND,
                                               AM6_KEY_MAC:mac,
                                               AM6_TYPE:DEVICE_TYPE,
                                               AM6_SET_UNBIND:@0,
                                           }];
                
            }else{
                
                [AM6ProfileModule sendErrorToBridge:weakSelf.bridge eventNotify:AM6_EVENT_NOTIFY WithCode:error  mac:mac];
            }
            
           
        }];
        
    }else{
        
        [AM6ProfileModule sendNoDevice:self.bridge];
    }
    
}

#pragma mark - DATA

RCT_EXPORT_METHOD(readySyncData:(nonnull NSString *)mac){
    
    if ([self getAM6WithMac:mac]!=nil) {
        
        __weak typeof(self) weakSelf = self;
        
        [[self getAM6WithMac:mac] prepareSyncWithSuccess:^{
            
            [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:AM6_EVENT_NOTIFY body:@{
                AM6_ACTION:ACTION_SYNC_READY,
                AM6_KEY_MAC:mac,
                AM6_TYPE:DEVICE_TYPE,
                AM6_SYNC_STATUS:@1,
            }];
                
            } fail:^(int error) {
                [AM6ProfileModule sendErrorToBridge:weakSelf.bridge eventNotify:AM6_EVENT_NOTIFY WithCode:error  mac:mac];
            }];
            
        }else{
            
            [AM6ProfileModule sendNoDevice:self.bridge];
        }
        
    
}
RCT_EXPORT_METHOD(getDailyData:(nonnull NSString *)mac){
        
        if ([self getAM6WithMac:mac]!=nil) {
            
            __weak typeof(self) weakSelf = self;

            [[self getAM6WithMac:mac] syncDailyActivityReportWithSuccess:^{
                
                NSMutableArray*dailyArray=[[weakSelf getAM6WithMac:mac].reportArray copy];
                
                NSMutableArray*dailyArrayResult=[NSMutableArray array];
                
                for (int i=0; i<dailyArray.count; i++) {
                    
                    NSMutableDictionary*dailyDic=[NSMutableDictionary dictionary];
                    
                    AM6DeviceDailyActivityReportModel*model=[dailyArray objectAtIndex:i];
                    
                    [dailyDic setValue:@(model.spo2) forKey:AM6_GET_DAILYDATA_PO];
                    [dailyDic setValue:@(model.calorie) forKey:AM6_GET_DAILYDATA_CALORIE];
                    [dailyDic setValue:model.dateString forKey:AM6_GET_DAILYDATA_DATE];
                    [dailyDic setValue:@(model.effectiveStand) forKey:AM6_GET_DAILYDATA_EFFECTIVESTAND];
                    [dailyDic setValue:@(model.heartRate) forKey:AM6_GET_DAILYDATA_HEARTRATE];
                    [dailyDic setValue:@(model.heartRateMax) forKey:AM6_GET_DAILYDATA_MAXHEARTRATE];
                    [dailyDic setValue:model.heartRateMaxTime forKey:AM6_GET_DAILYDATA_MAXHEARTRATETIME];
                    [dailyDic setValue:@(model.heartRateAve) forKey:AM6_GET_DAILYDATA_MEANHEARTRATE];
                    [dailyDic setValue:@(model.heartRateMin) forKey:AM6_GET_DAILYDATA_MINHEARTRATE];
                    [dailyDic setValue:model.heartRateMinTime forKey:AM6_GET_DAILYDATA_MINHEARTRATETIME];
                    [dailyDic setValue:@(model.heartRateResting) forKey:AM6_GET_DAILYDATA_RESTHEARTRATE];
                    [dailyDic setValue:@(model.steps) forKey:AM6_GET_DAILYDATA_STEP];
                    
                    [dailyArrayResult addObject:dailyDic];
                    
                }
                
                [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:AM6_EVENT_NOTIFY body:@{
                    AM6_ACTION:ACTION_GET_DAILYDATA,
                    AM6_KEY_MAC:mac,
                    AM6_TYPE:DEVICE_TYPE,
                    AM6_GET_DAILYDATA:dailyArrayResult,
                }];
                
            } fail:^(int error) {
                [AM6ProfileModule sendErrorToBridge:weakSelf.bridge eventNotify:AM6_EVENT_NOTIFY WithCode:error  mac:mac];
            }];
            
        }else{
            
            [AM6ProfileModule sendNoDevice:self.bridge];
        }
        
}
    

RCT_EXPORT_METHOD(getStepData:(nonnull NSString *)mac){
        
        if ([self getAM6WithMac:mac]!=nil) {
            
            __weak typeof(self) weakSelf = self;

            [[self getAM6WithMac:mac] syncDailyStepsCalorieDistanceWithSuccess:^{
                
                
                NSMutableArray*dailyArray=[[weakSelf getAM6WithMac:mac].dailyStepsArray copy];
                
                NSMutableArray*dailyArrayResult=[NSMutableArray array];
                
                for (int i=0; i<dailyArray.count; i++) {
                    
                    NSMutableDictionary*dailyDic=[NSMutableDictionary dictionary];
                    
                    AM6DeviceDailyStepModel*model=[dailyArray objectAtIndex:i];
                    
                    NSMutableArray*dailyArrayList=[NSMutableArray array];
                    
                    for (int j=0; j<model.distanceArray.count; j++) {
                        NSMutableDictionary*tempDic=[NSMutableDictionary dictionary];
                        [tempDic setValue:model.distanceArray[j] forKey:AM6_GET_STEPDATA_DISTANCE];
                        [tempDic setValue:model.calorieArray[j] forKey:AM6_GET_STEPDATA_CALORIE];
                        [tempDic setValue:model.stepsArray[j] forKey:AM6_GET_STEPDATA_STEP];
                        [dailyArrayList addObject:tempDic];
                    }
                    
                    [dailyDic setValue:model.dateString forKey:AM6_GET_STEPDATA_DATE];
                    [dailyDic setValue:dailyArrayList forKey:AM6_GET_STEPDATA_LIST];
                    
                    [dailyArrayResult addObject:dailyDic];
                    
                }
                
                [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:AM6_EVENT_NOTIFY body:@{
                    AM6_ACTION:ACTION_GET_STEPDATA,
                    AM6_KEY_MAC:mac,
                    AM6_TYPE:DEVICE_TYPE,
                    AM6_GET_STEPDATA:dailyArrayResult,
                }];
                
            } fail:^(int error) {
                [AM6ProfileModule sendErrorToBridge:weakSelf.bridge eventNotify:AM6_EVENT_NOTIFY WithCode:error  mac:mac];
            }];
            
        }else{
            
            [AM6ProfileModule sendNoDevice:self.bridge];
        }
        
}

RCT_EXPORT_METHOD(getSleepData:(nonnull NSString *)mac){
        
        if ([self getAM6WithMac:mac]!=nil) {
            
            __weak typeof(self) weakSelf = self;

            [[self getAM6WithMac:mac] syncSleepWithSuccess:^{
                
                NSMutableArray*sleepArray=[[weakSelf getAM6WithMac:mac].sleepArray copy];
                
                NSMutableArray*sleepArrayResult=[NSMutableArray array];
                
                for (int i=0; i<sleepArray.count; i++) {
                    
                    NSMutableDictionary*sleepDic=[NSMutableDictionary dictionary];
                    
                    AM6DeviceSleepModel*model=[sleepArray objectAtIndex:i];
                    
                    [sleepDic setValue:model.dateString forKey:AM6_GET_SLEEPDATA_DATE];
                    
                    NSMutableArray*sleepItemArray=[NSMutableArray array];
                    
                    for (int j=0; j<model.dataArray.count; j++) {
                        
                        NSMutableDictionary*sleepItemDic=[NSMutableDictionary dictionary];
                        
                        AM6DeviceSleepItem*itemMode=[model.dataArray objectAtIndex:j];
                        
                        [sleepItemDic setValue:itemMode.timeString forKey:AM6_GET_SLEEPDATA_MODE_DATE];
                        [sleepItemDic setValue:@(itemMode.status) forKey:AM6_GET_SLEEPDATA_MODE];
                        
                        [sleepItemArray addObject:sleepItemDic];
                        
                    }
                    
                    [sleepDic setValue:sleepItemArray forKey:AM6_GET_SLEEPDATA_LIST];
                    
                    [sleepArrayResult addObject:sleepDic];
                    
                }
                
                [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:AM6_EVENT_NOTIFY body:@{
                    AM6_ACTION:ACTION_GET_SLEEPDATA,
                    AM6_KEY_MAC:mac,
                    AM6_TYPE:DEVICE_TYPE,
                    AM6_GET_SLEEPDATA:sleepArrayResult,
                }];
                
            } fail:^(int error) {
                [AM6ProfileModule sendErrorToBridge:weakSelf.bridge eventNotify:AM6_EVENT_NOTIFY WithCode:error  mac:mac];
            }];
            
        }else{
            
            [AM6ProfileModule sendNoDevice:self.bridge];
        }
        
}


RCT_EXPORT_METHOD(getHeartRateData:(nonnull NSString *)mac){
        
        if ([self getAM6WithMac:mac]!=nil) {
            
            __weak typeof(self) weakSelf = self;

            [[self getAM6WithMac:mac] syncDailyHeartRateWithSuccess:^{
                
                NSMutableArray*heartRateArray=[[weakSelf getAM6WithMac:mac].dailyHeartRateArray copy];
                
                NSMutableArray*heartRateResult=[NSMutableArray array];
                
                for (int i=0; i<heartRateArray.count; i++) {
                    
                    NSMutableDictionary*heartRateDic=[NSMutableDictionary dictionary];
                    
                    AM6DeviceHeartRateModel*model=[heartRateArray objectAtIndex:i];
                    
                    [heartRateDic setValue:model.dateString forKey:AM6_GET_HEARTRATE_DATE];
                    
                    NSMutableArray*heartRateArrayList=[NSMutableArray array];
                    
                    for (int j=0; j<model.dataArray.count; j++) {
                        
                        NSMutableDictionary*tempDic=[NSMutableDictionary dictionary];
                        
                        [tempDic setValue:model.dataArray[j] forKey:AM6_GET_HEARTRATE_HEARTRATE];
                        
                        [heartRateArrayList addObject:tempDic];
                    }
                    
                    [heartRateDic setValue:heartRateArrayList forKey:AM6_GET_HEARTRATE_LIST];
                    
                    [heartRateResult addObject:heartRateDic];
                    
                }
                
                [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:AM6_EVENT_NOTIFY body:@{
                    AM6_ACTION:ACTION_GET_HEARTRATE,
                    AM6_KEY_MAC:mac,
                    AM6_TYPE:DEVICE_TYPE,
                    AM6_GET_HEARTRATE:heartRateResult,
                }];
                
            } fail:^(int error) {
                [AM6ProfileModule sendErrorToBridge:weakSelf.bridge eventNotify:AM6_EVENT_NOTIFY WithCode:error  mac:mac];
            }];
            
        }else{
            
            [AM6ProfileModule sendNoDevice:self.bridge];
        }
        
}


RCT_EXPORT_METHOD(getBloodOxygenData:(nonnull NSString *)mac){
        
        if ([self getAM6WithMac:mac]!=nil) {
            
            __weak typeof(self) weakSelf = self;

            [[self getAM6WithMac:mac] syncOfflineBloodOxygenWithSuccess:^{
                
                NSMutableArray*oxArray=[[weakSelf getAM6WithMac:mac].bloodOxygenArray copy];
                
                NSMutableArray*oxArrayResult=[NSMutableArray array];
                
                for (int i=0; i<oxArray.count; i++) {
                    
                    NSMutableDictionary*oxDic=[NSMutableDictionary dictionary];
                    
                    AM6DeviceOffineBloodOxygenModel*model=[oxArray objectAtIndex:i];
                    
                    [oxDic setValue:model.dateString forKey:AM6_GET_BLOODOXYGEN_DATE];
                    
                    [oxDic setValue:@(model.value) forKey:AM6_GET_BLOODOXYGEN_BLOODOXYGEN];
                    
                    [oxArrayResult addObject:oxDic];
                    
                }
                
                [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:AM6_EVENT_NOTIFY body:@{
                    AM6_ACTION:ACTION_GET_BLOODOXYGEN,
                    AM6_KEY_MAC:mac,
                    AM6_TYPE:DEVICE_TYPE,
                    AM6_GET_BLOODOXYGEN:oxArrayResult,
                }];
                
            } fail:^(int error) {
                [AM6ProfileModule sendErrorToBridge:weakSelf.bridge eventNotify:AM6_EVENT_NOTIFY WithCode:error  mac:mac];
            }];
            
        }else{
            
            [AM6ProfileModule sendNoDevice:self.bridge];
        }
        
}


RCT_EXPORT_METHOD(getActivityData:(nonnull NSString *)mac){
        
        if ([self getAM6WithMac:mac]!=nil) {
            
            __weak typeof(self) weakSelf = self;

            [[self getAM6WithMac:mac] syncSportWithSuccess:^{
                
                NSMutableArray*sportArray=[[weakSelf getAM6WithMac:mac].indoorRunArray copy];
                
                NSMutableArray*sportReportArray=[[weakSelf getAM6WithMac:mac].indoorRunReportArray copy];
                
                NSMutableArray*sportArrayResult=[NSMutableArray array];
                
                for (int i=0; i<sportArray.count; i++) {
                    
                    NSMutableDictionary*sportDic=[NSMutableDictionary dictionary];
                    
                    AM6DeviceIndoorRun*model=[sportArray objectAtIndex:i];
                    
                    NSMutableArray*sportItemArray=[NSMutableArray array];
                    
                    for (int j=0; j<model.dataArray.count; j++) {
                        
                        NSMutableDictionary*sportItemDic=[NSMutableDictionary dictionary];
                        
                        AM6DeviceIndoorRunPart*itemMode=[model.dataArray objectAtIndex:j];
                        
                        [sportItemDic setValue:itemMode.dateString forKey:AM6_GET_ACTIVITYPOINT_DATE];
                        [sportItemDic setValue:itemMode.calorieArray forKey:AM6_GET_ACTIVITYPOINT_CALORIE];
                        [sportItemDic setValue:itemMode.stepArray forKey:AM6_GET_ACTIVITYPOINT_STEP];
                        [sportItemDic setValue:itemMode.heartArray forKey:AM6_GET_ACTIVITYPOINT_HEARTRATE];
                        [sportItemDic setValue:itemMode.distanceArray forKey:AM6_GET_ACTIVITYPOINT_DISTANCE];
                        [sportItemArray addObject:sportItemDic];
                        
                    }
                    
                    [sportDic setValue:sportItemArray forKey:AM6_GET_ACTIVITYPOINT];

                    [sportArrayResult addObject:sportDic];
                    
                }
                
                for (int i=0; i<sportReportArray.count; i++) {
                    
                    NSMutableDictionary*sportReportDic=[NSMutableDictionary dictionary];
                    
                    AM6DeviceIndoorRunReport*model=[sportReportArray objectAtIndex:i];
                    
                    [sportReportDic setValue:@(model.anaerobicTime) forKey:AM6_GET_ACTIVITY_ANAEROBICTIME];
                    [sportReportDic setValue:@(model.aveHeartRate) forKey:AM6_GET_ACTIVITY_AVEHEARTRATE];
                    [sportReportDic setValue:@(model.bodyEnergyCost) forKey:AM6_GET_ACTIVITY_BODYENERGYCOST];
                    [sportReportDic setValue:@(model.cardioTime) forKey:AM6_GET_ACTIVITY_CARDIOTIME];
                    [sportReportDic setValue:model.endDateString forKey:AM6_GET_ACTIVITY_ENDDATE];
                    [sportReportDic setValue:@(model.estimatedRecoveryTime) forKey:AM6_GET_ACTIVITY_ESTIMATED];
                    [sportReportDic setValue:@(model.fatReductionTime) forKey:AM6_GET_ACTIVITY_FATREDTIME];
                    [sportReportDic setValue:@(model.maxHeartRate) forKey:AM6_GET_ACTIVITY_MAXHEARTRATE];
                    [sportReportDic setValue:@(model.maxOxygenUptake) forKey:AM6_GET_ACTIVITY_MAXOX];
                    [sportReportDic setValue:@(model.maxPace) forKey:AM6_GET_ACTIVITY_MAXPACE];
                    [sportReportDic setValue:@(model.maxStepFrequency) forKey:AM6_GET_ACTIVITY_MAXSF];
                    [sportReportDic setValue:@(model.minHeartRate) forKey:AM6_GET_ACTIVITY_MINHEARTRATE];
                    [sportReportDic setValue:@(model.minPace) forKey:AM6_GET_ACTIVITY_MINPACE];
                    [sportReportDic setValue:@(model.peakTime) forKey:AM6_GET_ACTIVITY_PEAKTIME];
                    [sportReportDic setValue:model.startDateString forKey:AM6_GET_ACTIVITY_STARTDATE];
                    [sportReportDic setValue:@(model.totalCalorie) forKey:AM6_GET_ACTIVITY_TOTLECALORIE];
                    [sportReportDic setValue:@(model.totalDistance) forKey:AM6_GET_ACTIVITY_TOTLEDISTANCE];
                    [sportReportDic setValue:@(model.totalStep) forKey:AM6_GET_ACTIVITY_TOTLESTEP];
                    [sportReportDic setValue:@(model.totalTime) forKey:AM6_GET_ACTIVITY_TOTLETIME];
                    [sportReportDic setValue:@(model.trainingEffect) forKey:AM6_GET_ACTIVITY_TRAININGEF];
                    [sportReportDic setValue:@(model.warmUpTime) forKey:AM6_GET_ACTIVITY_WARMUPTIME];
                    
                    
                    NSMutableDictionary*tempReportResultDic=[NSMutableDictionary dictionary];
                    
                    [tempReportResultDic setValue:sportReportDic forKey:AM6_GET_ACTIVITY_REPORT];

                    [sportArrayResult addObject:tempReportResultDic];
                    
                }
                
                [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:AM6_EVENT_NOTIFY body:@{
                    AM6_ACTION:ACTION_GET_ACTIVITY,
                    AM6_KEY_MAC:mac,
                    AM6_TYPE:DEVICE_TYPE,
                    AM6_GET_ACTIVITY:sportArrayResult,
                }];
                
            } fail:^(int error) {
                [AM6ProfileModule sendErrorToBridge:weakSelf.bridge eventNotify:AM6_EVENT_NOTIFY WithCode:error  mac:mac];
            }];
            
        }else{
            
            [AM6ProfileModule sendNoDevice:self.bridge];
        }
        
}

RCT_EXPORT_METHOD(deleteData:(nonnull NSString *)mac :(int)type){
        
        if ([self getAM6WithMac:mac]!=nil) {
            
            __weak typeof(self) weakSelf = self;

            [[self getAM6WithMac:mac] deleteDataWithType:type success:^{
                
                [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:AM6_EVENT_NOTIFY body:@{
                    AM6_ACTION:ACTION_DELETEDATA,
                    AM6_KEY_MAC:mac,
                    AM6_TYPE:DEVICE_TYPE,
                    AM6_DELETEDATA_RESULT:@1,
                }];
                
            } fail:^(int error) {
                
                if(error==AM6DeviceError_ActionFail){
                    
                    [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:AM6_EVENT_NOTIFY body:@{
                        AM6_ACTION:ACTION_DELETEDATA,
                        AM6_KEY_MAC:mac,
                        AM6_TYPE:DEVICE_TYPE,
                        AM6_DELETEDATA_RESULT:@0,
                    }];
                    
                }else{
                    
                    [AM6ProfileModule sendErrorToBridge:weakSelf.bridge eventNotify:AM6_EVENT_NOTIFY WithCode:error  mac:mac];
                }
                
               
            }];
            
        }else{
            
            [AM6ProfileModule sendNoDevice:self.bridge];
        }
        
}
RCT_EXPORT_METHOD(disconnect:(nonnull NSString *)mac){
        
        if ([self getAM6WithMac:mac]!=nil) {
            
            __weak typeof(self) weakSelf = self;
            
            NSString*deviceMAC=[[self getAM6WithMac:mac].serialNumber copy];

            [[self getAM6WithMac:mac] commandAM6Disconnect:^{
                
                [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:AM6_EVENT_NOTIFY body:@{
                    AM6_ACTION:AM6_DISCONNECT_DEVICE,
                    AM6_KEY_MAC:deviceMAC,
                    AM6_TYPE:DEVICE_TYPE,

                }];
                
            } fail:^(int error) {
               
                [AM6ProfileModule sendErrorToBridge:weakSelf.bridge eventNotify:AM6_EVENT_NOTIFY WithCode:error  mac:mac];
            }];
            
        }else{
            
            [AM6ProfileModule sendNoDevice:self.bridge];
        }
        
}

@end
