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

static NSString *const reuseIdentifier = @"ListingCell";

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
        [self.searchClient searchForKeywords:searchText completion:^(NSArray *listings, NSError *error) {
            if (error) {
                NSLog(@"error: %@", error.localizedDescription);
            }
            else {
                NSLog(@"Listings: %@", listings);
                self.listings = [NSMutableArray arrayWithArray:listings];

                dispatch_async(dispatch_get_main_queue(), ^{
                    // TODO: Don't reload entire collection view when inserting new listings.
                    [self.collectionView reloadData];
                });
            }
        }];
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
    ETListingCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    ETListing *listing = [self listingForIndexPath:indexPath];

    [cell.mainImageView setImageWithURL:listing.mainImageURL];
    cell.titleLabel.text = listing.title;
    cell.shopNameLabel.text = listing.shopName;

    return cell;

}

#pragma mark - UICollectionViewDelegateFlowLayout

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
//{
//    return CGSizeMake(100.0f, 100.0f);
//}

//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(50.0f, 20.0f, 50.0f, 20.0f);
//}

@end
