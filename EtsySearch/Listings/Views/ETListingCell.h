//
//  ETListingCell.h
//  EtsySearch
//
//  Created by Steph Sharp on 8/02/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ETListingCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end
