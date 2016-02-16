//
//  ETRandomImage.h
//  EtsySearch
//
//  Created by Steph Sharp on 16/02/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface ETRandomImage : UIView

@property (nonatomic) NSString *imageName;

- (void)fadeToImage:(NSString *)imageName withDuration:(NSTimeInterval)duration;

@end
