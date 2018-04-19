//
//  RootViewController.m
//  iDate
//
//  Created by D M R on 07/08/12.
//  Copyright (c) 2012 iHubTechnologies. All rights reserved.
//

#import "RootViewController.h"
#import "DDPageControl.h"
#import "Dating_cell.h"
#import "Signup.h"
#import "Menupage.h"
#import"JSON1.h"
#import "Login.h"
#import "Friend_cell.h"
#import "AsyncImageView.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"
#import "Profile_view.h"
#import "AsyncImageView1.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import <AudioToolbox/AudioServices.h>
#import "UIImageView+DispatchLoad.h"
#import "homeview_cell.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import "Profile_view.h"
#import "GooglePlusSampleSignInViewController.h"

static const int kNumViewControllers = 1;
static NSString * const kMenuOptions[kNumViewControllers] = {
    @"Sign In" };
static NSString * const kNibNames[kNumViewControllers] = {
    @"GooglePlusSampleSignInViewController" };

#define ASYNC_IMAGE_TAG 9999
#define FONT_SIZE 18.0f
#define CELL_CONTENT_WIDTH 320.0f
#define CELL_CONTENT_MARGIN 10.0f
@interface RootViewController ()

@end


//static const int kNumViewControllers = 1;
//static NSString * const kMenuOptions[kNumViewControllers] = {
//    @"Sign Up"};
//static NSString * const kNibNames[kNumViewControllers] = {
//    @"Signup"};

@implementation RootViewController
@synthesize locationManager,lbl_partnerWebsiteName;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    
    [self readlogin];
    
    global_show_msg_iconstr =@"0";
    
//    
//    name_arr=[[NSMutableArray alloc]init];
//    image_arr=[[NSMutableArray alloc]init];
//    age_arr=[[NSMutableArray alloc]init];
//    id_arr=[[NSMutableArray alloc]init];
//    gender_arr=[[NSMutableArray alloc]init];
//    race_arr=[[NSMutableArray alloc]init];
//    gender_image_arr=[[NSMutableArray alloc]init];
//    final_img_arr=[[NSMutableArray alloc]init];
//    
//    id_list_items= [[NSMutableArray alloc] init];
//    gender_list_items=[[NSMutableArray alloc] init];
//    race_list_items=[[NSMutableArray alloc] init];
//    image_list_items=[[NSMutableArray alloc] init];
//    name_list_items=[[NSMutableArray alloc] init];
//    age_list_items=[[NSMutableArray alloc] init];
    

 
//    [self readlogin];
//    if ([login_select isEqualToString:@"null"]||[login_select isEqualToString:@"(null)"]||[login_select isEqualToString:@""]||login_select ==Nil||login_select==NULL)
//    {
//        
//        [searchBar removeFromSuperview];
//        [searchBar release];
//        searchBar=nil;
//      
//        Signup_btn.hidden=NO;
//        Login_btn.hidden=NO;
//        Signup_btn1.hidden=YES;
//        user_menu.hidden=YES;
//        works_menu.hidden=YES;
//      //  searchBar.hidden=YES;
//        grid_btn1.hidden=YES;
//        grid_btn2.hidden=NO;
//       // profile_tbl.tableHeaderView = nil;
//      
//        profile_tbl.frame=CGRectMake(6.0, 75.0, 308.0, 300.0);
//
//         after_login_bool=FALSE;
//
//    
//    }
//    else 
//    {
//        [searchBar removeFromSuperview];
//        [searchBar release];
//        searchBar=nil;
//
//        Signup_btn.hidden=YES;
//        Login_btn.hidden=YES;
//        user_menu.hidden=NO;
//        works_menu.hidden=NO;
//        Signup_btn1.hidden=NO;
//       // searchBar.hidden=NO;
//        grid_btn1.hidden=NO;
//        grid_btn2.hidden=YES;
//      
//        profile_tbl.frame=CGRectMake(6.0, 75.0, 308.0, 300.0);
//
//        after_login_bool=TRUE;
//        
//           }
   // [self show_view];
    
    
    
    
    thumb_scroll=[[UIScrollView alloc]init];
    [thumb_scroll setFrame:CGRectMake(0,77,320,294)];
    thumb_scroll.clipsToBounds = YES;
	thumb_scroll.delegate = self;
    [profile_view_list addSubview:thumb_scroll];
    
    
    
    //profile_tbl.hidden=YES;
    
    [self performSelectorInBackground:@selector(call_logo_json) withObject:nil];
    [self performSelectorInBackground:@selector(call_logo_detail) withObject:nil];
    profile_tbl.hidden=YES;
    //  Profile_view *profile=[[Profile_view alloc]init];
    // [profile readlogin];
    // [self readlogin];
    if ([login_select isEqualToString:@"null"]||[login_select isEqualToString:@"(null)"]||[login_select isEqualToString:@""]||login_select ==Nil||login_select==NULL)
    {
        
        
        Signup_btn.hidden=NO;
        Login_btn.hidden=NO;
        Signup_btn1.hidden=YES;
        user_menu.hidden=YES;
        works_menu.hidden=YES;
        searchBar.hidden=YES;
        grid_btn1.hidden=YES;
        grid_btn2.hidden=NO;
        after_login_bool=FALSE;
        profile_tbl.tableHeaderView = nil;
        searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
        profile_tbl.frame=CGRectMake(6.0, 75.0, 308.0,260.0);
        //[self performSelectorInBackground:@selector(profile_json_call) withObject:nil];
        //[self performSelector:@selector(profile_json_call)];
        [self profile_json_call];
    }
    else //if([global_backMenu_string intValue]==2)
        if(global_back==2)
    {
        
    
        Signup_btn.hidden=YES;
        Login_btn.hidden=YES;
        user_menu.hidden=NO;
        works_menu.hidden=NO;
        Signup_btn1.hidden=NO;
        searchBar.hidden=NO;
        grid_btn1.hidden=NO;
        grid_btn2.hidden=YES;
        profile_tbl.tableHeaderView = searchBar;
        searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
        profile_tbl.frame=CGRectMake(6.0, 75.0, 308.0,252.0);
        after_login_bool=TRUE;
        [self performSelectorInBackground:@selector(after_login_json) withObject:nil];
        
      
    }
        else{
            
            [self callMessage];
            
            [self performSelector:@selector(call_Msg_timer) withObject:nil afterDelay:2.0f];
        
            locationManager = [[CLLocationManager alloc] init];
            locationManager.delegate = self;
            locationManager.desiredAccuracy = kCLLocationAccuracyBest;
            locationManager.distanceFilter = kCLDistanceFilterNone;
            [locationManager startUpdatingLocation];
            
           [self performSelector:@selector(latiAndLongCalu) withObject:nil afterDelay:2.0f];
           
            
        [self showMenu];
        Signup_btn.hidden=YES;
        Login_btn.hidden=YES;
        user_menu.hidden=NO;
        works_menu.hidden=NO;
        Signup_btn1.hidden=NO;
        searchBar.hidden=NO;
        grid_btn1.hidden=NO;
        grid_btn2.hidden=YES;
        profile_tbl.tableHeaderView = searchBar;
        searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
        profile_tbl.frame=CGRectMake(6.0, 75.0, 308.0,252.0);
        after_login_bool=TRUE;
        [self performSelectorInBackground:@selector(after_login_json) withObject:nil];
        
    
        }
    
    
    search_done.hidden=YES;
    default_imageview.image=[UIImage imageNamed:@"bg_2.png"];
    header_image.hidden=YES;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:profile_view_list animated:YES];
    hud.labelText = @"Loading...";
    
    //[self performSelector:@selector(profile_json_call) withObject:nil afterDelay:3.0];
    
    
    //    [self performSelector:@selector(profile_json_call) withObject:nil afterDelay:3.0];
    //
    
    
    
    
    //  [self profile_json_call];
    [self performSelectorInBackground:@selector(jsoncall) withObject:nil];
    //[self jsoncall];
    
    
    [self show_view];
    
    
    
    
    
    
    

    
}

-(void)call_Msg_timer{
    callMessageByTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(callMessage) userInfo:nil repeats:YES];
    
}



