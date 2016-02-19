//
//  ETTestURLSession.h
//  EtsySearch
//
//  Created by Steph Sharp on 16/02/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ETURLSession.h"

@interface ETTestURLSession : NSObject <ETURLSession>

@property (nonatomic) NSData *data;
@property (nonatomic) NSURLResponse *response;
@property (nonatomic) NSError *error;

@end
