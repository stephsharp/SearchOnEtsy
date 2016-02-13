//
//  ETRandomObjectEnumerator.m
//  EtsySearch
//
//  Created by Steph Sharp on 13/02/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import "ETRandomObjectEnumerator.h"
#import "NSMutableArray+ETShuffle.h"

@interface ETRandomObjectEnumerator ()

@property (nonatomic) NSArray *objects;
@property (nonatomic) NSEnumerator *randomObjectEnumerator;

@end

@implementation ETRandomObjectEnumerator

- (instancetype)initWithArray:(NSArray *)array
{
    self = [super init];
    if (self) {
        _objects = array;
        [self resetEnumerator];
    }
    return self;
}

- (instancetype)init
{
    return [self initWithArray:nil];
}

- (void)resetEnumerator
{
    NSArray *randomObjects = [self randomizeArray];
    _randomObjectEnumerator = [randomObjects objectEnumerator];
}

- (NSArray *)randomizeArray
{
    NSMutableArray *mutableObjects = [self.objects mutableCopy];
    [mutableObjects shuffle];

    return [mutableObjects copy];
}

- (id)nextObject
{
    id next = [self.randomObjectEnumerator nextObject];

    if (!next) {
        [self resetEnumerator];
        next = [self.randomObjectEnumerator nextObject];
    }

    return next;
}

@end
