//
//  USPhotoAlbumScroll.m
//  Just Us
//
//  Created by Peter Tsoi on 9/24/11.
//  Copyright 2011 Pixar Animation Studios. All rights reserved.
//

#import "USPhotoAlbumScroll.h"

@implementation USPhotoAlbumScroll

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        NSString* documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        mPhotoArray = [[NSArray alloc] initWithArray:[[[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsPath error:NULL] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)]];
        //NSLog(@"Total %i; first: %@", [mPhotoArray count], [mPhotoArray objectAtIndex:0] );
    }
    
    return self;
}

@end
