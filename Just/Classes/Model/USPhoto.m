//
//  USPhoto.m
//  Just Us
//
//  Created by Peter Tsoi on 9/23/11.
//  Copyright 2011 Pixar Animation Studios. All rights reserved.
//

#import "USPhoto.h"
#import <UIKit/UIImage.h>
#import <math.h>

#import "ASIHTTPRequest.h"

@interface USPhoto () 
- (UIImage*)p_imageByScalingImage:(UIImage *)image toSize:(CGSize)targetSize;
@end

static inline double radians (double degrees) {return degrees * M_PI/180;}

@implementation USPhoto

@synthesize delegate;
@synthesize image = mImage;
@synthesize local = mLocal;
@synthesize loaded = mLoaded;
@synthesize size = mImageSize;

#pragma mark -
#pragma mark Initializers
- (id)initRemoteImageWithURL:(NSURL *) remoteURL{
    if ((self = [super init])){
        mRemoteURL = remoteURL;
        mLocal = NO;
        mLoaded = NO;
    }
    return self;
}

- (id)initRemoteImageWithID:(NSString *) resourceID{
    if ((self = [super init])){
        mResourceID = resourceID;
        mLocal = NO;
        mLoaded = NO;
    }
    return self;
}

- (id) initLocalImageWithImage:(UIImage *) image {
    if ((self = [super init])){
        mImage = image;
        mImageSize = mImage.size;
        
        mLocal = YES;
        mLoaded = YES;
    }
    return self;
}

#pragma mark -
#pragma mark Network Activity
- (void) loadRemoteImage {
    if (!mLocal) {
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:mRemoteURL];
        [request setDelegate:self];
        [request startAsynchronous];
    }
}

- (void)requestFinished:(ASIHTTPRequest *)request{
    NSData *data = [request responseData];
    
    CFDataRef imgData = (CFDataRef)data;
	CGDataProviderRef imgDataProvider = CGDataProviderCreateWithCFData (imgData);
	CGImageRef image = CGImageCreateWithJPEGDataProvider(imgDataProvider, NULL, true, kCGRenderingIntentDefault);
    mImage = [UIImage imageWithCGImage:image];
    CGImageRelease(image);
    mImageSize = mImage.size;
    
    mLoaded = YES;
    
    [[self delegate] photoLoaded];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    //NSError *error = [request error];
    NSLog(@"An error occured in USPhoto.m - requestFailed:");
}

#pragma mark -
#pragma mark Layer Creation

- (CALayer *) thumbnailLayer {
    CALayer * newLayer = [[CALayer alloc] init];
    /*CGRect frame = CGRectMake(0, 0, 75, 75);
    CGColorSpaceRef rgbColorspace = CGColorSpaceCreateDeviceRGB();
    CGImageRef thumbRef = CGImageCreateWithImageInRect(mImage, frame);
    
    CGContextRef mainViewContentContext = CGBitmapContextCreate (NULL, frame.size.width, frame.size.height, 8, frame.size.height*4, rgbColorspace, kCGImageAlphaPremultipliedFirst);
    
    CGContextDrawImage(mainViewContentContext, frame, thumbRef);
    
    //newLayer.contents = (id)mImage;
    //newLayer.frame = CGRectMake(0, 0, 75, 75);*/
    return newLayer;
}

- (CALayer *) layerWithImage {
    CALayer * newLayer = [[CALayer alloc] init];
    CGColorSpaceRef rgbColorspace = CGColorSpaceCreateDeviceRGB();
    CGFloat values[4] = {1.0, 0.0, 0.0, 1.0}; 
    CGColorRef red = CGColorCreate(rgbColorspace, values); 
    newLayer.backgroundColor = red;
    
    return newLayer;
}

#pragma mark -
#pragma mark Private
- (UIImage*)p_imageByScalingImage:(UIImage *)image toSize:(CGSize)targetSize{
    UIImage* sourceImage = image; 
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    
    CGImageRef imageRef = [sourceImage CGImage];
    CGBitmapInfo bitmapInfo = CGImageGetBitmapInfo(imageRef);
    CGColorSpaceRef colorSpaceInfo = CGImageGetColorSpace(imageRef);
    
    if (bitmapInfo == kCGImageAlphaNone) {
        bitmapInfo = kCGImageAlphaNoneSkipLast;
    }
    
    CGContextRef bitmap;
    
    if (sourceImage.imageOrientation == UIImageOrientationUp || sourceImage.imageOrientation == UIImageOrientationDown) {
        bitmap = CGBitmapContextCreate(NULL, targetWidth, targetHeight, CGImageGetBitsPerComponent(imageRef), CGImageGetBytesPerRow(imageRef), colorSpaceInfo, bitmapInfo);
        
    } else {
        bitmap = CGBitmapContextCreate(NULL, targetHeight, targetWidth, CGImageGetBitsPerComponent(imageRef), CGImageGetBytesPerRow(imageRef), colorSpaceInfo, bitmapInfo);
        
    }       
    
    if (sourceImage.imageOrientation == UIImageOrientationLeft) {
        CGContextRotateCTM (bitmap, radians(90));
        CGContextTranslateCTM (bitmap, 0, -targetHeight);
        
    } else if (sourceImage.imageOrientation == UIImageOrientationRight) {
        CGContextRotateCTM (bitmap, radians(-90));
        CGContextTranslateCTM (bitmap, -targetWidth, 0);
        
    } else if (sourceImage.imageOrientation == UIImageOrientationUp) {
        // NOTHING
    } else if (sourceImage.imageOrientation == UIImageOrientationDown) {
        CGContextTranslateCTM (bitmap, targetWidth, targetHeight);
        CGContextRotateCTM (bitmap, radians(-180.));
    }
    
    CGContextDrawImage(bitmap, CGRectMake(0, 0, targetWidth, targetHeight), imageRef);
    CGImageRef ref = CGBitmapContextCreateImage(bitmap);
    UIImage* newImage = [UIImage imageWithCGImage:ref];
    
    CGContextRelease(bitmap);
    CGImageRelease(ref);
    
    return newImage; 
}

#pragma mark -
#pragma mark Memory Management
- (void) dealloc {
    RELEASE_SAFELY(delegate);
    RELEASE_SAFELY(mImage);
    [super dealloc];
}

@end
