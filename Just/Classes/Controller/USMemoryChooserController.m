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

- (void) viewDidAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, 
                                 self.tableView.frame.size.width, 200);
    self.tableView.rowHeight = 79.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ThumbnailCell";
    
    USThumbTableViewCell *cell = (USThumbTableViewCell *)[aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    if (cell == nil){
        cell = [[USThumbTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                            reuseIdentifier:CellIdentifier];
    }
    
    [cell.textLabel setText:[NSString stringWithFormat:@"%i", indexPath.row]];
    
    NSString * photosPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"Pictures"];
    NSArray * photoArray = [[NSArray alloc] initWithArray:[[[NSFileManager defaultManager] contentsOfDirectoryAtPath:photosPath error:NULL] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)]];
    [cell setColumnCount:4];
    for (unsigned int i = 0; i < [photoArray count]; i++) {
        NSString * photoPath = [NSString stringWithFormat:@"%@/%@", photosPath, [photoArray objectAtIndex:i]];
        USPhoto * test = [[USPhoto alloc] initLocalImageWithImage:[UIImage imageWithContentsOfFile:photoPath]];
        [cell assignPhoto:test toThumbViewAtIndex:i];

    }
    
    
    return cell;
}

@end
