//
//  ETHomeViewController.m
//  EtsySearch
//
//  Created by Steph Sharp on 12/02/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import "ETHomeViewController.h"
#import "ETSearchBar.h"
#import "ETListingsViewController.h"

static NSString *const ETListingsSegueIdentifier = @"ListingsSegue";

@interface ETHomeViewController () <ETSearchBarDelegate>

@property (weak, nonatomic) IBOutlet ETSearchBar *searchBar;

@end

@implementation ETHomeViewController

#pragma mark - ETSearchBarDelegate

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];

    self.searchBar.text = self.searchText;
}

- (void)searchBarSearchButtonClicked:(ETSearchBar *)searchBar
{
    self.searchText = searchBar.text;

    if (!searchBar.isEmpty) {
        [self performSegueWithIdentifier:ETListingsSegueIdentifier sender:searchBar];
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:ETListingsSegueIdentifier]) {
        ETListingsViewController *listingsVC = (ETListingsViewController *)segue.destinationViewController;
        listingsVC.searchText = self.searchText;
    }
}

- (IBAction)unwindToHomeViewController:(UIStoryboardSegue *)unwindSegue
{

}

@end
