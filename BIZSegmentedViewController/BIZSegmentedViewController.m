//
//  BIZSegmentedViewController.m
//  IgorBizi@mail.ru
//
//  Created by IgorBizi@mail.ru on 4/29/15.
//  Copyright (c) 2015 IgorBizi@mail.ru. All rights reserved.
//

#import "BIZSegmentedViewController.h"
#import "UINavigationBar+ShadowColor.h"


#define k_animationTime 0.5
#define k_INDEX_INITIAL -1


@interface BIZSegmentedViewController ()
// * subviews
@property (weak, nonatomic) IBOutlet UIView *segmentView;
@property (weak, nonatomic) IBOutlet UILabel *selectionAtIndex0_placeholder;
@property (weak, nonatomic) IBOutlet UILabel *selectionAtIndex1_placeholder;
@property (weak, nonatomic) IBOutlet UIButton *buttonAtIndex0;
@property (weak, nonatomic) IBOutlet UIButton *buttonAtIndex1;
// * Moving white line
@property (strong, nonatomic) UIView *selectionView;
// * Specify state of transition
@property (nonatomic) BOOL isInTransition;

@end


@implementation BIZSegmentedViewController


- (UIRectEdge)edgesForExtendedLayout
{
    return [super edgesForExtendedLayout] ^ UIRectEdgeTop;
}


#pragma mark - Abstract class 


- (NSArray *)titlesForSections
{
    NSLog(@"Error: Must implement abstract methods");
    return nil;
}

- (NSArray *)viewControllersForSections
{
    NSLog(@"Error: Must implement abstract methods");
    return nil;
}


#pragma mark - Getters/Setters


// * Init SelectionView with first section
- (UIView *)selectionView
{
    if (!_selectionView) {
        _selectionView = [[UIView alloc] initWithFrame:self.selectionAtIndex0_placeholder.frame];
        _selectionView.backgroundColor = [UIColor blackColor];
        [self.segmentView addSubview:_selectionView];
    }
    return _selectionView;
}


#pragma mark - LifeCycle


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setup];
}

// * First VC loads at screen startup
- (void)setup
{
    [self customization];
    
    [self assignViewControllersForSections];
    
    self.indexForSelectedSection = k_INDEX_INITIAL;
    [self setIndexesForSectionsAtStartup];
    [self selectSectionAtIndex:self.indexForSection1];
    
    // * Move segmentView to top level if Views hierarchy
    [self.view bringSubviewToFront:self.segmentView];
}

- (void)customization
{    
    self.navigationController.navigationBar.translucent = NO;
    self.containerView.backgroundColor = [UIColor clearColor];
    
    self.selectionAtIndex0_placeholder.hidden = YES;
    self.selectionAtIndex1_placeholder.hidden = YES;
    
    [self.buttonAtIndex0 setTitle:@"Left" forState:UIControlStateNormal];
    [self.buttonAtIndex1 setTitle:@"Right" forState:UIControlStateNormal];
}

- (void)assignViewControllersForSections
{
    [self addChildViewControllersFromArray:[self viewControllersForSections]];
}

// * Assistant method
- (void)addChildViewControllersFromArray:(NSArray *)array
{
    for (UIViewController *vc in array)
    {
        [self addChildViewController:vc];
    }
}

// * Assign indexes that will be used to move between childViewControllers
- (void)setIndexesForSectionsAtStartup
{
    [self setIndexesForSections];
}

// * Indexes for ViewControllers
- (void)setIndexesForSections
{
    self.indexForSection1 = 0;
    self.indexForSection2 = 1;
}

// * Layout then sizes changed
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self layoutSelectionViewForSelectedIndex:self.indexForSelectedSection];
    [self layoutChildViewControllers];

    UIColor *color = [self.navigationController.navigationBar.barTintColor colorWithAlphaComponent:0.95];
    [self.buttonAtIndex0 setBackgroundColor:color];
    [self.buttonAtIndex1 setBackgroundColor:color];
    
    [self.navigationController.navigationBar setBottomBorderColor:color height:1];
}

