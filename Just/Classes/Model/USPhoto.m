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
- (UIImage *)p_imageByScalingImage:(UIImage *)image toSize:(CGSize)targetSize;
- (UIImage *)p_cropToSquare:(UIImage *)image;
@end

static inline double radians (double degrees) {return degrees * M_PI/180;}

@implementation USPhoto

@synthesize delegate;
@synthesize image = mImage;
@synthesize local = mLocal;
@synthesize loaded = mLoaded;
@synthesize size = mImageSize;

#pragma mark - Initializers
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

#pragma mark - Network Activity
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
    CGDataProviderRelease(imgDataProvider);
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

#pragma mark - Layer Creation

- (CALayer *) thumbnailLayer {
    CALayer * newLayer = [CALayer layer];
    newLayer.frame = CGRectMake(0, 0, THUMBNAIL_SIZE_WIDTH, THUMBNAIL_SIZE_HEIGHT);
    CGImageRef thumbnail = [[self p_imageByScalingImage:[self p_cropToSquare:mImage] toSize:newLayer.frame.size] CGImage];
    newLayer.contents = (id)thumbnail;
    return newLayer;
}

- (CALayer *) layerWithImage {
    CALayer * newLayer = [CALayer layer];
    CGColorSpaceRef rgbColorspace = CGColorSpaceCreateDeviceRGB();
    CGFloat values[4] = {1.0, 0.0, 0.0, 1.0}; 
    CGColorRef red = CGColorCreate(rgbColorspace, values); 
    CGColorSpaceRelease(rgbColorspace);
    newLayer.backgroundColor = red;
    CGColorRelease(red);
    return newLayer;
}

#pragma mark - Private
- (UIImage *)p_imageByScalingImage:(UIImage *)image toSize:(CGSize)targetSize{
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

- (UIImage *)p_cropToSquare:(UIImage *)image{
    CGFloat maxDimention = MAX(MAX(image.size.width, image.size.width), MAX_PHOTO_SIZE_HEIGHT);
    return [self p_imageByScalingImage:image toSize:CGSizeMake(maxDimention, maxDimention)];
}

#pragma mark - Memory Management
- (void) dealloc {
    RELEASE_SAFELY(delegate);
    RELEASE_SAFELY(mImage);
    [super dealloc];
}

@end