-(void)callMessage
{
    //[self readlogin];
    NSString *str_unreadMsg = [[NSString alloc]initWithFormat:@"http://192.168.0.111/DatingService/Notifications.svc/unReadMsg/%@",login_select];
    
    NSLog(@"str_unreadMsg:%@",str_unreadMsg);
    
    NSMutableURLRequest *request =[[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:str_unreadMsg]];
    
    NSData *returnData = [ NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil ];
    
    NSString *returnString = [[NSString alloc]initWithData:returnData encoding:NSUTF8StringEncoding];
    
    NSLog(@"returnString:*%@*",returnString);
    if (returnString==nil||returnString==NULL)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Notifications Not Available" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    
    
    else {
        
        
    
    //NSDictionary *dict=[returnString JSONValue];
    
    //play_sound_global_string=@"0";
    
    NSString *unReadMssg = [[NSString alloc]initWithString:returnString];
    global_unredmsg_bool_str =[NSString stringWithString:unReadMssg];
    
    NSLog(@"unRead Messages:%@",unReadMssg);
    if([unReadMssg isEqualToString:@"true"])
    {
        global_show_msg_iconstr =@"1";
        
        //global_show_msg_iconstr = [NSString stringWithFormat:@"%i",1];
        NSLog(@"Enter in True Msg");
        //messageIconShow.hidden = NO;
        
        if([vibrate_global_string isEqualToString:@"0"])
        {
            
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        }else if([play_sound_global_string isEqualToString:@"0"])
        {
            
            NSError *error;
            NSString *st = [NSString stringWithFormat:@"%@",[[NSBundle mainBundle] pathForResource:@"click" ofType:@"wav"]];
            NSLog(@"St:%@",st);
            NSURL *path = [[NSURL alloc] initFileURLWithPath:st];
            NSLog(@"Tone url:%@",path);
            
            
            soundPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:path error:&error];
            soundPlayer.numberOfLoops = 0;
            soundPlayer.volume = 1.0;
            
            if (soundPlayer == nil)
                NSLog(@"Error.");
            
            else
                [soundPlayer play];
            
            
        }
        
        
    }
    else if([unReadMssg isEqualToString:@"false"])
    {
        global_show_msg_iconstr =@"0";
        //global_show_msg_iconstr = [NSString stringWithFormat:@"%i",0];
        
        NSLog(@"Enter in False Msg");
        // messageIconShow.hidden = YES;
    }
    
    
    }
    
    
    
}


-(void)showMenu
{
    Menupage *preview=[[Menupage alloc]initWithNibName:@"Menupage" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:preview animated:NO];

}
-(void)show_view
{
    

   // [self readlogin];
    if ([login_select isEqualToString:@"null"]||[login_select isEqualToString:@"(null)"]||[login_select isEqualToString:@""]||login_select ==Nil||login_select==NULL)
    {
        [searchBar removeFromSuperview];
        [searchBar release];
        searchBar=nil;
        [pageControl removeFromSuperview];

        pageControl = [[DDPageControl alloc] init] ;
        [pageControl setCenter:CGPointMake(160, 360)];
        
        [pageControl addTarget: self action: @selector(pageControlClicked:) forControlEvents: UIControlEventValueChanged] ;
        [pageControl setDefersCurrentPageDisplay: YES] ;
        [pageControl setType: DDPageControlTypeOnFullOffFull] ;
        [pageControl setOnColor: [UIColor cyanColor]] ;
        [pageControl setOffColor: [UIColor darkGrayColor]] ;
        [pageControl setIndicatorDiameter: 10.0f] ;
        [pageControl setIndicatorSpace: 10.0f] ;
        [self.view addSubview: pageControl] ;
        [pageControl release];
        
        [pageControl setNumberOfPages:4] ;
        
        scroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 333)];
        //scroll.backgroundColor=[UIColor redColor];
        scroll.scrollEnabled=YES;
        scroll.userInteractionEnabled=YES;
        scroll.pagingEnabled = YES;
        scroll.showsHorizontalScrollIndicator = NO;
        scroll.showsVerticalScrollIndicator = NO;
        scroll.scrollsToTop = NO;
        scroll.delegate = self;
        [self.view addSubview:scroll];
        
        [scroll setContentSize:CGSizeMake(320*4, 333)];
        
        
        logo_view.frame=CGRectMake(0, 0, 320, 333);
        [scroll addSubview:logo_view];

        
        
        home_page_view.frame=CGRectMake(320, 0, 320, 333);
        [scroll addSubview:home_page_view];

        
        profile_view_list.frame=CGRectMake(640, 0, 320, 333);
        [scroll addSubview:profile_view_list];
        
        
        
        how_it_works_view.frame=CGRectMake(960, 0, 320, 333);
        [scroll addSubview:how_it_works_view];
        
      //  profile_tbl.frame=CGRectMake(6.0, 75.0, 308.0, 300.0);

    
    
    }
    else
    {
        [searchBar removeFromSuperview];
        [searchBar release];
        searchBar=nil;
        [pageControl removeFromSuperview];
        pageControl = [[DDPageControl alloc] init] ;
        [pageControl setCenter:CGPointMake(160, 360)];
        
        [pageControl addTarget: self action: @selector(pageControlClicked:) forControlEvents: UIControlEventValueChanged] ;
        [pageControl setDefersCurrentPageDisplay: YES] ;
        [pageControl setType: DDPageControlTypeOnFullOffFull] ;
        [pageControl setOnColor: [UIColor cyanColor]] ;
        [pageControl setOffColor: [UIColor darkGrayColor]] ;
        [pageControl setIndicatorDiameter: 10.0f] ;
        [pageControl setIndicatorSpace: 10.0f] ;
        [self.view addSubview: pageControl] ;
        [pageControl release];
        
        [pageControl setNumberOfPages:2] ;
        
        scroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 333)];
        //scroll.backgroundColor=[UIColor redColor];
        scroll.scrollEnabled=YES;
        scroll.userInteractionEnabled=YES;
        scroll.pagingEnabled = YES;
        scroll.showsHorizontalScrollIndicator = NO;
        scroll.showsVerticalScrollIndicator = NO;
        scroll.scrollsToTop = NO;
        scroll.delegate = self;
        [self.view addSubview:scroll];
        
        [scroll setContentSize:CGSizeMake(320*2, 333)];
               
        
        profile_view_list.frame=CGRectMake(0, 0, 320, 333);
        [scroll addSubview:profile_view_list];
        
        
        
        how_it_works_view.frame=CGRectMake(321, 0, 320, 333);
        [scroll addSubview:how_it_works_view];
        
       // profile_tbl.frame=CGRectMake(6.0, 75.0, 308.0, 300.0);
        searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
        searchBar.delegate=self;
        [profile_view_list addSubview:searchBar];
        profile_tbl.tableHeaderView=searchBar;
        searchBar.backgroundColor=[UIColor cyanColor];
        searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
        searching = NO;
        searchBar.placeholder=@"Search By Name";
        letUserSelectRow = YES;

      


    }

}
#pragma mark Custom Actions
-(BOOL)CheckNetwork
{
    const char *host_name = "www.google.com";
    if( [self checkConnection:host_name] )
    {
        NSLog(@"Net available");
        return YES;
    }
    else
    {
        NSLog(@"Net Not available");
        return NO;
    }
	
}

- (BOOL) checkConnection:(const char*) host_name
{
    BOOL _isDataSourceAvailable = NO;
    Boolean success;
	
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(NULL, host_name);
	
    SCNetworkReachabilityFlags flags;
    success = SCNetworkReachabilityGetFlags(reachability, &flags);
    _isDataSourceAvailable = success &&(flags & kSCNetworkFlagsReachable) &&!(flags & kSCNetworkFlagsConnectionRequired);
	
    CFRelease(reachability);
	
    return _isDataSourceAvailable;
}

