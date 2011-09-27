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
    UIImage * previewImage = mPhoto.image;
    [mImageView setImage:previewImage];
    
    float aspectRatio = previewImage.size.width/previewImage.size.height;
    mImageView.frame = CGRectMake(mImageView.frame.origin.x, mImageView.frame.origin.y, 
                                  mImageView.frame.size.width, mImageView.frame.size.width / aspectRatio);
    /*[mImageView setFrame:CGRectMake(mImageView.frame.origin.x, mImageView.frame.origin.y, 
                                    mPhoto.image.size.width, mPhoto.image.size.height)];*/
    //[mImageView setImage:[mPhoto thumbnail]];
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
