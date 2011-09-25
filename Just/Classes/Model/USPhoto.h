//
//  USPhoto.h
//  Just Us
//
//  Created by Peter Tsoi on 9/23/11.
//  Copyright 2011 Pixar Animation Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@protocol USNetworkPhotoDelegate <NSObject>
@required
- (void) photoLoaded;
@end

#define THUMBNAIL_SIZE_WIDTH 75.0
#define THUMBNAIL_SIZE_HEIGHT 75.0
#define MAX_PHOTO_SIZE_WIDTH 960.0
#define MAX_PHOTO_SIZE_HEIGHT 960.0

@interface USPhoto : NSObject {
    NSString * mResourceID;
    NSURL * mRemoteURL;
    CGSize mImageSize;
    UIImage * mImage;
    
    // Flags
    BOOL mLocal;
    BOOL mLoaded;
    BOOL mExistsOnServer;
    
    id <USNetworkPhotoDelegate> delegate;
}

- (id) initRemoteImageWithURL:(NSURL *) remoteURL;
- (id) initLocalImageWithImage:(UIImage *) image;

- (void) loadRemoteImage;

- (CALayer *) layerWithImage;
- (CALayer *) thumbnailLayer;

@property (retain) UIImage * image;
@property (retain) id delegate;
@property BOOL loaded;
@property BOOL local;
@property CGSize size;

@end
