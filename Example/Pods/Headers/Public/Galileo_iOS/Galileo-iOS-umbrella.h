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

#import "Galileo-iOS.h"
#import "NSURLSessionConfiguration+Wormholy.h"
#import "WormholyMethodSwizzling.h"

FOUNDATION_EXPORT double Galileo_iOSVersionNumber;
FOUNDATION_EXPORT const unsigned char Galileo_iOSVersionString[];

