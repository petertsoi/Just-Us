//
//  USDetailEditorView.h
//  Just
//
//  Created by Peter Tsoi on 9/25/11.
//  Copyright 2011 Pixar Animation Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "USPhoto.h"

@interface USDetailEditorView : UIView <UITextFieldDelegate, USPhotoLoaderDelegate> {
    IBOutlet UITextField * mTitleField;
    IBOutlet UITextField * mLocationField;
    IBOutlet UITextField * mTimeField;
    IBOutlet UIImageView * mImageView;
    
    USPhoto * mPhoto;
}

@property (readonly, retain) USPhoto * photo;

- (void) setPhoto:(USPhoto *)photo;
- (void) savePhoto;

@end
