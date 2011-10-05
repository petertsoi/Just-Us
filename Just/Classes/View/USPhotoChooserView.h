//
//  USPhotoChooserView.h
//  Just
//
//  Created by Peter Tsoi on 10/4/11.
//  Copyright 2011 Pixar Animation Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@class USMemoriesController;

@interface USPhotoChooserView : UIView {
    USMemoriesController * mController;
    UIButton * mOverlayButton;
    UIButton * mDoneButton;
    
    NSMutableArray * mThumbHolders;
    NSMutableArray * mSelectedPhotos;
    
    BOOL mOverlayVisible;
}

@property (nonatomic, retain) NSMutableArray * selectedPhotos;

- (void) setController:(USMemoriesController *) control;

@end
