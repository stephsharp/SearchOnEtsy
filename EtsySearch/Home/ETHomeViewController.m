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
#import "ETRandomObjectEnumerator.h"
#import "UIImageView+ETFade.h"

static NSString *const ETListingsSegueIdentifier = @"ListingsSegue";
static NSTimeInterval const ETTimerInterval = 6;
static NSTimeInterval const ETCrossFadeDuration = 0.4;

@interface ETHomeViewController () <ETSearchBarDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *randomImageView;
@property (weak, nonatomic) IBOutlet ETSearchBar *searchBar;

@property (nonatomic) ETRandomObjectEnumerator *randomImageEnumerator;
@property (nonatomic) NSTimer *randomImageTimer;
@property (nonatomic) ETSearchTransitioningDelegate *transitioningDelegate;

@end

@implementation ETHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.transitioningDelegate = [ETSearchTransitioningDelegate new];
    [self setupRandomImages];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.searchBar.text = nil;

    [self startTimer];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self stopTimer];
}

#pragma mark - Random images

- (void)setupRandomImages
{
    self.randomImageEnumerator = [[ETRandomObjectEnumerator alloc] initWithArray:[ETHomeViewController imageInfo]];
    [self updateRandomImage];
}

- (void)updateRandomImage
{
    NSDictionary *imageInfo = [self.randomImageEnumerator nextObject];

    UIImage *nextImage = [UIImage imageNamed:imageInfo[@"imageName"]];
    NSString *nextPlaceholder = [NSString stringWithFormat:@"Search for something %@...", imageInfo[@"keyword"]];

    [self.randomImageView et_fadeImage:nextImage withDuration:ETCrossFadeDuration];
    [self fadePlaceholder:nextPlaceholder withDuration:ETCrossFadeDuration];
}

- (void)fadePlaceholder:(NSString *)placeholderText withDuration:(NSTimeInterval)duration
{
    [UIView transitionWithView:self.searchBar
                      duration:duration
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        self.searchBar.placeholder = placeholderText;
                    } completion:nil];
}

+ (NSArray *)imageInfo
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"HomeImages" ofType:@"plist"];
    return [[NSArray alloc] initWithContentsOfFile:path];
}

- (void)stopTimer
{
    [self.randomImageTimer invalidate];
    self.randomImageTimer = nil;
}

- (void)startTimer
{
    if (self.randomImageTimer) {
        [self stopTimer];
    }

    self.randomImageTimer = [NSTimer scheduledTimerWithTimeInterval:ETTimerInterval
                                                             target:self
                                                           selector:@selector(updateRandomImage)
                                                           userInfo:nil
                                                            repeats:YES];
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
