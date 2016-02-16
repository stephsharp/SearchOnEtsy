//
//  ETRandomObjectEnumeratorTests.m
//  EtsySearch
//
//  Created by Steph Sharp on 17/02/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ETRandomObjectEnumerator.h"

@interface ETRandomObjectEnumeratorTests : XCTestCase

@property (nonatomic) ETRandomObjectEnumerator *enumerator;

@end

@implementation ETRandomObjectEnumeratorTests

- (void)setUp
{
    [super setUp];
    self.enumerator = [ETRandomObjectEnumerator new];
}

- (void)tearDown
{
    self.enumerator = nil;
    [super tearDown];
}

- (void)testShuffle
{
    NSArray *objects = @[@1, @2, @3, @4, @5, @6, @7, @8, @9, @10];
    self.enumerator.objects = objects;

   XCTAssertFalse([objects isEqualToArray:self.enumerator.objects]);
}

- (void)testNextObjectResetsAfterConsumingAllObjects
{
    NSArray *objects = @[@1, @2];
    self.enumerator.objects = objects;

    [self.enumerator nextObject];
    [self.enumerator nextObject];

    XCTAssertNotNil([self.enumerator nextObject]);
}

- (void)testSameNumberOfObjectsIsReturnedEachReset
{
    NSArray *objects = @[@0, @1, @2, @3, @4, @5];
    NSMutableArray *frequency = [@[@0, @0, @0, @0, @0, @0] mutableCopy];
    NSInteger numberOfCycles = 3;

    self.enumerator.objects = objects;

    for (int i = 0; i < objects.count * numberOfCycles; i++) {
        NSInteger nextObject = [[self.enumerator nextObject] integerValue];
        frequency[nextObject] = @([frequency[nextObject] integerValue] + 1);
    }

    for (NSNumber *n in frequency) {
        XCTAssertEqual([n integerValue], numberOfCycles);
    }
}

@end
