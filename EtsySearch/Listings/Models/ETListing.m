//
//  ETListing.m
//  EtsySearch
//
//  Created by Steph Sharp on 7/02/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import "ETListing.h"

@implementation ETListing

- (instancetype)initWithTitle:(NSString *)title
             listingURLString:(NSString *)listingURLString
           mainImageURLString:(NSString *)mainImageURLString
                     shopName:(NSString *)shopName
                        price:(NSString *)price
                 currencyCode:(NSString *)currencyCode
{
    self = [super init];
    if (self) {
        _title = title;
        _listingURL = [NSURL URLWithString:listingURLString];
        _mainImageURL = [NSURL URLWithString:mainImageURLString];
        _shopName = shopName;
        _price = price;
        _currencyCode = currencyCode;
    }
    return self;
}

- (instancetype)init
{
    return [self initWithTitle:nil listingURLString:nil mainImageURLString:nil shopName:nil price:nil currencyCode:nil];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ | %@ | %@ %@", self.title, self.shopName, self.currencyCode, self.price];
}

@end
