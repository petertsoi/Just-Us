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

@synthesize photo = mPhoto;

- (void) setPhoto:(USPhoto *) newPhoto {
    mPhoto = [newPhoto retain];
    if (mPhoto == nil) {
        RELEASE_SAFELY(mPhoto);
    } else {
        [self setBackgroundColor:[UIColor colorWithPatternImage:[mPhoto thumbnail]]];
        //[self setBackgroundColor:[UIColor blueColor]];
    }
}
/*
- (void) drawRect:(CGRect)rect {
    UIImage * bg = [mPhoto thumbnail];
    [self setBackgroundColor:[UIColor colorWithPatternImage:bg]];
}*/

@end
