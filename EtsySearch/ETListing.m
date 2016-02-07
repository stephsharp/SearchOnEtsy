//
//  ETListing.m
//  EtsySearch
//
//  Created by Steph Sharp on 7/02/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import "ETListing.h"

@implementation ETListing

- (instancetype)initWithTitle:(NSString *)title mainImageURLString:(NSString *)urlString
{
    self = [super init];
    if (self) {
        _title = title;
        _mainImageURL = [NSURL URLWithString:urlString];
    }
    return self;
}

- (instancetype)init
{
    return [self initWithTitle:nil mainImageURLString:nil];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@", self.title];
}

@end
