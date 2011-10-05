//
//  USPhotoStripController.h
//  Just
//
//  Created by Peter Tsoi on 10/4/11.
//  Copyright 2011 Pixar Animation Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface USPhotoStripController : UIViewController {
    NSArray * mPhotos;
    NSMutableArray * mPhotoHolders;
    
    UIScrollView * mScroller;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil selectedPhotos:(NSArray *)photos;

@end