-(void)after_login_json
{
     //  [self readlogin];
    NSURL *url = [NSURL URLWithString:@"http://192.168.0.111/DatingService/getDetails.svc/getResults/"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    NSString *str_url=[[NSString alloc]initWithFormat:@"{\"userID\":\"%@\"}",login_select];
    
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


}
-(IBAction)Logout:(id)sender
{
    
//    [[signInButton_ googlePlusSignIn] signOut];
//    
//    AppDelegate *appDelegate = (AppDelegate *)
//    [[UIApplication sharedApplication] delegate];
//    appDelegate.auth = nil;

    
    Signup *signup=[[Signup alloc]init];
   [signup call_logout];
    [signup call_logout_google];
    
    login_select=[[NSString alloc]init];
    sqlite3_stmt *stmt2;
    NSString *update;
    
    
    update=[[NSString alloc]initWithFormat:@"delete from login;"];
       
    NSLog(@"upadte:%@",update);
    int x = sqlite3_prepare_v2(database, [update UTF8String], -1, &stmt2, nil);
    NSLog(@"x=%d",x);
    if (sqlite3_step(stmt2) != SQLITE_DONE)
        NSLog(@"Deletion Error."); 
    sqlite3_finalize(stmt2);

    
    sqlite3_stmt *stmt3;
    NSString *update1;
    
    
    update1=[[NSString alloc]initWithFormat:@"delete from freinds_profile;"];
    
    NSLog(@"upadte:%@",update1);
    int x1 = sqlite3_prepare_v2(database, [update1 UTF8String], -1, &stmt3, nil);
    NSLog(@"x=%d",x1);
    if (sqlite3_step(stmt3) != SQLITE_DONE)
        NSLog(@"Deletion Error.");
    sqlite3_finalize(stmt3);


   // [self copy_viewdidload];
   [self performSelector:@selector(copy_viewdidload) withObject:nil afterDelay:1.0];
    [callMessageByTimer invalidate];
    
  
}


-(void)show_selfControl
{
    RootViewController *fav=[[RootViewController alloc]initWithNibName:@"RootViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:fav animated:NO];
    
    
}


-(void)logoutMenu:(id)sender
{
    UIButton *tappedButton2 = (UIButton*)sender;
	int logoutBtn = tappedButton2.tag;
    
    global_logout_string = [[NSString alloc]initWithFormat:@"%i",logoutBtn];

    
    [self performSelector:@selector(logoutDelay) withObject:nil afterDelay:1.0];
    
    
}

-(void)latiAndLongCalu
{
    CLLocation *location = [locationManager location];
    
    // Configure the new event with information from the location
    
    CLLocationCoordinate2D coordinate = [location coordinate];
    latitude = [NSMutableString stringWithFormat:@"%f", coordinate.latitude];
    longitude = [NSMutableString stringWithFormat:@"%f", coordinate.longitude];
    
    NSLog(@"LatitudeLogin : %@", latitude);
    NSLog(@"LongitudeLogin : %@",longitude);
    
    latitudeReplace = [[NSString alloc]init];
    longitudeReplace = [[NSString alloc]init];
    
    latitudeReplace = [latitude stringByReplacingOccurrencesOfString:@"." withString:@"_"];
    longitudeReplace = [longitude stringByReplacingOccurrencesOfString:@"." withString:@"_"];
    
    
    NSLog(@"LatitudeLoginReplace : %@", latitudeReplace);
    NSLog(@"LongitudeLoginReplace : %@",longitudeReplace);
    
    latitude_string = [[NSString alloc]initWithString:latitudeReplace];
    longitude_string= [[NSString alloc]initWithString:longitudeReplace];
    
    [self performSelector:@selector(Latitude_Longtude_service) withObject:nil afterDelay:5.0f];
    
   // [self performSelector:@selector(Latitude_Longtude_service) withObject:nil];
    
}

-(void)Latitude_Longtude_service
{
    NSString *Lati_long_str = [[NSString alloc]initWithFormat:@"http://192.168.0.111/DatingService/signup.svc/gprsinfo/%@/%@/%@",login_select,latitude_string,longitude_string];
    
    NSLog(@"Latitude_Longitude_Service:%@",Lati_long_str);
    
    NSMutableURLRequest *request =[[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:Lati_long_str]];
    
    NSData *returnData = [ NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil ];
    
    NSString *returnString = [[NSString alloc]initWithData:returnData encoding:NSUTF8StringEncoding];
    
    NSLog(@"returnString of lati_long:*%@*",returnString);
    
    
        
}



-(void)logoutDelay
{
  [self Logout:global_logout_string];  
}
-(void)after_parse
{


    
    
    
    
    
    
}
-(void)copy_viewdidload
{
    
    [thumb_scroll removeFromSuperview];
    thumb_scroll=[[UIScrollView alloc]init];
    [thumb_scroll setFrame:CGRectMake(0,77,320,294)];
    thumb_scroll.clipsToBounds = YES;
	thumb_scroll.delegate = self;
    [profile_view_list addSubview:thumb_scroll];
    
    
    [self performSelectorInBackground:@selector(call_logo_json) withObject:nil];
    [self performSelectorInBackground:@selector(call_logo_detail) withObject:nil];
    profile_tbl.hidden=YES;
    [self readlogin];
    if ([login_select isEqualToString:@"null"]||[login_select isEqualToString:@"(null)"]||[login_select isEqualToString:@""]||login_select ==Nil||login_select==NULL)
    {
        
        
        Signup_btn.hidden=NO;
        Login_btn.hidden=NO;
        Signup_btn1.hidden=YES;
        user_menu.hidden=YES;
        works_menu.hidden=YES;
        searchBar.hidden=YES;
        grid_btn1.hidden=YES;
        grid_btn2.hidden=NO;
        after_login_bool=FALSE;
        profile_tbl.tableHeaderView = nil;
        searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
        profile_tbl.frame=CGRectMake(2.0, 75.0, 320.0, 260.0);
        [self performSelectorInBackground:@selector(profile_json_call) withObject:nil ];
        
        
    }
    else 
    {
        
        Signup_btn.hidden=YES;
        Login_btn.hidden=YES;
        user_menu.hidden=NO;
        works_menu.hidden=NO;
        Signup_btn1.hidden=NO;
        searchBar.hidden=NO;
        grid_btn1.hidden=NO;
        grid_btn2.hidden=YES;
        profile_tbl.tableHeaderView = searchBar;
        searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
        profile_tbl.frame=CGRectMake(2.0, 75.0, 320.0, 252.0);
        after_login_bool=TRUE;
        [self performSelectorInBackground:@selector(after_login_json) withObject:nil];


    }
   
    
    
    //  [self profile_json_call];
    [self performSelectorInBackground:@selector(jsoncall) withObject:nil];
    search_done.hidden=YES;
    default_imageview.image=[UIImage imageNamed:@"bg_2.png"];
    header_image.hidden=YES;
    
    
    //[self performSelector:@selector(profile_json_call) withObject:nil afterDelay:3.0];
    
    
    //    [self performSelector:@selector(profile_json_call) withObject:nil afterDelay:3.0];
    //    
    
    
    // [self performSelector:@selector(dating_articles_call) withObject:nil afterDelay:3.0];
    
    
    [self show_view];
    
    
    
    //Add the search bar
  
   MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:profile_view_list animated:YES ];
    hud.labelText = @"Loading...";
    
    

}

-(IBAction)buttonTap:(id)sender
{
    
    UIButton *tappedButton = (UIButton*)sender;
	
	if([tappedButton.currentImage isEqual:[UIImage imageNamed:@"grid.png"]])
        // {
	{
        
		[grid_btn2 setImage:[UIImage imageNamed:@"list.png"] forState:UIControlStateNormal];
        [self show_grid];
	
	}
	
	else 
	{
		[grid_btn2 setImage:[UIImage imageNamed:@"grid.png"] forState:UIControlStateNormal];
        [self show_table];
		
        
	}
    
}

-(IBAction)buttonTap1:(id)sender
{


    UIButton *tappedButton = (UIButton*)sender;
	
	if([tappedButton.currentImage isEqual:[UIImage imageNamed:@"grid.png"]])
        // {
	{
        
		[grid_btn1 setImage:[UIImage imageNamed:@"list.png"] forState:UIControlStateNormal];
        [self show_grid];
        
	}
	
	else 
	{
		[grid_btn1 setImage:[UIImage imageNamed:@"grid.png"] forState:UIControlStateNormal];
        [self show_table];
		
        
	}




}

#pragma mark -
#pragma mark DDPageControl triggered actions

- (void)pageControlClicked:(id)sender
{
   
	DDPageControl *thePageControl = (DDPageControl *)sender ;
	
	// we need to scroll to the new index
	[scroll setContentOffset: CGPointMake(scroll.bounds.size.width * thePageControl.currentPage, scroll.contentOffset.y) animated: YES] ;
}


#pragma mark -
#pragma mark UIScrollView delegate methods

- (void)scrollViewDidScroll:(UIScrollView *)aScrollView
{
	CGFloat pageWidth = scroll.bounds.size.width ;
    float fractionalPage = scroll.contentOffset.x / pageWidth ;
	NSInteger nearestNumber = lround(fractionalPage) ;
	
	if (pageControl.currentPage != nearestNumber)
	{
		pageControl.currentPage = nearestNumber ;
		
		// if we are dragging, we want to update the page control directly during the drag
		if (scroll.dragging)
			[pageControl updateCurrentPageDisplay] ;
	}
    
        int i =pageControl.currentPage;
    NSLog(@"i:%d",i);
    pageview=pageControl.currentPage;
    
    
   }
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)aScrollView
{
	// if we are animating (triggered by clicking on the page control), we update the page control
	[pageControl updateCurrentPageDisplay] ;
    
    NSLog(@"display");
    
}
-(void)jsoncall
{

    @try
    {
      
        
        // NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
    NSString *str = [[NSString alloc]initWithFormat:@"http://192.168.0.111/DatingService/getDetails.svc/getPartnerContents/%@/2",global_partnerID_str];
    
    NSLog(@"str:%@",str);
    
    NSMutableURLRequest *request =[[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:str]];
    
    NSData *returnData = [ NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil ];
    
    NSString *returnString = [[NSString alloc]initWithData:returnData encoding:NSUTF8StringEncoding];
    
  //  NSLog(@"returnString:*%@*",returnString);
        if ([returnString isEqualToString:@""])
        {
            NSLog(@"terminater");
            [MBProgressHUD hideHUDForView:self.view animated:YES];

      }

        else
        {
    
    NSDictionary *dict=[returnString JSONValue];
            
            if (dict==nil||dict==NULL)
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"No Response From Server" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                [alert release];
            }
            
            
            else {
                
            
    for (NSDictionary *info in dict)
    {
        NSLog(@"info:%@",info);
        partner_str123 = [info objectForKey:@"partnerContent"];
            NSLog(@"partner_str123:%@",partner_str123);
        
           
 
    }
            }
    
                    [self performSelectorOnMainThread:@selector(display_json_call) withObject:nil waitUntilDone:YES];
              //  [self performSelector:@selector() withObject:<#(id)#> afterDelay:<#(NSTimeInterval)#>]

        
         //[pool release];
}
        
    }
    
    
    @catch (NSException *exception)
    {
        NSLog(@"main: Caught %@: %@", [exception name], [exception reason]);
    }

    
   // NSLog(@"dict1:%@",dict);
     //NSString *str=[dict objectFor]

