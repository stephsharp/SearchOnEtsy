//
//  ETSearchURLTests.m
//  EtsySearch
//
//  Created by Steph Sharp on 17/02/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ETSearchURL.h"

@interface ETSearchURLTests : XCTestCase

@end

@implementation ETSearchURLTests

- (void)testKeyword
{
    NSURL *url = [ETSearchURL listingsURLWithKeywords:@"coffee" offset:0];

    XCTAssertTrue([url.absoluteString containsString:@"keywords=coffee"]);
}

- (void)testKeywordsWithPercentEncoding
{
    NSURL *url = [ETSearchURL listingsURLWithKeywords:@"coffee table" offset:0];

    XCTAssertTrue([url.absoluteString containsString:@"keywords=coffee%20table"]);
}

- (void)testKeywordsIsNil
{
    NSURL *url = [ETSearchURL listingsURLWithKeywords:nil offset:0];

    XCTAssertFalse([url.absoluteString containsString:@"keywords="]);
}

- (void)testOffset
{
    NSURL *urlWithoutOffset = [ETSearchURL listingsURLWithKeywords:nil offset:0];
    NSURL *urlWithOffset = [ETSearchURL listingsURLWithKeywords:nil offset:50];

    XCTAssertTrue([urlWithoutOffset.absoluteString containsString:@"offset=0"]);
    XCTAssertTrue([urlWithOffset.absoluteString containsString:@"offset=50"]);
}

@end
