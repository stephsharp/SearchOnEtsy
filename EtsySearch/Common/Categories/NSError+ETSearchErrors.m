//
//  NSError+ETSearchErrors.m
//  EtsySearch
//
//  Created by Steph Sharp on 17/02/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import "NSError+ETSearchErrors.h"

@implementation NSError (ETSearchErrors)

+ (NSError *)et_unknownError
{
    NSDictionary *userInfo = @{ NSLocalizedDescriptionKey: NSLocalizedString(@"Error", nil),
                                NSLocalizedFailureReasonErrorKey: NSLocalizedString(@"An error occurred.", nil) };

    return [[NSError alloc] initWithDomain:ETSearchErrorDomain code:ETSearchErrorUnknown userInfo:userInfo];
}

+ (NSError *)et_noResultsErrorWithKeywords:(NSString *)keywords
{
    NSString *failureReason = [NSString stringWithFormat:@"We couldn't find any results for \"%@\".", keywords];
    NSDictionary *userInfo = @{ NSLocalizedDescriptionKey: NSLocalizedString(@"No results.", nil),
                                NSLocalizedFailureReasonErrorKey: NSLocalizedString(failureReason, nil) };

    return [[NSError alloc] initWithDomain:ETSearchErrorDomain code:ETSearchErrorNoResults userInfo:userInfo];
}

@end