//   
}
-(void)display_json_call
{

    
    if ([partner_str123 isEqualToString:@"(null)"]||[partner_str123 isEqualToString:@""]||partner_str123==nil||partner_str123==NULL)
    {
        
        txtview.text=@"Server problem";
    }
    else
    {
        txtview.text=partner_str123;

        
    }


  }
-(void)readlogin
{
    NSString *query = [[NSString alloc] initWithFormat:@"select * from login ORDER BY id DESC LIMIT 1;"];
	sqlite3_stmt *stmt;
	int w = sqlite3_prepare_v2(database,[query UTF8String],-1, &stmt, nil);
	if (w == SQLITE_OK)
	{
		// Loop through the results and add them to the feeds array
		while(sqlite3_step(stmt) == SQLITE_ROW)
		{
			NSString *loginstr = [[NSString alloc]initWithUTF8String:(char *)sqlite3_column_text(stmt, 1)];
            NSLog(@"loginstr:%@",loginstr);
            
            login_select=[[NSString alloc]initWithFormat:@"%@",loginstr];
            global_notification_mssg_str = [[NSString alloc]initWithString:login_select];
            NSLog(@"login_select:%@",login_select);
            
		}
        
        
	}
	sqlite3_finalize(stmt);
    
}
- (void)viewDidLoad
{
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
   //  [self readlogin];
     // activity =[[LabeledActivityIndicatorView alloc]initWithController:self andText:@"Processing..."];
    //spinny = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    

}


-(void)call_logo_json
{
    //NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];

    
    NSLog(@"global_partnerID_str:%@",global_partnerID_str);
    NSString *str_country = [[NSString alloc]initWithFormat:@"http://192.168.0.111/DatingService/getDetails.svc/getPartnerDetails/%@",global_partnerID_str];
    NSLog(@"str_country:%@",str_country);
    
    NSMutableURLRequest *request =[[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:str_country]];
    
    NSData *returnData = [ NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil ];
    
    NSString *returnString = [[NSString alloc]initWithData:returnData encoding:NSUTF8StringEncoding];
    
  //  NSLog(@"returnString:*%@*",returnString);
    if ([returnString isEqualToString:@""])
    {
        [MBProgressHUD hideHUDForView:self.view animated:YES];

    }
    
    else
    {
    
    NSDictionary *dict=[returnString JSONValue];
    NSLog(@"dict:%@",dict);
    
        if (dict==nil||dict==NULL)
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"No Response From Server" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
        
        
        else {
            for (NSDictionary *info in dict)
    {
        
        logo_string=[[NSString alloc]initWithFormat:@"%@",[info objectForKey:@"partnerWebsiteLogo"]];
        partnerWebsiteName_str = [[NSString alloc]initWithFormat:@"%@",[info objectForKey:@"partnerWebsiteName"]];
        
        NSLog(@"partnerWebsiteName str:%@",partnerWebsiteName_str);
    }
        
        lbl_partnerWebsiteName.text = partnerWebsiteName_str;
        
        
     //   NSRange match1 = [partnerWebsiteName_str rangeOfString:@"("];
       // NSRange match2 = [partnerWebsiteName_str rangeOfString:@")"];
        
      //  global_partner_websitename = [partnerWebsiteName_str substringWithRange:NSMakeRange(match1.location+1, match2.location-1)];

        
    
        global_partner_websitename = [[NSString alloc]initWithString:partnerWebsiteName_str];
        
        lbl_partnerwebnamelist.text = global_partner_websitename;
            
           //logo_string= @"websitelogo1_839535.gif";
    
    final_logo=[[NSString alloc]initWithFormat:@"http://192.168.0.111/Dating/Uploads/%@",logo_string];
    
 
    
         [self performSelectorOnMainThread:@selector(logo_load) withObject:nil waitUntilDone:YES];
    //[pool release];
    }
    }
}

-(void)logo_load
{

    [logoimageview setImageFromUrl:final_logo
                        completion:^(void)
     {}];

}

-(void)call_logo_detail
{
   // NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];



   partnercontent_arr=[[NSMutableArray alloc]init];
    
    NSString *str_country = [[NSString alloc]initWithFormat:@"http://192.168.0.111/DatingService/getDetails.svc/getPartnerContents/%@/1",global_partnerID_str];
 //  NSLog(@"str_country:%@",str_country);
    
    NSMutableURLRequest *request =[[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:str_country]];
    
    NSData *returnData = [ NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil ];
    
    NSString *returnString = [[NSString alloc]initWithData:returnData encoding:NSUTF8StringEncoding];
    
   // NSLog(@"returnString:*%@*",returnString);
    
   
    NSDictionary *dict=[returnString JSONValue];
  //  NSLog(@"dict:%@",dict);
    if (dict==nil||dict==NULL)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"No Response From Server" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    
    
    else {
        
    
    for (NSDictionary *info in dict)
    {
        NSString *pid=[[NSString alloc]initWithFormat:@"%@",[info objectForKey:@"partnerContent"]];
        partner_string=[[NSString alloc]initWithFormat:@"%@",pid];
             // NSLog(@"parteberewq:%@",partnercontent_arr);
        
        
              
        
    }
    
    }
    
    if ([partner_string isEqualToString:@""]||[partner_string isEqualToString:@"<null>"]||[partner_string isEqualToString:@"null"]||[partner_string isEqualToString:@"(null)"]||partner_string ==nil||partner_string==NULL)
    { [MBProgressHUD hideHUDForView:self.view animated:YES];
        partner_string=@"Not available";
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Not available" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//        [alert release];
        
    }
    
    else
    {
       // partner_string=@"Not available";
    }
    
    
    
     [self performSelectorOnMainThread:@selector(home_load) withObject:nil waitUntilDone:YES];
    //[pool release];
    
    

    
}

-(void)home_load
{
 partner_txtview.text=partner_string;

}
/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
 
        if (searching)
            return 1;
        else
            return 1;
   
   	}
*/
- (IBAction)notificationButtonClick:(id)sender {
    
    
}

-(IBAction)dating_list_back
{
    
    CGRect frame = dating_articles_view.frame;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    frame.origin.x =961;
    frame.origin.y =0;
    dating_articles_view.frame = frame;
    [UIView commitAnimations];



}
-(IBAction)upload
{
    /*
     http:\/\/herbalist.com\/images\/image\/thumb\/phpxr.jpg
     */
    
    NSString *str_country = [[NSString alloc]initWithFormat:@"https://herbalist.com/api/directory?zip=80302&name=ACUPUNCTURE"];
    NSLog(@"str_country:%@",str_country);
    
    NSMutableURLRequest *request =[[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:str_country]];
    
    [request setValue:@"5644b3fe6e278b8e9ffa860f3f636094" forHTTPHeaderField:@"API_KEY"];
    
    NSData *returnData = [ NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil ];
    
    NSString *returnString = [[NSString alloc]initWithData:returnData encoding:NSUTF8StringEncoding];
    
    NSLog(@"returnString:*%@*",returnString);

    
     }

 

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
	
	
	NSLog(@"response:%@",response);
	
}


