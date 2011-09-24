//
//  FirstViewController.m
//  Just Us
//
//  Created by Peter Tsoi on 9/23/11.
//  Copyright 2011 Pixar Animation Studios. All rights reserved.
//

#import "MemoriesController.h"
#import "AppDelegate.h"
#import "USTabBarController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@implementation MemoriesController

@synthesize locationManager;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlackOpaque];
}


- (void)viewWillAppear:(BOOL)animated{
    NSString* documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* diskFile = [documentsPath stringByAppendingPathComponent:@"Latest.jpg"];
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:diskFile];
    
    if (fileExists) {
        [self presentPhotoEdit];
    }
    
}

- (void) donePhotoEditing{
    NSString* documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* oldPath = [documentsPath stringByAppendingPathComponent:@"Latest.jpg"];
    NSString* newPath = [documentsPath stringByAppendingPathComponent:@"Uploading.jpg"];
    [[NSFileManager defaultManager] moveItemAtPath:oldPath toPath:newPath error:NULL];
    
    NSArray* nibViews = [[NSBundle mainBundle] loadNibNamed:@"Memories"
                                                      owner:self
                                                    options:nil];
    UIView * myView = [ nibViews objectAtIndex: 0];
    self.view = myView;
    
    self.navigationItem.rightBarButtonItem = nil;
    self.navigationItem.leftBarButtonItem = nil;
    
    // Do upload stuff here.
    NSURL *url = [NSURL URLWithString:@"http://192.168.2.1:8080/photo"];
    
    
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setDelegate:self];
    [request setRequestMethod:@"POST"];
    
    [request setPostValue:@"fbid" forKey:@"101010101"];
    [request setPostValue:@"lat" forKey:[NSString stringWithFormat:@"%f", mLastLocation.latitude]];
    [request setPostValue:@"long" forKey:[NSString stringWithFormat:@"%f", mLastLocation.longitude]];
    [request setPostValue:@"time" forKey:[mTimeBox text]];
    [request setPostValue:@"caption" forKey:[mTitleBox text]];
    
    [request startAsynchronous];
    
    
    // Upload a file on disk
    //[request setFile:@"/Users/ben/Desktop/ben.jpg" withFileName:@"myphoto.jpg" andContentType:@"image/jpeg"
    //          forKey:@"photo"];
    /*
    // Upload an NSData instance
    [request setData:imageData withFileName:@"myphoto.jpg" andContentType:@"image/jpeg" forKey:@"photo"];
    [request addPostValue:@"Ben" forKey:@"names"];
    [request addPostValue:@"George" forKey:@"names"];
    [request addFile:@"/Users/ben/Desktop/ben.jpg" forKey:@"photos"];
    [request addData:imageData withFileName:@"george.jpg" andContentType:@"image/jpeg" forKey:@"photos"];
     */
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSString *response = [request responseString];
    if (![response isEqualToString:@"OK"]){
        NSLog(@"Uploading as %@", response);
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.2.1:8080/photo/%@.jpg", response]];
        NSString* documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString* oldPath = [documentsPath stringByAppendingPathComponent:@"Uploading.jpg"];
        NSString* newPath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg", response]];
        [[NSFileManager defaultManager] moveItemAtPath:oldPath toPath:newPath error:NULL];
        
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        [request setDelegate:self];
        [request setRequestMethod:@"POST"];
        
        [request setFile:newPath forKey:@"photo"];
        
        [request startAsynchronous];
    } else {
        NSLog(@"Uploaded photo");
    }
    
    
}

- (void)requestWentWrong:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
}


- (void) cancelPhotoDetailEdit {
    NSString* documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* diskFile = [documentsPath stringByAppendingPathComponent:@"Latest.jpg"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:diskFile error:NULL];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [(USTabBarController *)[appDelegate tabBarController] switchToCamera];
    
    NSArray* nibViews = [[NSBundle mainBundle] loadNibNamed:@"Memories"
                                                      owner:self
                                                    options:nil];
    UIView * myView = [ nibViews objectAtIndex: 0];
    self.view = myView;
    
    self.navigationItem.rightBarButtonItem = nil;
    self.navigationItem.leftBarButtonItem = nil;
}

