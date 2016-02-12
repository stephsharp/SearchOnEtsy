//
//  ETListingsFooterView.m
//  EtsySearch
//
//  Created by Steph Sharp on 11/02/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import "ETListingsFooterView.h"

@implementation ETListingsFooterView

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self configureSpinner];
}

- (void)configureSpinner
{
    self.spinner.type = NVActivityIndicatorTypeBallSpinFadeLoader;
    self.spinner.color = self.tintColor;
    self.spinner.size = self.spinner.frame.size;
    self.spinner.hidesWhenStopped = YES;

    [self.spinner startAnimation];
}

- (void)tintColorDidChange
{
    self.spinner.color = self.tintColor;
}

@end
