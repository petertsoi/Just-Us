//
//  USCameraController.h
//  Just
//
//  Created by Peter Tsoi on 9/25/11.
//  Copyright 2011 Pixar Animation Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@class USDetailEditorView, USTabBarController;

@interface USCameraController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    IBOutlet UIScrollView * mScrollContainer;
    
    UIImagePickerController * mPicker;
    USDetailEditorView * mDetailEditorView;
    USTabBarController * mController;
}

@property (nonatomic, retain) USTabBarController * controller;

- (void) showImagePicker;

@end
