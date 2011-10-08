//
//  USPhotoStripController.m
//  Just
//
//  Created by Peter Tsoi on 10/4/11.
//  Copyright 2011 Pixar Animation Studios. All rights reserved.
//

#import "USPhotoStripController.h"

#import "USPhoto.h"

@implementation USPhotoStripController

- (void) populateImages {
    CGFloat currentY = 40.0f;
    UIImageView * topCap = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"stripTopCap.png"]];
    [topCap setFrame:CGRectMake(10, 10, 185, 30)];
    [self.view addSubview:topCap];
    [topCap release];
    
    mTitleField = [[UITextField alloc] initWithFrame:topCap.frame];
    [mTitleField setBorderStyle:UITextBorderStyleNone];
    [mTitleField setTextAlignment:UITextAlignmentCenter];
    [mTitleField setFont:[UIFont fontWithName:@"Zapfino" size:12]];
    [mTitleField setTextColor:[UIColor colorWithRed:0.31 green:0.29 blue:0.25 alpha:1.0]];
    [mTitleField setPlaceholder:@"Title"];
    [mTitleField setDelegate:self];
    [self.view addSubview:mTitleField];
    
    UIImageView * repeatingBar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"stripBG.png"]];
    [repeatingBar setFrame:CGRectMake(10, currentY, 185, 1)];
    [self.view addSubview:repeatingBar];
    for (USPhoto * curPhoto in mPhotos) {
        UIImage * newImage = [curPhoto imageResizedToMaxSize:CGSizeMake(165, 553)];
        UIImageView * newFrame = [[UIImageView alloc] initWithImage:newImage];
        [newFrame setFrame:CGRectMake(20.0f, currentY, newImage.size.width, newImage.size.height)];
        [self.view addSubview:newFrame];
        currentY += newImage.size.height + 8.0f;
        [newFrame release];
    }
    [repeatingBar setFrame:CGRectMake(repeatingBar.frame.origin.x, repeatingBar.frame.origin.y, 
                                      185, currentY-repeatingBar.frame.origin.y)];
    [repeatingBar release];
    UIImageView * botCap = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"stripBotCap.png"]];
    [botCap setFrame:CGRectMake(repeatingBar.frame.origin.x, currentY, 
                                185, 30)];
    [self.view addSubview:botCap];
    [botCap release];
    
    UILabel * dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(botCap.frame.origin.x + 8, botCap.frame.origin.y-5, 
                                                                    botCap.frame.size.width - 16, botCap.frame.size.height)];
    [dateLabel setFont:[UIFont fontWithName:@"Zapfino" size:7]];
    [dateLabel setTextColor:[UIColor colorWithRed:0.31 green:0.29 blue:0.25 alpha:1.0]];
    [dateLabel setTextAlignment:UITextAlignmentRight];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"M/d/yyyy"];
    [dateLabel setText:[NSString stringWithFormat:@"%@ ",[dateFormatter stringFromDate:[NSDate date]]]];
    [dateFormatter release];
    [dateLabel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:dateLabel];
    [dateLabel release];
    [mScroller setContentSize:CGSizeMake(320, currentY + 40)];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil selectedPhotos:(NSArray *)photos
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        mScroller = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 387)];
        [mScroller setContentSize:CGSizeMake(320, 634)];
        self.view = mScroller;
        mPhotos = photos;
        self.title = @"Create Photo Strip";
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"strip_background.png"]]];
        [self populateImages];
    }
    return self;
}



- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void) dealloc {
    [mScroller release];
    [mPhotoHolders release];
    [mTitleField release];
    
    [super dealloc];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
