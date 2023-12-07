//
//  BG1AModule.m
//  ReactNativeIOSLibrary
//
//  Created by user on 2019/11/12.
//  Copyright © 2019 daiqingquan. All rights reserved.
//

#import "BG1AModule.h"
#import "BG1A.h"
#import "BG1AController.h"
#import "BG1AProfileModule.h"

#import "BGHeader.h"


#define DEVICE_TYPE   @"BG1A"

@implementation BG1AModule
@synthesize bridge = _bridge;
RCT_EXPORT_MODULE()

- (NSDictionary *)constantsToExport
{
    return @{ @"Event_Notify": BG1A_EVENT_NOTIFY ,
              
    };
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
        
        
        [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(handleStripStatusNoti:) name:kBG1ANotiNameStripStatus object:nil];
        [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(handleResultNoti:) name:kBG1ANotiNameResult object:nil];
        [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(handleErrorNoti:) name:kBG1ANotiNameError object:nil];
        
    }
    
    
    return self;
}

#pragma mark -
- (void)handleStripStatusNoti:(NSNotification*)noti{
    NSLog(@"%@",noti);
    NSNumber *num = noti.userInfo[@"status"];
    
    NSString *tempMac = noti.userInfo[@"mac"];
    
    NSNumber *stripType = noti.userInfo[@"type"];
    
    if(num!=nil && tempMac!=nil){
        
//        NSString*describe=@"";
//        switch ([num intValue]) {
//            case 0:
//                describe=@"strip in";
//                break;
//            case 1:
//                describe=@"strip out";
//                break;
//            case 2:
//                describe=@"start sucking blood";
//                break;
//            case 3:
//                describe=@"Less than 1 lifesteal";
//                break;
//            case 4:
//                describe=@"Blood sucking less than 1 state for more than 5s";
//                break;
//            case 5:
//                describe=@"Less than 2 lifesteal";
//                break;
//            case 6:
//                describe=@"blood sucking complete";
//                break;
//
//            default:
//                break;
//        }
        
        if(stripType==nil){
            
            [self.bridge.eventDispatcher sendDeviceEventWithName:BG1A_EVENT_NOTIFY body:@{
                BG1A_ACTION:ACTION_STRIP_INSERTION_STATUS,
                BG1A_KEY_MAC:tempMac,
                BG1A_TYPE:DEVICE_TYPE,
                BG1A_KEY_STATUS:num,
//                OPERATION_DESCRIBE:describe
            }];
            
        }else{
           
            [self.bridge.eventDispatcher sendDeviceEventWithName:BG1A_EVENT_NOTIFY body:@{
                BG1A_ACTION:ACTION_STRIP_INSERTION_STATUS,
                BG1A_KEY_MAC:tempMac,
                BG1A_TYPE:DEVICE_TYPE,
                BG1A_KEY_STATUS:num,
                BG1A_KEY_STRIPTYPE:stripType,
//                OPERATION_DESCRIBE:describe
            }];
            
        }
        
        
        
    }
    
    
}
- (void)handleResultNoti:(NSNotification*)noti{
    NSLog(@"%@",noti);
    NSNumber *num = noti.userInfo[@"result"];
    NSString *tempMac = noti.userInfo[@"mac"];
    
    if(num!=nil && tempMac!=nil){
        
        [self.bridge.eventDispatcher sendDeviceEventWithName:BG1A_EVENT_NOTIFY body:@{
            BG1A_ACTION:ACTION_MEASURE_RESULT,
            BG1A_KEY_MAC:tempMac,
            BG1A_TYPE:DEVICE_TYPE,
            MEASURE_RESULT:num,
            
        }];
    }
    
}
- (void)handleErrorNoti:(NSNotification*)noti{
    NSLog(@"%@",noti);
    NSNumber *num = noti.userInfo[@"error"];
    
    NSString *mac = noti.userInfo[@"mac"];
    //    kPrintLog(@"错误码:%@",num);
    
    [self sendBG1AErrorCode:[num intValue] mac:mac];
}


