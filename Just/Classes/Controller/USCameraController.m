//
//  USCameraController.m
//  Just
//
//  Created by Peter Tsoi on 9/25/11.
//  Copyright 2011 Pixar Animation Studios. All rights reserved.
//

#import "USCameraController.h"

@implementation USCameraController

@synthesize controller = mController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray * nibContents = [[NSBundle mainBundle] loadNibNamed:@"USDetailEditor" owner:self options:nil];
    NSEnumerator * nibEnumerator = [nibContents objectEnumerator];
    UIView * detailEditorView = (UIView*)[nibEnumerator nextObject];
    
    UIColor *bg = [UIColor colorWithPatternImage:[UIImage imageNamed:@"detailEditor_background.png"]];
    [detailEditorView setBackgroundColor:bg];
    [mScrollContainer setContentSize:detailEditorView.frame.size];
    [mScrollContainer addSubview:detailEditorView];
    
    mPicker = [[UIImagePickerController alloc] init];
    mPicker.delegate = self;
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        mPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        mPicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }
    
    [self.controller presentModalViewController:mPicker animated:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    RELEASE_SAFELY(mPicker);
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark UIImagePickerControllerDelegate Methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	[picker dismissModalViewControllerAnimated:YES];
	//imageView.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissModalViewControllerAnimated:YES];
}

@end
