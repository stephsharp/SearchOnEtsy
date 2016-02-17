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

    NSDictionary *shop = json[@"Shop"];
    if (shop && [shop isKindOfClass:[NSDictionary class]]) {
        _shopName = shop[@"shop_name"];
    }

    _price = json[@"price"];
    _currencyCode = json[@"currency_code"];

    // Color info for MainImage is null, but it can be accessed via the Images array.
    NSArray *images = json[@"Images"];

    if (images && [images isKindOfClass:[NSArray class]]) {
        NSDictionary *mainImage = images.firstObject;
        _mainImageURL = [NSURL URLWithString:mainImage[@"url_170x135"]];

        NSString *hexCode = mainImage[@"hex_code"];
        if (hexCode && hexCode != (id)[NSNull null]) {
            self.mainImageHexCode = hexCode;
        }
    }
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ | %@ | %@ %@", self.title, self.shopName, self.currencyCode, self.price];
}

@end
