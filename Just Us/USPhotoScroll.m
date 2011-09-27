//
//  USPhotoScroll.m
//  Just Us
//
//  Created by Peter Tsoi on 9/23/11.
//  Copyright 2011 Pixar Animation Studios. All rights reserved.
//

#import "USPhotoScroll.h"

@implementation USPhotoScroll

- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self){
        USPhoto * test = [[USPhoto alloc] initRemoteImageNamed:@"Test" 
                                                       withURL:[NSURL URLWithString:@"http://4.bp.blogspot.com/-8aCUO0tYQAA/Th57o9bMTuI/AAAAAAAABKo/3Cf6o52B4Dc/s1600/First-Date.jpg"]];
        [test setDelegate:self];
        [test loadRemoteImage];
        mPhotos = [[NSMutableArray alloc] initWithObjects:test, nil];
        
    }
    return self;
}

- (void) photoLoaded {
    NSLog(@"Photo Loaded");
    USPhoto * test = [mPhotos objectAtIndex:0];
    if ([test isLoaded]){
        CALayer * newLayer = [[CALayer alloc] init];
        CGColorSpaceRef rgbColorspace = CGColorSpaceCreateDeviceRGB();
        CGFloat values[4] = {1.0, 0.0, 0.0, 1.0}; 
        CGColorRef red = CGColorCreate(rgbColorspace, values); 
        newLayer.backgroundColor = red;
        
        self.layer.contents = newLayer;
        //[self.layer addSublayer:[test layerWithImage]];
    }
    
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
/*
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    USPhoto * test = [mPhotos objectAtIndex:0];
    if ([test isLoaded]){
         
    }
}*/



@end
