//
//  NSTimerBlocksKitTest.m
//  BlocksKit Unit Tests
//

#import "NSTimerBlocksKitTest.h"

@implementation NSTimerBlocksKitTest {
	NSInteger _total;	
}

- (void)setUp {
	_total = 0;
}

- (void)testScheduledTimer {
	BKTimerBlock timerBlock = ^(NSTimeInterval time) {
		_total++;
		NSLog(@"total is %ld",_total);
	};
	NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.1 block:timerBlock repeats:NO];
	STAssertNotNil(timer,@"timer is nil");
	[self waitForTimeout:0.5];
	STAssertEquals(_total, (NSInteger)1, @"total is %d", _total);
}

- (void)testRepeatedlyScheduledTimer {
	BKTimerBlock timerBlock = ^(NSTimeInterval time) {
		_total++;
		NSLog(@"total is %ld", _total);
	};
	NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.1 block:timerBlock repeats:YES];
	STAssertNotNil(timer,@"timer is nil");
	[self waitForTimeout:0.5];
	[timer invalidate];
	STAssertTrue(_total > 3, @"total is %d", _total);
}

- (void)testUnscheduledTimer {
	BKTimerBlock timerBlock = ^(NSTimeInterval time) {
		_total++;
		NSLog(@"total is %ld", _total);
	};
	NSTimer *timer = [NSTimer timerWithTimeInterval:0.1 block:timerBlock repeats:NO];
	STAssertNotNil(timer,@"timer is nil");
	[[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
	[self waitForTimeout:0.5];
	STAssertEquals(_total, (NSInteger)1, @"total is %d", _total);
}

- (void)testRepeatableUnscheduledTimer {
	BKTimerBlock timerBlock = ^(NSTimeInterval time) {
		_total += 1;
		NSLog(@"total is %ld",_total);
	};
	NSTimer *timer = [NSTimer timerWithTimeInterval:0.1 block:timerBlock repeats:YES];
	STAssertNotNil(timer,@"timer is nil");
	[[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
	[self waitForTimeout:0.5];
	[timer invalidate];
	STAssertTrue(_total > 3, @"total is %d", _total);
}

@end
