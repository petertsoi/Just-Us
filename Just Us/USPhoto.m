//
//  USPhoto.m
//  Just Us
//
//  Created by Peter Tsoi on 9/23/11.
//  Copyright 2011 Pixar Animation Studios. All rights reserved.
//

#import "USPhoto.h"

#import "ASIHTTPRequest.h"

@implementation USPhoto

@synthesize delegate;

- (id)initRemoteImageNamed:(NSString *) name withURL:(NSURL *) remoteURL{
    if ((self = [super init])){
        mPhotoName = name;
        mRemoteURL = remoteURL;
        mLocal = NO;
        mLoaded = NO;
    }
    return self;
}

- (id)initRemoteImageNamed:(NSString *) name withID:(NSString *) resourceID{
    if ((self = [super init])){
        mPhotoName = name;
        mResourceID = resourceID;
        mLocal = NO;
        mLoaded = NO;
    }
    return self;
}

- (id) initLocalImageNamed:(NSString *) name withImage:(UIImage *) image {
    if ((self = [super init])){
        mPhotoName = name;
        mImage = [image CGImage];
        
        mImageSize = CGSizeMake(CGImageGetWidth(mImage), CGImageGetHeight(mImage));
        
        mLocal = YES;
        mLoaded = YES;
    }
    return self;
}

- (void) loadRemoteImage {
    if (!mLocal) {
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:mRemoteURL];
        [request setDelegate:self];
        [request startAsynchronous];
    }
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSData *data = [request responseData];
    
    CFDataRef imgData = (CFDataRef)data;
	CGDataProviderRef imgDataProvider = CGDataProviderCreateWithCFData (imgData);
	mImage = CGImageCreateWithJPEGDataProvider(imgDataProvider, NULL, true, kCGRenderingIntentDefault);
    
    mImageSize = CGSizeMake(CGImageGetWidth(mImage), CGImageGetHeight(mImage));
    
    mLoaded = YES;
    
    [[self delegate] photoLoaded];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(@"An error occured in USPhoto.m - requestFailed:");
}

- (void) setDelegate:(id)notify{
    delegate = notify;
}

- (CGImageRef) CGImageRef {
    return mImage;
}

- (CALayer *) layerWithImage {
    CALayer * newLayer = [[CALayer alloc] init];
    CGColorSpaceRef rgbColorspace = CGColorSpaceCreateDeviceRGB();
    CGFloat values[4] = {1.0, 0.0, 0.0, 1.0}; 
    CGColorRef red = CGColorCreate(rgbColorspace, values); 
    newLayer.backgroundColor = red;
    
    return newLayer;
}

- (BOOL) isLoaded {
    return mLoaded;
}

@end
