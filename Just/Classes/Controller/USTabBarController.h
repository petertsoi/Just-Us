//
//  USTabBarController.h
//  Just
//
//  Created by Peter Tsoi on 9/25/11.
//  Copyright 2011 Pixar Animation Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@class USCameraController;

@interface USTabBarController : UITabBarController {
    USCameraController *mCameraController;
    unsigned int mLastState;
}

- (void) switchToPreviousState;

@end
