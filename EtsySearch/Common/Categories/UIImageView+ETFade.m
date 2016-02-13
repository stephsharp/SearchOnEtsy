//
//  UIImageView+ETFade.m
//  EtsySearch
//
//  Created by Steph Sharp on 8/02/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import "UIImageView+ETFade.h"

@implementation UIImageView (ETFade)

- (void)et_fadeImage:(UIImage *)image withDuration:(NSTimeInterval)duration
{
    [UIView transitionWithView:self
                      duration:duration
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        self.image = image;
                    } completion:nil];
}

- (void)et_fadeImage:(UIImage *)image
{
    [self et_fadeImage:image withDuration:0.15];
}

@end