- (void)requestFinished:(ASIHTTPRequest *)request
{    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if (request.responseStatusCode == 400) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Sign up failed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
    } else if (request.responseStatusCode == 403) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Sign up failed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    } else if (request.responseStatusCode == 200) {
        
        @try{
        /*
        name_arr=[[NSMutableArray alloc]init];
        image_arr=[[NSMutableArray alloc]init];
        age_arr=[[NSMutableArray alloc]init];
        id_arr=[[NSMutableArray alloc]init];
        gender_arr=[[NSMutableArray alloc]init];
        race_arr=[[NSMutableArray alloc]init];
        gender_image_arr=[[NSMutableArray alloc]init];
        final_img_arr=[[NSMutableArray alloc]init];
        
        id_list_items= [[NSMutableArray alloc] init];
        gender_list_items=[[NSMutableArray alloc] init];
        race_list_items=[[NSMutableArray alloc] init];
        image_list_items=[[NSMutableArray alloc] init];
        name_list_items=[[NSMutableArray alloc] init];
        age_list_items=[[NSMutableArray alloc] init];

       responseString_login = [request responseString];
        if (after_login_bool==TRUE)
        {
            if ([responseString_login isEqualToString:@""])
            {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                
            }
            else
            {
            NSDictionary *responseDict = [responseString_login JSONValue];
            for (NSDictionary *info in responseDict)
            {

                id_string=[info objectForKey:@"userID"];
                [id_arr addObject:id_string];
                NSLog(@"id_str:*%@*",id_string);
                
                name_string=[info objectForKey:@"userName"];
                [name_arr addObject:name_string];
               // NSLog(@"name_arr:%@",name_arr);
                
                age_string=[[NSString alloc]initWithFormat:@"%@",[info objectForKey:@"age"]];
                
                if ([age_string isEqualToString:@"(null)"]||[age_string isEqualToString:@""]||[age_string isEqualToString:@"<null>"]||[age_string isEqualToString:@"null"]||age_string==nil||age_string==NULL)
                    
                {
                    age_string=[[NSString alloc]initWithFormat:@"NA"];
                    
                }
                
                [age_arr addObject:age_string];
                
                gender_string=[[NSString alloc]initWithFormat:@"%@",[info objectForKey:@"isMale"]];
                [gender_arr addObject:gender_string];
               // NSLog(@"name_arr:%@",gender_arr);
                
                race_string=[info objectForKey:@"Ethnicity"];
                
                if (race_string == (NSString*)[NSNull null])
                    
                {
                    race_string=@"Not available";
                    
                }
                
                [race_arr addObject:race_string];
               // NSLog(@"name_arr:%@",race_arr);
                
                
                image_string=[info objectForKey:@"userFileURL"];
                
                [gender_image_arr addObject:image_string];
                
            }
            
            
            
            for (int i=0; i<[gender_image_arr count]; i++)
            {
                
                NSString *string_final=[[NSString alloc]initWithFormat:@"%@",[gender_image_arr objectAtIndex:i]];
                
                
                string_final=[string_final stringByReplacingOccurrencesOfString:@" " withString:@""];
                
                
                if ([string_final isEqualToString:@"male_icon.png"]||[string_final isEqual:@"profile_pic.png"])
                {
                    if ([gender_string isEqualToString:@"0"])
                    {
                        new_image_string=[[NSString alloc]initWithFormat:@"http://192.168.0.111/Dating/images/NoPhotoFemale.jpg"];
                    }
                    else
                    {
                        new_image_string=[[NSString alloc]initWithFormat:@"http://192.168.0.111/Dating/images/NoPhotoMale.jpg"];
                    }
                    
                    
                }
                
                else
                {
                    NSString *str_image_url_1 = [[NSString alloc]initWithFormat:@"http://192.168.0.111/Dating/Uploads/"];
                    
                    new_image_string =[[NSString alloc]initWithFormat:@"%@",[str_image_url_1 stringByAppendingString:string_final]];
                    
                    
                    
                    new_image_string=[new_image_string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    
                    
                }
                
                
                [final_img_arr addObject:new_image_string];
               // NSLog(@"final_gifts_arr:%@",final_img_arr);
                
                
                
            }
                
            }
            
            //[self performSelectorOnMainThread:@selector(display_profile) withObject:nil waitUntilDone:YES];
            
        }
        else
        {
        }
         */
        }@catch (NSException *e) {
            NSLog(@"ExceptionRoot:%@",e);
        }
      //  NSLog(@"responseString:%@",responseString_login);
       // NSDictionary *responseDict = [responseString_login JSONValue];
       // NSLog(@"responseDict:%@",responseDict);
     //   NSString *unlockCode = [responseDict objectForKey:@"unlock_code"];
        
//        if ([unlockCode compare:@"com.razeware.test.unlock.cake"] == NSOrderedSame)
//        {
//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Thank You For Signing Up!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//            [alert show];
//            [alert release];
//            
//        }
//        else
//        {
//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Sign up failed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//            [alert show];
//            [alert release];
//            
//        }
        
    } else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Sign up failed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    NSLog(@"scroll lati 12");
    //if (searching)
    //return 1;
    //else
    return 1;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
   // if (searching)
     //   return [name_list_items count];
    //else
        
        return [name_arr count];
    
    
    }

    

  
 
       


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   
    Friend_cell *cell1;
      
              static NSString *cellIdentifier1 = @"cellIdentifier";
         
         cell1 = (Friend_cell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
         if (cell1 == nil)
         {
             NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Friend_cell"
                                                          owner:self options:nil];
             for (id oneObject in nib) if ([oneObject isKindOfClass:[Friend_cell class]])
                 cell1 = (Friend_cell *)oneObject;
             
             cell1.selectionStyle = UITableViewCellSelectionStyleNone;

         }	   cell1.profile_img.clipsToBounds = YES;
              cell1.profile_img.layer.cornerRadius=10.0;
              //cell1.profile_img.layer.borderColor = [UIColor cyanColor].CGColor;
              cell1.profile_img.layer.borderWidth = 1.0;
             
        /*
         if(searching)
         {
             NSString *str_dis=[[NSString alloc]initWithString:@""];
             cell1.lbl1.text = [name_list_items objectAtIndex:indexPath.row];
             
             cell1.lbl2.text=[age_list_items objectAtIndex:[indexPath row]];
              cell1.distanceShow_lbl.text=str_dis;
             
             
             NSString *gender_image_string=[[NSString alloc]initWithFormat:@"%@",[gender_list_items objectAtIndex:[indexPath row]]];
             
             
             if ([gender_image_string isEqualToString:@"0"])
             {
                 //str_profile_image=[[NSString alloc]initWithFormat:@"http://192.168.0.111/Dating/images/NoPhotoFemale.jpg"];
                 cell1.gender_image.image=[UIImage imageNamed:@"female_icon.png"];
              
                 
             }
            
             else
             {
                 //str_profile_image=[[NSString alloc]initWithFormat:@"http://192.168.0.111/Dating/images/NoPhotoMale.jpg"];
                 cell1.gender_image.image=[UIImage imageNamed:@"male_icon.png"];
             }
             urlString1 = [NSString stringWithFormat:@"%@",[image_list_items objectAtIndex:[indexPath row]]];
             


           
             
            // NSURL *url1 = [NSURL URLWithString:urlString1];
             
             AsyncImageView1 *imgPhoto = [[AsyncImageView1 alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 57.0f, 55.0f)];
             imgPhoto.layer.masksToBounds = YES;
             imgPhoto.layer.cornerRadius = 10.0;
             imgPhoto.contentMode = UIViewContentModeScaleAspectFill;
             imgPhoto.clipsToBounds = YES;
             imgPhoto.tag = ASYNC_IMAGE_TAG;
             [cell1.profile_img  addSubview:imgPhoto];
          

            // imgPhoto.layer.cornerRadius = 9;
             
             
                  
             
             AsyncImageView1 *imageView1 = (AsyncImageView1 *)[cell1 viewWithTag:ASYNC_IMAGE_TAG];
             imageView1.layer.masksToBounds = YES;
            // imageView1.layer.cornerRadius =10.0;
             //cancel loading previous image for cell
             [[AsyncImageLoader sharedLoader] cancelLoadingURL:imageView1.imageURL];
             imageView1.imageURL = [NSURL URLWithString:urlString1]; 
             
             
             NSString *race_str=[[NSString alloc]initWithFormat:@"%@",[race_list_items objectAtIndex:[indexPath row]]];
             
             if ([race_str isEqualToString:@"Not available"])
             {
                 cell1.ethinicity_lbl.hidden=YES;
             }
             
             else
             { 
                 cell1.ethinicity_lbl.hidden=NO;
                  cell1.ethinicity_lbl.text=[race_list_items objectAtIndex:[indexPath row]];
             }
             
            
         }
         
         else 
             
         {
         */
             NSString *str_dist=[[NSString alloc]initWithString:@""];;
             
             //First get the dictionary object
             cell1.lbl1.text=[name_arr objectAtIndex:[indexPath row]];
             
             cell1.lbl2.text=[age_arr objectAtIndex:[indexPath row]];
             cell1.distanceShow_lbl.text=str_dist;
             
             
            NSString *gender_image_string=[[NSString alloc]initWithFormat:@"%@",[gender_arr objectAtIndex:[indexPath row]]];
//             
             if ([gender_image_string isEqualToString:@"0"])
             {
                 //str_profile_image=[[NSString alloc]initWithFormat:@"http://192.168.0.111/Dating/images/NoPhotoFemale.jpg"];
                 cell1.gender_image.image=[UIImage imageNamed:@"female_icon.png"];
                 cell1.profile_img.layer.borderColor = [UIColor colorWithRed:245/255.0 green:61/255.0 blue:165/255.0 alpha:1].CGColor;
                // cell1.profile_img.layer.borderColor =[UIColor magentaColor].CGColor;               //[UIColor ].CGColor;
                 
             }
             
             else
             {
                 //str_profile_image=[[NSString alloc]initWithFormat:@"http://192.168.0.111/Dating/images/NoPhotoMale.jpg"];
                 cell1.gender_image.image=[UIImage imageNamed:@"male_icon.png"];
                 cell1.profile_img.layer.borderColor = [UIColor colorWithRed:50/255.0 green:237/255.0 blue:250/255.0 alpha:1].CGColor;
                 //cell1.profile_img.layer.borderColor = [UIColor blueColor].CGColor;
             }
             
             urlString1 = [NSString stringWithFormat:@"%@",[final_img_arr objectAtIndex:[indexPath row]]];
             
     

             
