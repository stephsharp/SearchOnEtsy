//
//  NSError+ETSearchErrors.h
//  EtsySearch
//
//  Created by Steph Sharp on 17/02/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const ETSearchErrorDomain = @"ETSearchErrorDomain";

typedef NS_ENUM(NSInteger, ETSearchError) {
    ETSearchErrorDefault = 0,
    ETSearchErrorNoResults = 1,
};

@interface NSError (ETSearchErrors)

+ (NSError *)et_defaultError;
+ (NSError *)et_noResultsErrorWithKeywords:(NSString *)keywords;

@end
