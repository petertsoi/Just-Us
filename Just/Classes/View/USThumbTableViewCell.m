//
//  USThumbTableViewCell.m
//  Just
//
//  Created by Peter Tsoi on 9/25/11.
//  Copyright 2011 Pixar Animation Studios. All rights reserved.
//

#import "USThumbTableViewCell.h"
#import "USPhoto.h"
#import "USThumbView.h"

static const CGFloat kSpacing = 4.0f;

@implementation USThumbTableViewCell

@synthesize thumbViews = mThumbViews;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.thumbViews = [[NSMutableArray alloc] init];
        self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}

- (void) setColumnCount:(unsigned int) columns {
    mColumns = columns;
    for (unsigned int currentCol = 0; currentCol < columns; ++currentCol) {
        if (!self.thumbViews) {
            mThumbViews = [[NSMutableArray alloc] init];
        }
        USThumbView * currentView;
        if ([self.thumbViews count] <= currentCol) {
            currentView = [[USThumbView alloc] init];
            [ self.thumbViews addObject:currentView];
        } else {
            currentView = [self.thumbViews objectAtIndex:currentCol];
        }
        [currentView setFrame:CGRectMake(kSpacing + currentCol * (kSpacing + THUMBNAIL_SIZE_WIDTH), kSpacing, 
                                         THUMBNAIL_SIZE_WIDTH, THUMBNAIL_SIZE_HEIGHT)];
        [self addSubview:currentView];
    }
    
}

- (void) assignPhoto:(USPhoto *) newPhoto toThumbViewAtIndex:(unsigned int)thumbView {
    
    USThumbView * selectedThumbView = [mThumbViews objectAtIndex:thumbView];
    
    [selectedThumbView setPhoto:newPhoto];
    if (newPhoto != nil) {
        selectedThumbView.hidden = NO;
    } else {
        selectedThumbView.hidden = YES;
    }
    
}

- (void) assignPhotosToRow:(NSArray *) photoRow {
    unsigned int countUp = 0;
    for (USPhoto * newPhoto in photoRow) {
        [self assignPhoto:newPhoto toThumbViewAtIndex:countUp];
        ++countUp;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)prepareForReuse {
    //self.object = nil;
    //self.textLabel.text = nil;
    //self.detailTextLabel.text = nil;
    self.thumbViews = nil;
    [super prepareForReuse];
}


#pragma mark - Memory Management

- (void) dealloc {
    RELEASE_SAFELY(mPhoto);
    [super dealloc];
}

@end