//             if ([urlString1 isEqualToString:@"http://192.168.0.111/Dating/Uploads/male_icon.png"])
//             {
//                 if ([gender_image_string isEqualToString:@"1"])
//                     
//                 {
//                     urlString1=[[NSString alloc]initWithFormat:@"http://192.168.0.111/Dating/images/NoPhotoFemale.jpg"];
//                 }
//                 
//                 
//                 else 
//                 {
//                     urlString1=[[NSString alloc]initWithFormat:@"http://192.168.0.111/Dating/images/NoPhotoMale.jpg"];
//                 }
//
//             }
//             
//             else
//             {
//                 
                // NSURL *url1 = [NSURL URLWithString:urlString1];
                 
                 //=======
                 
                 AsyncImageView1 *imgPhoto = [[AsyncImageView1 alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 57.0f, 55.0f)];
                 imgPhoto.contentMode = UIViewContentModeScaleAspectFill;
                
                imgPhoto.layer.masksToBounds = YES;
                imgPhoto.layer.cornerRadius = 10.0;
                 imgPhoto.tag = ASYNC_IMAGE_TAG;
                 [cell1.profile_img addSubview:imgPhoto];
                 // imgPhoto.layer.cornerRadius = 9;
                 
                 
    
                 
                 AsyncImageView1 *imageView1 = (AsyncImageView1 *)[cell1 viewWithTag:ASYNC_IMAGE_TAG];
                 //cancel loading previous image for cell
                 [[AsyncImageLoader sharedLoader] cancelLoadingURL:imageView1.imageURL];
                 imageView1.imageURL = [NSURL URLWithString:urlString1];
            
                       
  
             NSString *race_str=[[NSString alloc]initWithFormat:@"%@",[race_arr objectAtIndex:[indexPath row]]];
             
             if ([race_str isEqualToString:@"Not available"] || [race_str isEqualToString:@"<null>"])
             {
                 cell1.ethinicity_lbl.hidden=YES;
                 //cell1.ethinicity_lbl.text= race_str;
             }
             
             else
             { 
                 cell1.ethinicity_lbl.hidden=NO;
                 //cell1.ethinicity_lbl.text= race_str;    //[race_arr objectAtIndex:[indexPath row]];
             }
             
             
             cell1.ethinicity_lbl.text= race_str;
         //}
         

         
    
   

    
   return cell1;
    
    
    
    
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self iconpicselect:nil];
   /*
    Friend_cell *cell2 = [[Friend_cell alloc]init];
    
    NSString *gender_image_string=[[NSString alloc]initWithFormat:@"%@",[gender_arr objectAtIndex:[indexPath row]]];
    //
    if ([gender_image_string isEqualToString:@"0"])
    {
        
        cell2.profile_img.layer.borderColor =[UIColor magentaColor].CGColor;               //[UIColor ].CGColor;
        
    }
    
    else
    {
        
        cell2.profile_img.layer.borderColor = [UIColor blueColor].CGColor;
    }
    */

    
    
    
    
    
    
    
    
    
    /*
    
    if ([login_select isEqualToString:@"null"]||[login_select isEqualToString:@"(null)"]||[login_select isEqualToString:@""]||login_select ==Nil||login_select==NULL)
    {
    }
    else
    {
        if (tableView==profile_tbl)
        {
            view_profile_bool=TRUE;
            
            
            if(searching)
            {
                
                
               global_string=[[NSString alloc]initWithFormat:@"%@",[id_list_items objectAtIndex:[indexPath row]]];
                
                NSLog(@"global_string:%@",global_string);
                
          Profile_view *preview=[[Profile_view alloc]initWithNibName:@"Profile_view" bundle:[NSBundle mainBundle]];
            [self.navigationController pushViewController:preview animated:NO];

                
            }
            else
                
            {
                 global_string=[[NSString alloc]initWithFormat:@"%@",[id_arr objectAtIndex:[indexPath row]]];
                //First get the dictionary object
                              
                NSLog(@"global_string:%@",global_string);
             Profile_view *preview=[[Profile_view alloc]initWithNibName:@"Profile_view" bundle:[NSBundle mainBundle]];
                            [self.navigationController pushViewController:preview animated:NO];

            }

            
            
            
           
            
//            Profile_view *preview=[[Profile_view alloc]initWithNibName:@"Profile_view" bundle:[NSBundle mainBundle]];
//            [self.navigationController pushViewController:preview animated:NO];
            
        }
        else if (tableView==tblview)
            
        {
            
            
            CGRect frame = dating_articles_view.frame;
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.5];
            frame.origin.x =0;
            frame.origin.y =0;
            dating_articles_view.frame = frame;
            [UIView commitAnimations];
            
            
            MBProgressHUD *hud1 = [MBProgressHUD showHUDAddedTo:dating_articles_view animated:YES];
            hud1.labelText = @"Loading...";
            
            
            partener_str=[[NSString alloc]initWithFormat:@"%@",[partenercontent_id_arr objectAtIndex:[indexPath row]]];
            
            [self performSelector:@selector(dating_articles_detail) withObject:nil afterDelay:1.0];
            
            
        }
        
       
    }
    

    */
       
}

#pragma mark Search Bar 

- (void) searchBarTextDidBeginEditing:(UISearchBar *)theSearchBar {
	
    
   // [self readlogin];
    if ([login_select isEqualToString:@"null"]||[login_select isEqualToString:@"(null)"]||[login_select isEqualToString:@""]||login_select ==Nil||login_select==NULL)
    {

        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"You need to login first to search" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];

    }
    else 
    {
        search_done.hidden=NO;
        //This method is called again when the user clicks back from teh detail view.
        //So the overlay is displayed on the results, which is something we do not want to happen.
        if(searching)
            return;
        
        //Add the overlay view.
        //	if(ovController == nil)
        //		ovController = [[OverlayViewController alloc] initWithNibName:@"OverlayView" bundle:[NSBundle mainBundle]];
        
        //	CGFloat yaxis = self.navigationController.navigationBar.frame.size.height;
        //	CGFloat width = self.view.frame.size.width;
        //	CGFloat height = self.view.frame.size.height;
        
        //Parameters x = origion on x-axis, y = origon on y-axis.
        //	CGRect frame = CGRectMake(0, yaxis, width, height);
        //	ovController.view.frame = frame;	
        //	ovController.view.backgroundColor = [UIColor grayColor];
        //	ovController.view.alpha = 0.5;
        //	
        //	ovController.rvController = self;
        //	
        //	[self.tableView insertSubview:ovController.view aboveSubview:self.parentViewController.view];
        
        searching = NO;
        letUserSelectRow = NO;
        profile_tbl.scrollEnabled = NO;
        

    }
    
   	//Add the done button.
    //	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] 
    											//   initWithBarButtonSystemItem:/UIBarButtonSystemItemDone 
    											//   target:self action:@selector(doneSearching_Clicked:)] autorelease];
}

- (void)searchBar:(UISearchBar *)theSearchBar textDidChange:(NSString *)searchText {
    
	//Remove all objects first.
    
    [id_list_items removeAllObjects];
    [gender_list_items removeAllObjects];
    [race_list_items removeAllObjects];
    [image_list_items removeAllObjects];
    [name_list_items removeAllObjects];
    [age_list_items removeAllObjects];
     
	if([searchText length] > 0) {
		
		
		searching = YES;
		letUserSelectRow = YES;
		profile_tbl.scrollEnabled = YES;
		[self searchTableView];
	}
	else {
		
        //		[self.tableView insertSubview:ovController.view aboveSubview:self.parentViewController.view];
		
		searching = NO;
		letUserSelectRow = NO;
		profile_tbl.scrollEnabled = NO;
	[self searchBarSearchButtonClicked:nil ];
    }
    
	
	[profile_tbl reloadData];
}
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar1
{
    [searchBar resignFirstResponder];
    return YES;

}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar1
{
  [searchBar resignFirstResponder];
    [self doneSearching_Clicked:nil];

}
- (void) searchBarSearchButtonClicked:(UISearchBar *)theSearchBar {
	
	//[self searchTableView];
    [searchBar resignFirstResponder];

}

