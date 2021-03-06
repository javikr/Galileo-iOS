//
//  NSURLSessionConfiguration+Wormholy.m
//  Wormholy-SDK
//
//  Created by Paolo Musolino on 18/01/18.
//  Copyright © 2018 Wormholy. All rights reserved.
//

//#if __has_include(<Galileo-iOS/Galileo_iOS-Swift.h>)
//#import <Galileo_iOS/Galileo_iOS-Swift.h>
//#else
//#import "Galileo_iOS-Swift.h"
//#endif

#import "Galileo_iOS-Swift.h"

#import "WormholyMethodSwizzling.h"

typedef NSURLSessionConfiguration*(*SessionConfigConstructor)(id,SEL);
static SessionConfigConstructor orig_defaultSessionConfiguration;
static SessionConfigConstructor orig_ephemeralSessionConfiguration;

static NSURLSessionConfiguration* Wormholy_defaultSessionConfiguration(id self, SEL _cmd)
{
    NSURLSessionConfiguration* config = orig_defaultSessionConfiguration(self,_cmd); // call original method
    
    [Wormholy enable:YES sessionConfiguration:config];
    return config;
}

static NSURLSessionConfiguration* Wormholy_ephemeralSessionConfiguration(id self, SEL _cmd)
{
    NSURLSessionConfiguration* config = orig_ephemeralSessionConfiguration(self,_cmd); // call original method
    
    [Wormholy enable:YES sessionConfiguration:config];
    return config;
}

@implementation NSURLSessionConfiguration (Wormholy)

+(void)load
{
    orig_defaultSessionConfiguration = (SessionConfigConstructor)WormholyReplaceMethod(@selector(defaultSessionConfiguration),
                                                                                       (IMP)Wormholy_defaultSessionConfiguration,
                                                                                       [NSURLSessionConfiguration class],
                                                                                       YES);

    orig_ephemeralSessionConfiguration = (SessionConfigConstructor)WormholyReplaceMethod(@selector(ephemeralSessionConfiguration),
                                                                                         (IMP)Wormholy_ephemeralSessionConfiguration,
                                                                                         [NSURLSessionConfiguration class],
                                                                                         YES);
}


@end
