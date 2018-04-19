//
//  Search_list.m
//  iDate
//
//  Created by D M R on 13/09/12.
//  Copyright (c) 2012 iHubTechnologies. All rights reserved.
//

#import "Search_list.h"
#import "Menupage.h"
#import "AppDelegate.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "JSON.h"
#import "JSON1.h"
#import "MBProgressHUD.h"
#import "UIImageView+DispatchLoad.h"
#import "Search_cell_view.h"
#import "AsyncImageView1.h"
#import "Profile_view.h"
#import "Friend_cell.h"
#import "Chat_view.h"
#define ASYNC_IMAGE_TAG 9999
#define FONT_SIZE 18.0f
#define CELL_CONTENT_WIDTH 320.0f
#define CELL_CONTENT_MARGIN 10.0f

int increF;
int increC;

@interface Search_list ()
{
    //NSMutableArray *gender_image_Search_arr;
}

@end

@implementation Search_list
@synthesize locationManager;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark -
#pragma mark Aux view methods

/*
 * Loads the table
 */
- (void)loadTable {
    
    reloads_++;
    
    [profile_list_tableView reloadData];
    
    [pullToRefreshManager_ tableViewReloadFinished];
}

- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    
    [pullToRefreshManager_ relocatePullToRefreshView];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading...";
    
    //////////ScrollView/////////////////
    [self readlogin];
    naddCount =0;
     thumb_scroll=[[UIScrollView alloc]init];
    [thumb_scroll setFrame:CGRectMake(0,77,320,335)];
    thumb_scroll.clipsToBounds = YES;
	thumb_scroll.delegate = self;
    [self.view addSubview:Search_profile_view];
    [Search_profile_view addSubview:thumb_scroll];
    
    ///////MutableArray Allocation///////////
    
    show_Distance_arr = [[NSMutableArray alloc]init];
    name_arr=[[NSMutableArray alloc]init];
    image_arr=[[NSMutableArray alloc]init];
    age_arr=[[NSMutableArray alloc]init];
    id_arr=[[NSMutableArray alloc]init];
    gender_arr=[[NSMutableArray alloc]init];
    race_arr=[[NSMutableArray alloc]init];
    height_arr=[[NSMutableArray alloc]init];
    weight_arr=[[NSMutableArray alloc]init];
    edu_level_arr=[[NSMutableArray alloc]init];
    gender_image_src_arr = [[NSMutableArray alloc]init];
    
    drinker_arr=[[NSMutableArray alloc]init];
    smoker_arr=[[NSMutableArray alloc]init];
    last_login_arr=[[NSMutableArray alloc]init];
    tagline_arr=[[NSMutableArray alloc]init];
    vital_arr=[[NSMutableArray alloc]init];
    cup_arr=[[NSMutableArray alloc]init];
    display_latlong_arr =[[NSMutableArray alloc]init];
    listOfItems = [[NSMutableArray alloc] init];
    
    //////////Dictionary Alloc/////////
    
    responseDict = [[NSDictionary alloc]init];
    
    /////////////LocationManager Alloc////////////
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    [locationManager startUpdatingLocation];
    
    
    
    
    
    
    
    profile_list_tableView.frame=CGRectMake(0.0, 75.0, 320.0,340.0);
    
    profile_list_tableView.hidden=YES;
    
    
    ////////////SearchBar////////////////
    
    searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 76, 320, 44)];
    searchBar.delegate=self;
    [Search_profile_view addSubview:searchBar];
    profile_list_tableView.tableHeaderView=searchBar;
    searchBar.backgroundColor=[UIColor cyanColor];
    searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    searching = NO;
    searchBar.placeholder=@"Search By Name";
    letUserSelectRow = YES;
    search_done.hidden=YES;
    [self performSelector:@selector(call_search_result) withObject:nil afterDelay:1.0];
    
    
    if([global_show_msg_iconstr isEqualToString:@"1"])
    {
        
        global_msg_btn.hidden=NO;
        
    }else
    {
        global_msg_btn.hidden=YES;
    }
    
    
    spinny = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [Search_profile_view release];
    Search_profile_view = nil;
    [heart_image_view release];
    heart_image_view = nil;
    [default_heart_image release];
    default_heart_image = nil;
    [show_gridTotable_btn release];
    show_gridTotable_btn = nil;
    [profile_list_tableView release];
    profile_list_tableView = nil;
    [black_imageView release];
    black_imageView = nil;
    [global_msg_btn release];
    global_msg_btn = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


      
