//
//  ETListingCard.m
//  EtsySearch
//
//  Created by Steph Sharp on 10/02/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import "ETListingCard.h"
#import "UIColor+ETTheme.h"

@implementation ETListingCard

- (instancetype)initWithListing:(ETListing *)listing
{
    self = [super init];
    if (self) {
        _listing = listing;
        [self configure];
    }
    return self;
}

- (void)configure
{
    _title = _listing.title;
    _shopName = _listing.shopName;
    _mainImageURL = _listing.mainImageURL;
    _formattedPrice = [NSString stringWithFormat:@"%@ %@", _listing.currencyCode, _listing.price];

    if (_listing.mainImageHexCode) {
        _mainImageColor = [UIColor et_colorFromHexCode:_listing.mainImageHexCode];
    }
}

@end
