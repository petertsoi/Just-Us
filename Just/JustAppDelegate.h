//
//  JustAppDelegate.h
//  Just
//
//  Created by Peter Tsoi on 9/25/11.
//  Copyright 2011 Pixar Animation Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JustAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@end
