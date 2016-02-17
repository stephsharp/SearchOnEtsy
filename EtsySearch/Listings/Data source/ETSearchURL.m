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

+ (NSURL *)listingsURLWithKeywords:(NSString *)keywords offset:(NSUInteger)offset
{
    NSURLComponents *components = [[NSURLComponents alloc] initWithString:ETActiveListingsURL];

    NSURLQueryItem *apiKeyItem = [NSURLQueryItem queryItemWithName:@"api_key" value:ETAPIKey];
    // Including Images here instead of MainImage to get the average color info (which is null in MainImage).
    NSURLQueryItem *includesItem = [NSURLQueryItem queryItemWithName:@"includes" value:@"Images,Shop"];
    NSURLQueryItem *keywordsItem = [NSURLQueryItem queryItemWithName:@"keywords" value:keywords];
    NSURLQueryItem *limitItem = [NSURLQueryItem queryItemWithName:@"limit" value:@(ETListingsLimit).stringValue];
    NSURLQueryItem *offsetItem = [NSURLQueryItem queryItemWithName:@"offset" value:@(offset).stringValue];

    components.queryItems = @[apiKeyItem, includesItem, keywordsItem, limitItem, offsetItem];

    return components.URL;
}

@end
