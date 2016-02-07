//
//  ETSearchClient.h
//  EtsySearch
//
//  Created by Steph Sharp on 7/02/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETSearchClient : NSObject

- (void)searchForKeywords:(NSString *)keywords completion:(void (^)(NSArray *listings, NSError *error))completion;
@end
