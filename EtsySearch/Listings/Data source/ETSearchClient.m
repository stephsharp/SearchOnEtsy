//
//  ETSearchClient.m
//  EtsySearch
//
//  Created by Steph Sharp on 7/02/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import "ETSearchClient.h"
#import "NSURLSession+ETURLSession.h"
#import "ETSearchURL.h"
#import "NSError+ETSearchErrors.h"

@interface ETSearchClient ()

@property (nonatomic) id<ETURLSession> session;
@property (nonatomic) id<ETURLSessionDataTask> dataTask;

@end

@implementation ETSearchClient

- (instancetype)initWithURLSession:(id<ETURLSession>)session
{
    self = [super init];
    if (self) {
        _session = session;
    }
    return self;
}

- (instancetype)init
{
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    return [self initWithURLSession:session];
}

- (void)searchForKeywords:(NSString *)keywords offset:(NSUInteger)offset completion:(void (^)(NSArray *listings, NSError *error))completion
{
    if (self.dataTask) {
        [self.dataTask cancel];
    }

    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

    NSURL *url = [ETSearchURL listingsURLWithKeywords:keywords offset:offset];

    self.dataTask = [self.session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        });

        if (error && completion) {
            completion(nil, error);
        }
        else if (response) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            if (httpResponse.statusCode == 200 && data) {
                NSError *jsonError;
                NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                                     options:0
                                                                       error:&jsonError];
                if (json) {
                    NSArray *listings = [self listingsFromJSON:json];
                    if (completion) {
                        if (listings.count == 0 && offset == 0) {
                            completion(nil, [NSError et_noResultsErrorWithKeywords:keywords]);
                        }
                        else {
                            completion(listings, nil);
                        }
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
                    completion(nil, [NSError et_unknownError]);
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
        ETListing *listing = [[ETListing alloc] initWithJSON:result];

        if (listing) {
            [mutableListings addObject:listing];
        }
    }

    return [mutableListings copy];
}

@end
