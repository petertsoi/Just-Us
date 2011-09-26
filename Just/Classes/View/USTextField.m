//
//  USTextField.m
//  Just
//
//  Created by Peter Tsoi on 9/25/11.
//  Copyright 2011 Pixar Animation Studios. All rights reserved.
//

#import "USTextField.h"

@implementation USTextField

- (void) drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 0)];
    paddingView.hidden = YES;
    self.leftView = paddingView;
    [paddingView release];
    self.leftViewMode = UITextFieldViewModeAlways;
}

@end
