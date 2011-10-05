//
//  USMemoryChooserController.h
//  Just
//
//  Created by Peter Tsoi on 9/26/11.
//  Copyright 2011 Pixar Animation Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@class USPhotoChooserView;

@interface USMemoryChooserController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    NSString * mPhotoPath;
    NSArray * mPhotoArray;
    
    IBOutlet UITableView *mTableView;
    IBOutlet USPhotoChooserView *mPhotoChooserView;
}

@property (nonatomic, retain) IBOutlet UITableView *tableView;

- (void) loadDataSource;

@end
