//
//  USMemoriesController.m
//  Just
//
//  Created by Peter Tsoi on 9/25/11.
//  Copyright 2011 Pixar Animation Studios. All rights reserved.
//

#import "USMemoriesController.h"
#import "USMemoryChooserController.h"
#import "USThumbTableViewCell.h"

@implementation USMemoriesController

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

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    mChooserController = [[USMemoryChooserController alloc] initWithStyle:UITableViewStylePlain];
    
    NSArray * nibContents = [[NSBundle mainBundle] loadNibNamed:@"USMemoryChooser" owner:mChooserController options:nil];
    NSEnumerator * nibEnumerator = [nibContents objectEnumerator];
    UIView * test = (UIView *)[nibEnumerator nextObject];
    
    self.view = test;
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
