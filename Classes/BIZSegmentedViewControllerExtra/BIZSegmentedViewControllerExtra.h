//
//  BIZSegmentedViewControllerExtra.h
//  IgorBizi@mail.ru
//
//  Created by IgorBizi@mail.ru on 5/20/15.
//  Copyright (c) 2015 IgorBizi@mail.ru. All rights reserved.
//

#import "BIZSegmentedViewController.h"


// * Extension for BIZSegmentedViewController that adds extra ViewControllers
// * It had 2 modes with different ViewControllers
// * Mode can be changed with changing property 'inAdditionalMode'
// * Sample of using is NearbyViewController
@interface BIZSegmentedViewControllerExtra : BIZSegmentedViewController

// * Must Implement
// * Additional ViewControllers
- (NSArray *)viewControllersForSectionsInExtraMode;

// * Must Implement if need to start with definite Mode
- (BOOL)activateAdditionalModeAtStartup;

// * Turn off/on AdditionalMode (switch between ViewControllers)
@property (nonatomic) BOOL inAdditionalMode;

// * Specify state of transition
@property (nonatomic) BOOL isInTransitionAdditionMode;

@end
