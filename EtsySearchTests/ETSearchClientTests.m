//
//  ETSearchClientTests.m
//  EtsySearchTests
//
//  Created by Steph Sharp on 7/02/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ETSearchClient.h"
#import "ETTestURLSession.h"

@interface ETSearchClientTests : XCTestCase

@property (nonatomic) ETSearchClient *client;
@property (nonatomic) ETTestURLSession *testSession;

@end

@implementation ETSearchClientTests

- (void)setUp
{
    [super setUp];
    self.testSession = [ETTestURLSession new];
    self.client = [[ETSearchClient alloc] initWithURLSession:self.testSession];
}

- (void)tearDown
{
    self.client = nil;
    [super tearDown];
}

- (void)testCompletionBlock
{
    __block BOOL called = NO;
    [self.client searchForKeywords:@"hello world" offset:0 completion:^(NSArray *listings, NSError *error) {
        called = YES;
    }];
    XCTAssertTrue(called);
}

@end
