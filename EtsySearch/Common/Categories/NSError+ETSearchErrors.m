//
//  NSError+ETSearchErrors.m
//  EtsySearch
//
//  Created by Steph Sharp on 17/02/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import "NSError+ETSearchErrors.h"

@implementation NSError (ETSearchErrors)

+ (NSError *)et_defaultError
{
    NSDictionary *userInfo = @{ NSLocalizedDescriptionKey: NSLocalizedString(@"Something unexpected happened.", nil) };

    return [[NSError alloc] initWithDomain:ETSearchErrorDomain code:ETSearchErrorDefault userInfo:userInfo];
}

+ (NSError *)et_noResultsErrorWithKeywords:(NSString *)keywords
{
    NSString *description = [NSString stringWithFormat:@"We couldn't find any results for \"%@\".", keywords];
    NSDictionary *userInfo = @{ NSLocalizedDescriptionKey: NSLocalizedString(description, nil) };

    return [[NSError alloc] initWithDomain:ETSearchErrorDomain code:ETSearchErrorNoResults userInfo:userInfo];
}

@end
