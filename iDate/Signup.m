//
//  Signup.m
//  iDate
//
//  Created by D M R on 07/08/12.
//  Copyright (c) 2012 iHubTechnologies. All rights reserved.
//

#import "Signup.h"
#import "FBConnect.h"

#import "FBLoginButton.h"
#import "UserInfo.h"
#import "MyRunViewController.h"
#import "Session.h"
#import"RootViewController.h"
#import"Menupage.h"
#import "Free_signup.h"
#import "Login.h"
#import "AsyncImageView.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"
#import "Profile_view.h"
#import "AsyncImageView1.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "JSON.h"
#import "JSON1.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import "GooglePlusSignIn.h"
#import "GooglePlusSignInButton.h"
#import "GooglePlusSampleAppDelegate.h"


#import "Freinds_view.h"
static NSString* kAppId = @"438746826175336";
@interface Signup ()

@end



@implementation Signup
@synthesize logoutView = _logoutView,loginView  = _loginView,headerView = _headerView,addRunView = _addRunView,myRunController = _myRunController;
@synthesize managedObjectContext;
@synthesize signInButton = signInButton_;
@synthesize signInAuthStatus = signInAuthStatus_;
@synthesize signOutButton = signOutButton_;

#pragma mark - View lifecycle




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _permissions =  [[NSArray arrayWithObjects: 
						  @"publish_stream", @"offline_access",@"user_birthday",@"email",@"user_location",nil] retain];
    }
    return self;
}
#pragma mark- Facebook

///////////////////////////////////////////////////////////////////////////////////////////////////
// Private helper function for login / logout

- (void) login
{
    NSLog(@"permi1");
	[_facebook authorize:kAppId permissions:_permissions delegate:self];
    //[_facebook authorize:kAppId permissions:nil delegate:self];
}

- (void) logout {
	[_session unsave];
	[_facebook logout:self]; 
}


