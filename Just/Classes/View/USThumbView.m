//
//  USThumbView.m
//  Just
//
//  Created by Peter Tsoi on 9/25/11.
//  Copyright 2011 Pixar Animation Studios. All rights reserved.
//

#import "USThumbView.h"

#import "USPhotoChooserView.h"
#import "USPhoto.h"

@implementation USThumbView

@synthesize photo = mPhoto;

- (id) initWithController:(USPhotoChooserView *)target {
    self = [super init];
    if (self) {
        mTarget = target;
    }
    return self;
}

- (void) setPhoto:(USPhoto *) newPhoto {
    mPhoto = [newPhoto retain];
    if (mPhoto == nil) {
        RELEASE_SAFELY(mPhoto);
    } else {
        [self setImage:[mPhoto thumbnail] forState:UIControlStateNormal];
        [self addTarget:mTarget action:@selector(addPhoto:) forControlEvents:UIControlEventTouchUpInside];
    }
}

@end
