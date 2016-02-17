//
//  ETSearchURL.m
//  EtsySearch
//
//  Created by Steph Sharp on 17/02/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import "ETSearchURL.h"
#import "ETConstants.h"

@implementation ETSearchURL

+ (NSURL *)urlWithKeywords:(NSString *)keywords offset:(NSUInteger)offset
{
    NSCharacterSet *expectedCharacterSet = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString *keywordQueryString = [keywords stringByAddingPercentEncodingWithAllowedCharacters:expectedCharacterSet];

    // Including Images here instead of MainImage to get the average color info (which is null in MainImage).
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.etsy.com/v2/listings/active?api_key=%@&includes=Images,Shop&keywords=%@&limit=%ld&offset=%ld", ETAPIKey, keywordQueryString, (unsigned long)ETListingsLimit, (unsigned long)offset]];

    return url;
}

@end
