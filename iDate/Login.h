//
//  Login.h
//  iDate
//
//  Created by D M R on 16/08/12.
//  Copyright (c) 2012 iHubTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LabeledActivityIndicatorView.h"

#import <AudioToolbox/AudioServices.h>
#import <AVFoundation/AVFoundation.h>

//#import <CoreLocation/CoreLocation.h>

NSString * latitudeReplace;
NSString * longitudeReplace;

@interface Login : UIViewController<UITextFieldDelegate,UIAlertViewDelegate,AVAudioPlayerDelegate>//,CLLocationManagerDelegate>
{
    bool running;
    //NSTimeInterval startTime;
    IBOutlet UITextField *id_text;
    IBOutlet UITextField *passwd_text;
   // CLLocationManager *locationManager;
   // NSMutableString *latitude ;
   // NSMutableString *longitude;
    //NSString * latitudeReplace;
    //NSString * longitudeReplace;
    //NSMutableString* latitudeReplaceAgain;
    //NSMutableString* longitudeReplaceAgain;
    
    IBOutlet UILabel *lbl_partner_website_name;
//AVAudioPlayer *soundPlayer;
    NSString *login_id;
    LabeledActivityIndicatorView *activity;
    NSString *login_select;
    NSString *str;
}
//@property (nonatomic, retain) CLLocationManager *locationManager;
-(IBAction)login;
-(IBAction)back;
-(IBAction)registr;
-(void)readlogin;
-(void)login_call;


@end
