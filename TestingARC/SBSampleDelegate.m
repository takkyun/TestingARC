//
//  SBSampleDelegate.m
//  TestingARC
//
//  Created by Takuya Otani on 20/02/12.
//  Copyright (c) 2012 SerendipityNZ Ltd. All rights reserved.
//

#import "SBSampleDelegate.h"

#pragma mark -

@implementation SampleClassC
{
@private
  __unretained id<SampleDelegateC> mDelegate;
}

@synthesize delegate = mDelegate;

- (id)initWithObject:(id)delegate
{
  self = [super init];
  if (self)
  {
    self.delegate = delegate;
    NSTimeInterval delay = (rand() % 10 + 1) / 10.;
    [self performSelector:@selector(callDelegate)
               withObject:nil
               afterDelay:delay];
    NSLog(@"[C]  -> initialized [%p]",self);
  }
  return self;
}

- (void)dealloc
{
  NSLog(@"[C]  -> destroyed   [%p]",self);
  mDelegate = nil;
}

- (void)callDelegate
{
  NSLog(@"[C]  -> started     [%p]",self);
#if kAsseccingViaProperty
  [self.delegate callFromClassC:self];
#else
  [mDelegate callFromClassC:self];
#endif
  NSLog(@"[C]  -> ended       [%p]",self);
}

@end

#pragma mark -

#pragma mark -

@implementation SampleClassB
{
@private
  __unretained id<SampleDelegateB> mDelegate;
  __strong NSString *mMessage;
  __strong SampleClassC *mTimer;
}

@synthesize delegate = mDelegate;

- (id)initWithMessage:(NSString *)message
         withDelegate:(id<SampleDelegateB>)delegate
{
  self = [super init];
  if (self)
  {
    self.delegate = delegate;
    mMessage = [message copy];
    mTimer = [[SampleClassC alloc] initWithObject:self];
    NSLog(@"[B]  -> initialized [%p] with '%@'",self,mMessage);
  }
  return self;
}

- (void)dealloc
{
  mDelegate = nil;
  mTimer.delegate = nil;
  NSLog(@"[B]  -> destroyed   [%p] with '%@'",self,mMessage);
}

- (void)callFromClassC:(SampleClassC *)object
{
  NSLog(@"[B]  -> started     [%p] with '%@'",self,mMessage);
  [self.delegate callFromClassB:self];
  NSLog(@"[B]  -> endded      [%p] with '%@'",self,mMessage);
}

@end

#pragma mark -

@implementation SampleClassA
{
@private
  NSMutableArray *mRequests;
}

- (id)init
{
  self = [super init];
  if (self)
  {
    NSLog(@"[A]===> initialized [%p]",self);
    static NSInteger kSBNumOfRequests = 10;
    mRequests = [NSMutableArray arrayWithCapacity:kSBNumOfRequests];
    for (NSInteger i = 0; i<kSBNumOfRequests; ++i)
    {
      NSString *msg = [NSString stringWithFormat:@"msg%d",i];
      [mRequests addObject:[[SampleClassB alloc] initWithMessage:msg
                                                    withDelegate:self]];
    }
  }
  return self;
}

- (void)dealloc
{
  NSLog(@"[A]===> destroyed   [%p]",self);
}

- (void)callFromClassB:(SampleClassB *)object
{
  NSLog(@"[A]===> called      [%p]",object);
#if kUsingRetainAutoreleaseHack
  __autoreleasing id temp = object;
  [mRequests removeObject:temp];
#else
  [mRequests removeObject:object];
#endif
  NSLog(@"[A]===> removed     [%p]",object);
}

@end
