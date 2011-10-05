//
//  USMemoriesController.m
//  Just
//
//  Created by Peter Tsoi on 9/25/11.
//  Copyright 2011 Pixar Animation Studios. All rights reserved.
//

#import "USMemoriesController.h"
#import "USMemoryChooserController.h"

#import "USPhotoChooserView.h"
#import "USPhotoStripController.h"

#import "USThumbTableViewCell.h"

@implementation USMemoriesController

@synthesize chooserController = mChooserController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization NSArray * photoArray = [[NSArray alloc] initWithArray:[[[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsPath error:NULL] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)]];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void) sendDone:(UIButton *)sender {
    USPhotoChooserView * chooser = (USPhotoChooserView *)[sender superview];
    USPhotoStripController * mStripController = [[USPhotoStripController alloc] initWithNibName:@"USPhotoStripController" bundle:[NSBundle mainBundle] selectedPhotos:chooser.selectedPhotos];
    [self pushViewController:mStripController animated:YES];
    [mStripController release];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    mChooserController = [[USMemoryChooserController alloc] initWithNibName:@"USMemoryChooser" bundle:[NSBundle mainBundle]];
    [mChooserController setController:self];
    
    [self setViewControllers:[NSArray arrayWithObject:mChooserController]];
    //self.view = test;
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
