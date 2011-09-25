//
//  USCameraController.h
//  Just
//
//  Created by Peter Tsoi on 9/25/11.
//  Copyright 2011 Pixar Animation Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@class USTabBarController;

@interface USCameraController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    UIImagePickerController * mPicker;
    USTabBarController * mController;
    IBOutlet UIScrollView * mScrollContainer;
}

@property (nonatomic, retain) USTabBarController * controller;

@end
