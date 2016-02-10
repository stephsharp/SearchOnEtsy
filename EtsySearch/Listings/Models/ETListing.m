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
           mainImageURLString:(NSString *)urlString
                     shopName:(NSString *)shopName
                        price:(NSString *)price
                 currencyCode:(NSString *)currencyCode
{
    self = [super init];
    if (self) {
        _title = title;
        _mainImageURL = [NSURL URLWithString:urlString];
        _shopName = shopName;
        _price = price;
        _currencyCode = currencyCode;
    }
    return self;
}

- (instancetype)init
{
    return [self initWithTitle:nil mainImageURLString:nil shopName:nil price:nil currencyCode:nil];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ | %@ | %@ %@", self.title, self.shopName, self.currencyCode, self.price];
}

@end
