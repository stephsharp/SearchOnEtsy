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
    _formattedPrice = [self formatPrice:_listing.price withCurrencyCode:_listing.currencyCode];

    if (_listing.mainImageHexCode) {
        _mainImageColor = [UIColor et_colorFromHexCode:_listing.mainImageHexCode];
    }
}

- (NSString *)formatPrice:(NSString *)price withCurrencyCode:(NSString *)currencyCode
{
    NSDecimalNumber *amount = [NSDecimalNumber decimalNumberWithString:price];
    NSNumberFormatter *currencyFormatter = [self currencyFormatterForCurrencyCode:currencyCode];

    return [currencyFormatter stringFromNumber:amount];
}

- (NSNumberFormatter *)currencyFormatterForCurrencyCode:(NSString *)currencyCode
{
    NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc] init];
    [currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];

    NSLocale *locale = [self localeForCurrencyCode:currencyCode];
    [currencyFormatter setLocale:locale];

    return currencyFormatter;
}

- (NSLocale *)localeForCurrencyCode:(NSString *)currencyCode
{
    NSDictionary *components = @{ NSLocaleCurrencyCode: currencyCode,
                                  NSLocaleLanguageCode: [NSLocale preferredLanguages][0] };
    NSString *localeIdentifier = [NSLocale localeIdentifierFromComponents:components];

    return [[NSLocale alloc] initWithLocaleIdentifier:localeIdentifier];
}

@end
