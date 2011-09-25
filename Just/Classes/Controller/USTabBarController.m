//
//  USTabBarController.m
//  Just
//
//  Created by Peter Tsoi on 9/25/11.
//  Copyright 2011 Pixar Animation Studios. All rights reserved.
//

#import "USTabBarController.h"

@implementation USTabBarController

- (void) switchToCamera {
    self.selectedIndex = 1;
}

- (void) setupCameraButton {
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    
    UIImage * cameraButtonImage = [UIImage imageNamed:@"tabbar_camera.png"];
    UIImage * cameraButtonActiveImage = [UIImage imageNamed:@"tabbar_camera_active.png"];
    
    button.frame = CGRectMake(0.0, 0.0, cameraButtonImage.size.width, cameraButtonImage.size.height);
    [button setBackgroundImage:cameraButtonImage forState:UIControlStateNormal];
    [button setBackgroundImage:cameraButtonActiveImage forState:UIControlStateHighlighted];
    
    CGFloat heightDifference = cameraButtonImage.size.height - self.tabBar.frame.size.height;
    if (heightDifference < 0)
        button.center = self.tabBar.center;
    else
    {
        CGPoint center = self.tabBar.center;
        center.y = center.y - heightDifference/2.0;
        button.center = center;
    }
    
    [self.view addSubview:button];
    
    [button addTarget:self action:@selector(switchToCamera) forControlEvents:UIControlEventTouchUpInside];
}

- (void) viewDidLoad {
    [super viewDidLoad];
    [self setupCameraButton];
}

@end
