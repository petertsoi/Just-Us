//
//  USTabBarController.h
//  Just Us
//
//  Created by Peter Tsoi on 9/23/11.
//  Copyright 2011 Pixar Animation Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface USTabBarController : UITabBarController{
}

// Create a custom UIButton and add it to the center of our tab bar
-(void) addCenterButtonWithImage:(UIImage*)buttonImage highlightImage:(UIImage*)highlightImage;


@end
