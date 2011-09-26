//
//  USThumbView.m
//  Just
//
//  Created by Peter Tsoi on 9/25/11.
//  Copyright 2011 Pixar Animation Studios. All rights reserved.
//

#import "USThumbView.h"
#import "USPhoto.h"

@implementation USThumbView

- (void) setPhoto:(USPhoto *) newPhoto {
    if (newPhoto == nil) {
        RELEASE_SAFELY(mPhoto);
    } else {
        mPhoto = newPhoto;
    }
}

- (void) drawRect:(CGRect)rect {
    [super drawRect:rect];
    [self setBackgroundColor:[UIColor colorWithPatternImage:[mPhoto thumbnail]]];
}

@end
