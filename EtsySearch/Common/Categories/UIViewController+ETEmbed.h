//
//  UIViewController+ETEmbed.h
//  EtsySearch
//
//  Created by Steph Sharp on 18/02/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (ETEmbed)

/**
 * @param useLayoutGuides If YES, subview will be constrained to the parent view controller's top and bottom layout guides. If NO, the subview is constrained to the edges of the parent view.
 */
- (void)et_embedViewController:(UIViewController *)viewController
               useLayoutGuides:(BOOL)useLayoutGuides
                      animated:(BOOL)animated;

- (void)et_removeFromParentViewControllerAnimated:(BOOL)animated;

@end
