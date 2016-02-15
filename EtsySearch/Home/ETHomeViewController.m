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
static NSTimeInterval const ETTimerInterval = 7;
static NSTimeInterval const ETCrossFadeDuration = 0.4;
static NSUInteger const ETMinHeightForImage = 400;
static NSUInteger const ETLandscapeSearchBarOffset = 40;

@interface ETHomeViewController () <ETSearchBarDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *randomImageView;
@property (nonatomic) IBOutlet NSLayoutConstraint *randomImageViewZeroHeightConstraint;
@property (nonatomic) IBOutlet NSLayoutConstraint *searchBarYConstraint;
@property (weak, nonatomic) IBOutlet ETSearchBar *searchBar;

@property (nonatomic) CGFloat searchBarYConstraintOriginalConstant;
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
    [self updateRandomImageAnimated:NO];
    [self startTimer];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];

    if (CGRectGetHeight(self.view.bounds) < ETMinHeightForImage) {
        [self hideRandomImage];
    }
    else {
        [self showRandomImage];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self stopTimer];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
}

#pragma mark - Properties

- (CGFloat)searchBarYConstraintOriginalConstant
{
    if (_searchBarYConstraintOriginalConstant == 0) {
        _searchBarYConstraintOriginalConstant = self.searchBarYConstraint.constant;
    }
    return _searchBarYConstraintOriginalConstant;
}

#pragma mark - Random images

+ (NSArray *)imageInfo
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"HomeImages" ofType:@"plist"];
    return [[NSArray alloc] initWithContentsOfFile:path];
}

- (void)setupRandomImages
{
    self.randomImageEnumerator = [[ETRandomObjectEnumerator alloc] initWithArray:[ETHomeViewController imageInfo]];

    [self updateRandomImageAnimated:NO];
    [self addTimerObservers];
}

- (void)updateRandomImageAnimated:(BOOL)animated
{
    NSDictionary *imageInfo = [self.randomImageEnumerator nextObject];

    UIImage *nextImage = [UIImage imageNamed:imageInfo[@"imageName"]];
    NSString *nextPlaceholder = [NSString stringWithFormat:@"Find something %@...", imageInfo[@"keyword"]];

    BOOL fadeDuration = animated ? ETCrossFadeDuration : 0;
    [self.randomImageView et_fadeImage:nextImage withDuration:fadeDuration];

    BOOL fadePlaceholderDuration = self.searchBar.text.length == 0 ? fadeDuration : 0;
    [self fadePlaceholder:nextPlaceholder withDuration:fadePlaceholderDuration];
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

- (void)updateRandomImage
{
    [self updateRandomImageAnimated:YES];
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

- (void)stopTimer
{
    [self.randomImageTimer invalidate];
    self.randomImageTimer = nil;
}

- (void)addTimerObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(startTimer)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(stopTimer)
                                                 name:UIApplicationWillResignActiveNotification
                                               object:nil];
}

- (void)hideRandomImage
{
    self.randomImageViewZeroHeightConstraint.active = YES;
    self.searchBarYConstraint.constant = self.searchBarYConstraintOriginalConstant - ETLandscapeSearchBarOffset;
}

- (void)showRandomImage
{
    self.randomImageViewZeroHeightConstraint.active = NO;
    self.searchBarYConstraint.constant = self.searchBarYConstraintOriginalConstant;
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
