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
    NSString * mResourceID;
    BOOL mLocal;
    BOOL mLoaded;
    NSURL * mRemoteURL;
    CGSize mImageSize;
    UIImage * mImage;
    
    id <USPhotoLoadingDelegate> delegate;
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
