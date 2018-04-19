//
//  Signup.h
//  iDate
//
//  Created by D M R on 07/08/12.
//  Copyright (c) 2012 iHubTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"

#import "FBLoginButton.h"
#import "UserInfo.h"
#import "MyRunViewController.h"
#import "Session.h"
#import "AppDelegate.h"
#import "GooglePlusSignIn.h"

@class GooglePlusSignInButton,AppDelegate;
@interface Signup : UIViewController<GooglePlusSignInDelegate,FBSessionDelegate, UserInfoLoadDelegate,FBDialogDelegate,FBRequestDelegate>
{
IBOutlet FBLoginButton* _fbButton;
IBOutlet UIButton* _addRunButton;
Facebook *_facebook;
Session *_session;
NSArray *_permissions;
UserInfo *_userInfo;
MyRunViewController *_myRunController;
      BOOL signin_bool;
    NSString *str;
    NSString *gender_string;
    NSString *response_id;
    NSString *string_id;
    NSString *string_result;
   //IBOutlet GooglePlusSignInButton *signInButton;
    AppDelegate *app;
    NSString *login_type;
    
    int socailLogTest;
    
    
    IBOutlet UIImageView *signup_img_ref;
    
    IBOutlet UIButton *facebk_btn_ref;
    
    
    IBOutlet UIButton *signin_btn_ref;
    
    
    IBOutlet UIButton *sign_new_btn_ref;
    
     IBOutlet UILabel *lbl_partnerwebsitename;
    
   // NSString *str;
///==========  endfacebook ========/////
}



////////============ facebook ============
-(IBAction)shareButtonClick:(id)sender;
@property(nonatomic, retain) UIView *logoutView;
@property(nonatomic, retain) UIScrollView *loginView;
@property(nonatomic, retain) UIView *headerView;
@property(nonatomic, retain) UIView *addRunView;
@property(nonatomic, retain) MyRunViewController *myRunController;
@property(nonatomic, retain) NSManagedObjectContext *managedObjectContext;
///==========  endfacebook ========/////

//-(IBAction)shareButtonClick:(id)sender;
-(IBAction)back;
-(IBAction)menupage;
-(IBAction)Signupforfree;
-(IBAction)login_pressed;
-(void)check_login;
-(void)login_call;
-(void)call_logout;
-(void)call_create_account;
-(void)fetch_details;


// The button that handles Google+ sign-in.
@property (retain, nonatomic) IBOutlet GooglePlusSignInButton *signInButton;
// A label to display the result of the sign-in action.
@property (retain, nonatomic) IBOutlet UILabel *signInAuthStatus;
// A button to sign out of this application.
@property (retain, nonatomic) IBOutlet UIButton *signOutButton;

// Called when the user presses the "Sign out" button.
- (IBAction)signOut:(id)sender;

-(void)sendrequest;
-(void)facebook_signup;
-(void)insert_login;
- (void)reportAuthStatus;

-(void)call_google_login;
-(void)call_logout_google;
@end