- (void) searchTableView {
/*
	
	NSMutableArray *searchArray = [[NSMutableArray alloc] init];
	NSMutableArray *Search1 = [[NSMutableArray alloc] init];

    
	for (NSDictionary *dictionary in listOfItems)
	{
		NSArray *array = [dictionary objectForKey:@"name"];
		[searchArray addObjectsFromArray:array];
  
	}
	
	for (NSString *sTemp in searchArray)
	{
		NSRange titleResultsRange = [sTemp rangeOfString:searchText options:NSCaseInsensitiveSearch];
		
		if (titleResultsRange.length > 0)
			[copyListOfItems addObject:sTemp];
	}
    
   	
    
    
    for (int i=0;i<[copyListOfItems count];i++)
    {
        NSString *string_copy=[[NSString alloc]initWithFormat:@"%@",[copyListOfItems objectAtIndex:i]];
        
        NSInteger int_copy =[copyListOfItems indexOfObject:string_copy];
        
        
        NSString *fetch_id=[[NSString alloc]initWithFormat:@"%@",[id_arr objectAtIndex:int_copy]];
        
        
        [copy_items addObject:fetch_id];
        
        
    }
    NSLog(@"asaksdjakjd:%@",copy_items);
    
	[searchArray release];
	searchArray = nil;
    [Search1 release];

    Search1=nil;
    */
    
    
  NSString *searchText = searchBar.text;
    //for (NSString *sTemp in playemailarr)
    for (int i=0; i<[name_arr count]; i++)
    {
        NSString *sTemp = [name_arr objectAtIndex:i];
        NSString *sTempId = [id_arr objectAtIndex:i];
        NSString *sTempage = [age_arr objectAtIndex:i];
          NSString *sTempimage = [final_img_arr objectAtIndex:i];
         NSString*sTemprace= [race_arr objectAtIndex:i];
           NSString*sTempgender= [gender_arr objectAtIndex:i];
        
        NSRange titleResultsRange = [sTemp rangeOfString:searchText options:NSCaseInsensitiveSearch];
        if (titleResultsRange.length > 0)
        {
            [name_list_items addObject:sTemp];
            [image_list_items addObject:sTempimage];
            [id_list_items addObject:sTempId];
             [age_list_items addObject:sTempage];
             [race_list_items addObject:sTemprace];
             [gender_list_items addObject:sTempgender];
        }
    }
    [profile_tbl reloadData];
    NSLog(@"image_list_items:%@",image_list_items);

}

- (void) doneSearching_Clicked:(id)sender {
	
	//searchBar.text = @"";
	[searchBar resignFirstResponder];
	
	letUserSelectRow = YES;
	searching = NO;
	self.navigationItem.rightBarButtonItem = nil;
	profile_tbl.scrollEnabled = YES;
	
    //	[ovController.view removeFromSuperview];
    //	[ovController release];
    //	ovController = nil;
	
	[profile_tbl reloadData];
    
    search_done.hidden=YES;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
        return 63;
  
	
}
-(IBAction)login
{

    
    Login *preview=[[Login alloc]initWithNibName:@"Login" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:preview animated:NO];
    


}
-(IBAction)sign_check
{





}
-(IBAction)Signip
{
       


    sign_in_bool=TRUE;
    edit_bool=FALSE;
    
//    Class nibClass = NSClassFromString(kNibNames[0]);
//    UIViewController *controller =
//    [[[nibClass alloc] initWithNibName:nil bundle:nil] autorelease];
//    controller.navigationItem.title = kMenuOptions[0];
//    
//    [self.navigationController pushViewController:controller animated:YES];
    
//    GooglePlusSampleSignInViewController *preview=[[GooglePlusSampleSignInViewController alloc]initWithNibName:@"GooglePlusSampleSignInViewController" bundle:[NSBundle mainBundle]];
//    [self.navigationController pushViewController:preview animated:YES];


    
    
    Signup *preview=[[Signup alloc]initWithNibName:@"Signup" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:preview animated:YES];
    
    
    
    
    

    
}

