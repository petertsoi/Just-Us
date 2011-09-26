//
//  USMemoryChooserController.m
//  Just
//
//  Created by Peter Tsoi on 9/26/11.
//  Copyright 2011 Pixar Animation Studios. All rights reserved.
//

#import "USMemoryChooserController.h"
#import "USThumbTableViewCell.h"

@implementation USMemoryChooserController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ThumbnailCell";
    
    USThumbTableViewCell *cell = (USThumbTableViewCell *)[aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    if (cell == nil){
        cell = [[[USThumbTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                            reuseIdentifier:CellIdentifier] autorelease];
    }
    
    return cell;
}

@end
