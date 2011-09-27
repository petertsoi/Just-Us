//
//  FirstViewController.h
//  Just Us
//
//  Created by Peter Tsoi on 9/23/11.
//  Copyright 2011 Pixar Animation Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MemoriesController : UIViewController <UITextFieldDelegate, CLLocationManagerDelegate> {
    IBOutlet UIImageView * mLatestImageView;
    IBOutlet UITextField * mLocationBox;
    IBOutlet UITextField * mTimeBox;
    IBOutlet UITextField * mTitleBox;
    
    IBOutlet UIButton * mFacebookButton;
    IBOutlet UIButton * mPublicButton;
    
    IBOutlet UIScrollView * mAlbumScroll;
    IBOutlet UIView * mSelectedPhotoView;   // THIS NEEDS TO BE SUBCLASSED
    
    BOOL mFacebookOn;
    BOOL mPublicOn;
    CLLocationManager *locationManager;
    
    CLLocationCoordinate2D mLastLocation;
}

@property (nonatomic, retain) CLLocationManager *locationManager;

- (void) presentPhotoEdit;

@end
