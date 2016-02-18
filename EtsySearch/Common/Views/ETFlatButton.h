//
//  ETFlatButton.h
//  EtsySearch
//
//  Created by Steph Sharp on 18/02/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface ETFlatButton : UIButton

@property (nonatomic, getter=isFilled) IBInspectable BOOL filled;

@property (nonatomic) IBInspectable CGFloat cornerRadius;
@property (nonatomic) IBInspectable CGFloat borderWidth;

@property (nonatomic) IBInspectable UIColor *highlightedColor;
@property (nonatomic) IBInspectable UIColor *selectedColor;
@property (nonatomic) IBInspectable UIColor *disabledColor;
@property (nonatomic) IBInspectable UIColor *disabledSelectedColor; // defaults to disabledColor

// title colour for filled buttons, and selected and heighlighted for ghost buttons
@property (nonatomic) IBInspectable UIColor *filledTitleColor;
@property (nonatomic) IBInspectable UIColor *disabledSelectedTitleColor; // defaults to filledTitleColor

// TODO: Option to still show border on highlighted/selected for ghost buttons?

@end