-(void)profile_json_call
{
    @try
    {
    
    name_arr=[[NSMutableArray alloc]init];
       // image_arr=[[NSMutableArray alloc]init];
    age_arr=[[NSMutableArray alloc]init];
    id_arr=[[NSMutableArray alloc]init];
    gender_arr=[[NSMutableArray alloc]init];
    race_arr=[[NSMutableArray alloc]init];
    gender_image_arr=[[NSMutableArray alloc]init];
    final_img_arr=[[NSMutableArray alloc]init];
        
        id_list_items= [[NSMutableArray alloc] init];
        gender_list_items=[[NSMutableArray alloc] init];
        race_list_items=[[NSMutableArray alloc] init];
        image_list_items=[[NSMutableArray alloc] init];
        name_list_items=[[NSMutableArray alloc] init];
        age_list_items=[[NSMutableArray alloc] init];

        
        
    //  NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];

     //[activity show];
  // http://192.168.0.111/Dating/Uploads/2_572216_datee_TN.jpg
    
   
    NSString *str_country = [[NSString alloc ]initWithString:@"http://192.168.0.111/DatingService/getDetails.svc/scrollGallery/"];
    
    NSLog(@"str_country:%@",str_country);
    
    NSMutableURLRequest *request =[[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:str_country]];
    
    NSData *returnData = [ NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil ];
    
    NSString *returnString = [[NSString alloc]initWithData:returnData encoding:NSUTF8StringEncoding];
    
 //   NSLog(@"returnString:*%@*",returnString);
    
        if ([returnString isEqualToString:@""])
        {
            [MBProgressHUD hideHUDForView:self.view animated:YES];

        }
    else
    {
    NSDictionary *dict=[returnString JSONValue];
    
        if (dict==nil||dict==NULL)
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"No Response From Server" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
        
        
        else {
            
    NSDictionary *str123 = [dict objectForKey:@"scrollGalleryResult"];
    NSLog(@"str123:%@",str123);
    
    for (NSDictionary *info in str123)
    {
             
       // NSLog(@"info:%@",info);
        
        id_string=[info objectForKey:@"userID"];
        [id_arr addObject:id_string];
       // NSLog(@"id_str:*%@*",id_string);
        
        name_string=[info objectForKey:@"userName"];
        [name_arr addObject:name_string];
       // NSLog(@"name_arr:%@",name_arr);
        
        age_string=[[NSString alloc]initWithFormat:@"%@",[info objectForKey:@"age"]];
        
          if ([age_string isEqualToString:@"<null>"])
        
          {
              age_string=[[NSString alloc]initWithFormat:@"NA"];
          
          }
        
         [age_arr addObject:age_string];
      
        gender_string=[[NSString alloc]initWithFormat:@"%@",[info objectForKey:@"isMale"]];
        [gender_arr addObject:gender_string];
      //  NSLog(@"name_arr:%@",gender_arr);
              
        race_string=[info objectForKey:@"Ethnicity"];
        
        if (race_string == (NSString*)[NSNull null] ||race_arr == NULL)
            
        {
            race_string=@"Not available";
            
        }

        [race_arr addObject:race_string];
       // NSLog(@"name_arr:%@",race_arr);
        
        
        image_string=[info objectForKey:@"userFileURL"];
        
        
        
        [gender_image_arr addObject:image_string];
        
              //Set the title
        //self.navigationItem.title = @"Countries";
        
        //Add the search bar
//        profile_tbl.tableHeaderView = searchBar;
//        searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
//        
//        searching = NO;
//        letUserSelectRow = YES;
        
    }
        
    
    
    
    for (int i=0; i<[gender_image_arr count]; i++)
    {
        
        
       // NSLog(@"dfsjfssadfa:%d",[gender_image_arr count]);
        NSString *string_final=[[NSString alloc]initWithFormat:@"%@",[gender_image_arr objectAtIndex:i]];
        
        NSString *value = [string_final substringWithRange:NSMakeRange(0, 4)];
        
        string_final=[string_final stringByReplacingOccurrencesOfString:@"<null>" withString:@""];
        
        NSString *genderCheck = [[NSString alloc]initWithFormat:@"%@",[gender_arr objectAtIndex:i]];
        NSLog(@"genderCheck:%@",genderCheck);
       // NSLog(@"lastPathcom:%@",[string_final lastPathComponent]);
        if ([string_final isEqualToString:@"male_icon.png"]||[string_final isEqual:@"profile_pic.png"]||[string_final isEqualToString:@"<null>"]||[string_final isEqualToString:@""])
        {
            if ([genderCheck isEqualToString:@"0"])
            {
                
                 new_image_string=[[NSString alloc]initWithFormat:@"http://192.168.0.111/Dating/images/NoPhotoFemale.jpg"]; 
            }
            else if([genderCheck isEqualToString:@"1"])
            {
                
                 new_image_string=[[NSString alloc]initWithFormat:@"http://192.168.0.111/Dating/images/NoPhotoMale.jpg"]; 
            }
            [final_img_arr addObject:new_image_string];
           
        }else
            if ([value isEqualToString:@"http"]) {
                
                [final_img_arr addObject:string_final];
                NSLog(@"socialUrl:%@",value);
                
            }
        
        else
        {
            
            NSString *str_image_url_1 = [[NSString alloc]initWithFormat:@"http://192.168.0.111/Dating/Uploads/"];
            
            new_image_string =[[NSString alloc]initWithFormat:@"%@",[str_image_url_1 stringByAppendingString:string_final]];
            
         
            
            new_image_string=[new_image_string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [final_img_arr addObject:new_image_string];
           
       
        NSLog(@"final_gifts_arr:%@",new_image_string);
        }
        

        
       
        
      
            
    }

        
                
        
        
        [profile_tbl reloadData];
        
        
        
       // [self performSelectorOnMainThread:@selector(display_profile) withObject:nil waitUntilDone:YES];
        
        [self performSelector:@selector(display_profile) withObject:nil afterDelay:1.0];
        
        //if([final_img_arr count]!=0){
        
        //[self performSelector:@selector(display_profile)];
        //}
        //[self performSelector:@selector(display_profile) withObject:nil afterDelay:0.5];
        
           
    
    }
    
    
    if ([name_string isEqualToString:@"(null)"]||[name_string isEqualToString:@""]||name_string==nil||name_string==NULL)
    {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Not Available" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
    }
    else
    {
        
             
        
        
    }
    
    
    }
          //[pool release];
    }
    @catch (NSException *exception)
    {
        NSLog(@"main: Caught %@: %@", [exception name], [exception reason]);
    }
    

}
/*
-(void)loadtbl
{
    [MBProgressHUD hideHUDForView:profile_view_list animated:YES];
  
}
*/
-(void)show_table
{

    profile_tbl.hidden=NO;
    thumb_scroll.hidden=YES;
    
}
-(void)show_grid
{
    
    profile_tbl.hidden=YES;
    thumb_scroll.hidden=NO;

}
-(void)display_profile
{
    
    
    
 [MBProgressHUD hideHUDForView:profile_view_list animated:YES];
    
    [profile_tbl reloadData];
   
    @try{
    NSLog(@"Name Arry Count:%d",[name_arr count]);
    int var1 = [final_img_arr count];
    
    NSLog(@"count:%d",[final_img_arr count]);
    NSLog(@"count_var:%d",var1);
    
    int var2= [name_arr count];
    int count=0;
	int offset1 =1;
    
    int x,y=3;
    if([name_arr count]!=0){
        
    for (int row =0;row<var2;row++)
    {
        NSLog(@"row:%d",row);
        x=2;
        // offset1=1;
        NSLog(@"x:%d",x);
        
        for (int col = 0; col<4;col++)
        {
           NSLog(@"col:%d",col);
            if(count<var2)
            {
				
                NSLog(@"y:%d",y);
                
                
                NSString *str_lbl=[[NSString alloc]initWithFormat:@"%@",[name_arr objectAtIndex:count]];
                
                
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake(x, y, 75, 80);
				btn.backgroundColor=[UIColor clearColor];
                //btn.layer.borderColor = [UIColor blueColor].CGColor;
                //btn.layer.borderWidth = 1.0;
                
                // [self readlogin];
                if ([login_select isEqualToString:@"null"]||[login_select isEqualToString:@"(null)"]||[login_select isEqualToString:@""]||login_select ==Nil||login_select==NULL)
                {
                   
                    
                    NSLog(@"login_select:%@",login_select);
                    [btn addTarget:self action:@selector(iconpicselect:) forControlEvents:UIControlEventTouchUpInside];
                
                
                }
                else
                {
                    
                    [btn addTarget:self action:@selector(iconselect:) forControlEvents:UIControlEventTouchUpInside];
                
                }
                
				      
                [thumb_scroll addSubview:btn];
				btn.tag =count;
                
                
                @try{
                    
                    
                AsyncImageView1 *imgPhoto = [[AsyncImageView1 alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 75.0f, 80.0f)];
                imgPhoto.contentMode = UIViewContentModeScaleAspectFill;
                imgPhoto.clipsToBounds = YES;
                   // imgPhoto.layer.borderColor = [UIColor magentaColor].CGColor;
                imgPhoto.tag = ASYNC_IMAGE_TAG;
                    
                    NSString *gender_image_str=[[NSString alloc]initWithFormat:@"%@",[gender_arr objectAtIndex:count]];
                    
                    if ([gender_image_str isEqualToString:@"0"])
                    {
                        NSLog(@"entered in girls");
                        imgPhoto.layer.borderColor = [UIColor colorWithRed:245/255.0 green:61/255.0 blue:165/255.0 alpha:1].CGColor;
                       // imgPhoto.layer.borderColor =[UIColor magentaColor].CGColor;
                        imgPhoto.layer.borderWidth =1.0;
                    }
                    
                    else
                    {
                        NSLog(@"Entered in boys");
                        //imgPhoto.layer.borderColor = [UIColor blueColor].CGColor;
                        imgPhoto.layer.borderColor = [UIColor colorWithRed:50/255.0 green:237/255.0 blue:250/255.0 alpha:1].CGColor;
                        imgPhoto.layer.borderWidth = 1.0;
                        //imgPhoto.layer.borderColor = [UIColor].CGColor;
                    }

                [btn addSubview:imgPhoto];
                    
                
                AsyncImageView1 *imageView1 = (AsyncImageView1 *)[btn viewWithTag:ASYNC_IMAGE_TAG];

                //cancel loading previous image for cell
                    
                [[AsyncImageLoader sharedLoader] cancelLoadingURL:imageView1.imageURL];
                    
                imageView1.imageURL = [NSURL URLWithString:[final_img_arr objectAtIndex:count]];
               
                
                lbl_image=[[UIImageView alloc]initWithFrame:CGRectMake(x, y+67, 75, 13)];
                lbl_image.image=[UIImage imageNamed:@"title_bg.png"];
                
                
                    
                [thumb_scroll addSubview:lbl_image];
                
                
                UILabel *dateLbl = [[UILabel alloc]initWithFrame:CGRectMake(x,y+65,75,13)];
                dateLbl.text = str_lbl;
                dateLbl.backgroundColor = [UIColor clearColor];
              //  dateLbl.font = [UIFont systemFontOfSize:10];
                dateLbl.font=[UIFont boldSystemFontOfSize:12];
                dateLbl.textColor =[UIColor whiteColor];
                dateLbl.textAlignment=UITextAlignmentCenter;
                dateLbl.lineBreakMode=UILineBreakModeWordWrap;
                dateLbl.numberOfLines =1;
                [thumb_scroll addSubview:dateLbl];
                    
                       
                [thumb_scroll setContentSize:CGSizeMake(320,y+130)];
                   
                x=x+80;
				offset1=offset1+x;
                count++;
                }@catch (NSException *ex) {
                    NSLog(@"mani Exception:%@ %@",[ex name],[ex reason]);
                }
                
				
            }
            else
            {
				NSLog(@"sdfsdfs ");
            }
            
			//count++;
        }
        if(count<var2)
        {
            y+=85;
            NSLog(@"y==%d",y);
        }else
        {
            NSLog(@"out of loop");
        }
    }
}
else {
    
    NSLog(@"Search data is not Found");
    
}

    }@catch(NSException *e){
        
        NSLog(@"Exception:%@",e);
        
    }

}


-(IBAction)iconpicselect:(UIButton*)sender{
    
    
   // UIButton *tappedButton2 = (UIButton*)sender;
	//int indx2 = tappedButton2.tag;
    //sender.layer.borderColor = [UIColor yellowColor].CGColor;
    //sender.layer.borderWidth = 1.0;
    
    UIAlertView *alertIcon = [[UIAlertView alloc]initWithTitle:@"Member Selected" message:@"Please Sign Up To Access Members Profile!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    [alertIcon show];
    
}


-(IBAction)iconselect:(UIButton*)sender
{
    
    
    view_profile_bool=TRUE;
    UIButton *tappedButton1 = (UIButton*)sender;
	int indx1 = tappedButton1.tag;
    
    
    global_string=[[NSString alloc]initWithFormat:@"%@",[id_arr objectAtIndex:indx1]];
    
    gender_string_global=[[NSString alloc]initWithFormat:@"%@",[gender_arr objectAtIndex:indx1]];
    NSLog(@"global_string:%@",global_string);
    
    Profile_view *preview=[[Profile_view alloc]initWithNibName:@"Profile_view" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:preview animated:NO];
    
    
   }


-(IBAction)mainmenu
{

    NSLog(@"menu");
    global_back = 0;
    
    Menupage *preview=[[Menupage alloc]initWithNibName:@"Menupage" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:preview animated:NO];


}


- (void)viewDidUnload
{
    [notificationButton release];
    notificationButton = nil;
    [notificationsTotalLbl release];
    notificationsTotalLbl = nil;
    [notificationRoundImage release];
    notificationRoundImage = nil;
    [lbl_image release];
    /*
    [name_arr release ];
    [image_arr release];
    [age_arr release];
    [id_arr release];
    [gender_arr release];
    [race_arr release];
    [gender_image_arr release];
    [final_img_arr release];
    [id_list_items release];
    [gender_list_items release];
    [race_list_items release];
    [image_list_items release];
    [name_list_items release];
    [age_list_items release];
     
     */
    
    
    [self setLbl_partnerWebsiteName:nil];
    [lbl_partnerwebnamelist release];
    lbl_partnerwebnamelist = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
    [notificationButton release];
    [notificationsTotalLbl release];
    [notificationRoundImage release];
    
    
    //[_lbl_partnerWebsiteName release];
    [lbl_partnerwebnamelist release];
    [super dealloc];
}
@end
