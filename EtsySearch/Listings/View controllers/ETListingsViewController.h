//
//  ETListingsViewController.h
//  EtsySearch
//
//  Created by Steph Sharp on 8/02/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETSearchTransitioningDelegate.h"

@interface ETListingsViewController : UICollectionViewController <ETSearchTransitionViewController>

@property (nonatomic) NSString *searchText;

@end