// * Set size of ChildViewControllers as size of containerView
// * ChildViewControllers already have assigned X and Y
- (void)layoutChildViewControllers
{
    for (UIViewController *vc in self.childViewControllers)
    {
        CGRect frame = vc.view.frame;
        frame.size.height = self.containerView.bounds.size.height;
        frame.size.width = self.containerView.bounds.size.width;
        vc.view.frame = frame;
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // * Layout view at startup
    [self layoutSelectionViewForSelectedIndex:self.indexForSelectedSection];
    [self layoutChildViewControllers];
}

// * Set frame of selection placeholder
- (void)layoutSelectionViewForSelectedIndex:(NSUInteger)index
{
    if (index == self.indexForSection1) {
        self.selectionView.frame = self.selectionAtIndex0_placeholder.frame;
    } else if (index == self.indexForSection2) {
        self.selectionView.frame = self.selectionAtIndex1_placeholder.frame;
    }
}


#pragma mark - Events


- (IBAction)buttonAction:(UIButton *)sender
{
    if (!self.isInTransition)
    {
        // * Start of transition
        self.isInTransition = YES;
        
        NSUInteger index = -1;
        if (sender == self.buttonAtIndex0) {
            index = self.indexForSection1;
        } else if (sender == self.buttonAtIndex1) {
            index = self.indexForSection2;
        }
    
        // * Button for section tapped, go to present other section
        [self selectSectionAtIndex:index];
    }
}

- (void)selectSectionAtIndex:(NSUInteger)index
{
    // * Move selectionView
    [UIView animateWithDuration:k_animationTime
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         
                         [self layoutSelectionViewForSelectedIndex:index];
                         
                     } completion:nil];
    
    [self selectViewControllerAtIndex:index];
}

// * Select VC and move to it
- (void)selectViewControllerAtIndex:(NSUInteger)index
{
    if (index < self.childViewControllers.count)
    {
        
        if (self.indexForSelectedSection == k_INDEX_INITIAL) { // * Initial state
            
            [self moveToViewControllerAtIndex:index];
            [self.containerView addSubview:self.selectedViewController.view];
            
        } else if (index != self.indexForSelectedSection) {
            // * Selected differ VC from presented on the screen
            
            UIViewController *firstVC = self.selectedViewController;
            UIViewController *secondVC = self.childViewControllers[index];
    
            // * Sizes
            CGFloat w = self.containerView.frame.size.width;
            CGFloat h = self.containerView.frame.size.height;
            CGFloat y = 0;
            
            // * Perform animation of moving left/right
            // * FirstVC already on the screen
            // * Set FirstVC to the left/right side of the screen
            // * SecondVC is out of screen bounds
            // * Set SecondVC to the screen bounds
            
            CGRect destinationFrameForFirstVC = CGRectZero;
            CGRect destinationFrameForSecondVC = (CGRect){0, y, w, h};
            CGRect sourceFrameForSecondVC = CGRectZero;
            
            if (index == self.indexForSection1) {
                destinationFrameForFirstVC = (CGRect){w, y, w, h};
                sourceFrameForSecondVC = (CGRect){-w, y, w, h};
            } else if (index == self.indexForSection2) {
                destinationFrameForFirstVC = (CGRect){-w, y, w, h};
                sourceFrameForSecondVC = (CGRect){w, y, w, h};
            }
            
            secondVC.view.frame = sourceFrameForSecondVC;
            
            [self transitionFromViewController:firstVC
                              toViewController:secondVC
                                      duration:k_animationTime
                                       options:UIViewAnimationOptionCurveEaseInOut
                                    animations:^{
                       
                    firstVC.view.frame = destinationFrameForFirstVC;
                    secondVC.view.frame = destinationFrameForSecondVC;
                                        
                                    } completion:^(BOOL finished) {
                                        
                                        [self moveToViewControllerAtIndex:index];
                                        
                                        // * End of transition
                                        self.isInTransition = NO;
                                        
                                    }];
        } else {
            self.isInTransition = NO;
        }
        
        self.indexForSelectedSection = index;
    }
}

// * Finish transition of ViewControllers
- (void)moveToViewControllerAtIndex:(NSUInteger)index
{
    // * Index already checked
    self.selectedViewController = self.childViewControllers[index];
    [self didMoveToParentViewController:self.childViewControllers[index]];
}



@end
