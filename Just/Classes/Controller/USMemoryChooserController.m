//
//  USMemoryChooserController.m
//  Just
//
//  Created by Peter Tsoi on 9/26/11.
//  Copyright 2011 Pixar Animation Studios. All rights reserved.
//

#import "USMemoryChooserController.h"
#import "USThumbTableViewCell.h"
#import "USPhoto.h"

@implementation USMemoryChooserController

- (void) loadDataSource {
    mPhotoPath = [[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"Pictures"] retain];
    if (mPhotoArray) {
        RELEASE_SAFELY(mPhotoArray);
    }
    mPhotoArray = [[NSArray alloc] initWithArray:[[[NSFileManager defaultManager] contentsOfDirectoryAtPath:mPhotoPath error:NULL] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)]];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, 
                                 self.tableView.frame.size.width, 200);
    self.tableView.rowHeight = 79.0f;
    [self loadDataSource];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ceil((double)[mPhotoArray count] / 4.0);
}
- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ThumbnailCell";
    
    USThumbTableViewCell *cell = (USThumbTableViewCell *)[aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    if (cell == nil){
        cell = [[[USThumbTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                            reuseIdentifier:CellIdentifier] autorelease];
    }
    
    
    [cell setColumnCount:4];
    for (unsigned int i = 0; indexPath.row*4 + i < [mPhotoArray count] && i <  4; i++) {
        NSString * photoPath = [mPhotoPath stringByAppendingPathComponent:[mPhotoArray objectAtIndex:indexPath.row*4 + i]];
        USPhoto * test = [[USPhoto alloc] initLocalImageWithImage:[UIImage imageWithContentsOfFile:photoPath]];
        [cell assignPhoto:test toThumbViewAtIndex:i];
        [test release];
    }
    
    
    return cell;
}

@end
