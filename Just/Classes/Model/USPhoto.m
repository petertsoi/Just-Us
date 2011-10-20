//
//  USPhoto.m
//  Just Us
//
//  Created by Peter Tsoi on 9/23/11.
//  Copyright 2011 Pixar Animation Studios. All rights reserved.
//

#import "USPhoto.h"
#import <UIKit/UIImage.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <math.h>

#import "ASIHTTPRequest.h"

@interface USPhoto () 
- (UIImage *)p_imageByScalingImage:(UIImage *)image toSize:(CGSize)targetSize cropToSquare:(BOOL) square;
- (UIImage *)p_cropToSquare:(UIImage *)image;
- (void) p_loadReferencedImage;
@end

static inline double radians (double degrees) {return degrees * M_PI/180;}
static const CGFloat kDefaultThumbSize = 75.0f;

@implementation USPhoto

@synthesize delegate;
//@synthesize image = mImage;
@synthesize resourceID = mResourceID;
@synthesize timestamp = mTimestamp;
@synthesize local = mLocal;
@synthesize loaded = mLoaded;
@synthesize size = mImageSize;

- (UIImage *) image{
    if (!mLoaded) {
        if (mLocal) {
            [self p_loadReferencedImage];
        }
    }
    //return [self p_cropToSquare:mImage];
    //return [self thumbnail];
    //return [self p_imageByScalingImage:mImage toSize:CGSizeMake(75, 75) cropToSquare:YES];
    
    return mImage;
}

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
        mImage = [image retain];
        mImageSize = mImage.size;
        
        mLocal = YES;
        mLoaded = YES;
    }
    return self;
}

- (id) initLocalImageWithImageFromCamera:(UIImage *) image {
    if ((self = [super init])){
        mImage = [image retain];
        UIImage * resizedImage = [self imageResizedToMaxSize:CGSizeMake(MAX_PHOTO_SIZE_WIDTH, MAX_PHOTO_SIZE_HEIGHT)];
        
        mImage = [resizedImage retain];
        [image release];
        mImageSize = mImage.size;
        
        mLocal = YES;
        mLoaded = YES;
    }
    return self;
}

- (id) initLocalImageWithReferenceURL:(NSURL *) referenceURL{
    if ((self = [super init])){
        mReferenceURL = referenceURL;
        //mImageSize = mImage.size;
        
        mLocal = YES;
        mLoaded = NO;
    }
    return self;
}

- (void) load {
    if (!mLoaded) {
        if (mLocal)
            [self p_loadReferencedImage];
    } else {
        [self.delegate photoLoaded];
    }
}

- (void) save {
    NSData *imageData = [NSData dataWithData:UIImageJPEGRepresentation(mImage, 1.0)];
    NSString * photosPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"Pictures"];
    BOOL dir;
    if (![[NSFileManager defaultManager] fileExistsAtPath:photosPath isDirectory:&dir]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:photosPath
                                  withIntermediateDirectories:YES 
                                                   attributes:nil
                                                        error:NULL];
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd-HH-mm-SS"];
    NSString * name = [NSString stringWithFormat:@"Uploading-%@.jpg",[dateFormatter stringFromDate:[NSDate date]]];
    mResourceID = name;
    NSString * imagePath = [photosPath stringByAppendingPathComponent:name];
    //[dateFormatter setDateFormat:@"dd/MM/yyyy HH:mm a"];
    RELEASE_SAFELY(dateFormatter);
    NSLog(@"Saving image to %@", imagePath);
	[imageData writeToFile:imagePath atomically:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SavedPhoto" object:self];
}


#pragma mark - Disk Activity
- (void) p_loadReferencedImage {
    if (!mLoaded) {
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
        [library assetForURL:mReferenceURL resultBlock:^(ALAsset *asset) {
            CGImageRef fullScreenImage = [[asset defaultRepresentation] fullScreenImage];
            mLocation = ((CLLocation *)[asset valueForProperty:@"ALAssetPropertyLocation"]).coordinate;
            mTimestamp = [asset valueForProperty:@"ALAssetPropertyDate"];
            [mTimestamp retain];
            if (!mTimestamp) 
                mTimestamp = [NSDate date];
            mImage = [[UIImage alloc] initWithCGImage:fullScreenImage
                                         scale:1.0f
                                   orientation:[[asset valueForProperty:@"ALAssetPropertyOrientation"] intValue]];
            mLoaded = YES;
            [[self delegate] photoLoaded];
        } failureBlock:^(NSError *error) {
            // Log error
        }];
        [library release];
    }
}

- (UIImage *) thumbnail {
    //if (!mThumb) {
        mThumb = [self p_imageByScalingImage:self.image toSize:CGSizeMake(kDefaultThumbSize, kDefaultThumbSize) cropToSquare:YES];
    NSLog(@"Created thumbnail");
    //}
    //[mThumb retain];
    return mThumb;
}

- (UIImage *) imageResizedToMaxSize:(CGSize) maxSize {
    float aspectRatio = mImage.size.width/mImage.size.height;
    CGSize rescaleSize = maxSize.width < maxSize.height ? CGSizeMake(maxSize.width, maxSize.width / aspectRatio) : CGSizeMake(maxSize.height * aspectRatio, maxSize.width );
    //NSLog(@"Max:\t%f, %f\n Act:\t%f, %f", maxSize.width, maxSize.height, rescaleSize.width, rescaleSize.height);
    return [self p_imageByScalingImage:self.image toSize:rescaleSize cropToSquare:NO];
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
    CGImageRef thumbnail = [[self p_imageByScalingImage:[self p_cropToSquare:mImage] toSize:newLayer.frame.size cropToSquare:YES] CGImage];
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
- (UIImage *)p_imageByScalingImage:(UIImage *)image toSize:(CGSize)targetSize cropToSquare:(BOOL) square{
    UIImage* sourceImage = image; 
    CGFloat targetWidth;
    CGFloat targetHeight;
    if (IS_RETINA){
        targetWidth = targetSize.width * 2;
        targetHeight = targetSize.height * 2;
    } else {
        targetWidth = targetSize.width;
        targetHeight = targetSize.height;
    }
    
    CGImageRef imageRef = [sourceImage CGImage];
    if (square) {
        CGFloat minDimention = MIN(image.size.width, image.size.width);
        CGFloat x, y;
        if (image.size.width < image.size.height) {
            x = 0.0f;
            y = (image.size.height - image.size.width) / 2;
        } else {
            x = (image.size.width - image.size.height) / 2;
            y = 0.0f;
        }
        imageRef = CGImageCreateWithImageInRect(imageRef, CGRectMake(x, y, minDimention , minDimention));
    }
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
    if (square) {
        CGImageRelease(imageRef);
    }
    CGImageRef ref = CGBitmapContextCreateImage(bitmap);
    UIImage* newImage = [UIImage imageWithCGImage:ref];
    
    CGContextRelease(bitmap);
    CGImageRelease(ref);
    
    return newImage; 
}

- (UIImage *)p_cropToSquare:(UIImage *)image{
    CGFloat minDimention = MIN(image.size.width, image.size.width);
    return [self p_imageByScalingImage:image toSize:CGSizeMake(minDimention, minDimention) cropToSquare:NO];
}

#pragma mark - Memory Management
- (void) dealloc {
    RELEASE_SAFELY(delegate);
    RELEASE_SAFELY(mImage);
    [super dealloc];
}

@end
