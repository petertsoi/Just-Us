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

@protocol USPhotoLoadingDelegate <NSObject>
@required
- (void) photoLoaded;
@end

@interface USPhoto : NSObject {
    NSString * mPhotoName;
    NSString * mResourceID;
    BOOL mLocal;
    BOOL mLoaded;
    CGImageRef mImage;
    NSURL * mRemoteURL;
    CGSize mImageSize;
    
    id <USPhotoLoadingDelegate> delegate;
}

- (id) initRemoteImageNamed:(NSString *) name withURL:(NSURL *) remoteURL;
- (id) initLocalImageNamed:(NSString *) name withImage:(UIImage *) image;

- (void) loadRemoteImage;

- (void) setDelegate:(id)notify;

- (CGImageRef) CGImageRef;
- (CALayer *) layerWithImage;
- (BOOL) isLoaded;

@property (retain) id delegate;

@end
