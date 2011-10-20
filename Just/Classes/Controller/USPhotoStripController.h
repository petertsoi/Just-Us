//
//  USPhotoStripController.h
//  Just
//
//  Created by Peter Tsoi on 10/4/11.
//  Copyright 2011 Pixar Animation Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Facebook.h"

#define kUSPHOTOSTRIP_WIDTH 185

@interface USPhotoStripController : UIViewController <UITextFieldDelegate, FBRequestDelegate> {
    NSArray * mPhotos;
    NSMutableArray * mPhotoHolders;
    
    UIScrollView * mScroller;
    
    UITextField * mTitleField;
    
    UIButton * mPublicButton;
    UIButton * mFacebookButton;
    
    float mPhotoStripHeight;
    BOOL mIsPublic;
    BOOL mIsFacebook;
}

- (void) togglePublic;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil selectedPhotos:(NSArray *)photos;

@end
