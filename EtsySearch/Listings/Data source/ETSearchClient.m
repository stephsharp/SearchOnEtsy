//
//  ETSearchClient.m
//  EtsySearch
//
//  Created by Steph Sharp on 7/02/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import "ETSearchClient.h"
#import "ETConstants.h"
#import <MWFeedParser/NSString+HTML.h>

@interface ETSearchClient ()

@property (nonatomic) NSURLSession *session;
@property (nonatomic) NSURLSessionDataTask *dataTask;

@end

@implementation ETSearchClient

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:config];
    }
    return self;
}

- (void)searchForKeywords:(NSString *)keywords offset:(NSUInteger)offset completion:(void (^)(NSArray *listings, NSError *error))completion
{
    if (self.dataTask) {
        [self.dataTask cancel];
    }

    NSCharacterSet *expectedCharacterSet = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString *keywordQueryString = [keywords stringByAddingPercentEncodingWithAllowedCharacters:expectedCharacterSet];

    // Including Images here instead of MainImage to get the average color info (which is null in MainImage).
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.etsy.com/v2/listings/active?api_key=%@&includes=Images,Shop&keywords=%@&limit=%ld&offset=%ld", ETAPIKey, keywordQueryString, (unsigned long)ETListingsLimit, (unsigned long)offset]];

    self.dataTask = [self.session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            if (completion) {
                // TODO: If cancelled, send a custom error to say task was cancelled because new search was initiated.
                completion(nil, error);
            }
        }
        else if (response) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            if (httpResponse.statusCode == 200 && data) {
                NSError *jsonError;
                NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                                     options:0
                                                                       error:&jsonError];
                if (!jsonError) {
                    NSArray *listings = [self listingsFromJSON:json];
                    if (completion) {
                        completion(listings, nil);
                    }
                }
                else {
                    if (completion) {
                        completion(nil, error);
                    }
                }
            }
            else {
                if (completion) {
                    NSDictionary *userInfo = @{ NSLocalizedDescriptionKey: NSLocalizedString(@"Unknown error", nil),
                                                NSLocalizedFailureReasonErrorKey: NSLocalizedString(@"An unknown error occurred.", nil),
                                                };
                    // TODO: Extract error codes into a separate file.
                    NSError *unknownError = [[NSError alloc] initWithDomain:@"ETSearchErrorDomain" code:100 userInfo:userInfo];

                    completion(nil, unknownError);
                }
            }
        }
    }];

    [self.dataTask resume];
}

- (NSArray *)listingsFromJSON:(NSDictionary *)json
{
    NSMutableArray *mutableListings = [NSMutableArray array];
    NSArray *results = json[@"results"];

    for (NSDictionary *result in results) {
        ETListing *listing = [[ETListing alloc] initWithTitle:[result[@"title"] stringByConvertingHTMLToPlainText]
                                             listingURLString:result[@"url"]
                                           mainImageURLString:result[@"Images"][0][@"url_170x135"]
                                                     shopName:result[@"Shop"][@"shop_name"]
                                                        price:result[@"price"]
                                                 currencyCode:result[@"currency_code"]];

        // Color info for MainImage is null, but it can be accessed via the Images array.
        NSString *hexCode = result[@"Images"][0][@"hex_code"];

        if (hexCode && hexCode != (id)[NSNull null]) {
            listing.mainImageHexCode = hexCode;
        }

        [mutableListings addObject:listing];
    }

    return [mutableListings copy];
}

@end
