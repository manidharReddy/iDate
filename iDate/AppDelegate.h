//
//  AppDelegate.h
//  iDate
//
//  Created by D M R on 07/08/12.
//  Copyright (c) 2012 iHubTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "GooglePlusSampleSignInViewController.h"

sqlite3	*database;

@class  GooglePlusSampleSignInViewController;
@class RootViewController;
@class GooglePlusShare;
@class GooglePlusSignInButton;
@class GTMOAuth2Authentication;

BOOL view_profile_bool;
BOOL dating_bool;
BOOL view_full_bool;
NSString *global_string;

NSString *global_gift_id;
NSString *global_gift_to_id;

NSString *global_acess_token;

////////PartnerID GlobalVariabel///////////////
NSString *global_partnerID_str;
NSString *global_partner_websitename;
///////
NSString *global_country_selectedid;
NSString *global_haircolor_selectedid;
NSString *global_eyecolor_selectedid;
NSString *global_edu_selectedid;
NSString *global_race_selectedid;
NSString *global_drinker__selectedid;
NSString *global_smoker_selectedid;
NSString *global_interest_Business;
NSString *global_interest_chatting;
NSString *global_interest_dating;
NSString *global_interest_flirting;
NSString *global_interest_friendship;
NSString *global_interest_relationship;
NSString *global_interest_other_activity;
NSString *global_genderString;
NSString *global_height_from_string;
NSString *global_height_to_string;
NSString *global_weight_from_string;
NSString *global_weight_to_string;
NSString *global_age_from_string;
NSString *global_age_to_string;
NSString *global_car_string;
NSString *global_bike_string;
NSString *global_keyword_string;
NSString *global_logout_string;
NSString *global_backMenu_string;
NSString *global_notification_mssg_str;
//NSString *global_Message_string;
//NSString *global_messageCreation_string;
NSString *global_show_msg_iconstr;

NSMutableArray *global_Message_arr;
NSMutableArray *global_messageCreation_arr;
int global_back;

NSString *global_partener_str;
NSString *global_partenerNews_str;

NSString *global_unredmsg_bool_str;

NSString *request_id;
NSString *request_sel_id;
NSString *global_Chat_id;
BOOL sign_in_bool;
BOOL edit_bool;
NSString *chat_id;
int chat_index;
NSString *fid;
NSString *fname;
NSString *facebkName;
NSString *fgender;
NSString *femail;
BOOL check_bool;
BOOL login_bool;
BOOL del_chat_bool;

BOOL after_login_bool;
 NSMutableArray *message_arr;
 NSMutableArray *mesaage_arr;
NSMutableArray *arrdata;
NSMutableArray *arrdata1;
NSMutableArray *arrid;
NSString *logo_string;
NSString *final_logo;
NSString *partner_id_str;
NSString *string_contact;
NSMutableArray *ContactsAddressArray;
NSString *gender_string_global;


//Facebook String
NSString *dayFacebook;
NSString *monthFacebook;
NSString *yearFacebook;

NSString *locationFacebook;

NSString *EducationFacebook;
NSString *languagesFacebook;
NSString *global_socialLogID;
NSString *global_SocialCheck;
NSString *facebkImgUrl;
NSString *globalCheckFavorites;


//NSString * latiDulicat;
//NSString * longDuplicat;

NSString *vibrate_global_string;
NSString *play_sound_global_string;
NSString *global_login_type;
NSString *global_delete_msg_str;
NSString *global_artilce_content_str;
     /////Timer//////
NSTimer *callMessageByTimer;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(strong,nonatomic)IBOutlet UINavigationController *navController;
@property(strong,nonatomic)IBOutlet RootViewController *rootviewcontroller;
// The Google+ sign-in button to handle the URL redirect.
@property (retain, nonatomic) GooglePlusSignInButton *signInButton;
// The OAuth 2.0 authentication used in the application.
@property (retain, nonatomic) GTMOAuth2Authentication *auth;
// The Google+ share object to handle the URL redirect.
@property (retain, nonatomic) GooglePlusShare *share;

// The OAuth 2.0 client ID to be used for Google+ sign-in, share, and moments.
+ (NSString *)clientID;
+ (NSString *)ClientSecret;
- (NSString *)dataFilePath;
-(void)login_insert;


@end
