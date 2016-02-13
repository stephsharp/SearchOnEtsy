//
//  ETSearchBar.h
//  EtsySearch
//
//  Created by Steph Sharp on 10/02/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ETSearchBar;

@protocol ETSearchBarDelegate <NSObject>

- (void)searchBarSearchButtonClicked:(ETSearchBar *)searchBar;

@end

IB_DESIGNABLE
@interface ETSearchBar : UIView

@property (nonatomic, weak) IBOutlet id<ETSearchBarDelegate> delegate;

@property (nonatomic) IBInspectable UIColor *textColor;
@property (nonatomic) IBInspectable NSString *placeholder;
@property (nonatomic) IBInspectable NSString *text;
@property (nonatomic) IBInspectable CGFloat borderWidth;
@property (nonatomic) UIFont *font;

@property (nonatomic, readonly) BOOL isEmpty;

@end
