//
//  USCameraController.m
//  Just Us
//
//  Created by Peter Tsoi on 9/23/11.
//  Copyright 2011 Pixar Animation Studios. All rights reserved.
//

#import "USCameraController.h"
#import "AppDelegate.h"
#import "USTabBarController.h"

@implementation USCameraController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        NSLog(@"Init cam control");
        mPicker = [[UIImagePickerController alloc] init];
        mPicker.delegate = self;
        mPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self presentModalViewController:mPicker animated:YES];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    mLastState = [(USTabBarController *)[appDelegate tabBarController] getLastState];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	[picker dismissModalViewControllerAnimated:YES];
	/*imageView.image = */
    //[info objectForKey:@"UIImagePickerControllerOriginalImage"];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [[appDelegate tabBarController] setSelectedIndex:mLastState]; 
    
    [picker dismissModalViewControllerAnimated:YES];
}


- (UIImagePickerController *) photoPicker{
    return mPicker;
    
}
@end
