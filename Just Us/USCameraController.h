//
//  USCameraController.h
//  Just Us
//
//  Created by Peter Tsoi on 9/23/11.
//  Copyright 2011 Pixar Animation Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface USCameraController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>{
    UIImagePickerController * mPicker;
    unsigned int mLastState;
}

- (UIImagePickerController *) photoPicker;

@end
