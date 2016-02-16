//
//  ETListing.m
//  EtsySearch
//
//  Created by Steph Sharp on 7/02/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import "ETListing.h"
#import <MWFeedParser/NSString+HTML.h>

@implementation ETListing

- (instancetype)initWithJSON:(NSDictionary *)json
{
    self = [super init];
    if (self) {
        [self parseJSON:json];
    }
    return self;
}

- (instancetype)init
{
    return [self initWithJSON:nil];
}

- (void)parseJSON:(NSDictionary *)json
{
    _title = [json[@"title"] stringByConvertingHTMLToPlainText];
    _listingURL = [NSURL URLWithString:json[@"url"]];
    _mainImageURL = [NSURL URLWithString:json[@"Images"][0][@"url_170x135"]];
    _shopName = json[@"Shop"][@"shop_name"];
    _price = json[@"price"];
    _currencyCode = json[@"currency_code"];

    // Color info for MainImage is null, but it can be accessed via the Images array.
    NSString *hexCode = json[@"Images"][0][@"hex_code"];

    if (hexCode && hexCode != (id)[NSNull null]) {
        self.mainImageHexCode = hexCode;
    }
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ | %@ | %@ %@", self.title, self.shopName, self.currencyCode, self.price];
}

@end
