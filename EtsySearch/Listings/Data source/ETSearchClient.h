//
//  ETSearchClient.h
//  EtsySearch
//
//  Created by Steph Sharp on 7/02/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETListing.h"
#import "ETURLSession.h"

@interface ETSearchClient : NSObject

- (instancetype)initWithURLSession:(id<ETURLSession>)session NS_DESIGNATED_INITIALIZER;

- (void)searchForKeywords:(NSString *)keywords offset:(NSUInteger)offset completion:(void (^)(NSArray *listings, NSError *error))completion;

@end