-(void)call_search_result    
{  
    NSURL *url = [NSURL URLWithString:@"http://192.168.0.111/DatingService/getDetails.svc/getSearchResults/"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    
    NSString *str_url=[[NSString alloc]initWithFormat:@"{\"userID\":\"%@\",\"Gender\":\"%@\",\"userCountryID\":\"%@\",\"userHeightFrom\":\"%@\",\"userHeightTo\":\"%@\",\"userWeightFrom\":\"%@\",\"userWeightTo\":\"%@\",\"userAgeFrom\":\"%@\",\"userAgeTo\":\"%@\",\"userRaceID\":\"%@\",\"userHairColorID\":\"%@\",\"userEyesColorID\":\"%@\",\"userEducationLevelID\":\"%@\",\"drinkerTypeID\":\"%@\",\"smokerTypeID\":\"%@\",\"isDriveCar\":\"%@\",\"isDriveBike\":\"%@\",\"isInterestedInBusinessNetworking\":\"%@\",\"isInterestedInChatting\":\"%@\",\"isInterestedInDating\":\"%@\",\"isInterestedInFlirting\":\"%@\",\"isInterestedInFriendships\":\"%@\",\"isInterestedInOtherActivities\":\"%@\",\"isInterestedInRelationships\":\"%@\",\"userKeywords\":\"%@\"}",login_select,global_genderString,global_country_selectedid,global_height_from_string,global_height_to_string,global_weight_from_string,global_weight_to_string,global_age_from_string,global_age_to_string,global_race_selectedid,global_haircolor_selectedid,global_eyecolor_selectedid,global_edu_selectedid,global_drinker__selectedid,global_smoker_selectedid,global_car_string,global_bike_string,global_interest_Business,global_interest_chatting,global_interest_dating,global_interest_flirting,global_interest_friendship,global_interest_other_activity,global_interest_relationship,global_keyword_string];
    
    
    NSLog(@"str_url:%@",str_url);
    [request appendPostData:[str_url dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request setRequestMethod:@"POST"];
    [request setDelegate:self];
    [request startAsynchronous];
    // Start hud
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading...";
    
     
}   
- (void)requestFinished:(ASIHTTPRequest *)request
{    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if (request.responseStatusCode == 400) {
        
        NSError *error = [request error];
        NSLog(@"error:%@",error);
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Search not found" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        Search_view *search_view=[[Search_view alloc]initWithNibName:@"Search_view" bundle:[NSBundle mainBundle]];
        [self.navigationController pushViewController:search_view animated:NO];

        
        
    } else if (request.responseStatusCode == 403) {
        
        NSError *error = [request error];
        NSLog(@"error:%@",error);
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Search not found" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        Search_view *search_view=[[Search_view alloc]initWithNibName:@"Search_view" bundle:[NSBundle mainBundle]];
        [self.navigationController pushViewController:search_view animated:NO];

    } else if (request.responseStatusCode == 200)
    {
        [MBProgressHUD hideHUDForView:self.view animated:YES];

        NSString *responseString = [request responseString];
        NSLog(@"responseString2:%@",responseString);
       responseDict = [responseString JSONValue];
        NSLog(@"responseDict:%@",responseDict);
       
        name_arr=[[NSMutableArray alloc]init];
        image_arr=[[NSMutableArray alloc]init];
        age_arr=[[NSMutableArray alloc]init];
        id_arr=[[NSMutableArray alloc]init];
        gender_arr=[[NSMutableArray alloc]init];
        race_arr=[[NSMutableArray alloc]init];
        gender_image_src_arr=[[NSMutableArray alloc]init];
        
        
        height_arr=[[NSMutableArray alloc]init];
        weight_arr=[[NSMutableArray alloc]init];
        edu_level_arr=[[NSMutableArray alloc]init];
        
        
        drinker_arr=[[NSMutableArray alloc]init];
        smoker_arr=[[NSMutableArray alloc]init];
        last_login_arr=[[NSMutableArray alloc]init];
        tagline_arr=[[NSMutableArray alloc]init];
        vital_arr=[[NSMutableArray alloc]init];
        cup_arr=[[NSMutableArray alloc]init];
        final_img_arr = [[NSMutableArray alloc]init];
        latitude_arr = [[NSMutableArray alloc]init];
        longtude_arr = [[NSMutableArray alloc]init];
        
        id_list_items= [[NSMutableArray alloc] init];
        gender_list_items=[[NSMutableArray alloc] init];
        race_list_items=[[NSMutableArray alloc] init];
        image_list_items=[[NSMutableArray alloc] init];
        name_list_items=[[NSMutableArray alloc] init];
        age_list_items=[[NSMutableArray alloc] init];
        distance_list_items = [[NSMutableArray alloc]init];
        
        
        [self profile_json_call];
        pullToRefreshManager_ = [[MNMBottomPullToRefreshManager alloc] initWithPullToRefreshViewHeight:60.0f tableView:profile_list_tableView withClient:self];
        
        
    } 
    else 
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Search not found" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        Search_view *search_view=[[Search_view alloc]initWithNibName:@"Search_view" bundle:[NSBundle mainBundle]];
        [self.navigationController pushViewController:search_view animated:NO];

    }
    
}

- (void)requestFailed:(ASIHTTPRequest *)request
{    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    NSError *error = [request error];
    NSLog(@"error:%@",error);
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Search not found" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [alert release];
    Search_view *search_view=[[Search_view alloc]initWithNibName:@"Search_view" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:search_view animated:NO];

}



-(void)readlogin
{
    NSString *query = [[NSString alloc] initWithFormat:@"select * from login;"];
	sqlite3_stmt *stmt;
	int x1= sqlite3_prepare_v2(database,[query UTF8String],-1, &stmt, nil);
	if (x1 == SQLITE_OK)
	{
		// Loop through the results and add them to the feeds array
		while(sqlite3_step(stmt) == SQLITE_ROW)
		{
			NSString *loginstr = [[NSString alloc]initWithUTF8String:(char *)sqlite3_column_text(stmt, 1)];
            NSLog(@"loginstr:%@",loginstr);
            
            login_select=[[NSString alloc]initWithFormat:@"%@",loginstr];
            NSLog(@"login_select:%@",login_select);
            
		}
        
        
	}else {
        NSLog(@"%s (%1d)", sqlite3_errmsg(database), sqlite3_errcode(database));
    }
	sqlite3_finalize(stmt);
    
    //sqlite3_close(database);
    
}

/*
-(void)LatitudeAndLongCal
{
    
    @try{
        
    NSLog(@"Entered Latitude and Long Cal before");
        
    NSLog(@"increF befor %i",increF);
    NSLog(@"increC befor %i",increC);
    NSLog(@"Entered Latitude and Long Cal");
    
    //NSInteger inkF = [increF intValue];
    //NSInteger inkC = [increC intValue];
    
        int inkF = increF;
        int inkC = increC;
        
    
    NSString * strF = [NSString stringWithFormat:@"%i",inkF];
    NSString * strC = [NSString stringWithFormat:@"%i",inkC];
    
    NSLog(@"strF after %@",strF);
    NSLog(@"strC after %@",strC);
    
    i=[strF intValue];
    j=[strC intValue];
    
    
   if((increF<([name_arr count])))
     {
               
            while (i<([latitude_arr count]+1) && j<([longtude_arr count]+1)){
        
        
        if(i<5+5*h && j<5+5*h)
        {
            NSLog(@"scroll lati 12");
            
            NSString *lati_str = [[NSString alloc]initWithFormat:@"%@",[latitude_arr objectAtIndex:i]];
            
            NSString *long_str = [[NSString alloc]initWithFormat:@"%@",[longtude_arr objectAtIndex:j]];
            
            NSLog(@"get lati wh:%@",lati_str);
            NSLog(@"get long wh:%@",long_str);
            
            lat1=[lati_str doubleValue];
            long1 = [long_str doubleValue];
            
            
            
            if(![lati_str isEqualToString:@""]|| ![long_str isEqualToString:@""])
            {
                NSLog(@"scroll lati 11");
                CLLocation *location = [locationManager location];
                
                // Configure the new event with information from the location
                
                CLLocationCoordinate2D coordinate = [location coordinate];
                latitude_current_string = [NSString stringWithFormat:@"%f", coordinate.latitude];
                longtude_current_String = [NSString stringWithFormat:@"%f", coordinate.longitude];
                
                NSLog(@"dLatitude : %@", latitude_current_string);
                NSLog(@"dLongitude : %@",longtude_current_String);
                
                
                
                lat2 = [latitude_current_string doubleValue];
                long2 = [longtude_current_String doubleValue];
                
                
                
                
                CLLocation *location1 = [[CLLocation alloc] initWithLatitude:lat1  longitude:long1 ];
                CLLocation *location2 = [[CLLocation alloc] initWithLatitude:lat2  longitude:long2 ];
                //NSLog(@"Distance i meters: %f", ([location1 distanceFromLocation:location2]/1609.344)/0.621371192237 );
                NSLog(@"Distance i kilometers: %f", ([location1 distanceFromLocation:location2]/1000.0) );
                
                
                double distance_doub =[location1 distanceFromLocation:location2]/1000.0;
                //double distance_doub =0.0;
                NSLog(@"Distance j kilometers: %f", distance_doub );
                
                display_lati_long_str = [[NSString alloc]initWithFormat:@"%.2f",distance_doub];
                NSLog(@"Distance k kilometers: %@", display_lati_long_str );
                
                
                
                
            }else {
                
                display_lati_long_str=@"";
                NSLog(@"empty displ");
                
            }
            
            NSLog(@"count name_arr=%i",[name_arr count]);
            NSLog(@"count name_arr=%i",i);
        }else if(i<([name_arr count]+1))
        {
            int f,c;
            f = 5+5*h;
            c = 5+5*h;
            NSLog(@"f incref calculation point =%i",f);
            NSLog(@"c increc calculation point =%i",c);
            NSLog(@"h incref calculation point =%i",h);
            increF = f;
            increC = c;
            
            NSLog(@"increF %i",increF);
            NSLog(@"increC %i",increC);
            
            
        }
        [display_latlong_arr addObject:display_lati_long_str];
        
        
        i++;
        j++;
 
        
        
        
    }
        }
        else{
            NSLog(@"end of latiude and long");
            increF = increF +1;
            increC = increC +1;
        NSLog(@"increF = increF +1=%i",increF);
            NSLog(@"incre C = increC +1=%i",increC);
        }
        
}
@catch (NSException *exception)
{
    NSLog(@"main: Caught %@: %@", [exception name], [exception reason]);
}
    
}
 */

-(void)profile_json_call
{
    
    reloads_ = 0;
       NSLog(@"scroll lati 9");
       NSLog(@"response string latitude: %@",responseDict);
    
    //gender_image_Search_arr = [[NSMutableArray alloc]init];

    for (NSDictionary *info in responseDict)
    {
        /////////////ID///////////////////
        
       id_string=[[NSString alloc]initWithFormat:@"%@",[info objectForKey:@"userID"]];
       [id_arr addObject:id_string];
       NSLog(@"id_str:*%@*",id_string);
        
        ///////////Name////////////////////
        
       name_string=[info objectForKey:@"userName"];
       [name_arr addObject:name_string];
       NSLog(@"name_arr:%@",name_arr);
        NSLog(@"Count of name arry:%i",[name_arr count]);
        
        
       ///////////Age////////////////
        
        age_string=[info objectForKey:@"userAge"];
        
        if (age_string == (NSString*)[NSNull null])
            
        {
            new_age_string=@"";
            
        }
        else
        {
            new_age_string=[[NSString alloc]initWithFormat:@"%@ years old",age_string];
        }

        
        [age_arr addObject:new_age_string];
        
        ////////////////Gender///////////////////////
       
        gender_string=[[NSString alloc]initWithFormat:@"%@",[info objectForKey:@"isMale"]];
        [gender_arr addObject:gender_string];
        NSLog(@"gender_string:%@",gender_string);
        
        
       /////////////////////race/////////////////////  
        
        race_string=[[NSString alloc]initWithFormat:@"%@",[info objectForKey:@"Ethnicity"]];
        
        if (race_string == (NSString*)[NSNull null])
            
        {
            race_string=@"Not available";
            
        }
        
        else if([race_string isEqualToString:@""]||[race_string isEqualToString:@"null"]||[race_string isEqualToString:@"(null)"]||[race_string isEqualToString:@"<null>"])
        {
            race_string=@"Not available";
        }

        
        [race_arr addObject:race_string];
        
        NSLog(@"race_arr:%@",race_arr);
        
        
      //////////////tagline/////////////////////  
        
        
        
         tagline_string=[info objectForKey:@"userTagline"];
        if (tagline_string == (NSString*)[NSNull null])
            
        {
            tagline_string=@"Not available";
            
        }
        else ([tagline_string isEqualToString:@""]||[tagline_string isEqualToString:@"null"]||[tagline_string isEqualToString:@"(null)"]||[tagline_string isEqualToString:@"<null>"]);
        {
            tagline_string=@"Not available";
        }
        [tagline_arr addObject:tagline_string];
        
        NSLog(@"tagline_arr:%@",tagline_arr);
        
         //////////////height/////////////////////  
        
         height_string=[[NSString alloc]initWithFormat:@"%@",[info objectForKey:@"userHeight"]];
        if (height_string == (NSString*)[NSNull null])
            
        {
            height_string=@"Not available";
            
        }
        else if([height_string isEqualToString:@""]||[height_string isEqualToString:@"null"]||[height_string isEqualToString:@"(null)"]||[height_string isEqualToString:@"<null>"])
        {
            height_string=@"Not available";
        }

        [height_arr addObject:height_string];
        NSLog(@"height_arr:%@",height_arr);
        
       
        
         //////////////weight/////////////////////  
        
         weight_string=[[NSString alloc]initWithFormat:@"%@",[info objectForKey:@"userWeight"]];
        if (weight_string == (NSString*)[NSNull null])
            
        {
            weight_string=@"Not available";
            
        }
        
        else if([weight_string isEqualToString:@""]||[weight_string isEqualToString:@"null"]||[weight_string isEqualToString:@"(null)"]||[weight_string isEqualToString:@"<null>"])
        {
            weight_string=@"Not available";
        }

        [weight_arr addObject:weight_string];
        NSLog(@"weight_arr:%@",weight_arr);
        
         //////////////vital/////////////////////  
    
         bust_string=[[NSString alloc]initWithFormat:@"%@",[info objectForKey:@"userVitalStatsBust"]];
        if (bust_string == (NSString*)[NSNull null])
            
        {
            bust_string=@"Not available";
            
        }
        
        else if([bust_string isEqualToString:@""]||[bust_string isEqualToString:@"null"]||[bust_string isEqualToString:@"(null)"]||[bust_string isEqualToString:@"<null>"])
        {
            bust_string=@"Not available";
        }

        //[race_arr addObject:bust_string];
        
        
        
        cup_string =[[NSString alloc]initWithFormat:@"%@",[info objectForKey:@"userCupSize"]];
        if (cup_string == (NSString*)[NSNull null])
            
        {
            cup_string=@"Not available";
            
        }
        else if([cup_string isEqualToString:@""]||[cup_string isEqualToString:@"null"]||[cup_string isEqualToString:@"(null)"]||[cup_string isEqualToString:@"<null>"])
        {
            cup_string=@"Not available";
        }

        //[race_arr addObject:race_string];
        
        
        
        
        
         waist_string=[[NSString alloc]initWithFormat:@"%@",[info objectForKey:@"userVitalStatsWaist"]];
        if (waist_string == (NSString*)[NSNull null])
            
        {
            waist_string=@"Not available";
            
        }
        
        else if([waist_string isEqualToString:@""]||[waist_string isEqualToString:@"null"]||[waist_string isEqualToString:@"(null)"]||[waist_string isEqualToString:@"<null>"])
        {
            waist_string=@"Not available";
        }

        //[race_arr addObject:waist_string];
        
        
        
        
        
         hips_string=[[NSString alloc]initWithFormat:@"%@",[info objectForKey:@"userVitalStatsHips"]];
        if (hips_string == (NSString*)[NSNull null])
            
        {
            hips_string=@"Not available";
            
        }
        
        else if([hips_string isEqualToString:@""]||[hips_string isEqualToString:@"null"]||[hips_string isEqualToString:@"(null)"]||[hips_string isEqualToString:@"<null>"])
        {
            hips_string=@"Not available";
        }

        
        vital_string=[[NSString alloc]initWithFormat: @"%@%@-%@-%@",bust_string,cup_string,waist_string,hips_string];
        [vital_arr addObject:hips_string];
        
        NSLog(@"vital_arr:%@",vital_arr);
        
        
        //////////////education/////////////////////
        
         edulevel_string=[[NSString alloc]initWithFormat:@"%@",[info objectForKey:@"EducationLevel"]];
        if (edulevel_string == (NSString*)[NSNull null])
            
        {
            edulevel_string=@"Not available";
            
        }
        else if([edulevel_string isEqualToString:@""]||[edulevel_string isEqualToString:@"null"]||[edulevel_string isEqualToString:@"(null)"]||[edulevel_string isEqualToString:@"<null>"])
        {
            edulevel_string=@"Not available";
        }

        [edu_level_arr addObject:edulevel_string];
        NSLog(@"edu_level_arr:%@",edu_level_arr);
        
        
        //////////////drinker/////////////////////
        
         drinker_string=[[NSString alloc]initWithFormat:@"%@",[info objectForKey:@"DrinkerType"]];
        if (drinker_string == (NSString*)[NSNull null])
            
        {
            drinker_string=@"Not available";
            
        }
        else if([drinker_string isEqualToString:@""]||[drinker_string isEqualToString:@"null"]||[drinker_string isEqualToString:@"(null)"]||[drinker_string isEqualToString:@"<null>"])
        {
            drinker_string=@"Not available";
        }

        [drinker_arr addObject:drinker_string];
        
        NSLog(@"drinker_arr:%@",drinker_arr);
        
        
        //////////////smoker/////////////////////
        
        smoker_string=[[NSString alloc]initWithFormat:@"%@",[info objectForKey:@"SmokerType"]];
        if (smoker_string == (NSString*)[NSNull null])
            
        {
            smoker_string=@"Not available";
            
        }
        else if([smoker_string isEqualToString:@""]||[smoker_string isEqualToString:@"null"]||[smoker_string isEqualToString:@"(null)"]||[smoker_string isEqualToString:@"<null>"])
        {
            smoker_string=@"Not available";
        }

        [smoker_arr addObject:smoker_string];

        NSLog(@"smoker_arr:%@",smoker_arr);
        
        
        ///////////////////LastLogin/////////////////////////////
        
        lastLogin_string=[[NSString alloc]initWithFormat:@"%@",[info objectForKey:@"lastLogin"]];
        if (lastLogin_string == (NSString*)[NSNull null])
            
        {
            lastLogin_string=@"";
            
        }
        else if([lastLogin_string isEqualToString:@""]||[lastLogin_string isEqualToString:@"null"]||[lastLogin_string isEqualToString:@"(null)"]||[lastLogin_string isEqualToString:@"<null>"])
        {
            lastLogin_string=@"";
        }

        [last_login_arr addObject:lastLogin_string];
        
        NSLog(@"last_login_arr:%@",last_login_arr);
        
        
        ////////////////////GenderImage/////////////////////
        
       /* image_string=[info objectForKey:@"userFileURL"];
        NSLog(@"image_string:%@",image_string);
        if (image_string == (NSString*)[NSNull null])
            
        {
            NSLog(@"image_string12");
            image_string=@"";
            
        }
        else if([image_string isEqualToString:@""]||[image_string isEqualToString:@"null"]||[image_string isEqualToString:@"(null)"]||[image_string isEqualToString:@"<null>"])
        {
            NSLog(@"image_string13");
            image_string=@"";
        }

        [gender_image_arr addObject:image_string];
        NSLog(@"gender_image_arr:%@",gender_image_arr);
        */
        
        image_string=[[NSString alloc]initWithFormat:@"%@",[info objectForKey:@"userFileScreenshotURL"]];
        NSLog(@"image_string:%@",image_string);
        /*if (image_string == (NSString*)[NSNull null])
            
        {
            NSLog(@"image_string12");
            image_string=@"";
            
        } else if([image_string isEqualToString:@""]||[image_string isEqualToString:@"null"]||[image_string isEqualToString:@"(null)"]||[image_string isEqualToString:@"<null>"])
        {
            NSLog(@"image_string13");
            image_string=@"";
        }*/
        @try{

            [gender_image_src_arr addObject:image_string];
        //[gender_image_Search_arr addObject:image_string];
        }@catch (NSException *exception)
        {
            NSLog(@"main: gender_image Caught %@: %@", [exception name], [exception reason]);
        }

        
        //////////////////////// Latitude////////////////////////////
        
        latitude_string=[[NSString alloc]initWithFormat:@"%@",[info objectForKey:@"latitude"]];
        NSLog(@"latitude get:%@",latitude_string);
        if (latitude_string == (NSString*)[NSNull null])
            
        {
            //latitude_string=@"Not available";
            latitude_string=@"";
        }
        else if([latitude_string isEqualToString:@""]||[latitude_string isEqualToString:@"null"]||[latitude_string isEqualToString:@"(null)"]||[latitude_string isEqualToString:@"<null>"]||[latitude_string isEqualToString:@"0"])
        {
            //latitude_string=@"Not available";
            latitude_string=@"";
        }
        
        [latitude_arr addObject:latitude_string];
        NSLog(@"latitude_arr:%@",latitude_arr);
        
        //////////////longitude/////////////////////
        
        longtude_String=[[NSString alloc]initWithFormat:@"%@",[info objectForKey:@"longitude"]];
        NSLog(@"longitude get:%@",longtude_String);
        if (longtude_String == (NSString*)[NSNull null])
            
        {
            //longtude_String=@"Not available";
            longtude_String=@"";
        }
        else if([longtude_String isEqualToString:@""]||[longtude_String isEqualToString:@"null"]||[longtude_String isEqualToString:@"(null)"]||[longtude_String isEqualToString:@"<null>"]||[longtude_String isEqualToString:@"0"])
        {
            //longtude_String=@"Not available";
            longtude_String=@"";
        }
        
        [longtude_arr addObject:longtude_String];
        NSLog(@"longtitude_arr:%@",longtude_arr);
       
        
    }
    
    for (int l=0; l<[gender_image_src_arr count]; l++)
    
    {
        
       
        NSString *string_final=[[NSString alloc]initWithFormat:@"%@",[gender_image_src_arr objectAtIndex:l]];
        
        NSString *value = [string_final substringWithRange:NSMakeRange(0, 4)];
        
        NSString *isMalerFemal=[[NSString alloc]initWithFormat:@"%@",[gender_arr objectAtIndex:l]];
    
        string_final=[string_final stringByReplacingOccurrencesOfString:@"<null>" withString:@""];
        NSLog(@"string final image:%@",string_final);
        NSLog(@"string final value male or Female:%@",isMalerFemal);
       
        NSLog(@"string final value:%@",string_final);
        
        if ([string_final isEqualToString:@"male_icon.png"]||[string_final isEqual:@"profile_pic.png"]||[string_final isEqualToString:@""]||[string_final isEqualToString:@"<null>"]||[string_final isEqualToString:@"(null)"]||string_final == NULL)
            
        {
            NSLog(@"male1 or female1");
            if ([isMalerFemal isEqualToString:@"1"])
            {
        NSLog(@"string final value male:%@",isMalerFemal);
                NSLog(@"male icon");
                new_image_string=[[NSString alloc]initWithFormat:@"http://192.168.0.111/Dating/images/NoPhotoMale.jpg"];
                
                }
            else if ([isMalerFemal isEqualToString:@"0"])
            {
                NSLog(@"string final value female:%@",isMalerFemal);
                NSLog(@"female icon");
                new_image_string=[[NSString alloc]initWithFormat:@"http://192.168.0.111/Dating/images/NoPhotoFemale.jpg"];
                
            }
            [final_img_arr addObject:new_image_string];
            
            
        }else
        if ([value isEqualToString:@"http"]) {
            
            [final_img_arr addObject:string_final];
            NSLog(@"socialUrl:%@",value);
            
        }
        else
        {
            
            
                
            NSLog(@"upload icon");
            NSString *str_image_url_1 = [[NSString alloc]initWithFormat:@"http://192.168.0.111/Dating/Uploads/"];
            
            new_image_string =[[NSString alloc]initWithFormat:@"%@",[str_image_url_1 stringByAppendingString:string_final]];
            
            
            
            new_image_string=[new_image_string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [final_img_arr addObject:new_image_string];
            
        
            }
        
    
    }
    
    
    for(int q=0;q<[latitude_arr count];q++)
    {
        NSString *lati_str = [[NSString alloc]initWithFormat:@"%@",[latitude_arr objectAtIndex:q]];
        
        NSString *long_str = [[NSString alloc]initWithFormat:@"%@",[longtude_arr objectAtIndex:q]];
        
        NSLog(@"get lati for:%@",lati_str);
        NSLog(@"get long for:%@",long_str);
        
        lat1=[lati_str doubleValue];
        long1 = [long_str doubleValue];
        
        
        NSLog(@"lati and log calculation");
        CLLocation *location = [locationManager location];
        
        
        // Configure the new event with information from the location
        
        
        CLLocationCoordinate2D coordinate = [location coordinate];
        latitude_current_string = [NSString stringWithFormat:@"%f", coordinate.latitude];
        longtude_current_String = [NSString stringWithFormat:@"%f", coordinate.longitude];
        
        
        NSLog(@"dLatitude : %@", latitude_current_string);
        NSLog(@"dLongitude : %@",longtude_current_String);
        
        if([latitude_current_string isEqualToString:@"37.785834"]||[longtude_current_String isEqualToString:@"-122.406417"]||[latitude_current_string isEqualToString:@""]||[longtude_current_String isEqualToString:@""]||[lati_str isEqualToString:@""]||[long_str isEqualToString:@""]||[lati_str isEqualToString:@"NULL"]||[long_str isEqualToString:@"NULL"]||[lati_str isEqualToString:@"<null>"]||[long_str isEqualToString:@"<null>"]||[lati_str isEqualToString:@"0.000000"]||[long_str isEqualToString:@"0.000000"]||[latitude_current_string isEqualToString:@"0.000000"]||[longtude_current_String isEqualToString:@"0.000000"])
        {
            show_Distance =@"";
            NSLog(@"Distance is empty:");
            
        }else{
            
            
            lat2 = [latitude_current_string doubleValue];
            long2 = [longtude_current_String doubleValue];
            
            
            
            
            CLLocation *location1 = [[CLLocation alloc] initWithLatitude:lat1  longitude:long1 ];
            CLLocation *location2 = [[CLLocation alloc] initWithLatitude:lat2  longitude:long2 ];
            
            //NSLog(@"Distance i meters: %f", ([location1 distanceFromLocation:location2]/1609.344)/0.621371192237 );
            
            NSLog(@"Distance i kilometers: %f", ([location1 distanceFromLocation:location2]/1000.0) );
            
            
            double distance_doub =[location1 distanceFromLocation:location2]/1000.0;
            //double distance_doub =0.0;
            NSLog(@"Distance j kilometers: %f", distance_doub );
            
            display_lati_long_str = [[NSString alloc]initWithFormat:@"%.2f",distance_doub];
            NSString *appendKm = [[NSString alloc] initWithString:@"Km"];
            
            NSString *show_lati_long_str = [ display_lati_long_str stringByAppendingString:appendKm];
            
            show_Distance = [[NSString alloc]initWithString:show_lati_long_str];
            
            
            
            NSLog(@"Distance k kilometers: %@", show_Distance );
            
            
            
        }
        
        [show_Distance_arr addObject:show_Distance];
        
        
    }
    
    int v=[name_arr count];
    NSLog(@"total name_arr count:%i",v);
    nPercent = v%10;
    NSLog(@"percentail of count:%i",naddCount);
    if(nPercent == 0){
        nPercent = 0;
    }else if(nPercent == 1)
    {
        naddCount=naddCount+1;
    NSLog(@"naddCount == 1:%i",naddCount);
        //[self addEmptyvalue];
        
    }else if (nPercent == 2)
    {
        naddCount=2;
        NSLog(@"naddCount == 2:%i",naddCount);
        
    }else if (nPercent == 3)
    {
        naddCount=3;
        NSLog(@"naddCount == 3:%i",naddCount);
        
    }else if (nPercent == 4)
    {
        naddCount=4;
        NSLog(@"naddCount == 4:%i",naddCount);
        
    }else if (nPercent == 5)
    {
        naddCount = 5;
        NSLog(@"naddCount == 5:%i",naddCount);
    }else
    if( nPercent == 6)
    {
        naddCount=naddCount+6;
        NSLog(@"naddCount == 6:%i",naddCount);
        //[self addEmptyvalue];
        
        
        
        
    }else if ( nPercent == 7)
    {
        naddCount=7;
        NSLog(@"naddCount == 7:%i",naddCount);
        
    }else if (nPercent == 8)
    {
        naddCount=8;
        NSLog(@"naddCount == 8:%i",naddCount);
        
    }else if (nPercent == 9)
    {
        naddCount=9;
        NSLog(@"naddCount == 9:%i",naddCount);
        
    }
    
    
   // var1 = 16;
    
    
    k=0;
    
    
    
    
    [profile_list_tableView reloadData];
    
    
    
    
    
    
    NSLog(@"scroll lati 8");
    //[self LatitudeAndLongCal];
        
    var2 = [name_arr count];
    var1 =16;
    NSLog(@"count:%d",[name_arr count]);
    NSLog(@"count_var:%d",var1);
    
     //var2= var1/4;
     count=0,offset1 =1,x=1,y=4,num=0,nums=1;
    
    
    [self performSelectorOnMainThread:@selector(display_profile) withObject:nil waitUntilDone:YES];
        
        

        
    
    
    if ([name_string isEqualToString:@"(null)"]||[name_string isEqualToString:@""]||name_string==nil||name_string==NULL)
    {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"No Results were found " delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        Search_view *search_view=[[Search_view alloc]initWithNibName:@"Search_view" bundle:[NSBundle mainBundle]];
        [self.navigationController pushViewController:search_view animated:NO];

        
        
        
        
    }
    else
    {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        
    }
    
   // [profile_list_tableView reloadData];
    


}






-(void)loadtbl
{
    //a=naddCount;
    //naddCount=0;
    k=naddCount;
[profile_list_tableView reloadData];
[pullToRefreshManager_ tableViewReloadFinished];
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
                
    //NSLog(@"scroll lati 6");
    //NSLog(@"name_arry Count%i",[name_arr count]);
    
    int numRow;
    numRow = [name_arr count];
    nameCount = [name_arr count];
    NSLog(@"count=%i",numRow);
    NSLog(@"reloads_=%i",reloads_);
   
    
 if (searching)
 {
     
 return [name_list_items count];
     
 }else if (numRow>0 && numRow>=([name_arr count]-naddCount))
 {
     if(k==0){
     NSLog(@"reloads_2=%i",reloads_);
     return 5 + (5 * reloads_);
     }else if (k<10 && (k>0))
     {
         return [name_arr count];
      //return 5 + (5 * reloads_)+k;
       //  k=6;
     }
     //else if (k>6)
     //{
       //  return [name_arr count];
     //}
 }
    /*
 else{
     NSLog(@"return 1");
     
     return 0;
 }
*/

    
/*
 else
 {
return [name_arr count];
 }
*/
 
    return nil;
 

}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    
  Search_cell_view *cell1;
 
 static NSString *cellIdentifier1 = @"cellIdentifier1";
 
 cell1 = (Search_cell_view *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
 
 if (cell1 == nil)
 {
 NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Search_cell_view"
 owner:self options:nil];
 for (id oneObject in nib) if ([oneObject isKindOfClass:[Search_cell_view class]])
 cell1 = (Search_cell_view *)oneObject;
 
 cell1.selectionStyle = UITableViewCellSelectionStyleNone;
 
 }
 cell1.profile_img.clipsToBounds = YES;
 cell1.profile_img.layer.cornerRadius=10.0;
 cell1.profile_img.layer.borderColor = [UIColor cyanColor].CGColor;
 cell1.profile_img.layer.borderWidth = 1.0;
 
 
 if(searching)
 {
 cell1.user_name.text = [name_list_items objectAtIndex:indexPath.row];
 
 cell1.age_lbl.text=[age_list_items objectAtIndex:[indexPath row]];
 
 cell1.distance_display.text = [distance_list_items objectAtIndex:[indexPath row]];
 
 
 NSString *gender_image_string=[[NSString alloc]initWithFormat:@"%@",[gender_list_items objectAtIndex:[indexPath row]]];
 
 
 if ([gender_image_string isEqualToString:@"0"])
 {
 //str_profile_image=[[NSString alloc]initWithFormat:@"http://192.168.0.111/Dating/images/NoPhotoFemale.jpg"];
 
     
     cell1.gender_img.image=[UIImage imageNamed:@"female_icon.png"];
     //cell1.profile_img.layer.borderColor =[UIColor magentaColor].CGColor;
     cell1.profile_img.layer.borderColor =[UIColor colorWithRed:245/255.0 green:61/255.0 blue:165/255.0 alpha:1].CGColor;

    cell1.profile_img.layer.borderWidth = 1.0;
 }
 
 else
 {
 //str_profile_image=[[NSString alloc]initWithFormat:@"http://192.168.0.111/Dating/images/NoPhotoMale.jpg"];

     cell1.gender_img.image=[UIImage imageNamed:@"male_icon.png"];
     //cell1.profile_img.layer.borderColor = [UIColor blueColor].CGColor;
     cell1.profile_img.layer.borderColor = [UIColor colorWithRed:50/255.0 green:237/255.0 blue:250/255.0 alpha:1].CGColor;
     cell1.profile_img.layer.borderWidth = 1.0;
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
 /*
 
 NSString *race_str=[[NSString alloc]initWithFormat:@"%@",[race_list_items objectAtIndex:[indexPath row]]];
 
 if ([race_str isEqualToString:@"Not available"])
 {
 cell1.e.hidden=YES;
 }
 
 else
 {
 cell1.ethinicity_lbl.hidden=NO;
 cell1.ethinicity_lbl.text=[race_list_items objectAtIndex:[indexPath row]];
 }
 */
 
 }
    
    
  else
 
 {
     //NSLog(@"IndexPath Check:%i",indexPath.row);
 
     //NSLog(@"Name of the Users:%@",[name_arr objectAtIndex:0]);
     //NSLog(@"Name of the Users:%@",[name_arr objectAtIndex:1]);
     //NSLog(@"Name of the Users:%@",[name_arr objectAtIndex:2]);
     //NSLog(@"Name of the Users count:%i",[name_arr count]);
 //First get the dictionary object
     
     @try{
 cell1.user_name.text=[name_arr objectAtIndex:[indexPath row]];
 
 cell1.age_lbl.text=[age_arr objectAtIndex:[indexPath row]];
 
 cell1.distance_display.text =[show_Distance_arr objectAtIndex:[indexPath row]];
 
 
 NSString *gender_image_string=[[NSString alloc]initWithFormat:@"%@",[gender_arr objectAtIndex:[indexPath row]]];
 
     
 if ([gender_image_string isEqualToString:@"0"])
 {
  cell1.gender_img.image=[UIImage imageNamed:@"female_icon.png"];
     //cell1.profile_img.layer.borderColor =[UIColor magentaColor].CGColor;
      cell1.profile_img.layer.borderColor =[UIColor colorWithRed:245/255.0 green:61/255.0 blue:165/255.0 alpha:1].CGColor;
     cell1.profile_img.layer.borderWidth = 1.0;
 
 }
 
 else
 {
 
 cell1.gender_img.image=[UIImage imageNamed:@"male_icon.png"];
      cell1.profile_img.layer.borderColor = [UIColor colorWithRed:50/255.0 green:237/255.0 blue:250/255.0 alpha:1].CGColor;
     //cell1.profile_img.layer.borderColor = [UIColor blueColor].CGColor;
     cell1.profile_img.layer.borderWidth = 1.0;

 }
 
 urlString1 = [NSString stringWithFormat:@"%@",[final_img_arr objectAtIndex:[indexPath row]]];
 
 
     }@catch (NSException *exep) {
         NSLog(@"ExceptionCatched:%@",exep);
     }
 
 //NSURL *url1 = [NSURL URLWithString:urlString1];
 
 //=============================================================
 
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
 
 
/*
 NSString *race_str=[[NSString alloc]initWithFormat:@"%@",[race_arr objectAtIndex:[indexPath row]]];
 
 if ([race_str isEqualToString:@"Not available"])
 {
 cell1.ethinicity_lbl.hidden=YES;
 } 
 
 else
 {
 cell1.ethinicity_lbl.hidden=NO;
 cell1.ethinicity_lbl.text=[race_arr objectAtIndex:[indexPath row]];
 }
 */
 
 
  }
 
 
 
 
 
 
 return cell1;

}

 



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 
 
 if (tableView==profile_list_tableView)
 {
 view_profile_bool=TRUE;
 
 
 if(searching)
 {
 
 
 global_string=[[NSString alloc]initWithFormat:@"%@",[id_list_items objectAtIndex:[indexPath row]]];
 
 NSLog(@"global_string:%@",global_string);
    // global_Chat_id=[[NSString alloc]initWithFormat:@"%@",global_string];
 Profile_view *preview=[[Profile_view alloc]initWithNibName:@"Profile_view" bundle:[NSBundle mainBundle]];
 [self.navigationController pushViewController:preview animated:NO];
 
 
 }
 else
 
 {
 global_string=[[NSString alloc]initWithFormat:@"%@",[id_arr objectAtIndex:[indexPath row]]];
 //First get the dictionary object
 //global_Chat_id=[[NSString alloc]initWithFormat:@"%@",global_string];
 NSLog(@"global_string:%@",global_string);
 Profile_view *preview=[[Profile_view alloc]initWithNibName:@"Profile_view" bundle:[NSBundle mainBundle]];
 [self.navigationController pushViewController:preview animated:NO];
 
 }
 
 
 
 
 
   }

   


}



#pragma mark Search Bar

- (void) searchBarTextDidBeginEditing:(UISearchBar *)theSearchBar {
	
	//This method is called again when the user clicks back from teh detail view.
	//So the overlay is displayed on the results, which is something we do not want to happen.
	search_done.hidden=NO;
    if(searching)

		return;
	
	
	searching = NO;
	letUserSelectRow = NO;
	profile_list_tableView.scrollEnabled = NO;
        NSLog(@"searchBarTextDidBegin5");

       // [self searchBarTextDidEndEditing:theSearchBar];
    
    
	
}

- (void)searchBar:(UISearchBar *)theSearchBar textDidChange:(NSString *)searchText {
    
	//Remove all objects first.
 [id_list_items removeAllObjects];
 [gender_list_items removeAllObjects];
 [race_list_items removeAllObjects];
 [image_list_items removeAllObjects];
 [name_list_items removeAllObjects];
 [age_list_items removeAllObjects];
 [distance_list_items removeAllObjects];
    
    
 if([searchText length] > 0) {
 
 
 searching = YES;
 letUserSelectRow = YES;
 profile_list_tableView.scrollEnabled = YES;
 [self searchTableView];
     NSLog(@"searchBarTextDidBegin1");
 }
 else {
 
 //		[self.tableView insertSubview:ovController.view aboveSubview:self.parentViewController.view];
 
 searching = NO;
 letUserSelectRow = YES;
 profile_list_tableView.scrollEnabled = NO;
     NSLog(@"searchBarTextDidBegin2");
     
     
     [self searchBarSearchButtonClicked:nil ];
 
     
     
 }
    
    
 [profile_list_tableView reloadData];

 }
 - (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar1
 {
 [searchBar resignFirstResponder];
 return YES;
     NSLog(@"secr button click2");
 
 }
 - (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar1
 {
 [searchBar resignFirstResponder];
     [self doneSearching_Clicked:nil];
     
     NSLog(@"secr button click1");
// [self searchBarSearchButtonClicked:searchBar1];
 }
 - (void) searchBarSearchButtonClicked:(UISearchBar *)theSearchBar {
 
 //[self searchTableView];
 [searchBar resignFirstResponder];
    // [self searchBarSearchButtonClicked:theSearchBar];
     NSLog(@"secr button click");
 
 }
 - (void) searchTableView {
 
NSString *searchText = searchBar.text;
//for (NSString *sTemp in playemailarr)
for (int s=0; s<[name_arr count]; s++)
{
    NSString *sTemp = [name_arr objectAtIndex:s];
    NSString *sTempId = [id_arr objectAtIndex:s];
    NSString *sTempage = [age_arr objectAtIndex:s];
    NSString *sTempimage = [final_img_arr objectAtIndex:s];
    NSString*sTemprace= [race_arr objectAtIndex:s];
    NSString*sTempgender= [gender_arr objectAtIndex:s];
    NSString *sTempDistance = [show_Distance_arr objectAtIndex:s];
    NSRange titleResultsRange = [sTemp rangeOfString:searchText options:NSCaseInsensitiveSearch];
    if (titleResultsRange.length > 0)
    {
        [name_list_items addObject:sTemp];
        [image_list_items addObject:sTempimage];
        [id_list_items addObject:sTempId];
        [age_list_items addObject:sTempage];
        [race_list_items addObject:sTemprace];
        [gender_list_items addObject:sTempgender];
        [distance_list_items addObject:sTempDistance];
    }
}
[profile_list_tableView reloadData];
NSLog(@"image_list_items:%@",image_list_items);

}

- (void) doneSearching_Clicked:(id)sender {
	
	[searchBar resignFirstResponder];
	
	letUserSelectRow = YES;
	searching = NO;
	self.navigationItem.rightBarButtonItem = nil;
	profile_list_tableView.scrollEnabled = YES;
	
    
    search_done.hidden=YES;
    NSLog(@"searchBarTextDidBegin3");
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
    {
        
        return 63;
        
        
    }



-(void)show_table
{
    //[profile_list_tableView reloadData];
    profile_list_tableView.hidden=NO;
    thumb_scroll.hidden=YES;
    
}
-(void)show_grid
{
    
    profile_list_tableView.hidden=YES;
    thumb_scroll.hidden=NO;
    
}



-(IBAction)mainmenu
{
    
    Search_view *searchShow = [[Search_view alloc]initWithNibName:@"Search_view" bundle:[NSBundle mainBundle]];
    
    [self.navigationController pushViewController:searchShow animated:NO];
    
    /*
    Menupage *preview=[[Menupage alloc]initWithNibName:@"Menupage" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:preview animated:NO];
    */
    
}
#pragma mark -
#pragma mark MNMBottomPullToRefreshManagerClient

/**
 * This is the same delegate method as UIScrollView but required in MNMBottomPullToRefreshManagerClient protocol
 * to warn about its implementation. Here you have to call [MNMBottomPullToRefreshManager tableViewScrolled]
 *
 * Tells the delegate when the user scrolls the content view within the receiver.
 *
 * @param scrollView: The scroll-view object in which the scrolling occurred.
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //NSLog(@"entered in scrollviewdidscroll");
    [pullToRefreshManager_ tableViewScrolled];
}

/**
 * This is the same delegate method as UIScrollView but required in MNMBottomPullToRefreshClient protocol
 * to warn about its implementation. Here you have to call [MNMBottomPullToRefreshManager tableViewReleased]
 *
 * Tells the delegate when dragging ended in the scroll view.
 *
 * @param scrollView: The scroll-view object that finished scrolling the content view.
 * @param decelerate: YES if the scrolling movement will continue, but decelerate, after a touch-up gesture during a dragging operation.
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    NSLog(@"var1 value:%d",var1);
    //if(var1<var2)
    
    
    NSLog(@"nadd percent:%i",naddCount);
      if(var1>0 && var1<(var2-naddCount))
    {
        NSLog(@"entered in scrollviewdidend2");
        num++;
        nums++;
        var1 = nums*16;
        //var1 = var1/4;
      NSLog(@"var1 value in if:%d",var1);  
        //num=num+1;
        spinny.frame = CGRectMake(145, y+20, 25, 25);
        [spinny startAnimating];
        [thumb_scroll addSubview:spinny];
        //[spinny release];
        
         NSLog(@"entered in scrollviewdidend1");
        
        [self performSelector:@selector(display_profile) withObject:nil afterDelay:2.0f];
        
        //[self performSelectorOnMainThread:@selector(display_profile) withObject:nil waitUntilDone:YES];
        
        
    }else{
        
        num=0;
        var1 = [name_arr count];
        NSLog(@"var1 value in scroll:%d",var1);
        NSLog(@"out of loop in scroll");
        [self performSelector:@selector(display_profile) withObject:nil afterDelay:2.0f];
    }
    [pullToRefreshManager_ tableViewReleased];
}

/**
 * Tells client that refresh has been triggered
 * After reloading is completed must call [MNMBottomPullToRefreshManager tableViewReloadFinished]
 *
 * @param manager PTR manager
 */
- (void)bottomPullToRefreshTriggered:(MNMBottomPullToRefreshManager *)manager {
    
    if((5+5*reloads_)<([name_arr count]-naddCount))
    {
        NSLog(@"reloads count in scroll:%i",reloads_);
    [self performSelector:@selector(loadTable) withObject:nil afterDelay:1.0f];
    }else{
        //k=naddCount;
        [self performSelector:@selector(loadtbl) withObject:nil afterDelay:1.0f];
        NSLog(@"End of the Scroll");
    }
    }



-(void)display_profile
{
    
    [spinny stopAnimating];
    
    //[MBProgressHUD hideHUDForView:Search_profile_view animated:YES];
    
    //[profile_tbl reloadData];
    
    
   //int imageCountval = [final_img_arr count];
    
   NSLog(@"image Count:%d",[final_img_arr count]);
    NSLog(@"count_var:%d",var1);
    
    //var2= var1/4;
    //int count=0;
	//int offset1 =1;
    
    //int x=4,y=3;
    NSLog(@"Name Array:%@",name_arr);
    
    
    @try{
    if([name_arr count]!=0){
    for (int row = num*4; row<var1/4;row++)
    {
        NSLog(@"row:%d",row);
        x=2;
        // offset1=1;
        NSLog(@"x:%d",x);
        
        for (int col = 0; col<4;col++)
        {
             NSLog(@"col:%d",col);
             NSLog(@"count in dis before:%d",count);
            if(count<var1)
            {
				
             //NSLog(@"count in dis:%d",count);
               // NSLog(@"Name Search:%d",[name_arr count]);
                
                
                
                NSString *str_lbl=[[NSString alloc]initWithFormat:@"%@",[name_arr objectAtIndex:count]];
                
                NSLog(@"Name in String:%@",str_lbl);
                
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake(x, y, 75, 80);
				btn.backgroundColor=[UIColor clearColor];
               
                
                [btn addTarget:self action:@selector(iconselect:) forControlEvents:UIControlEventTouchUpInside];
                
                
				[thumb_scroll addSubview:btn];
				btn.tag =count;
                
                
                
                AsyncImageView1 *imgPhoto = [[AsyncImageView1 alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 75.0f, 80.0f)];
                imgPhoto.contentMode = UIViewContentModeScaleAspectFill;
                imgPhoto.clipsToBounds = YES;
                imgPhoto.tag = ASYNC_IMAGE_TAG;
                
                NSString *gender_image_str=[[NSString alloc]initWithFormat:@"%@",[gender_arr objectAtIndex:count]];
                
                if ([gender_image_str isEqualToString:@"0"])
                {
                    NSLog(@"entered in girls");
                    imgPhoto.layer.borderColor = [UIColor colorWithRed:245/255.0 green:61/255.0 blue:165/255.0 alpha:1].CGColor;

                    //imgPhoto.layer.borderColor =[UIColor magentaColor].CGColor;
                    imgPhoto.layer.borderWidth =1.0;
                }
                
                else
                {
                    NSLog(@"Entered in boys");
                   // imgPhoto.layer.borderColor = [UIColor blueColor].CGColor;
                    imgPhoto.layer.borderColor = [UIColor colorWithRed:50/255.0 green:237/255.0 blue:250/255.0 alpha:1].CGColor;
                    imgPhoto.layer.borderWidth = 1.0;
                }

                [btn addSubview:imgPhoto];
                
                
                AsyncImageView1 *imageView1 = (AsyncImageView1 *)[btn viewWithTag:ASYNC_IMAGE_TAG];
                
                
                //cancel loading previous image for cell
                
                [[AsyncImageLoader sharedLoader] cancelLoadingURL:imageView1.imageURL];
                imageView1.imageURL = [NSURL URLWithString:[final_img_arr objectAtIndex:count]];
                
                UIImageView *lbl_image=[[UIImageView alloc]initWithFrame:CGRectMake(x, y+67, 75, 13)];
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
				NSLog(@"x==%d",x);
                NSLog(@"offset==%d",offset1);
                    
                    
            }
            else
            {
                
				NSLog(@"Display_profile In Search result");
            }
            
			
        }
        //if(count<var1)
        //{
        y+=85;
        NSLog(@"y==%d",y);
        //}else
        //{
            NSLog(@"out of loop");
        //}
        //count++;
    }
    }
        else {
            
            NSLog(@"Search data is not Found");
            
        }
        
    }
        @catch(NSException *e){
            
            NSLog(@"ExceptionName:%@",e);
            
        }
    
}

-(IBAction)iconselect:(UIButton*)sender
{
    
    
    
    UIButton *tappedButton1 = (UIButton*)sender;
	int indx1 = tappedButton1.tag;
    
    
    global_string=[[NSString alloc]initWithFormat:@"%@",[id_arr objectAtIndex:indx1]];
    //global_Chat_id =[[NSString alloc]initWithFormat:@"%@",global_string];
    
    NSLog(@"global_string in search_list:%@",global_string);
    gender_string_global=[[NSString alloc]initWithFormat:@"%@",[gender_arr objectAtIndex:indx1]];
    NSLog(@"global_string:%@",global_string);
    
    
    view_profile_bool=TRUE;
    
    globalCheckFavorites = [[NSString alloc]initWithFormat:@"%@",@"SearchResults"];
    
    Profile_view *preview=[[Profile_view alloc]initWithNibName:@"Profile_view" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:preview animated:NO];
    
    
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
    [Search_profile_view release];
    [heart_image_view release];
    [default_heart_image release];
    [show_gridTotable_btn release];
    [profile_list_tableView release];
    [black_imageView release];
    [global_msg_btn release];
    [super dealloc];
}
- (IBAction)show_GridorTable_Click:(id)sender {
    
    UIButton *tappedButton = (UIButton*)sender;
	
	if([tappedButton.currentImage isEqual:[UIImage imageNamed:@"grid.png"]])
        // {
	{
        
		[show_gridTotable_btn setImage:[UIImage imageNamed:@"list.png"] forState:UIControlStateNormal];
        [self show_grid];
        [self doneSearching_Clicked:tappedButton];
        
	}
	
	else
	{
		[show_gridTotable_btn setImage:[UIImage imageNamed:@"grid.png"] forState:UIControlStateNormal];
        [self show_table];
		
        
	}

    
    
}

- (IBAction)click_msg_Chatwindow:(id)sender {
    
    //Chat_view *chatView = [[chatView alloc]initWithNibName:@"Chat_view" bundle:[NSBundle mainBundle]];
}

@end
