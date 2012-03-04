//
//  SBSampleDelegate.h
//  TestingARC
//
//  Created by Takuya Otani on 20/02/12.
//  Copyright (c) 2012 SerendipityNZ Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

// The following macro determines using weak reference for delegate.
#define kUsingWeak 0

// The following macro determines accessing delegate via property in SampleClassC.
#define kAsseccingViaProperty 0

// The following macro determines using retain-autorelease hack in SampleClassA.
#define kUsingRetainAutoreleaseHack 1


#if kUsingWeak
  #define unretained   weak
  #define __unretained __weak
#else
  #define unretained   unsafe_unretained
  #define __unretained __unsafe_unretained
#endif

@class SampleClassA;
@class SampleClassB;
@class SampleClassC;

@protocol SampleDelegateB <NSObject>

- (void)callFromClassB:(SampleClassB *)object;

@end

@protocol SampleDelegateC <NSObject>

- (void)callFromClassC:(SampleClassC *)object;

@end

#pragma mark -

@interface SampleClassA : NSObject <SampleDelegateB>

@end

@interface SampleClassB : NSObject <SampleDelegateC>

@property (nonatomic, unretained) id<SampleDelegateB> delegate;

@end

@interface SampleClassC : NSObject

@property (nonatomic, unretained) id<SampleDelegateC> delegate;

@end
