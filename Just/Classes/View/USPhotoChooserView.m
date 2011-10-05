//
//  USPhotoChooserView.m
//  Just
//
//  Created by Peter Tsoi on 10/4/11.
//  Copyright 2011 Pixar Animation Studios. All rights reserved.
//

#import "USPhotoChooserView.h"

#import "USPhoto.h"
#import "USThumbView.h"

@implementation USPhotoChooserView

- (void) fadeOverlay {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25];
    mOverlayButton.alpha = 0.0; 
    [UIView commitAnimations];
    mOverlayVisible = NO;
}

- (void) awakeFromNib {
    mOverlayVisible = YES;
    mThumbHolders = [[NSMutableArray alloc] initWithCapacity:3];
    mSelectedPhotos = [[NSMutableArray alloc] init];
    [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"chooserBG.png"]]];
    
    for (unsigned int i = 0; i < 3; ++i) {
        UIImageView * thumbHolder = [[UIImageView alloc] initWithFrame:CGRectMake(4 + 79*i, 15, 75, 75)];
        [mThumbHolders addObject:thumbHolder];
        [self addSubview:thumbHolder];
    }
    
    mDoneButton = [[UIButton alloc] initWithFrame:CGRectMake(244, 11, 76, 88)];
    [mDoneButton setImage:[UIImage imageNamed:@"chooserDoneButton.png"] forState:UIControlStateNormal];
    [self addSubview:mDoneButton];
    
    mOverlayButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 8, 320, 90)];
    [mOverlayButton setImage:[UIImage imageNamed:@"overlay.png"] forState:UIControlStateNormal];
    [mOverlayButton addTarget:self action:@selector(fadeOverlay) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:mOverlayButton];
}

- (void) addPhoto:(USThumbView *)sender {
    if ([mSelectedPhotos count] < 3 && !mOverlayVisible) {
        USPhoto * newPhoto = sender.photo;
        UIImageView * currentThumbHolder = [mThumbHolders objectAtIndex:[mSelectedPhotos count]];
        [currentThumbHolder setBackgroundColor:[UIColor colorWithPatternImage:[newPhoto thumbnail]]];
        [mSelectedPhotos addObject:newPhoto];
    }
    
}


@end
