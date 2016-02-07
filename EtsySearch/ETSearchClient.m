//
//  ETSearchClient.m
//  EtsySearch
//
//  Created by Steph Sharp on 7/02/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import "ETSearchClient.h"
#import "ETConstants.h"
#import "ETListing.h"

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

- (void)searchForKeywords:(NSString *)keywords completion:(void (^)(NSArray *listings, NSError *error))completion
{
    if (self.dataTask) {
        [self.dataTask cancel];
    }

    NSCharacterSet *expectedCharacterSet = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString *keywordQueryString = [keywords stringByAddingPercentEncodingWithAllowedCharacters:expectedCharacterSet];

    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.etsy.com/v2/listings/active?api_key=%@&includes=MainImage&keywords=%@&limit=30", ETAPIKey, keywordQueryString]];

    self.dataTask = [self.session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            if (completion) {
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
        // TODO: Convert HTML title to string
        ETListing *listing = [[ETListing alloc] initWithTitle:result[@"title"]
                                           mainImageURLString:result[@"MainImage"][@"url_170x135"]];
        [mutableListings addObject:listing];
    }

    return [mutableListings copy];
}

@end
