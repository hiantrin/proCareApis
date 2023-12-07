//
//  AM6Module.h
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

@interface AM6Module : NSObject<RCTBridgeModule>

@end

