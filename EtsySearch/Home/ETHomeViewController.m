//
//  ETHomeViewController.m
//  EtsySearch
//
//  Created by Steph Sharp on 12/02/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import "ETHomeViewController.h"
#import "ETListingsViewController.h"
#import "ETSearchTransitioningDelegate.h"
#import "UIViewController+ETContentViewController.h"
#import "ETSearchBar.h"

static NSString *const ETListingsSegueIdentifier = @"ListingsSegue";

@interface ETHomeViewController () <ETSearchBarDelegate>

@property (weak, nonatomic) IBOutlet ETSearchBar *searchBar;
@property (nonatomic) ETSearchTransitioningDelegate *transitioningDelegate;

@end

@implementation ETHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.transitioningDelegate = [ETSearchTransitioningDelegate new];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.searchBar.text = nil;
}

#pragma mark - ETSearchBarDelegate

- (void)searchBarSearchButtonClicked:(ETSearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];

    if (!searchBar.isEmpty) {
        [self performSegueWithIdentifier:ETListingsSegueIdentifier sender:searchBar];
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:ETListingsSegueIdentifier]) {
        ETListingsViewController *listingsVC = (ETListingsViewController *)segue.destinationViewController.et_contentViewController;
        listingsVC.searchText = self.searchBar.text;

        segue.destinationViewController.transitioningDelegate = self.transitioningDelegate;
        segue.destinationViewController.modalPresentationStyle = UIModalPresentationCustom;
    }
}

- (IBAction)unwindToHomeViewController:(UIStoryboardSegue *)unwindSegue
{

}

#pragma mark - ETSearchTransitionViewController

- (UIView *)transitioningSearchBar
{
    return self.searchBar;
}

@end
