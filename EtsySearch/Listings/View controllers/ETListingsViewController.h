//
//  ETListingsViewController.h
//  EtsySearch
//
//  Created by Steph Sharp on 8/02/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETSearchBar.h"

@interface ETListingsViewController : UICollectionViewController

@property (weak, nonatomic) IBOutlet ETSearchBar *searchBar;

@property (nonatomic) NSString *searchText;

@end
