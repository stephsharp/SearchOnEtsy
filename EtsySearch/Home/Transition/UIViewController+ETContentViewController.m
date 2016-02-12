//
//  UIViewController+ETContentViewController.m
//  EtsySearch
//
//  Created by Steph Sharp on 12/02/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import "UIViewController+ETContentViewController.h"

@implementation UIViewController (ETContentViewController)

- (UIViewController *)et_contentViewController
{
    if ([self isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)self;
        return navigationController.visibleViewController;
    }
    return self;
}

@end
