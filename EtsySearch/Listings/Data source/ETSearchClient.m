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

    NSURL *url = [ETSearchURL urlWithKeywords:keywords offset:offset];

    self.dataTask = [self.session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        });

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
                if (json) {
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
        ETListing *listing = [[ETListing alloc] initWithJSON:result];

        if (listing) {
            [mutableListings addObject:listing];
        }
    }

    return [mutableListings copy];
}

@end
