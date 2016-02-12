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
#import "ETListingFlowLayout.h"
#import "ETListingCard.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import "UIImageView+ETFade.h"
#import <SafariServices/SafariServices.h>
#import "ETSearchBar.h"
#import "ETListingsFooterView.h"
#import "ETConstants.h"

static NSString *const ETListingReuseIdentifier = @"ListingCell";
static NSUInteger const ETDefaultCellWidth = 160;
static NSUInteger const ETFooterViewHeight = 55;

@interface ETListingsViewController () <ETSearchBarDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic) ETSearchClient *searchClient;
@property (nonatomic) NSMutableArray *listingCards;
@property (nonatomic) NSString *currentSearchText;
@property (nonatomic, getter=isFetching) BOOL fetching;
@property (nonatomic) BOOL endOfSearchResults;
@property (nonatomic) BOOL shouldShowFooter;
@property (nonatomic, weak) ETListingsFooterView *footerView;

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
    _listingCards = [NSMutableArray new];
}

- (ETListingCard *)listingCardForIndexPath:(NSIndexPath *)indexPath
{
    return self.listingCards[indexPath.row];
}

#pragma mark - Properties

- (void)setShouldShowFooter:(BOOL)shouldShowFooter
{
    _shouldShowFooter = shouldShowFooter;
    shouldShowFooter ? [self.footerView.spinner startAnimation] : [self.footerView.spinner stopAnimation];
}

#pragma mark - Search

- (void)searchForKeywords:(NSString *)keywords withOffset:(NSUInteger)offset
{
    self.fetching = YES;
    self.shouldShowFooter = YES;

    [self.searchClient searchForKeywords:keywords offset:offset completion:^(NSArray *listings, NSError *error) {
        self.shouldShowFooter = NO;

        if (error) {
            NSLog(@"error: %@", error.localizedDescription);
            self.fetching = NO;
        }
        else {
            NSLog(@"Listings: %@", listings);

            if (listings.count == 0) {
                self.fetching = NO;
                self.endOfSearchResults = YES;

                // Not as smooth as I would like, but sligthly better than invalidating layout
                // which causes collection view to flicker when coming to rest.
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.collectionView performBatchUpdates:nil completion:nil];
                });
            }

            NSInteger numberOfExistingCards = self.listingCards.count;

            for (int i = 0; i < listings.count; i++) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC) * i), dispatch_get_main_queue(), ^{
                    ETListingCard *card = [[ETListingCard alloc] initWithListing:listings[i]];
                    [self.listingCards addObject:card];
                    [self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:(numberOfExistingCards + i) inSection:0]]];

                    BOOL isLastItem = (i == listings.count - 1);
                    if (isLastItem) {
                        self.fetching = NO;
                        [self.collectionView flashScrollIndicators];
                    }
                });
            }
        }
    }];
}

#pragma mark - ETSearchBarDelegate

- (void)searchBarSearchButtonClicked:(ETSearchBar *)searchBar
{
    self.currentSearchText = searchBar.text;
    self.endOfSearchResults = NO;

    if (self.currentSearchText.length > 0) {
        // Clear collection view & show spinner
        [self.listingCards removeAllObjects];
        [self.collectionView reloadData];

        [self searchForKeywords:self.currentSearchText withOffset:0];

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
    return self.listingCards.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ETListingCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ETListingReuseIdentifier forIndexPath:indexPath];
    ETListingCard *card = [self listingCardForIndexPath:indexPath];
    [cell configureWithListingCard:card];

    [cell.mainImageView setImageWithURLRequest:[NSURLRequest requestWithURL:card.mainImageURL]
                              placeholderImage:nil
                                       success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
                                            [cell.mainImageView et_fadeImage:image];
                                       }
                                       failure:nil];

    BOOL isLastItem = (indexPath.row == self.listingCards.count - 1);
    if (isLastItem && !self.endOfSearchResults && !self.isFetching) {
        [self.collectionViewLayout invalidateLayout];
        [self searchForKeywords:self.currentSearchText withOffset:self.listingCards.count];
    }

    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView = nil;

    if (kind == UICollectionElementKindSectionFooter) {
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
        self.footerView = (ETListingsFooterView *)reusableView;
    }

    return reusableView;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (self.shouldShowFooter) {
        return CGSizeMake(CGRectGetWidth(self.collectionView.frame), ETFooterViewHeight);
    }
    return CGSizeMake(0.1, 0.1); // Collection view crashes if footer size is CGRectZero.
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ETListingCard *card = [self listingCardForIndexPath:indexPath];
    SFSafariViewController *safariViewController = [[SFSafariViewController alloc] initWithURL:card.listingURL];
    safariViewController.view.tintColor = self.collectionView.tintColor;
    [self presentViewController:safariViewController animated:YES completion:nil];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout*)collectionViewLayout;

    CGFloat collectionViewWidth = CGRectGetWidth(collectionView.frame);
    NSUInteger cellsPerRow = collectionViewWidth / ETDefaultCellWidth;

    CGFloat availableWidthForCells = collectionViewWidth - flowLayout.sectionInset.left - flowLayout.sectionInset.right - flowLayout.minimumInteritemSpacing * (cellsPerRow - 1);
    CGFloat cellWidth = availableWidthForCells / cellsPerRow;

    return CGSizeMake(cellWidth, cellWidth);
}

#pragma mark - UIViewController

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        [self.collectionView performBatchUpdates:nil completion:nil];
    } completion:nil];
}

@end
