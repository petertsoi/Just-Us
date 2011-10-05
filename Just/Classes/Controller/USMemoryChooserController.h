//
//  USMemoryChooserController.h
//  Just
//
//  Created by Peter Tsoi on 9/26/11.
//  Copyright 2011 Pixar Animation Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@class USMemoriesController, USPhotoChooserView;

@interface USMemoryChooserController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    NSString * mPhotoPath;
    NSArray * mPhotoArray;
    
    USMemoriesController *mControl;
    
    IBOutlet UITableView *mTableView;
    IBOutlet USPhotoChooserView *mPhotoChooserView;
}

@property (nonatomic, retain) IBOutlet UITableView *tableView;

- (void) loadDataSource;
- (void) setController:(USMemoriesController *)control;

@end