-(BG1A*)getDeviceWithMac:(NSString*)mac{
    
    BG1AController *controller = [BG1AController shareIHBG1AController];
    NSArray *BG1ADeviceArray = [controller getAllCurrentBG1AInstace];
    
    for(BG1A *tempDevice in BG1ADeviceArray){
        if([mac isEqualToString:tempDevice.serialNumber]){
            
            return tempDevice;
        }
    }
    return nil;
}

RCT_EXPORT_METHOD(getAllConnectedDevices){
    
    
    NSArray*BG1ADeviceArray= [[BG1AController shareIHBG1AController] getAllCurrentBG1AInstace];
    
    NSMutableArray*deviceMacArray=[NSMutableArray array];
    
    for (int i=0; i<[BG1ADeviceArray count]; i++) {
        
        BG1A *BG1A = [BG1ADeviceArray objectAtIndex:i];
        
        [deviceMacArray addObject:BG1A.serialNumber];
        
    }
    
    NSDictionary* deviceInfo = @{BG1A_ACTION:kACTION_GET_ALL_CONNECTED_DEVICES,BG1A_DEVICE:deviceMacArray};
    
    [self.bridge.eventDispatcher sendDeviceEventWithName:BG1A_EVENT_NOTIFY body:deviceInfo];
}

