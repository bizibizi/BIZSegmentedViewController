//
//  BIZSegmentedViewControllerExtra.m
//  IgorBizi@mail.ru
//
//  Created by IgorBizi@mail.ru on 5/20/15.
//  Copyright (c) 2015 IgorBizi@mail.ru. All rights reserved.
//

#import "BIZSegmentedViewControllerExtra.h"


#define k_animationTime 0.5


@interface BIZSegmentedViewControllerExtra ()
@property (nonatomic, getter=isTransitionInProgress) BOOL transitionInProgress;
@end


@implementation BIZSegmentedViewControllerExtra


#pragma mark - Abstract class


- (NSArray *)viewControllersForSectionsInExtraMode
{
    NSLog(@"Error: Must implement abstract methods");
    return nil;
}

- (BOOL)activateAdditionalModeAtStartup
{
    return NO;
}


#pragma mark - SuperClass


- (void)assignViewControllersForSections
{
    [super assignViewControllersForSections];
    
    if ([self viewControllersForSectionsInExtraMode])
    {
        [self addChildViewControllersFromArray:[self viewControllersForSectionsInExtraMode]];
    }
}

// * Assign indexes that will be used to move between childViewControllers
// * Choose indexes based on enaled/disabled AdditionalMode
- (void)setIndexesForSectionsAtStartup
{
    if ([self activateAdditionalModeAtStartup]) {
        [self setIndexesForSectionsInAdditionalMode];
    } else {
        [self setIndexesForSections];
    }
}

// * Indexes for ViewControllers in AdditionalMode
- (void)setIndexesForSectionsInAdditionalMode
{
    self.indexForSection1 = 2;
    self.indexForSection2 = 3;
}

#pragma mark - Getters/Setters


// * After setting AdditionalMode on/off move to or out of ViewControllers for AdditionalMode
- (void)setInAdditionalMode:(BOOL)inAdditionalMode
{
    if (!self.isTransitionInProgress) {
        _inAdditionalMode = inAdditionalMode;
        
        // * Start of transition
        self.isInTransitionAdditionMode = YES;
        
        [self updateIndexesForSections];
        [self updateIndexForSelectedSection];
    }
}

// * Choose indexes based on enaled/disabled AdditionalMode
- (void)updateIndexesForSections
{
    if (self.inAdditionalMode) {
        [self setIndexesForSectionsInAdditionalMode];
    } else {
        [self setIndexesForSections];
    }
}

// * After changing AdditionalMode need to update index for selected section
- (void)updateIndexForSelectedSection
{
    if (self.indexForSelectedSection == 2 ||
        self.indexForSelectedSection == 3)
    {
        self.indexForSelectedSection -= [self viewControllersForSectionsInExtraMode].count;
    } else if (self.indexForSelectedSection == 0 ||
               self.indexForSelectedSection == 1)
    {
        self.indexForSelectedSection += [self viewControllersForSectionsInExtraMode].count;
    }
    
    [self transitionInOutAdditionalMode];
}

// * Performs transition
- (void)transitionInOutAdditionalMode
{
    self.transitionInProgress = YES;
    
    NSUInteger index = self.indexForSelectedSection;
    UIViewController *firstVC = self.selectedViewController;
    UIViewController *secondVC = self.childViewControllers[index];
    
    // * Do not change frame of VC that at the screen now
    // * Set frame of secondVC without animation to get clear CrossDissolve transition
    secondVC.view.frame = self.containerView.bounds;
    
    [self transitionFromViewController:firstVC
                      toViewController:secondVC
                              duration:k_animationTime
                               options:UIViewAnimationOptionTransitionCrossDissolve | UIViewAnimationOptionCurveEaseInOut
                            animations:nil completion:^(BOOL finished) {
                                
                                [self moveToViewControllerAtIndex:index];
                                
                                // * End of transition
                                self.isInTransitionAdditionMode = NO;
                                self.transitionInProgress = NO;
                            }];
}

@end
