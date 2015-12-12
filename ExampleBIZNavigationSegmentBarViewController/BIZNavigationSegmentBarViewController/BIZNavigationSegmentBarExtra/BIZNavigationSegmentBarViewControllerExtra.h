//
//  BIZNavigationSegmentBarViewControllerExtra.h
//  IgorBizi@mail.ru
//
//  Created by IgorBizi@mail.ru on 5/20/15.
//  Copyright (c) 2015 IgorBizi@mail.ru. All rights reserved.
//

#import "BIZNavigationSegmentBarViewController.h"


// * Extension for BIZNavigationSegmentBarViewController that adds extra ViewControllers
// * It had 2 modes with different ViewControllers
// * Mode can be changed with changing property 'inAdditionalMode'
// * Sample of using is NearbyViewController
@interface BIZNavigationSegmentBarViewControllerExtra : BIZNavigationSegmentBarViewController

// * Must Implement
// * Additional ViewControllers
- (NSArray *)viewControllersForSectionsInAdditionalMode;

// * Must Implement if need to start with definite Mode
- (BOOL)activateAdditionalModeAtStartup;

// * Turn off/on AdditionalMode (switch between ViewControllers)
@property (nonatomic) BOOL inAdditionalMode;

// * Specify state of transition
@property (nonatomic) BOOL isInTransitionAdditionMode;

@end
