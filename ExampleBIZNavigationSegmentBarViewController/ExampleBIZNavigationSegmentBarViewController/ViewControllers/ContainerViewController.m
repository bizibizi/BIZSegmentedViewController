//
//  ContainerViewController.m
//  IgorBizi@mail.ru
//
//  Created by IgorBizi@mail.ru on 10/26/15.
//  Copyright © 2015 IgorBizi@mail.ru. All rights reserved.
//

#import "ContainerViewController.h"
#import "ViewController1.h"
#import "ViewController2.h"
#import "ViewController3.h"
#import "ViewController4.h"



@implementation ContainerViewController


#pragma mark - Abstract class


- (NSArray *)titlesForSections
{
    return @[@"Left", @"Right"];
}

- (NSArray *)viewControllersForSections
{
    ViewController1 *vc1 = [[ViewController1 alloc] initWithNibName:@"ViewController1" bundle:nil];
    ViewController2 *vc2 = [[ViewController2 alloc] initWithNibName:@"ViewController2" bundle:nil];
    
    return @[vc1, vc2];
}

- (NSArray *)viewControllersForSectionsInAdditionalMode
{
    ViewController3 *vc3 = [[ViewController3 alloc] initWithNibName:@"ViewController3" bundle:nil];
    ViewController4 *vc4 = [[ViewController4 alloc] initWithNibName:@"ViewController4" bundle:nil];
    
    return @[vc3, vc4];
}


#pragma mark - LifeCycle


- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)setup
{
    [super setup];
    
    self.title = @"BIZNavigationSegmentBar";
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithTitle:@"Extra" style:UIBarButtonItemStylePlain target:self action:@selector(extraButtonAction)];
    self.navigationItem.rightBarButtonItem = barButton;
}

- (void)extraButtonAction
{
    self.inAdditionalMode = !self.inAdditionalMode;
}


@end
