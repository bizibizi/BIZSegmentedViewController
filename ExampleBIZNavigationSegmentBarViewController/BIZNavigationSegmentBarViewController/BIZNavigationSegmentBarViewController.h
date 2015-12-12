//
//  BIZNavigationSegmentBarViewController.h
//  IgorBizi@mail.ru
//
//  Created by IgorBizi@mail.ru on 4/29/15.
//  Copyright (c) 2015 IgorBizi@mail.ru. All rights reserved.
//

#import <UIKit/UIKit.h>


// * ABSTRACT CLASS
// * Root class for VC's with 2 selection segments below navigation bar
// * Need to use with Custom NavigationBar to avoid the navigationBar items to steal the touches
@interface BIZNavigationSegmentBarViewController : UIViewController

// * Must implement
- (NSArray *)titlesForSections;
- (NSArray *)viewControllersForSections;

// * Must call super if override 'setup' function
- (void)setup;


///////// *  Shared to subclasses
// * Class have 2 segments, it indexes can be changed
@property (nonatomic) NSUInteger indexForSection1;
@property (nonatomic) NSUInteger indexForSection2;
// * Event handling
// * Save selected index
@property (nonatomic) NSUInteger indexForSelectedSection;
// * Save selected ViewController
@property (nonatomic, strong) UIViewController *selectedViewController;
// * Other ViewControllers placed in it
@property (weak, nonatomic) IBOutlet UIView *containerView;
// *  Shared assistant methods
- (void)moveToViewControllerAtIndex:(NSUInteger)index;
- (void)assignViewControllersForSections;
- (void)addChildViewControllersFromArray:(NSArray *)list;
- (void)setIndexesForSections;
// *


@end