RCT_EXPORT_METHOD(getDeviceInfo:(nonnull NSString *)mac){
 
    __weak typeof(self) weakSelf = self;
    
    if ([self getDeviceWithMac:mac] != nil) {
        
        [[self getDeviceWithMac:mac] commandGetDeviceInfo:^{
            
            NSDateFormatter *mydateFormatter = [[NSDateFormatter alloc] init];
            [mydateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            mydateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
            NSString *dateStr = [mydateFormatter stringFromDate:[weakSelf getDeviceWithMac:mac].deviceTS];
            
            [self.bridge.eventDispatcher sendDeviceEventWithName:BG1A_EVENT_NOTIFY body:@{
                                           BG1A_ACTION:ACTION_INFO_DEVICE,
                                           BG1A_KEY_MAC:mac,
                                           BG1A_TYPE:DEVICE_TYPE,
                                           BG1A_KEY_MANUFACTURE:[weakSelf getDeviceWithMac:mac].manufaturer,
                                           BG1A_KEY_MODENUMBER:[weakSelf getDeviceWithMac:mac].modelNumber,
                                           BG1A_KEY_HARDWAREVERSION:[weakSelf getDeviceWithMac:mac].hardwareVersion,
                                           BG1A_KEY_FIRMWAREVERSION:[weakSelf getDeviceWithMac:mac].firmwareVersion,
                                           BG1A_KEY_ACCESSORYNAME:[weakSelf getDeviceWithMac:mac].accessoryName,
                                           BG1A_KEY_PROTOCOLSTRING:[weakSelf getDeviceWithMac:mac].protocol,
                                           BG1A_KEY_LOCALTIME:dateStr,
                                           BG1A_KEY_HISTORY_STATUS:[NSNumber numberWithBool:[weakSelf getDeviceWithMac:mac].hasHistoryResult],
                                           BG1A_KEY_BATTERY:[NSNumber numberWithInt:[weakSelf getDeviceWithMac:mac].battery],
                                       }];
        
            
            
        } fail:^(BG1ADeviceError error) {
            
            [weakSelf sendBG1AErrorCode:error mac:mac];
            
        }];
        
    }
}

RCT_EXPORT_METHOD(setMeasureMode:(nonnull NSString *)mac measureMode:(nonnull NSNumber *)mode){
    
    if ([self getDeviceWithMac:mac] != nil) {
        
        
        BG1AMeasureType tempMode=BG1AMeasureType_BloodSugar;
        
        if([@(BG1AMeasureType_CTL) isEqual:mode]){
            
            tempMode=BG1AMeasureType_CTL;
            
        }else if([@(BG1AMeasureType_BloodSugar) isEqual:mode]){
            
            tempMode=BG1AMeasureType_BloodSugar;
            
        }else{
            
            NSDictionary *deviceInfo = @{BG1A_KEY_MAC:mac,BG1A_TYPE:DEVICE_TYPE,BG1A_ACTION:ACTION_ERROR_BG1A,ERROR_NUM_BG1A:@400,ERROR_DESCRIPTION_BG1A:@"Input parameter error"};
            [self.bridge.eventDispatcher sendDeviceEventWithName:BG1A_EVENT_NOTIFY body:deviceInfo];
            
            return;
        }
        
        [[self getDeviceWithMac:mac] commandSetMeasureType:tempMode success:^{
            
            [self.bridge.eventDispatcher sendDeviceEventWithName:BG1A_EVENT_NOTIFY body:@{
                BG1A_ACTION:ACTION_SET_MEASURE_MODE,
                BG1A_KEY_MAC:mac,
                BG1A_TYPE:DEVICE_TYPE,
                BG1A_KEY_STATUS:@0,
                
            }];
            
            
        } fail:^(BG1ADeviceError error) {
            
            [self sendBG1AErrorCode:error mac:mac];
        }];
        
    }
    
}

RCT_EXPORT_METHOD(setDeviceTime:(nonnull NSString *)mac){
    
    if ([self getDeviceWithMac:mac] != nil) {
        
        [[self getDeviceWithMac:mac] commandSyncTime:^{
            
            [self.bridge.eventDispatcher sendDeviceEventWithName:BG1A_EVENT_NOTIFY body:@{
                                           BG1A_ACTION:ACTION_SET_DEVICE_TIME,
                                           BG1A_KEY_MAC:mac,
                                           BG1A_TYPE:DEVICE_TYPE,
                                          
                                       }];
            
            
        } fail:^(BG1ADeviceError error) {
            
            [self sendBG1AErrorCode:error mac:mac];
        }];
        
    }
    
}

///{
///mac = "004D3201D6CD";
///isResultNeedCalibrate = 0;
///measureTs = 2023-05-19 14:28:51 +0000;
///mode = 0;//
///result= 200;
///metaData = <BG1AMeasureMetaData: 0x281a89f20>;
///errorCode=0;    If it is not 0, it 

RCT_EXPORT_METHOD(getHistoryData:(nonnull NSString *)mac){
    
    if ([self getDeviceWithMac:mac] != nil) {
        
        [[self getDeviceWithMac:mac] commandSyncHistory:^(NSArray * _Nullable historyArray) {
            
            NSMutableArray * tempArr = [[NSMutableArray alloc]init];
            
            for(NSDictionary *history in historyArray)
            {
                NSDate *tempDate = [history objectForKey:@"measureTs"];
                
                //将时间格式转化成字符串，适配plugin和react native【
                NSDateFormatter *mydateFormatter = [[NSDateFormatter alloc] init];
                [mydateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                mydateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
                NSString *dateStr = [mydateFormatter stringFromDate:tempDate];
                
                NSNumber*errorNum=[history valueForKey:@"errorCode"];
                
                NSNumber*result=[history valueForKey:@"result"];
                
                NSNumber*mode=[history valueForKey:@"mode"];
                
                NSNumber*isResultNeedCalibrate=[history valueForKey:@"isResultNeedCalibrate"];
                
                NSDictionary *dic=[NSDictionary dictionary];

                dic = @{
                    BG1A_RESULT_KEY_TIME: dateStr,
                    MEASURE_RESULT: result,
                    BG1A_RESULT_KEY_ERRORNUM: errorNum,
                    BG1A_RESULT_KEY_isResultNeedCalibrate: isResultNeedCalibrate,
                    BG1A_RESULT_KEY_MODE: mode,
                };
                
                [tempArr addObject:dic];
                
            }
            
            if (tempArr.count > 0) {
                [self.bridge.eventDispatcher sendDeviceEventWithName:BG1A_EVENT_NOTIFY body:@{
                                               BG1A_ACTION:ACTION_GET_HISTORY,
                                               BG1A_KEY_MAC:mac,
                                               BG1A_TYPE:DEVICE_TYPE,
                                               BG1A_RESULT_KEY_HISTORY:tempArr
                                           }];
            }else{
                
                [self.bridge.eventDispatcher sendDeviceEventWithName:BG1A_EVENT_NOTIFY body:@{
                                               BG1A_ACTION:ACTION_GET_HISTORY,
                                               BG1A_KEY_MAC:mac,
                                               BG1A_TYPE:DEVICE_TYPE,
                                               BG1A_RESULT_KEY_HISTORY:[NSArray array]
                                           }];
                
            }
            
            
            
            
           
            
        } fail:^(BG1ADeviceError error) {
            
            [self sendBG1AErrorCode:error mac:mac];
            
        }];
        
    }
    
}


RCT_EXPORT_METHOD(deleteHistoryData:(nonnull NSString *)mac){
    
    
    if ([self getDeviceWithMac:mac] != nil) {
        
        [[self getDeviceWithMac:mac] commandDeleteHistory:^{
           
            [self.bridge.eventDispatcher sendDeviceEventWithName:BG1A_EVENT_NOTIFY body:@{
                                           BG1A_ACTION:ACTION_DELETE_HISTORY,
                                           BG1A_KEY_MAC:mac,
                                           BG1A_TYPE:DEVICE_TYPE,
                                          
                                       }];
        
        } fail:^(BG1ADeviceError error) {
            
            [self sendBG1AErrorCode:error mac:mac];
            
        }];
        
    }
    
}


//断开连接
RCT_EXPORT_METHOD(disconnect:(nonnull NSString *)mac){
    
    if ([self getDeviceWithMac:mac]!=nil) {
        
        [[self getDeviceWithMac:mac] commandDisconnectDevice];
    }
    
}


-(void)sendBG1AErrorCode:(BG1ADeviceError)errorID mac:(NSString*)mac{
    
                NSString *errorMassage = [NSString string];
                switch (errorID) {
                    case 1:
                        errorMassage = @"The calculation result is zero";
                        break;
                    case 2:
                         errorMassage = @"BG1ADeviceError_LowCurrent";
                        break;
                    case 3:
                        errorMassage = @"BG1ADeviceError_AlgorithmError";
                        break;
                    case 4:
                        errorMassage = @"Blood-sucking timeout";
                        break;
                    case 5:
                         errorMassage = @"BG1ADeviceError_XM1Error";
                        break;
                    case 6:
                         errorMassage = @"Sample exception";
                        break;
                    case 0x0A:
                        errorMassage = @"BG1ADeviceError_SelfCheckError";
                        break;
                    case 0x0B:
                        errorMassage = @"BG1ADeviceError_StripTypeCannotRecognize";
                        break;
                    case 0x0C:
                        errorMassage = @"Waste test strip";
                        break;
                    case 0x0E:
                        errorMassage = @"BG1ADeviceError_LowBattery";
                        break;
                    case 0x0F:
                        errorMassage = @"BG1ADeviceError_HighBattery";
                        break;
                    case 0x10:
                        errorMassage = @"BG1ADeviceError_LowTemperature";
                        break;
                    case 0x11:
                        errorMassage = @"BG1ADeviceError_HighTemperature";
                        break;
                    case 0x12:
                        errorMassage = @"BG1ADeviceError_FlashError";
                        break;
                    case 0x14:
                        errorMassage = @"BG1ADeviceError_NoCheckFlagError1";
                        break;
                    case 0x15:
                        errorMassage = @"BG1ADeviceError_NoCheckFlagError2";
                        break;
                    case 0x16:
                        errorMassage = @"BG1ADeviceError_NoStripCheckFlag";
                        break;
                    case 0x17:
                        errorMassage = @"Early blood-sucking";
                        break;
                    case 0xF0:
                        errorMassage = @"Reject Change MeasureType";
                        break;
                    case 400:
                        errorMassage = @"BG1ADeviceError_ParameterError";
                        break;
                    case 401:
                        errorMassage = @"Result is too low";
                        break;
                    case 402:
                        errorMassage = @"Result is too high";
                        break;

                    default:
                        break;
                }
    
                NSDictionary *deviceInfo = @{BG1A_KEY_MAC:mac,BG1A_TYPE:DEVICE_TYPE,BG1A_ACTION:ACTION_ERROR_BG1A,ERROR_NUM_BG1A:[NSNumber numberWithInt:errorID],ERROR_DESCRIPTION_BG1A:errorMassage};
                [self.bridge.eventDispatcher sendDeviceEventWithName:BG1A_EVENT_NOTIFY body:deviceInfo];
    
    
}

@end