-(void) fbDidLogin 
{
//	[_logoutView removeFromSuperview];
//	[_addRunView removeFromSuperview];
//	
	_fbButton.isLoggedIn         = YES;
//	[_fbButton updateImage];
//	_addRunButton.hidden = NO;
	
	_userInfo = [[[[UserInfo alloc] initializeWithFacebook:_facebook andDelegate: self] 
				  autorelease] 
				 retain];
	[_userInfo requestAllInfo];
	
//    if (self.loginView.isHidden==NO)
//    {
//    }
//    else {
//        [self.view addSubview:self.loginView];
//    }
    
 //[self performSelector:@selector(fetch_details) withObject:nil afterDelay:1.0];
    
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading...";
    [self performSelector:@selector(check_login) withObject:nil afterDelay:3.0];
    
}
-(void)fetch_details
{
[_facebook requestWithGraphPath:@"me" andDelegate:self];
}
- (void)request:(FBRequest*)request didLoad:(id)result
{
    NSLog(@"result123123131:%@",result);
    
    NSString *uid = [result objectForKey:@"id"];
    NSLog(@"result:%@",result);
    fid=[[NSString alloc]initWithFormat:@"%@",uid];
    
    NSString *username=[result objectForKey:@"name"];
    NSLog(@"uesrname:%@",username);
    fname=[[NSString alloc]initWithFormat:@"%@",username];
    NSString *email=[result objectForKey:@"email"];
    NSLog(@"email:%@",email);
    femail=[[NSString alloc]initWithFormat:@"%@",email];
    
    NSString *gender_str=[result objectForKey:@"gender"];
    NSLog(@"gender_str:%@",gender_str);
    fgender=[[NSString alloc]initWithFormat:@"%@",gender_str];
    
    //NSlog(@"usersLocation:%@",[result objectForKey:@"user_location"]);
    NSString *birthday=[result objectForKey:@"birthday"];
    if (birthday == (NSString*)[NSNull null])
        
    {
        
        
        birthday=[[NSString alloc]initWithFormat:@"Not known"];
        
    }
    
    else
    {/*
    NSLog(@"birthday In Else:%@",birthday);
        NSArray *splitFBirthday =[[NSArray alloc]init];
        splitFBirthday = [birthday componentsSeparatedByString:@"/"];
        NSLog(@"splitbirthday:%@",splitFBirthday);
        dayFacebook = [[NSString alloc]initWithFormat:@"%@",[splitFBirthday objectAtIndex:0]];
        monthFacebook = [[NSString alloc]initWithFormat:@"%@",[splitFBirthday objectAtIndex:1]];
        yearFacebook = [[NSString alloc]initWithFormat:@"%@",[splitFBirthday objectAtIndex:2]];
     */   
        
    }
    
    NSLog(@"birthday in :%@",birthday);
    

}
-(void)check_login
{
    
    check_bool=TRUE;
    login_bool=FALSE;
    
    if(global_login_type == (NSString*)[NSNull null]){
        NSLog(@"glt");
        global_login_type=@"";
    }
    socailLogTest =0;
    
    NSURL *url = [NSURL URLWithString:@"http://192.168.0.111/DatingService/signUp.svc/emailExists/"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    NSString *str_url=[[NSString alloc]initWithFormat:@"{\"userEmail\":\"%@\"}",femail];
    
    NSLog(@"str_urlemailexists:%@",str_url);
    [request appendPostData:[str_url dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    //[request addRequestHeader:@"Accept" value:@"application/json"];
    [request setRequestMethod:@"POST"];
    [request setDelegate:self];
    [request startAsynchronous];
    // Start hud
  
    




}

- (void)requestFinished:(ASIHTTPRequest *)request
{    
   // [MBProgressHUD hideHUDForView:self.view animated:YES];
    if (request.responseStatusCode == 400) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Sign up failed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        [MBProgressHUD hideHUDForView:self.view animated:YES];

        
    } else if (request.responseStatusCode == 403) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Sign up failed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        [MBProgressHUD hideHUDForView:self.view animated:YES];

    } else if (request.responseStatusCode == 200) {
        NSString *responseString = [request responseString];
        NSLog(@"responseStringor:%@",responseString);
        
        NSLog(@"responseString:%@",responseString);
  
        NSDictionary *responseDict = [responseString JSONValue];
       // NSDictionary *responseDict = [responseString ;

        NSLog(@"responseDict:%@",responseDict);
        NSString *unlockCode = [responseDict objectForKey:@"unlock_code"];
        NSLog(@"unlock:%@",unlockCode);
        if(socailLogTest ==0){
         NSLog(@"checkboolmani:%d",check_bool);
        if ([unlockCode compare:@"com.razeware.test.unlock.cake"] == NSOrderedSame)
        
        {
            if (check_bool==TRUE)
            {
                check_bool=FALSE;
                signin_bool=TRUE;
                responseString=[responseString stringByReplacingOccurrencesOfString:@"\"" withString:@""];
                if ([responseString isEqualToString:@"false"])
                {
                    NSLog(@"enter in face");
                    [self facebook_signup];
                    
                    
                }
                else
                {
                    //socailLogTest = 1;
                    [self login_call];
                }
                
            }
            
            
            else 
                
                
            {
                 //[MBProgressHUD hideHUDForView:self.view animated:YES];
                response_id=[[NSString alloc]initWithFormat:@"%@",responseString];
                
                [self login_call];
                

            }

            
        } 
        
        else 
        {        
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Sign up failed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
            
        }

        }else if (socailLogTest ==1){
        
        
        
        
        
            //NSDictionary *str_social = [responseDict objectForKey:@"socialLoginResult"];
            //NSLog(@"str_social:%@",str_social);
            
            
            
            
            string_id=[[NSString alloc]initWithFormat:@"%@",[responseDict objectForKey:@"userID"]];
            NSLog(@"string_id:%@",string_id);
            string_result=[[NSString alloc]initWithFormat:@"%@",[responseDict objectForKey:@"result"]];
            
            
            
            
            
            
            //check_bool=FALSE;
            
            [self performSelector:@selector(insert_login) withObject:nil afterDelay:2.0];
            
            
        
        
        
        
        }
    }
    
    
    else
{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Sign up failed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    
}
-(void)facebook_signup
{
    signin_bool=TRUE;
    check_bool=FALSE;
    NSURL *url = [NSURL URLWithString:@"http://192.168.0.111/DatingService/signUp.svc/createAccount/"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    NSLog(@"Create Account:%@",url);
    
    if ([fgender isEqualToString:@"male"])
    {
        gender_string=[[NSString alloc]initWithFormat:@"1"];
    }
    else
    {
    
      gender_string=[[NSString alloc]initWithFormat:@"0"];
    }
    /*
    if ([languagesFacebook isEqualToString:@""]==1)
    {
        NSLog(@"manilang" );
        //NSLog(@"locationfacebook is empty");
        languagesFacebook=@"0";
        
        
        
    }else if (locationFacebook == (NSString*)[NSNull null])
    {
        
        //NSLog(@"locationfacebook is empty");
        NSLog(@"edumani");
        locationFacebook=@"0";
        
        
        
    }
        
    */
    
    languagesFacebook=@"0";
    EducationFacebook=@"0";
    locationFacebook=@"";
    
    NSLog(@"manilantest:%@",languagesFacebook);
    NSLog(@"maniedutest:%@",EducationFacebook);
    
    NSString *str_url=[[NSString alloc]initWithFormat:@"{\"isMale\":\"%@\",\"userName\":\"%@\",\"userPassword\":\"A1234\",\"userEmail\":\"%@\",\"userRealName\":\"%@\",\"userMobileNumber\":\"null\",\"userDOBDay\":\"%@\",\"userDOBMonth\":\"%@\",\"userDOBYear\":\"%@\",\"userCountryID\":\"0\",\"userCountrystateID\":\"0\",\"userCountrystateCityID\":\"0\",\"languageID\":\"%@\",\"userHeight\":\"0\",\"userWeight\":\"0\",\"userVitalStatsWaist\":\"null\",\"userVitalStatsHips\":\"null\",\"userVitalStatsBust\":\"null\",\"userCupSize\":\"null\",\"userRaceID\":\"0\",\"userHairColorID\":\"0\",\"userEyesColorID\":\"0\",\"userEducationLevelID\":\"%@\",\"drinkerTypeID\":\"0\",\"smokerTypeID\":\"0\",\"isDriveCar\":\"0\",\"isDriveBike\":\"0\",\"isInterestedInMale\":\"0\",\"isInterestedInFemale\":\"0\",\"isInterestedInBusinessNetworking\":\"0\",\"isInterestedInChatting\":\"0\",\"isInterestedInDating\":\"0\",\"isInterestedInFlirting\":\"0\",\"isInterestedInFriendships\":\"0\",\"isInterestedInOtherActivities\":\"0\",\"isInterestedInRelationships\":\"0\",\"userTagline\":\"null\",\"userShortDescription\":\"null\",\"userLongDescription\":\"null\",\"userKeywords\":\"null\",\"userMinimumBookingFee\":\"0\",\"userMinimumBookingHours\":\"0\",\"userServicesDescription\":\"null\",\"userAddress\":\"%@\",\"partnerID\":\"%@\",\"bonusCode\":\"Bonus Code\",\"partnerRemarks\":\"Partner Remarks\",\"referredByUserid\":\"0\",\"userFileDescription\":\"null\",\"userFileURL\":\"%@\",\"userFileScreenshotURL\":\"%@\"}",gender_string,facebkName,femail,fname,dayFacebook,monthFacebook,yearFacebook,languagesFacebook, EducationFacebook,locationFacebook,global_partnerID_str,facebkImgUrl,facebkImgUrl];
    //\"userFileScreenshotURL\":\"profile_pic.png\"}"
    NSLog(@"str_url:%@",str_url);
    [request appendPostData:[str_url dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    //[request addRequestHeader:@"Accept" value:@"application/json"];
    [request setRequestMethod:@"POST"];
    [request setDelegate:self];
    [request startAsynchronous];
    // Start hud
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    hud.labelText = @"Loading...";
//


}
- (void)requestFailed:(ASIHTTPRequest *)request
{    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    NSError *error = [request error];
    NSLog(@"error:%@",error);
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Sign up failed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [alert release];
}
-(void)login_call
{
    
    
    check_bool=FALSE;
    login_bool=TRUE;
    signin_bool=FALSE;
    socailLogTest =1;
    
    NSURL *url = [NSURL URLWithString:@"http://192.168.0.111/DatingService/signUp.svc/socialLogin/"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    NSString *str_url=[[NSString alloc]initWithFormat:@"{\"userEmail\":\"%@\"}",femail];
    
    NSLog(@"str_url:%@",str_url);
    [request appendPostData:[str_url dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    //[request addRequestHeader:@"Accept" value:@"application/json"];
    [request setRequestMethod:@"POST"];
    [request setDelegate:self];
    [request startAsynchronous];
    
    
    
    
    
    
    
    
    
     /*
    str = [[NSString alloc ]initWithFormat:@"http://192.168.0.111/DatingService/signUp.svc/socialLogin/%@",facebkName];
    
     str=[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"str:%@",str);





NSMutableURLRequest *request =[[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:str]];

NSData *returnData = [ NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil ];

NSString *returnString = [[NSString alloc]initWithData:returnData encoding:NSUTF8StringEncoding];

NSLog(@"returnString:*%@*",returnString);


NSDictionary *dict=[returnString JSONValue];
NSLog(@"dict:%@",dict);


    if (dict==nil||dict==NULL)
    {
        [MBProgressHUD hideHUDForView:self.view animated:YES];

        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Login failed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];

    }
       
    else
    {
        
        
    NSDictionary *str_social = [dict objectForKey:@"socialLoginResult"];
    NSLog(@"str_social:%@",str_social);
    
 

        
            string_id=[[NSString alloc]initWithFormat:@"%@",[str_social objectForKey:@"userID"]];
        NSLog(@"string_id:%@",string_id);
                       string_result=[[NSString alloc]initWithFormat:@"%@",[str_social objectForKey:@"result"]];

        
     
   

    
    check_bool=FALSE;
            
        [self performSelector:@selector(insert_login) withObject:nil afterDelay:2.0];



    
}
      */

}
                     
                     
                     
                     
                     
-(void)insert_login
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];


    sqlite3_stmt *stmt3;
    char *errorMsg4;
    char *update4 = "insert into login values (?,?,?);";
    
    int x1 = sqlite3_prepare_v2(database, update4, -1, &stmt3, nil);
    
    if (x1 == SQLITE_OK)
    {
        sqlite3_bind_text(stmt3, 1, NULL,-1, NULL);
        sqlite3_bind_text(stmt3, 2, [string_id UTF8String],-1, NULL);
        sqlite3_bind_text(stmt3, 3, [@"A1234"UTF8String],-1, NULL);
        
    }
    if (sqlite3_step(stmt3) != SQLITE_DONE)
        NSLog(@"Error: %s",errorMsg4);
    sqlite3_finalize(stmt3);
    

    
   
          RootViewController *preview=[[RootViewController alloc]initWithNibName:@"RootViewController" bundle:[NSBundle mainBundle]];
          [self.navigationController pushViewController:preview animated:NO];
}
-(void)call_create_account
{

}






-(void)call_logout
{


    //===== FB logout ======////  
    _session = [[Session alloc] init];
    // _facebook = [[_session restore] retain];
    if (_facebook == nil)
    {
        _facebook = [[[[Facebook alloc] init] autorelease] retain];
        _fbButton.isLoggedIn = NO;
        _addRunButton.hidden = YES;
        [self.view addSubview:self.logoutView];
    } 
    else 
    {
        _fbButton.isLoggedIn = YES;
        _addRunButton.hidden = NO;
        [self fbDidLogin];
        [self.view addSubview:self.loginView];
    }
    
    [_fbButton updateImage];
    [[self view] addSubview:[self headerView]];
    [_headerView addSubview:_fbButton];
    
    //////////////////////////////////////////////////////
    
    NSLog(@"Is Kind of NSString: %@", _fbButton.isLoggedIn ? @"YES" : @"NO");     
    _fbButton =[[FBLoginButton alloc]init];
    if (_fbButton.isLoggedIn) 
    {
        NSLog(@"isloggedin");
        [self logout];
    } 
    else
    {
        [self logout];
        NSLog(@"isloggedinfgjfdgjdfjgdfjfj");
    }
    //===== end FB logout ======////  
    [self fbDidLogout];
    [self logout];
    
    
    
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *each in cookieStorage.cookies) 
    {
        [cookieStorage deleteCookie:each];
    }

}

-(void)viewWillAppear:(BOOL)animated
{

    [self.navigationController setNavigationBarHidden:YES];

}
-(IBAction)shareButtonClick:(id)sender
{
    
    if (_fbButton.isLoggedIn)
    {
        [self logout];
        
        NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for (NSHTTPCookie *each in cookieStorage.cookies)
        {
            [cookieStorage deleteCookie:each];
        }

    }

    //login_type=[[NSString alloc]initWithFormat:@"_facebook"];
    //global_login_type =[[NSString alloc]initWithString:login_type];
    
   [self facebookcall];
}

/**
 * FBSessionDelegate
 */ 


-(void) fbDidLogout
{
	[_session unsave];
	[_loginView removeFromSuperview];
	[self.view addSubview:_logoutView];
	_fbButton.isLoggedIn         = NO;
	[_fbButton updateImage];
	_addRunButton.hidden = YES;
}

/*
 * UserInfoLoadDelegate
 */

- (void)userInfoDidLoad 
{
	[_session setSessionWithFacebook:_facebook andUid:_userInfo.uid];
	[_session save];
	
	_myRunController = [[MyRunViewController alloc] init];
	_myRunController.userInfo = _userInfo;
	_myRunController.view.frame = CGRectMake(0, 0, 320, 460);
	[self.myRunController viewWillAppear:YES];
	[_loginView addSubview:self.myRunController.view];
}
- (void)userInfoFailToLoad 
{
    
    [self logout]; 
	_fbButton.isLoggedIn = NO;
	_addRunButton.hidden = YES;
	[self.view addSubview:self.logoutView];
	
}

//////////////////////////////////////////////////////////////////////////////////////////////////

-(void)facebookcall
{
    _session = [[Session alloc] init];
    _facebook = [[_session restore] retain];
    if (_facebook == nil) {
        _facebook = [[[[Facebook alloc] init] autorelease] retain];
        _fbButton.isLoggedIn = NO;
        _addRunButton.hidden = YES;
        [self.view addSubview:self.logoutView];
    } else {
        _fbButton.isLoggedIn = YES;
        _addRunButton.hidden = NO;
       // [self fbDidLogin]
        [self.view addSubview:self.loginView];
    }
    
    [_fbButton updateImage];
    
    [[self view] addSubview:[self headerView]];
    [_headerView addSubview:_fbButton];
    //////////////////////////////////////////////////////
    
    _fbButton =[[FBLoginButton alloc]init];
    if (_fbButton.isLoggedIn) 
    {
        NSLog(@"isloggedin");
        [self logout];
    } 
    else
    {
        [self login];
       // [self sendrequest];
        NSLog(@"islogged facebookCall");
        
    }
}

-(void)sendrequest
{
    
    
    NSLog(@"send request");
    

}
-(IBAction)back
{
    
    RootViewController* B2 = [[RootViewController alloc] init];
    UINavigationController *B2Nav = [[UINavigationController alloc] initWithRootViewController:B2];  
    [B2Nav setNavigationBarHidden:YES];
    B2Nav.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentModalViewController:B2Nav animated:YES];
    [B2 release];
    [B2Nav release];
    // [self.navigationController pop:preview animated:NO];
    //[self.navigationController p]
    
}

-(IBAction)menupage
{
    
    Menupage *preview=[[Menupage alloc]initWithNibName:@"Menupage" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:preview animated:NO];
    
    
}
-(IBAction)Signupforfree
{

    Free_signup *preview=[[Free_signup alloc]initWithNibName:@"Free_signup" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:preview animated:NO];
    



}

-(IBAction)login_pressed
{


    Login *preview=[[Login alloc]initWithNibName:@"Login" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:preview animated:NO];
    



}


// DO NOT USE THIS CLIENT ID. IT WILL NOT WORK FOR YOUR APP.
// Please use the client ID created for you by Google.
static NSString * const kClientID = @"702427597477.apps.googleusercontent.com";

static NSString * const kClientSecret = @"GfX0L2Ue9ev9st3zTIU7WKQ7";

//702427597477.apps.googleusercontent.com
//GfX0L2Ue9ev9st3zTIU7WKQ7

+ (NSString *)clientID {
    
    NSLog(@"kclientID:%@",kClientID);
    return kClientID;
}

+ (NSString *)ClientSecret {
    return kClientSecret;
}
- (void)viewDidLoad
{
   
    
    
    lbl_partnerwebsitename.text = global_partner_websitename;

   
  
    signin_bool=TRUE;
    
    
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

/*
    // Set up sign-out button.
    [[signOutButton_ layer] setCornerRadius:5];
    [[signOutButton_ layer] setMasksToBounds:YES];
    CGColorRef borderColor = [[UIColor colorWithWhite:203.0/255.0
                                                alpha:1.0] CGColor];
    [[signOutButton_ layer] setBorderColor:borderColor];
    [[signOutButton_ layer] setBorderWidth:1.0];
    */
    
   
    @try {
        // Set up sample view of Google+ sign-in.

        signInButton_.delegate = self;
        NSLog(@"Img0:%@",signInButton_.delegate);
        signInButton_.clientID = [AppDelegate clientID];
        NSLog(@"client id=%@",[AppDelegate clientID]);
        signInButton_.scope = [NSArray arrayWithObjects:@"https://www.googleapis.com/auth/plus.me",@"https://www.googleapis.com/auth/userinfo.profile",@"https://www.googleapis.com/auth/userinfo.email",
                               nil];
               appDelegate.signInButton = signInButton_;
        NSLog(@"Img1:%@",signInButton_);
       [self reportAuthStatus];
       
        

        
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
    }
    //signInButton_.frame = CGRectMake(27,436,273,58);
    
    [self.view addSubview:signInButton_];
    [super viewDidLoad];

    // Do any additional setup after loading the view from its nib.
}
- (void)viewDidUnload
{
       AppDelegate *appDelegate = (AppDelegate *)
    [[UIApplication sharedApplication] delegate];
    appDelegate.signInButton = nil;
    [facebk_btn_ref release];
    facebk_btn_ref = nil;
    [signin_btn_ref release];
    signin_btn_ref = nil;
    [sign_new_btn_ref release];
    sign_new_btn_ref = nil;
    [signup_img_ref release];
    signup_img_ref = nil;
    [super viewDidUnload];
}
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;


/////Google plus///

#pragma mark - View lifecycle
- (void)reportAuthStatus {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (appDelegate.auth)
    {
        signInAuthStatus_.text = @"Status: Authenticated";
        NSLog(@"logindine");
    } else {
        NSLog(@"logindine not authenticated");
        // To authenticate, use Google+ sign-in button.
        signInAuthStatus_.text = @"Status: Not authenticated";
    }
    
}


#pragma mark - GooglePlusSignInDelegate

- (void)finishedWithAuth:(GTMOAuth2Authentication *)auth
                   error:(NSError *)error {
    if (error) {
        signInAuthStatus_.text =
        [NSString stringWithFormat:@"Status: Authentication error: %@", error];
        return;
    }
      NSLog(@"logindinext463");
    AppDelegate *appDelegate = (AppDelegate *)
    [[UIApplication sharedApplication] delegate];
    appDelegate.auth = auth;
    [self reportAuthStatus];
    login_type=[[NSString alloc]initWithFormat:@"_google"];
    global_login_type =[[NSString alloc]initWithString:login_type];

    [self performSelector:@selector(call_google_login) withObject:nil afterDelay:2.0];
}
#pragma mark - IBActions

- (IBAction)signOut:(id)sender {
    [[signInButton_ googlePlusSignIn] signOut];
    
    AppDelegate *appDelegate = (AppDelegate *)
    [[UIApplication sharedApplication] delegate];
    appDelegate.auth = nil;
    
    NSLog(@"Am I called - signout");
    [self reportAuthStatus];
}

-(void)call_logout_google
{
    //[[signOutButton_ googlePlusSignOut] signOut];
    
    [[signInButton_ googlePlusSignIn] signOut];
    
    
    
   
    //AppDelegate *appDelegate = (AppDelegate *)
    //[[UIApplication sharedApplication] delegate];
    //appDelegate.auth = nil;
    [self reportAuthStatus];
    
    
    

}
-(void)call_google_login
{

    
    if ([global_acess_token isEqualToString:@"null"]||[global_acess_token isEqualToString:@"(null)"]||[global_acess_token isEqualToString:@""]||[global_acess_token isEqualToString:@"<null>"])
    
    {
        /*
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Login failed.Try again" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        */
        
        [[signInButton_ googlePlusSignIn] signOut];
        
        AppDelegate *appDelegate = (AppDelegate *)
        [[UIApplication sharedApplication] delegate];
        appDelegate.auth = nil;
//        NSHTTPCookieStorage* cookies = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//        NSArray* facebookCookies = [cookies cookiesForURL:
//                                    [NSURL URLWithString:@"http://login.facebook.com"]];
//        
//        for (NSHTTPCookie* cookie in facebookCookies) {
//            [cookies deleteCookie:cookie];
//        }
        [self reportAuthStatus];
        
    }
    
    else
    {
        
        global_SocialCheck =[[NSString alloc]initWithFormat:@"%@",@"googlePic"];
        NSString *str1 = [NSString stringWithFormat:@"https://www.googleapis.com/oauth2/v1/userinfo?access_token=%@",global_acess_token];
        
        str1 =[str1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"str:%@",str1);
        NSMutableURLRequest *request =[[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:str1]];
        
        NSData *returnData = [ NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil ];
        
        NSString *returnString = [[NSString alloc]initWithData:returnData encoding:NSUTF8StringEncoding];
        NSDictionary *dict=[returnString JSONValue];
        NSLog(@"dictGoogle:%@",dict);
        
        if (dict==nil||dict==NULL)
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"No Response From Server" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
        
        
        else {
            
        
        NSString *username=[dict objectForKey:@"name"];
        NSLog(@"uesrname:%@",username);
        NSString *replacUsername = [ username stringByReplacingOccurrencesOfString:@" " withString:@"_"];
        
        facebkName = [[NSString alloc]initWithFormat:@"%@",replacUsername];
        
        //facebkName = [[NSString alloc]initWithFormat:@"%@",username];
        
        NSString *realGooglename = [dict objectForKey:@"name"];
        
        fname=[[NSString alloc]initWithFormat:@"%@_google",realGooglename];
        NSString *email=[dict objectForKey:@"email"];
        NSLog(@"email:%@",email);
        
        femail=[[NSString alloc]initWithFormat:@"%@",email];
        
        NSString *gender_str=[dict objectForKey:@"gender"];
        NSLog(@"gmailgender_str:%@",gender_str);
        fgender=[[NSString alloc]initWithFormat:@"%@",gender_str];
        
        NSString *picture_str=[dict objectForKey:@"picture"];
        global_socialLogID = [[NSString alloc]initWithFormat:@"%@",picture_str];
        
        facebkImgUrl = [[NSString alloc]initWithFormat:@"%@",global_socialLogID];
        
        NSLog(@"goglePic:%@",global_socialLogID);
        
        NSString *birthday=[dict objectForKey:@"birthday"];
        NSLog(@"birthday_str:%@",birthday);
        
        if (birthday == (NSString*)[NSNull null] || birthday == NULL)
            
        {
            
            
            birthday=[[NSString alloc]initWithFormat:@"Not known"];
            
            dayFacebook = @"0";
            monthFacebook =@"0";
            yearFacebook = @"0";
            
        }
        
        else
        {
            // NSLog(@"birthday In Else:%@",birthday);
            NSArray *splitFBirthday =[[NSArray alloc]init];
            splitFBirthday = [birthday componentsSeparatedByString:@"-"];
            NSLog(@"splitbirthday:%@",splitFBirthday);
            dayFacebook = [[NSString alloc]initWithFormat:@"%@",[splitFBirthday objectAtIndex:2]];
            monthFacebook = [[NSString alloc]initWithFormat:@"%@",[splitFBirthday objectAtIndex:1]];
            yearFacebook = [[NSString alloc]initWithFormat:@"%@",[splitFBirthday objectAtIndex:0]];
            
        }
        NSLog(@"birthday:%@",birthday);
        
        locationFacebook =@"0";
        languagesFacebook =@"0";
        EducationFacebook =@"0";
        
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = @"Loading...";
        
        [self performSelector:@selector(check_login) withObject:nil afterDelay:2.0];
    
    
    
    }
    }

}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if(interfaceOrientation == UIInterfaceOrientationPortrait)
    {
        return YES;
    }
    else if(interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


- (void)dealloc {
    [facebk_btn_ref release];
    [signin_btn_ref release];
    [sign_new_btn_ref release];
    [signup_img_ref release];
    [super dealloc];
}
@end
