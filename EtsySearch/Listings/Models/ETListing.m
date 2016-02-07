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
{
    self = [super init];
    if (self) {
        _title = title;
        _mainImageURL = [NSURL URLWithString:urlString];
        _shopName = shopName;
    }
    return self;
}

- (instancetype)init
{
    return [self initWithTitle:nil mainImageURLString:nil shopName:nil];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@", self.title];
}

@end
