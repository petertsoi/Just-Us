//
//  USMemoriesController.h
//  Just
//
//  Created by Peter Tsoi on 9/25/11.
//  Copyright 2011 Pixar Animation Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@class USMemoryChooserController;

@interface USMemoriesController : UIViewController {
    USMemoryChooserController * mChooserController;
    IBOutlet UIView * mView;
}

@property (nonatomic, retain) USMemoryChooserController * chooserController;

@end
