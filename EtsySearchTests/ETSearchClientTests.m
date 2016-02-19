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
#import "NSError+ETSearchErrors.h"

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

- (void)testError
{
    NSDictionary *json = @{@"results": @[@{@"title": @"Title 1", @"Shop": @{@"shop_name": @"Shop A"}}]};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:json options:0 error:NULL];

    self.testSession.data = jsonData;
    self.testSession.error = [NSError errorWithDomain:@"TestErrorDomain" code:0 userInfo:nil];

    __block NSArray *receivedListings;
    __block NSError *receivedError;

    [self.client searchForKeywords:@"coffee table" offset:0 completion:^(NSArray *listings, NSError *error) {
        receivedListings = listings;
        receivedError = error;
    }];

    XCTAssertNil(receivedListings);
    XCTAssertEqualObjects(receivedError.domain, @"TestErrorDomain");
}

- (void)testValidJSON
{
    NSDictionary *json = @{@"results": @[@{@"title": @"Title 1", @"Shop": @{@"shop_name": @"Shop A"}},
                                         @{@"title": @"Title 2", @"Shop": @{@"shop_name": @"Shop B"}}]};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:json options:0 error:NULL];

    self.testSession.data = jsonData;
    self.testSession.response = [[NSHTTPURLResponse alloc] initWithURL:[NSURL new] statusCode:200 HTTPVersion:nil headerFields:nil];

    __block NSArray *receivedListings;
    __block NSError *receivedError;

    [self.client searchForKeywords:@"some keywords" offset:0 completion:^(NSArray *listings, NSError *error) {
        receivedListings = listings;
        receivedError = error;
    }];

    XCTAssertNotNil(receivedListings);
    XCTAssertTrue([((ETListing *)receivedListings[0]).title isEqualToString:@"Title 1"]);
    XCTAssertTrue([((ETListing *)receivedListings[1]).shopName isEqualToString:@"Shop B"]);
}

- (void)testInvalidJSON
{
    self.testSession.data = [NSData new];
    self.testSession.response = [[NSHTTPURLResponse alloc] initWithURL:[NSURL new] statusCode:200 HTTPVersion:nil headerFields:nil];

    __block NSArray *receivedListings;
    __block NSError *receivedError;

    [self.client searchForKeywords:@"invalid json" offset:0 completion:^(NSArray *listings, NSError *error) {
        receivedListings = listings;
        receivedError = error;
    }];

    XCTAssertNil(receivedListings);
    XCTAssertNotNil(receivedError);
}

- (void)testNoResultsError
{
    NSDictionary *json = @{@"results": @[]};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:json options:0 error:NULL];

    self.testSession.data = jsonData;
    self.testSession.response = [[NSHTTPURLResponse alloc] initWithURL:[NSURL new] statusCode:200 HTTPVersion:nil headerFields:nil];

    __block NSArray *receivedListings;
    __block NSError *receivedError;

    [self.client searchForKeywords:@"no results" offset:0 completion:^(NSArray *listings, NSError *error) {
        receivedListings = listings;
        receivedError = error;
    }];

    XCTAssertNil(receivedListings);
    XCTAssertTrue([receivedError.domain isEqualToString:ETSearchErrorDomain]);
    XCTAssertTrue(receivedError.code == ETSearchErrorNoResults);
}

- (void)testDefaultError
{
    self.testSession.response = [[NSHTTPURLResponse alloc] initWithURL:[NSURL new] statusCode:404 HTTPVersion:nil headerFields:nil];

    __block NSArray *receivedListings;
    __block NSError *receivedError;

    [self.client searchForKeywords:@"not found" offset:0 completion:^(NSArray *listings, NSError *error) {
        receivedListings = listings;
        receivedError = error;
    }];

    XCTAssertNil(receivedListings);
    XCTAssertTrue([receivedError.domain isEqualToString:ETSearchErrorDomain]);
    XCTAssertTrue(receivedError.code == ETSearchErrorDefault);
}

@end
