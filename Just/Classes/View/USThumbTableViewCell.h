//
//  USThumbTableViewCell.h
//  Just
//
//  Created by Peter Tsoi on 9/25/11.
//  Copyright 2011 Pixar Animation Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@class USPhoto;

@interface USThumbTableViewCell : UITableViewCell {
    USPhoto * mPhoto;
    NSMutableArray * mThumbViews;
    
    unsigned int mColumns;
}

@property (nonatomic, retain) NSMutableArray * thumbViews;

- (void) assignPhoto:(USPhoto *) newPhoto toThumbViewAtIndex:(unsigned int)thumbView;
- (void) assignPhotosToRow:(NSArray *) photoRow;

- (void) setColumnCount:(unsigned int) columns;

@end
