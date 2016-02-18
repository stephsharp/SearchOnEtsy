//
//  ETGhostButton.h
//  EtsySearch
//
//  Created by Steph Sharp on 18/02/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface ETGhostButton : UIButton

@property (nonatomic) IBInspectable CGFloat cornerRadius;
@property (nonatomic) IBInspectable CGFloat borderWidth;
@property (nonatomic) IBInspectable CGFloat highlightedOpacity;
@property (nonatomic) IBInspectable CGFloat selectedOpacity;

@end
