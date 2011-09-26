//
//  USPhoto.h
//  Just Us
//
//  Created by Peter Tsoi on 9/23/11.
//  Copyright 2011 Pixar Animation Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <CoreLocation/CoreLocation.h>
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@protocol USPhotoLoaderDelegate <NSObject>
@required
- (void) photoLoaded;
@end

#define THUMBNAIL_SIZE_WIDTH 75.0
#define THUMBNAIL_SIZE_HEIGHT 75.0
#define MAX_PHOTO_SIZE_WIDTH 960.0
#define MAX_PHOTO_SIZE_HEIGHT 960.0

@interface USPhoto : NSObject {
    UIImage * mImage;
    
    // Metadata
    NSString * mResourceID;
    NSURL * mRemoteURL;
    NSURL * mReferenceURL;
    CGSize mImageSize;
    CLLocationCoordinate2D mLocation;
    NSDate * mTimestamp;
    
    // Flags
    BOOL mLocal;
    BOOL mLoaded;
    BOOL mExistsOnServer;
    
    id <USPhotoLoaderDelegate> delegate;
}

@property (readonly, retain) UIImage * image;
@property (readonly, retain) NSDate * timestamp;
@property (retain) id delegate;
@property BOOL loaded;
@property BOOL local;
@property CGSize size;

- (id) initRemoteImageWithURL:(NSURL *) remoteURL;
- (id) initLocalImageWithImage:(UIImage *) image;
- (id) initLocalImageWithReferenceURL:(NSURL *) referenceURL;

- (void) loadRemoteImage;

- (CALayer *) layerWithImage;
- (CALayer *) thumbnailLayer;

- (void) load;
- (void) save;

@end
