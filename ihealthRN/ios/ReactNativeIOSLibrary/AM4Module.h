//
//  AM4Module.h
//  ReactNativeIOSLibrary
//
//  Created by daiqingquan on 2016/11/23.
//  Copyright © 2016年 daiqingquan. All rights reserved.
//

#import <Foundation/Foundation.h>

#if __has_include(<React/RCTAssert.h>)
#import <React/RCTEventDispatcher.h>
#else
#import <React/RCTEventDispatcher.h>
#endif

@interface AM4Module : NSObject<RCTBridgeModule>

@end
