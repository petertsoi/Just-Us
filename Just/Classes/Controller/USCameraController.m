//
//  USCameraController.m
//  Just
//
//  Created by Peter Tsoi on 9/25/11.
//  Copyright 2011 Pixar Animation Studios. All rights reserved.
//

#import "USCameraController.h"

#import "USDetailEditorView.h"
#import "USTabBarController.h"
#import "USPhoto.h"

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

#pragma mark - Event Handlers
- (IBAction)takeDone:(id)sender {
    // For now, save the image and switch views
    [mDetailEditorView savePhoto];
    [self.controller newPhotoAdded];
    self.controller.selectedIndex = 0;
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray * nibContents = [[NSBundle mainBundle] loadNibNamed:@"USDetailEditor" owner:self options:nil];
    NSEnumerator * nibEnumerator = [nibContents objectEnumerator];
    mDetailEditorView = (USDetailEditorView *)[nibEnumerator nextObject];
    
    UIColor *bg = [UIColor colorWithPatternImage:[UIImage imageNamed:@"detailEditor_background.png"]];
    [mDetailEditorView setBackgroundColor:bg];
    [mScrollContainer setContentSize:mDetailEditorView.frame.size];
    [mScrollContainer addSubview:mDetailEditorView];
    
    [mDetailEditorView retain];
}

- (void)viewDidUnoad
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

#pragma mark - UIImagePickerController Creation
- (void) createImagePicker {
    if (!mPicker){
        mPicker = [[UIImagePickerController alloc] init];
        mPicker.delegate = self;
        mPicker.sourceType = UIImagePickerControllerSourceTypeCamera ? [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] : UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }
}

- (void) showImagePicker {
    [self createImagePicker];
    [self.controller presentModalViewController:mPicker animated:YES];
}

- (void) awakeFromNib {
    [self createImagePicker];
}

#pragma mark - UIImagePickerControllerDelegate Methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    // Switch background
    self.controller.selectedIndex = 1;
    
    //[mDetailEditorView setImageWithReferenceURL:[info objectForKey:UIImagePickerControllerReferenceURL]];
    USPhoto * chosenPhoto = [[USPhoto alloc] initLocalImageWithReferenceURL:[info objectForKey:UIImagePickerControllerReferenceURL]];
    [mDetailEditorView setPhoto:chosenPhoto];
    [chosenPhoto release];
	[picker dismissModalViewControllerAnimated:YES];
	//imageView.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [mController switchToPreviousState];
    [picker dismissModalViewControllerAnimated:YES];
    
}

#pragma mark - Memory Management

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
    if (mPicker) {
        RELEASE_SAFELY(mPicker);
    }
}

- (void) dealloc {
    RELEASE_SAFELY(mPicker);
    [super dealloc];
}


@end
