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

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        mThumbViews = [[NSMutableArray alloc] init];
        self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void) assignPhoto:(USPhoto *) newPhoto toThumbViewAtIndex:(unsigned int)thumbView {
    USThumbView * selectedThumbView = [mThumbViews objectAtIndex:thumbView];
    if (newPhoto) {
        [selectedThumbView setPhoto:newPhoto];
        selectedThumbView.hidden = NO;
    } else {
        [selectedThumbView setPhoto:nil];
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

- (void)layoutThumbViews {
    CGRect thumbFrame = CGRectMake(kSpacing, 0,
                                   THUMBNAIL_SIZE_WIDTH, THUMBNAIL_SIZE_HEIGHT);
    
    for (USThumbView* thumbView in mThumbViews) {
        thumbView.frame = thumbFrame;
        thumbFrame.origin.x += kSpacing + THUMBNAIL_SIZE_HEIGHT;
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
    [super prepareForReuse];
}

#pragma mark - UIView Methods
- (void)layoutSubviews {
    [super layoutSubviews];
    [self layoutThumbViews];
}

#pragma mark - Memory Management

- (void) dealloc {
    RELEASE_SAFELY(mPhoto);
    [super dealloc];
}

@end
