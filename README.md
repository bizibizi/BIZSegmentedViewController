# BIZSegmentedViewController

*Wait for gif presentation, it's loading...*

![alt tag](https://github.com/bizibizi/BIZNavigationSegmentBarViewController/blob/master/presentation.gif)


BIZSegmentedViewController is a class that creates container with 2 or 4 UIViewControlers.


# Installation

### Manually
- Copy ```Classes``` folder to your project 

### From CocoaPods:
```objective-c
pod 'BIZSegmentedViewController' 
```


# Usage

- Create ```ContainerViewController``` as subclass of ```BIZSegmentedViewController```  or ```BIZSegmentedViewControllerExtra``` (Extra Mode)
- Create and setup ```UIViewControllers```
```objective-c
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

//For Extra mode
- (NSArray *)viewControllersForSectionsInExtraMode
{
    ViewController3 *vc3 = [[ViewController3 alloc] initWithNibName:@"ViewController3" bundle:nil];
    ViewController4 *vc4 = [[ViewController4 alloc] initWithNibName:@"ViewController4" bundle:nil];
    
    return @[vc3, vc4];
}
```

- Setup ```Extra Mode```
```objective-c
- (void)setup
{
    [super setup];
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithTitle:@"Extra" style:UIBarButtonItemStylePlain target:self action:@selector(extraButtonAction:)];
    self.navigationItem.rightBarButtonItem = barButton;
}

- (void)extraButtonAction:(UIBarButtonItem *)sender
{
    self.inAdditionalMode = !self.inAdditionalMode;
}
```


# Contact

Igor Bizi
- https://www.linkedin.com/in/igorbizi
- igorbizi@mail.ru


# License
 
The MIT License (MIT)

Copyright (c) 2015-present Igor Bizi

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 
