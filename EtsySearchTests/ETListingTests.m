//
//  ETListingTests.m
//  EtsySearch
//
//  Created by Steph Sharp on 17/02/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ETListing.h"

@interface ETListingTests : XCTestCase

@end

@implementation ETListingTests

- (void)testJSONIsNil
{
    ETListing *listing = [[ETListing alloc] initWithJSON:nil];

    XCTAssertNotNil(listing);
    XCTAssertNil(listing.title);
}

- (void)testHTMLTitle
{
    NSDictionary *htmlTitle1 = @{@"title": @"OAK SIDEBOARD, Danish Modern Side Table made from Old Oak 60&#39;s Design"};
    NSDictionary *htmlTitle2 = @{@"title": @"Set of 4 Metal Square Table Legs 17&quot;-28&quot; with hardware"};

    NSString *plainTextTitle1 = @"OAK SIDEBOARD, Danish Modern Side Table made from Old Oak 60's Design";
    NSString *plainTextTitle2 = @"Set of 4 Metal Square Table Legs 17\"-28\" with hardware";

    ETListing *listing1 = [[ETListing alloc] initWithJSON:htmlTitle1];
    ETListing *listing2 = [[ETListing alloc] initWithJSON:htmlTitle2];

    XCTAssertTrue([listing1.title isEqualToString:plainTextTitle1]);
    XCTAssertTrue([listing2.title isEqualToString:plainTextTitle2]);
}

- (void)testListingURL
{
    NSDictionary *validURL = @{@"url": @"https://www.etsy.com/listing/150349421/oak-sideboard-danish-modern-side-table?utm_source=iosteaminterviewapp&utm_medium=api&utm_campaign=api"};
    NSDictionary *invalidURL = @{@"url": @"some invalid url"};

    ETListing *listingWithURL = [[ETListing alloc] initWithJSON:validURL];
    ETListing *listingWithoutURL = [[ETListing alloc] initWithJSON:invalidURL];

    XCTAssertNotNil(listingWithURL.listingURL);
    XCTAssertNil(listingWithoutURL.listingURL);
}

- (void)testShopName
{
    NSDictionary *json = @{@"Shop": @{@"shop_name": @"A shop name"}};

    ETListing *listing = [[ETListing alloc] initWithJSON:json];

    XCTAssertNotNil(listing);
    XCTAssertTrue([listing.shopName isEqualToString:@"A shop name"]);
}

- (void)testInvalidShop
{
    NSDictionary *invalidJSON = @{@"Shop": @"A shop name"};

    ETListing *listing = [[ETListing alloc] initWithJSON:invalidJSON];

    XCTAssertNil(listing.shopName);
}

- (void)testMainImage
{
    NSDictionary *json = @{@"Images": @[@{@"url_170x135": @"https://img1.etsystatic.com/010/0/6765852/il_170x135.460402083_eh9s.jpg",
                                          @"hex_code": @"A59E6C"}]};

    ETListing *listing = [[ETListing alloc] initWithJSON:json];

    XCTAssertNotNil(listing.mainImageURL);
    XCTAssertNotNil(listing.mainImageHexCode);
}

- (void)testNoImages
{
    NSDictionary *json = @{@"Images": @[]};

    ETListing *listing = [[ETListing alloc] initWithJSON:json];

    XCTAssertNil(listing.mainImageURL);
    XCTAssertNil(listing.mainImageHexCode);
}

- (void)testInvalidImages
{
    NSDictionary *invalidJSON = @{@"Images": @"Some images"};

    ETListing *listing = [[ETListing alloc] initWithJSON:invalidJSON];

    XCTAssertNil(listing.mainImageURL);
    XCTAssertNil(listing.mainImageHexCode);
}

- (void)testPrice
{
    NSDictionary *json = @{@"price": @"150.00", @"currency_code": @"USD"};

    ETListing *listing = [[ETListing alloc] initWithJSON:json];

    XCTAssertTrue([listing.price isEqualToString:@"150.00"]);
    XCTAssertTrue([listing.currencyCode isEqualToString:@"USD"]);
}

@end
