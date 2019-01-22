//
//  Galileo-iOS.h
//  Galileo-iOS
//
//  Created by Javier Aznar on 22/01/2019.
//

#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif


#import "NSURLSessionConfiguration+Wormholy.h"
#import "WormholyMethodSwizzling.h"


FOUNDATION_EXPORT double WormholyVersionNumber;
FOUNDATION_EXPORT const unsigned char WormholyVersionString[];
