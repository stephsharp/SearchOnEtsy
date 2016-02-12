//
//  ETNavigationControllerDelegate.h
//  EtsySearch
//
//  Created by Steph Sharp on 12/02/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ETSearchTransitionPresentedViewController <NSObject>

@property (nonatomic, weak) UIView *toSearchBar;

@end

@interface ETSearchTransitioningDelegate : NSObject <UIViewControllerTransitioningDelegate>

@property (nonatomic) UIView *fromSearchBar;

@end
