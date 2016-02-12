//
//  ETNavigationControllerDelegate.h
//  EtsySearch
//
//  Created by Steph Sharp on 12/02/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ETSearchTransitionViewController <NSObject>

@property (weak, nonatomic, readonly) UIView *transitioningSearchBar;

@end


@interface ETSearchTransitioningDelegate : NSObject <UIViewControllerTransitioningDelegate>

@end
