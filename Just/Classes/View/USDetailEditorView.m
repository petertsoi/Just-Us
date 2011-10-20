//
//  USDetailEditorView.m
//  Just
//
//  Created by Peter Tsoi on 9/25/11.
//  Copyright 2011 Pixar Animation Studios. All rights reserved.
//

#import "USDetailEditorView.h"
#import "USPhoto.h"

#import <AssetsLibrary/ALAssetsLibrary.h>

@implementation USDetailEditorView

@synthesize photo;

- (void) setPhoto:(USPhoto *) chosenPhoto {
    mPhoto = chosenPhoto;
    mPhoto.delegate = self;
    [mPhoto load];
}

- (void) savePhoto {
    [mPhoto save];
}

#pragma mark - USPhotoLoadingDelegate Methods
- (void) photoLoaded {
    
    NSLog(@"USPhotoLoading Delegate; W: %f, H: %f", mPhoto.image.size.width, mPhoto.image.size.height);
    UIImage * previewImage = [mPhoto imageResizedToMaxSize:CGSizeMake(mImageView.frame.size.width, mImageView.frame.size.height)];
    
    [mImageView setImage:previewImage];
    CGFloat width, height;
    if (IS_RETINA) {
        width = previewImage.size.width / 2;
        height = previewImage.size.height / 2;
    } else {
        width = previewImage.size.width;
        height = previewImage.size.height;
    }
    
    mImageView.frame = CGRectMake(mImageView.frame.origin.x, mImageView.frame.origin.y, 
                                  width, height);
    [mPhoto retain];
}

- (void) dealloc {
    RELEASE_SAFELY(mPhoto);
}


#pragma mark - UITextFieldDelegate Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField { 
    [textField resignFirstResponder]; 
    return YES; 
}

@end
