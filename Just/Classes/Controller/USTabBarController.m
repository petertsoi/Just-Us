//
//  USTabBarController.m
//  Just
//
//  Created by Peter Tsoi on 9/25/11.
//  Copyright 2011 Pixar Animation Studios. All rights reserved.
//

#import "USTabBarController.h"
#import "USMemoriesController.h"
#import "USMemoryChooserController.h"
#import "USCameraController.h"

@implementation USTabBarController

- (void) newPhotoAdded {
    //[mMemoriesController.chooserController loadDataSource];
}

#pragma mark Camera Button
- (void) switchToCamera {
    
    mLastState = self.selectedIndex;
    UIImage * cameraButtonActiveImage = [UIImage imageNamed:@"tabbar_camera_active.png"];
    [mCameraButton setBackgroundImage:cameraButtonActiveImage forState:UIControlStateNormal];
    
    //[self presentModalViewController:mCameraController animated:YES];
    //self.selectedIndex = 1;     // Replace with present modal?
    [mCameraController showImagePicker];
}

- (void) switchToPreviousState {
    self.selectedIndex = mLastState;
    UIImage * cameraButtonImage = [UIImage imageNamed:@"tabbar_camera.png"];
    [mCameraButton setBackgroundImage:cameraButtonImage forState:UIControlStateNormal];
}

- (void) setupCameraButton {
    mCameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
    mCameraButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    
    UIImage * cameraButtonImage = [UIImage imageNamed:@"tabbar_camera.png"];
    UIImage * cameraButtonActiveImage = [UIImage imageNamed:@"tabbar_camera_active.png"];
    
    mCameraButton.frame = CGRectMake(0.0, 0.0, cameraButtonImage.size.width, cameraButtonImage.size.height);
    [mCameraButton setBackgroundImage:cameraButtonImage forState:UIControlStateNormal];
    [mCameraButton setBackgroundImage:cameraButtonActiveImage forState:UIControlStateHighlighted];
    
    CGFloat heightDifference = cameraButtonImage.size.height - self.tabBar.frame.size.height;
    if (heightDifference < 0)
        mCameraButton.center = self.tabBar.center;
    else
    {
        CGPoint center = self.tabBar.center;
        center.y = center.y - heightDifference/2.0;
        mCameraButton.center = center;
    }
    
    [self.view addSubview:mCameraButton];
    
    [mCameraButton addTarget:self action:@selector(switchToCamera) forControlEvents:UIControlEventTouchUpInside];
    
    mCameraController = [self.viewControllers objectAtIndex:1];
    [mCameraController setController:self];
}

#pragma mark - UITabBarControllerDelegate Methods
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    UIImage * cameraButtonImage = [UIImage imageNamed:@"tabbar_camera.png"];
    [mCameraButton setBackgroundImage:cameraButtonImage forState:UIControlStateNormal];
}

#pragma mark - UIViewController Override
- (void) viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    [self setupCameraButton];
    mMemoriesController = [self.viewControllers objectAtIndex:0];
}

@end
