//
//  ETListingsViewController.m
//  EtsySearch
//
//  Created by Steph Sharp on 8/02/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import "ETListingsViewController.h"
#import "ETSearchClient.h"
#import "ETListingCell.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import "ETListingFlowLayout.h"
#import "UIImageView+ETFade.h"
#import "UIColor+ETTheme.h"

static NSString *const ETListingReuseIdentifier = @"ListingCell";
static NSUInteger const ETDefaultCellWidth = 160;

@interface ETListingsViewController () <UISearchBarDelegate, UICollectionViewDataSource /*, UICollectionViewDelegateFlowLayout */>

@property (nonatomic) ETSearchClient *searchClient;
@property (nonatomic) NSMutableArray *listings;

@end

@implementation ETListingsViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self sharedInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self sharedInit];
    }
    return self;
}

- (void)sharedInit
{
    _searchClient = [ETSearchClient new];
    _listings = [NSMutableArray new];
}

- (ETListing *)listingForIndexPath:(NSIndexPath *)indexPath
{
    return self.listings[indexPath.row];
}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSString *searchText = searchBar.text;

    if (searchText.length > 0) {
        // Clear collection view & show spinner
        [self.listings removeAllObjects];
        [self.collectionView reloadData];

        [self.searchClient searchForKeywords:searchText completion:^(NSArray *listings, NSError *error) {
            if (error) {
                NSLog(@"error: %@", error.localizedDescription);
            }
            else {
                NSLog(@"Listings: %@", listings);

                dispatch_async(dispatch_get_main_queue(), ^{
                    for (int i = 0; i < listings.count; i++) {
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC) * i), dispatch_get_main_queue(), ^{
                            [self.listings addObject:listings[i]];
                            [self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:i inSection:0]]];
                        });
                    }
                });
            }
        }];

        [searchBar resignFirstResponder];
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.listings.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ETListingCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ETListingReuseIdentifier forIndexPath:indexPath];
    ETListing *listing = [self listingForIndexPath:indexPath];

    [cell.mainImageView setImageWithURLRequest:[NSURLRequest requestWithURL:listing.mainImageURL]
                              placeholderImage:nil
                                       success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
                                           [cell.mainImageView et_fadeImage:image];
                                        }
                                       failure:nil];

    cell.titleLabel.text = listing.title;
    cell.shopNameLabel.text = listing.shopName;

    if (listing.mainImageHexCode) {
        cell.mainImageView.backgroundColor = [UIColor et_colorFromHexCode:listing.mainImageHexCode];
    }

    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout*)collectionViewLayout;

    CGFloat collectionViewWidth = CGRectGetWidth(collectionView.frame);
    NSUInteger cellsPerRow = collectionViewWidth / ETDefaultCellWidth;

    CGFloat availableWidthForCells = collectionViewWidth - flowLayout.sectionInset.left - flowLayout.sectionInset.right - flowLayout.minimumInteritemSpacing * (cellsPerRow - 1);
    CGFloat cellWidth = availableWidthForCells / cellsPerRow;

    return CGSizeMake(cellWidth, cellWidth);
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        [self.collectionView performBatchUpdates:nil completion:nil];
    } completion:nil];
}


@end