- (void) toggleFB {
    if (mFacebookOn) {
        mFacebookOn = NO;
        [mFacebookButton setImage:[UIImage imageNamed:@"fb_button_off.png"] forState:UIControlStateNormal];
    } else {
        mFacebookOn = YES;
        [mFacebookButton setImage:[UIImage imageNamed:@"fb_button_on.png"] forState:UIControlStateNormal];
    }
}

- (void) togglePublic {
    if (mPublicOn) {
        mPublicOn = NO;
        [mPublicButton setImage:[UIImage imageNamed:@"public_button_off.png"] forState:UIControlStateNormal];
    } else {
        mPublicOn = YES;
        [mPublicButton setImage:[UIImage imageNamed:@"public_button_on.png"] forState:UIControlStateNormal];
    }
}

- (void) presentPhotoEdit {
    mFacebookOn = NO;
    mPublicOn = NO;
    
    NSArray* nibViews = [[NSBundle mainBundle] loadNibNamed:@"PhotoEdit"
                                                      owner:self
                                                    options:nil];
    UIView * myView = [ nibViews objectAtIndex: 0];
    
    
    
    NSString* documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* diskFile = [documentsPath stringByAppendingPathComponent:@"Latest.jpg"];
    
    NSFileManager* fm = [NSFileManager defaultManager];
    NSDictionary* attrs = [fm attributesOfItemAtPath:diskFile error:nil];
    
    if (attrs != nil) {
        NSDate *date = (NSDate*)[attrs objectForKey: NSFileCreationDate];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd/MM/yyyy HH:MM:SS a"];
        //NSLog(@"%@", [dateFormatter dateFromString:@"12/12/2012 12:12:12 AM"]);
        //NSLog(@"Date Created: %@", [date description]);
        [mTimeBox setText:[dateFormatter stringFromDate:date]];
    } 
    else {
        //NSLog(@"Not found");
    }
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone
                                                                  target:self 
                                                                  action:@selector(donePhotoEditing)];  
    self.navigationItem.rightBarButtonItem = doneButton;
    
    UIBarButtonItem *discardButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash
                                                                                   target:self
                                                                                   action:@selector(cancelPhotoDetailEdit)];
    self.navigationItem.leftBarButtonItem = discardButton;
    
    [mFacebookButton addTarget:self action:@selector(toggleFB) forControlEvents:UIControlEventTouchUpInside];
    [mPublicButton addTarget:self action:@selector(togglePublic) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *latest = [UIImage imageWithContentsOfFile:diskFile];
    [mLatestImageView setImage:latest];
    
    UIScrollView * container = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 368)];
    [myView setFrame:CGRectMake(myView.frame.origin.x, myView.frame.origin.y, 
                                320, 546)];
    [container setContentSize:CGSizeMake(320, 546)];
    
    UIImageView * backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"single_image_background.png"]];
    
    [container addSubview:backgroundImage];
    [myView setBackgroundColor:[UIColor clearColor]];
    [container addSubview:myView];
    [self.view addSubview:container];
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self; 
    locationManager.desiredAccuracy = kCLLocationAccuracyBest; 
    locationManager.distanceFilter = kCLDistanceFilterNone; 
    [locationManager startUpdatingLocation];
    
    
    
    
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    // Configure the new event with information from the location
    mLastLocation = [newLocation coordinate];
    NSString * latLongString = [NSString stringWithFormat:@"%f, %f", mLastLocation.latitude, mLastLocation.longitude];
    [mLocationBox setText:latLongString];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField { 
    [textField resignFirstResponder]; 
    return NO; 
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];

    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

@end
