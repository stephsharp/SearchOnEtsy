//
//  ETTitleView.m
//  EtsySearch
//
//  Created by Steph Sharp on 11/02/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import "ETTitleView.h"

static CGFloat const ETPercentageOfNavBar = 0.7;

@implementation ETTitleView

- (void)setFrame:(CGRect)frame
{
    CGFloat barWidth = CGRectGetWidth(self.superview.bounds);
    CGFloat titleViewWidth = MIN(barWidth * ETPercentageOfNavBar, 400);
    CGFloat leftPadding = (barWidth - titleViewWidth) / 2.0f;

    CGRect newFrame = CGRectMake(leftPadding,    CGRectGetMinY(frame),
                                 titleViewWidth, CGRectGetHeight(frame));

    [super setFrame:CGRectIntegral(newFrame)];
}

@end
