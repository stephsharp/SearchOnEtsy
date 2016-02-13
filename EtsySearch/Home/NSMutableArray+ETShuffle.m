//
//  NSMutableArray+ETShuffle.m
//  EtsySearch
//
//  Created by Steph Sharp on 13/02/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//
// See: http://stackoverflow.com/a/56656/1367622
//

#import "NSMutableArray+ETShuffle.h"

@implementation NSMutableArray (ETShuffle)

- (void)shuffle
{
    NSUInteger count = self.count;

    if (count < 1) {
        return;
    }

    for (NSUInteger i = 0; i < count - 1; i++) {
        NSInteger remainingCount = count - i;
        NSInteger exchangeIndex = i + arc4random_uniform((u_int32_t)remainingCount);

        [self exchangeObjectAtIndex:i withObjectAtIndex:exchangeIndex];
    }
}

@end