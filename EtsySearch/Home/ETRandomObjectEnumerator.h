//
//  ETRandomObjectEnumerator.h
//  EtsySearch
//
//  Created by Steph Sharp on 13/02/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETRandomObjectEnumerator : NSObject

@property (nonatomic) NSArray *objects;

- (instancetype)initWithObjects:(NSArray *)objects;

- (id)nextObject;

@end
