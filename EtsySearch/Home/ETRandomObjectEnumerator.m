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

@property (nonatomic) NSEnumerator *randomObjectEnumerator;

@end

@implementation ETRandomObjectEnumerator

- (instancetype)initWithObjects:(NSArray *)objects
{
    self = [super init];
    if (self) {
        _objects = objects;
        [self resetEnumerator];
    }
    return self;
}

- (instancetype)init
{
    return [self initWithObjects:nil];
}

- (void)setObjects:(NSArray *)objects
{
    _objects = objects;
    [self resetEnumerator];
}

- (void)resetEnumerator
{
    [self randomizeObjects];
    _randomObjectEnumerator = [self.objects objectEnumerator];
}

- (void)randomizeObjects
{
    NSMutableArray *mutableObjects = [self.objects mutableCopy];
    [mutableObjects shuffle];

    _objects = [mutableObjects copy];
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
