//
//  USPhotoScroll.h
//  Just Us
//
//  Created by Peter Tsoi on 9/23/11.
//  Copyright 2011 Pixar Animation Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "USPhoto.h"

@interface USPhotoScroll : UIView <USPhotoLoadingDelegate> {
    NSMutableArray * mPhotos;
    id <USPhotoLoadingDelegate> delegate;
}

@end
