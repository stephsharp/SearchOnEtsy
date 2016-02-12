//
//  ETSearchTransitionAnimator.h
//  EtsySearch
//
//  Created by Steph Sharp on 12/02/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ETSearchTransitionAnimator : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic) BOOL presenting;

@property (nonatomic) UIView *toSearchBar;
@property (nonatomic) UIView *fromSearchBar;
@property (nonatomic) NSArray *fromSearchBarConstraints;

@end
