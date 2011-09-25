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

#import <AssetsLibrary/ALAssetsLibrary.h>

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

- (void) awakeFromNib {
    mPicker = [[UIImagePickerController alloc] init];
    mPicker.delegate = self;
    mPicker.sourceType = UIImagePickerControllerSourceTypeCamera ? [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] : UIImagePickerControllerSourceTypeSavedPhotosAlbum;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void) showImagePicker {
    [self.controller presentModalViewController:mPicker animated:YES];
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

#pragma mark - UIImagePickerControllerDelegate Methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    // Switch background
    [self.controller setSelectedIndex:1];
    
	[picker dismissModalViewControllerAnimated:YES];
	//imageView.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    NSURL *referenceURL = [info objectForKey:UIImagePickerControllerReferenceURL];
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    [library assetForURL:referenceURL resultBlock:^(ALAsset *asset) {
        // code to handle the asset here
    } failureBlock:^(NSError *error) {
        // error handling
    }];
    [library release];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [mController switchToPreviousState];
    [picker dismissModalViewControllerAnimated:YES];
    
}

@end
