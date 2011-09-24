//
//  USCameraController.m
//  Just Us
//
//  Created by Peter Tsoi on 9/23/11.
//  Copyright 2011 Pixar Animation Studios. All rights reserved.
//

#import "USCameraController.h"
#import "AppDelegate.h"

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

- (void)viewWillAppearFrom:(unsigned int) previousState{
    [super viewWillAppear:YES];
    [self presentModalViewController:mPicker animated:YES];
    mLastState = previousState;
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
