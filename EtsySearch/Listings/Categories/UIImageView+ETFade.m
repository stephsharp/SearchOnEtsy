//
//  UIImageView+ETFade.m
//  EtsySearch
//
//  Created by Steph Sharp on 8/02/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import "UIImageView+ETFade.h"

@implementation UIImageView (ETFade)

- (void)et_fadeImage:(UIImage *)image
{
    [UIView transitionWithView:self
                      duration:0.15f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        self.image = image;
                    } completion:nil];
}

@end
