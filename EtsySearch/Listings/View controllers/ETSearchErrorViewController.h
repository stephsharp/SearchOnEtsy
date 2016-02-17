//
//  ETSearchErrorViewController.h
//  EtsySearch
//
//  Created by Steph Sharp on 17/02/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ETSearchErrorViewController;

@protocol ETSearchErrorViewControllerDelegate <NSObject>

- (void)searchViewControllerShouldRetry:(ETSearchErrorViewController *)searchErrorViewController;

@end

@interface ETSearchErrorViewController : UIViewController

@property (weak, nonatomic) id<ETSearchErrorViewControllerDelegate> delegate;

@property (nonatomic) NSString *errorTitle;
@property (nonatomic) NSString *errorDescription;
@property (nonatomic) NSString *retryButtonTitle;

+ (ETSearchErrorViewController *)errorViewControllerWithTitle:(NSString *)title
                                                  description:(NSString *)description
                                                  buttonTitle:(NSString *)buttonTitle;

@end
