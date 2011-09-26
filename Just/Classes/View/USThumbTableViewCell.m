//
//  USThumbTableViewCell.m
//  Just
//
//  Created by Peter Tsoi on 9/25/11.
//  Copyright 2011 Pixar Animation Studios. All rights reserved.
//

#import "USThumbTableViewCell.h"

static const CGFloat kSpacing = 4.0f;
static const CGFloat kDefaultThumbSize = 75.0f;

@implementation USThumbTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
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

- (void) dealloc {
    RELEASE_SAFELY(mPhoto);
    [super dealloc];
}

@end
