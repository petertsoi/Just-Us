//
//  USThumbView.h
//  Just
//
//  Created by Peter Tsoi on 9/25/11.
//  Copyright 2011 Pixar Animation Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@class USPhotoChooserView, USPhoto;

@interface USThumbView : UIButton {
    USPhoto * mPhoto;
    USPhotoChooserView * mTarget;
}

@property (readonly, retain) USPhoto * photo;

- (id) initWithController:(USPhotoChooserView *)target;

- (void) setPhoto:(USPhoto *) newPhoto;

@end
