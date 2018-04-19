//
//  Profile_view.m
//  iDate
//
//  Created by D M R on 18/08/12.
//  Copyright (c) 2012 iHubTechnologies. All rights reserved.
//

#import "Profile_view.h"
#import "JSON.h"
#import "AppDelegate.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "JSON.h"
#import "JSON1.h"
#import "MBProgressHUD.h"
#import "UIImageView+DispatchLoad.h"
#import "Profile_cell.h"
#import "Give_gift_view.h"
#import "Rating_cell.h"
#import "RequestView.h"
#import "AsyncImageView1.h"
#import "Update_profile.h"
#import "Chat_list.h"
#import "vote_cell.h"
#import"RootViewController.h"
#import "Menupage.h"
#import "Chat_view.h"


#define ASYNC_IMAGE_TAG 9999
#define FONT_SIZE 18.0f
#define CELL_CONTENT_WIDTH 320.0f
#define CELL_CONTENT_MARGIN 10.0f
@interface Profile_view ()

@end

@implementation Profile_view
@synthesize locationManager;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
  if([globalCheckFavorites isEqualToString:@"Favorites"]){
      
      [self callPreviousSetImg];
      
  }else if ([globalCheckFavorites isEqualToString:@"SearchResults"]){
      
      [self callPreviousSetImg];
      
  }
    
    
    MBProgressHUD *hud1 = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
     hud1.labelText = @"Loading...";
    
    
    
    NSLog(@"global string one %@:",global_string);
    profile_img.layer.borderColor=[UIColor cyanColor].CGColor;
     nogift_lbl.hidden=YES;
    view_full_bool=FALSE;
    view_profile_btn.hidden=NO;
    gift_rate_lbl.text=@"Gifts";
    rate_vote_tbl.hidden=YES;
    UIImage *buttonImage=[UIImage imageNamed:@"rateview_btn.png"];

    [view_profile_btn setImage:buttonImage forState:UIControlStateNormal]; 

    remove_fav_btn.hidden=YES;
    Section_arr=[[NSMutableArray alloc]initWithObjects:@"Basic",@"Other",nil];
    
    
    Section_arr1=[[NSMutableArray alloc]initWithObjects:@"Basic",nil];
    //header_arr=[[NSMutableArray alloc]initWithObjects:@"Member",@"Username",@"Age",@"Birthday",@"Gender",@"E-mail",@"Mobile",@"Last login",nil];
    header_arr=[[NSMutableArray alloc]initWithObjects:@"",@"",@"",@"",@"",@"",@"",@"",nil];
    
    header_arr1=[[NSMutableArray alloc]initWithObjects:@"Member",@"Username",@"Age",@"Birthday",@"Gender",@"E-mail",@"Mobile",@"Last login",@"Education",@"Ethinity",@"Eyescolor",@"Haircolor",@"Smoker type",@"Drinker type",@"Looking for",@"Height",@"Weight",@"Bust",@"Hips",@"Waist",@"Tagline",@"Interested In",@"Short Desc",@"Long Desc",@"Search Keywords",nil];
   
    
   // user_arr=[[NSMutableArray alloc]initWithObjects:@"Member",@"Username",@"Age",@"Birthday",@"Gender",@"E-mail",@"Mobile",@"Last login",nil];
    user_arr=[[NSMutableArray alloc]initWithObjects:@"",@"",@"",@"",@"",@"",@"",@"",nil];
    
    //[imagescroll setFrame:CGRectMake(12,25, 280, 340)];
    img_scroll=[[UIScrollView alloc]init];
    [img_scroll setFrame:CGRectMake(0,213, 320, 58)];
    img_scroll.clipsToBounds = YES;
	img_scroll.delegate = self;
    [img_scroll setBounces:NO]; 
    img_scroll.alwaysBounceVertical = NO;
    [self.view addSubview:img_scroll];
    
    
    gifts_scroll=[[UIScrollView alloc]init];
    [gifts_scroll setFrame:CGRectMake(160,60, 157, 110)];
    gifts_scroll.clipsToBounds = YES;
	gifts_scroll.delegate = self;
    [self.view addSubview:gifts_scroll];
    
    
    rate_scroll=[[UIScrollView alloc]init];
    [rate_scroll setFrame:CGRectMake(0,38, 139, 29)];
    rate_scroll.clipsToBounds = YES;
	rate_scroll.delegate = self;
    [self.view addSubview:rate_scroll];
    
    
    
    user_profile_view.frame=CGRectMake(0,425, 320, 60);
	[self.view addSubview:user_profile_view];
    
    menu_view.frame=CGRectMake(0,425, 320, 60);
	[edit_image_view addSubview:menu_view];

    
    other_profile_view.frame=CGRectMake(0,420, 320, 60);
	[self.view addSubview:other_profile_view];

    
    more_view.frame=CGRectMake(0,0, 320, 480);
	[self.view addSubview:more_view];
    more_view.alpha=0.0;

    rate_view.frame=CGRectMake(0,0, 320, 480);
	[self.view addSubview:rate_view];
    rate_view.alpha=0.0;
    
    rating_tbl_view.frame=CGRectMake(0,0, 320, 480);
	[rate_view addSubview:rating_tbl_view];
    rating_tbl_view.alpha=0.0;

    edit_image_view.frame=CGRectMake(0,0, 320, 480);
	[self.view addSubview:edit_image_view];
    edit_image_view.alpha=0.0;

    
    desc_view.frame=CGRectMake(0,-480, 320, 480);
	[edit_image_view addSubview:desc_view];
    
    
    add_desc_view.frame=CGRectMake(0,-480, 320, 480);
	[self.view addSubview:add_desc_view];
    
    profile_image_view.frame=CGRectMake(0,-480, 320, 480);
	[self.view addSubview:profile_image_view];

    
    sel_scrollview=[[UIScrollView alloc]init];
    [sel_scrollview setFrame:CGRectMake(0,275, 320, 58)];
    sel_scrollview.clipsToBounds = YES;
	sel_scrollview.delegate = self;
    [edit_image_view addSubview:sel_scrollview];

    
    
    //rating_tbl_view.alpha=0.0;

    
    
    if (view_profile_bool==TRUE)
    {
        NSLog(@"profile true");
        other_profile_view.hidden=NO;
        user_profile_view.hidden=YES;
        menu_view.hidden=YES;
        
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.distanceFilter = kCLDistanceFilterNone;
        [locationManager startUpdatingLocation];
        
        
        latitude_arr = [[NSMutableArray alloc]init];
        longtude_arr = [[NSMutableArray alloc]init];
        
        distance_Km_show_lbl.hidden=NO;
        distance_show_lbl.hidden=NO;
        
        
    }
    else
    {
        NSLog(@"profile false");
        other_profile_view.hidden=YES;
        user_profile_view.hidden=NO;
        menu_view.hidden=NO;
        
        distance_Km_show_lbl.hidden=YES;
        distance_show_lbl.hidden=YES;
        
        
        
    }

    
    activity =[[LabeledActivityIndicatorView alloc]initWithController:self andText:@"Processing..."];
    [self readlogin];
    profile_view.frame=CGRectMake(321,130, 320, 353);
	[self.view addSubview:profile_view];
    

      [scrollview setContentSize:CGSizeMake(320, 1500)];
       scrollview.scrollEnabled = YES;
   // view_profile_bool=TRUE;
   
           [self performSelectorInBackground:@selector(json_call) withObject:nil];
    
    
           [self performSelectorInBackground:@selector(favorite_call) withObject:nil];

   

            [self performSelectorInBackground:@selector(call_votes) withObject:nil];
    
    [self performSelectorInBackground:@selector(fetch_ratings) withObject:nil];
    [self performSelectorInBackground:@selector(call_images) withObject:nil];

  // [self performSelector:@selector(fetch_ratings) withObject:nil afterDelay:0.10];
  
    [self performSelectorInBackground:@selector(call_gifts) withObject:nil];

    rate_scroll=[[UIScrollView alloc]init];
    [rate_scroll setFrame:CGRectMake(0,38, 139, 29)];
    rate_scroll.clipsToBounds = YES;
	rate_scroll.delegate = self;
    [self.view addSubview:rate_scroll];
    
    
    votes_scrollview=[[UIScrollView alloc]init];
    [votes_scrollview setFrame:CGRectMake(0,38, 139, 29)];
    votes_scrollview.clipsToBounds = YES;
	votes_scrollview.delegate = self;
    [self.view addSubview:votes_scrollview];
    
    NSLog(@"global_show_msg_iconstr%@:",global_show_msg_iconstr);
    
    if([global_show_msg_iconstr isEqualToString:@"1"])
    {
        NSLog(@"enter in msg");
        global_msg_btn.hidden=NO;
        global_msg_icon.hidden=NO;
        
    }else if([global_show_msg_iconstr isEqualToString:@"0"])
    {
        NSLog(@"enter in msg hiden");
        global_msg_btn.hidden=YES;
        global_msg_icon.hidden=YES;
    }
    
    //ac = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];

}

-(void)callPreviousSetImg{
    
    [backToPrevious setImage:[UIImage imageNamed:@"left.png"] forState:UIControlStateNormal];
}
-(IBAction)Give_gifts
{
    Give_gift_view *gift_view=[[Give_gift_view alloc]initWithNibName:@"Give_gift_view" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:gift_view animated:NO];

}

-(IBAction)back
{
    
    if([globalCheckFavorites isEqualToString:@"Favorites"]){
        NSLog(@"Favo:%@",globalCheckFavorites);
        
        Favorites_list *favScreen = [[Favorites_list alloc]initWithNibName:@"Favorites_list" bundle:[NSBundle mainBundle]];
        [self.navigationController pushViewController:favScreen animated:NO];
        
    }if([globalCheckFavorites isEqualToString:@"SearchResults"]){
        NSLog(@"Favo1:%@",globalCheckFavorites);
        Search_list *serchList = [[Search_list alloc]initWithNibName:@"Search_list" bundle:[NSBundle mainBundle]];
        [self.navigationController pushViewController:serchList animated:NO];
        
    }else if([globalCheckFavorites isEqualToString:@""]){
    NSLog(@"Favo3:%@",globalCheckFavorites);
    
    Menupage *preview=[[Menupage alloc]initWithNibName:@"Menupage" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:preview animated:NO];

    }
    
    
/*
    RootViewController *gift_view=[[RootViewController alloc]initWithNibName:@"RootViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:gift_view animated:NO];
    
*/

}

-(IBAction)select_image
{
    
    UIImagePickerControllerSourceType sourceType = 	UIImagePickerControllerSourceTypePhotoLibrary; 
    UIImagePickerController *picker = [[UIImagePickerController alloc] init]; 
    picker.delegate = self; 
    //picker.allowsImageEditing = YES;
    picker.allowsEditing = YES;
    
	//picker.allowsEditing = YES;
    picker.sourceType = sourceType; 
    [self presentModalViewController:picker animated:YES]; 
    [picker release]; 
    
    
    
}
-(IBAction)take_image
{
    BOOL isCamera = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
	if (isCamera==YES)
	{
        UIImagePickerControllerSourceType sourceType = 	UIImagePickerControllerSourceTypeCamera; 
        UIImagePickerController *picker = [[UIImagePickerController alloc] init]; 
        picker.delegate = self; 
        //picker.allowsImageEditing = YES;
        picker.allowsEditing = YES;
        picker.sourceType = sourceType; 
        [self presentModalViewController:picker animated:YES]; 
        [picker release]; 
         
	}
	else 
	{
        
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"No Camera Available" message:@"Sorry, It seems you dont have camera on this device. Please select a picture from your album. " delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
    
    
    
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo 
{ 
	//selectImage = YES;
	globImg = [[UIImage alloc]init];
	[globImg retain];
	globImg = image;
	[globImg retain];	
	NSLog(@"globImg:%@",globImg);
	[globImg retain];
	[picker dismissModalViewControllerAnimated:YES];
    profile_add_image.image= globImg;
}
-(IBAction)Addtofavorites
{
    allow_fav_bool=TRUE;
   
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading...";
    
    [self readlogin];
    str_country = [[NSString alloc]initWithFormat:@"http://192.168.0.111/DatingService/userProfile.svc/isAllowedFavorites/%@/%@",login_select,userid_string];
    


NSLog(@"str_country:%@",str_country);

NSMutableURLRequest *request =[[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:str_country]];

NSData *returnData = [ NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil ];

NSString *returnString = [[NSString alloc]initWithData:returnData encoding:NSUTF8StringEncoding];

    returnString = [returnString stringByReplacingOccurrencesOfString:@"\""
                                                               withString:@""];
//NSLog(@"returnString:*%@*",returnString);


    if ([returnString isEqualToString:@"true"]) 
    {
         [MBProgressHUD hideHUDForView:self.view animated:YES];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Favorites" message:@"Add to favorites list" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel",nil];
        [alert show];
        [alert release];
        
        fav_list_boolvalue =TRUE;
        allow_fav_bool=FALSE;

    }
    else
    {
        [MBProgressHUD hideHUDForView:self.view animated:YES];

        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Favorites" message:@"Cannot add to favorites" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel",nil];
        [alert show];
        [alert release];

        
          fav_list_boolvalue =FALSE;
    }
    
    
}

-(void)add_fav
{

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading...";
    
    [self readlogin];
    NSURL *url = [NSURL URLWithString:@"http://192.168.0.111/DatingService/userProfile.svc/processAddFriend/"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    
    NSString *str_url=[[NSString alloc]initWithFormat:@"{\"selectedUserID\":\"%@\",\"userID\":\"%@\"}",userid_string,login_select];
    
    NSLog(@"str_url:%@",str_url);
    [request appendPostData:[str_url dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    //[request addRequestHeader:@"Accept" value:@"application/json"];
    [request setRequestMethod:@"POST"];
    [request setDelegate:self];
    [request startAsynchronous];

}
-(void)remove_fav
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading...";
    
    [self readlogin];
    NSURL *url = [NSURL URLWithString:@"http://192.168.0.111/DatingService/userProfile.svc/processRemoveFriend/"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    
    NSString *str_url=[[NSString alloc]initWithFormat:@"{\"selectedUserID\":\"%@\",\"userID\":\"%@\"}",userid_string,login_select];
    
    NSLog(@"str_url:%@",str_url);
    [request appendPostData:[str_url dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    //[request addRequestHeader:@"Accept" value:@"application/json"];
    [request setRequestMethod:@"POST"];
    [request setDelegate:self];
    [request startAsynchronous];


}
-(IBAction)Remove_from_fav
{

    remove_list_boolvalue=TRUE;
    fav_list_boolvalue=FALSE;
    wink_bool_value=TRUE;
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Remove from favorites list" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel",nil];
    [alert show];
    [alert release];
   

}
- (void)requestFinished:(ASIHTTPRequest *)request
{    
    
    if (request.responseStatusCode == 400) {
        
               
        
        
        if (rating_bool==TRUE)
        {   [MBProgressHUD hideHUDForView:rate_view animated:YES];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Rating failed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];

        }
        
        else if(allow_fav_bool==TRUE)
        {
        
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Cannot added to favorites list" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];

        
        }
        
        else if(fav_list_boolvalue==TRUE)
        {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Cannot added to favorites list" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];

        }
        
        else if(remove_list_boolvalue==TRUE)
        {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Cannot remove from favorites list" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
            
        }

        
        else if(wink_bool_value==TRUE)
        {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Cannot wink" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
            
        }

        
        
    } else if (request.responseStatusCode == 403) {
        
        if (rating_bool==TRUE)
        {   [MBProgressHUD hideHUDForView:rate_view animated:YES];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Rating failed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
            
                      
        }
        
        else if(allow_fav_bool==TRUE)
        {
            
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Cannot added to favorites list" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
            
            
        }
        
        else if(fav_list_boolvalue==TRUE)
        {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Cannot added to favorites list" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
            
        }
        
        else if(remove_list_boolvalue==TRUE)
        {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Cannot remove from favorites list" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
            
        }
        
        
        else if(wink_bool_value==TRUE)
        {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Cannot wink" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
            
        }
        
        else if(del_bool==TRUE)
        {
            [MBProgressHUD hideHUDForView:edit_image_view animated:YES];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Not deleted" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
            
        }
        
        else if(default_bool==TRUE)
        {
            [MBProgressHUD hideHUDForView:edit_image_view animated:YES];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"cannot set as profile image" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
            
        }

        
        else if(edit_bool==TRUE)
        {
            [MBProgressHUD hideHUDForView:edit_image_view animated:YES];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Description not changed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
            
        }

        else if(upload_bool==TRUE)
        {
            [MBProgressHUD hideHUDForView:add_desc_view animated:YES];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Image cannot upload.Try again later." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
            
        }


    } else if (request.responseStatusCode == 200) {
        
        
        NSString *responseString = [request responseString];
        NSLog(@"responseString:%@",responseString);
        
        
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\""
                                                                   withString:@""];
        
        fetch_uid=[[NSString alloc]initWithFormat:@"%@",responseString];
        NSLog(@"fetch_uid:%@",fetch_uid);   
        NSDictionary *responseDict = [responseString JSONValue];
        NSLog(@"responseDict:%@",responseDict);
        NSString *unlockCode = [responseDict objectForKey:@"unlock_code"];
        
        if ([unlockCode compare:@"com.razeware.test.unlock.cake"] == NSOrderedSame)
        {  [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            
            if (fav_list_boolvalue==TRUE)
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Added to favorites list" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                [alert release];
                
                fav_list_boolvalue=FALSE;
                fav_btn.hidden=YES;
                remove_fav_btn.hidden=NO;

            }
            else if (remove_list_boolvalue==TRUE)
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Remove From favorites list" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                [alert release];
                
                remove_list_boolvalue=FALSE;
                fav_btn.hidden=NO;
                remove_fav_btn.hidden=YES;

                
            }
            
            else if (wink_bool_value==TRUE)
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:responseString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                [alert release];
                
                wink_bool_value=FALSE;
                [wink_btn setImage:[UIImage imageNamed:@"winked.png"] forState:UIControlStateNormal];
                

                
                
            }

            else if (rating_bool==TRUE)
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Rated the user successfully"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                [alert release];
                
                 [MBProgressHUD hideHUDForView:rate_view animated:YES];
                rating_bool=FALSE;
                [self hide_rate_popup];
                //[self viewDidLoad];
                
                [self fetch_ratings];
                
                
            }
            else if(del_bool==TRUE)
            {
                [MBProgressHUD hideHUDForView:edit_image_view animated:YES];
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Deleted pic" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                [alert release];
                
            }
            
            else if(default_bool==TRUE)
            {
                [MBProgressHUD hideHUDForView:edit_image_view animated:YES];
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Profile image set" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                [alert release];
                
            }
            
            
            else if(edit_bool==TRUE)
            {
                [MBProgressHUD hideHUDForView:edit_image_view animated:YES];
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Description  changed sucessfully" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                [alert release];
                
            }
            
            
            
            else if(upload_bool==TRUE)
            {
                [MBProgressHUD hideHUDForView:add_desc_view animated:YES];
                               
                if (fetch_uid==nil)
                {
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Image cannot upload.Try again later." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                    [alert release];

                }
                
                else 
                {
                    
                    NSLog(@"upload_bool==TRUE success_upload");
//                    [self performSelector:@selector(success_upload) withObject:nil afterDelay:2.0];
                    
                    [self success_upload];
                    
                }
                
                

            
            }
            

            
            
        } else 
        {    
            if (rating_bool==TRUE)
            {   [MBProgressHUD hideHUDForView:rate_view animated:YES];
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:responseString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                [alert release];
                
            }
            
            else if(allow_fav_bool==TRUE)
            {
                
                
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Cannot added to favorites list" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                [alert release];
                
                
            }
            
            else if(fav_list_boolvalue==TRUE)
            {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Cannot added to favorites list" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                [alert release];
                
            }
            
            else if(remove_list_boolvalue==TRUE)
            {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Cannot remove from favorites list" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                [alert release];
                
            }
            
            
            else if(wink_bool_value==TRUE)
            {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Cannot wink" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                [alert release];
                
            }  
            
            
            
            else if(del_bool==TRUE)
            {
                [MBProgressHUD hideHUDForView:edit_image_view animated:YES];
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Not deleted" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                [alert release];
                
            }
            
            else if(default_bool==TRUE)
            {
                [MBProgressHUD hideHUDForView:edit_image_view animated:YES];
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"cannot set as profile image" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                [alert release];
                
            }
            
            
            else if(edit_bool==TRUE)
            {
                [MBProgressHUD hideHUDForView:edit_image_view animated:YES];
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Description not changed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                [alert release];
                
            }  
        
            else if(upload_bool==TRUE)
            {
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Image cannot upload.Try again later." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                [alert release];
                
            }

        
        
        }
        
    } else 
    {
        if (rating_bool==TRUE)
        {   [MBProgressHUD hideHUDForView:rate_view animated:YES];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Rating failed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
            
        }
        
        else if(allow_fav_bool==TRUE)
        {
            
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Cannot added to favorites list" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
            
            
        }
        
        else if(fav_list_boolvalue==TRUE)
        {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Cannot added to favorites list" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
            
        }
        
        else if(remove_list_boolvalue==TRUE)
        {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Cannot remove from favorites list" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
            
        }
        
        
        else if(wink_bool_value==TRUE)
        {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Cannot wink" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
           
            
            
        }  
        else if(del_bool==TRUE)
        {
            [MBProgressHUD hideHUDForView:edit_image_view animated:YES];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Not deleted" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
            
        }
        
        else if(default_bool==TRUE)
        {
            [MBProgressHUD hideHUDForView:edit_image_view animated:YES];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"cannot set as profile image" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
            
        }
        
        
        else if(edit_bool==TRUE)
        {
            [MBProgressHUD hideHUDForView:edit_image_view animated:YES];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Description not changed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
            
        }
        
        else if(upload_bool==TRUE)
        {
            [MBProgressHUD hideHUDForView:add_desc_view animated:YES];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Image cannot upload.Try again later." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
            
        }

    
    }
    
}

- (void)requestFailed:(ASIHTTPRequest *)request
{    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    NSError *error = [request error];
    NSLog(@"error:%@",error);
    
    if (rating_bool==TRUE)
    {   [MBProgressHUD hideHUDForView:rate_view animated:YES];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Rating failed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
    }
    
    else if(allow_fav_bool==TRUE)
    {
        
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Cannot added to favorites list" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
    }
    
    else if(fav_list_boolvalue==TRUE)
    {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Cannot added to favorites list" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
    }
    
    else if(remove_list_boolvalue==TRUE)
    {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Cannot remove from favorites list" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
    }
    
    
    else if(wink_bool_value==TRUE)
    {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Cannot wink" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
    }
    else if(del_bool==TRUE)
    {
        [MBProgressHUD hideHUDForView:edit_image_view animated:YES];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Not deleted" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
    }
    
    else if(default_bool==TRUE)
    {
        [MBProgressHUD hideHUDForView:edit_image_view animated:YES];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"cannot set as profile image" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
    }
    
    
    else if(edit_bool==TRUE)
    {
        [MBProgressHUD hideHUDForView:edit_image_view animated:YES];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Description not changed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
    }
    
    else if(upload_bool==TRUE)
    {
        [MBProgressHUD hideHUDForView:add_desc_view animated:YES];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Image cannot upload.Try again later." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
    }

}
-(void)loadtbl
{
    [profile_tbl reloadData];
    [MBProgressHUD hideHUDForView:self.view animated:YES];    


}
-(void)favorite_call
{
    // [self readlogin];
    @try
    {

   
    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];

    user_id_arr=[[NSMutableArray alloc]init];
    
    NSString *str_country_12 = [[NSString alloc]initWithFormat:@"http://192.168.0.111/DatingService/getDetails.svc/scrollGalleryFavorites/%@",login_select];
    
    NSLog(@"str_country_12:%@",str_country_12);
    
    NSMutableURLRequest *request =[[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:str_country_12]];
    
    NSData *returnData = [ NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil ];
    
    NSString *returnString = [[NSString alloc]initWithData:returnData encoding:NSUTF8StringEncoding];
    
   // NSLog(@"returnString:*%@*",returnString);
    
    
    NSDictionary *dict=[returnString JSONValue];
        if (dict==nil||dict==NULL)
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"No Response From Server" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
        
        
        else {
            
    
    NSDictionary *str123 = [dict objectForKey:@"scrollGalleryFavoritesResult"];
    NSLog(@"str123:%@",str123);
    
    
    if (str123==nil||str123==NULL)
        
     {
         UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Favorite Not Available" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
         [alert show];
         [alert release];
    }
    
    else 
    {
        
 
    
    for (NSDictionary *info in str123)
    {
        
          
        NSString  *id_string=[[NSString alloc]initWithFormat:@"%@",[info objectForKey:@"userID"]];
        NSLog(@"id_string:%@",id_string);
        [user_id_arr addObject:id_string];
        NSLog(@"user_id_arr:*%@*",user_id_arr);
    }
    
    
    
        [self fav_result];
      
    
    
    }
    [self performSelectorOnMainThread:@selector(fav_result) withObject:nil waitUntilDone:YES];
    

    
    [pool release];
    }
    }
    @catch (NSException *exception)
    {
        NSLog(@"main: Caught %@: %@", [exception name], [exception reason]);
    }
}

-(void)fav_result
{
    
    if ([user_id_arr containsObject:global_string])
    {
        
        fav_btn.hidden=YES;
        remove_fav_btn.hidden=NO;
    }
    else
    {
        fav_btn.hidden=NO;
        remove_fav_btn.hidden=YES;
    }



}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"Alert index:%d",buttonIndex);
    
    if(buttonIndex==0)
    {
        if (fav_list_boolvalue==TRUE)
        {
            [self add_fav];
        }
        else if (remove_list_boolvalue==TRUE)
        {
            [self remove_fav];
        }
        
        else if (wink_bool_value==TRUE)
        {
            [self wink_date];
        }
        
        else if (rating_bool==TRUE)
        {
            //rating_bool =FALSE;
            [self sumbit_json];
        }
        else if (edit_bool==TRUE)
        {
            [self edit_description];
            
            
        }
        else if (del_bool==TRUE)
        {
            [self delete_pic];
        }
        else if (default_bool==TRUE)
        {
            [self default_image];
        }


        //[self mailaction];
    }
    else if(buttonIndex==1)
    {
        
    }
}

-(void)wink_date
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading...";
    
    [self readlogin];
    NSURL *url = [NSURL URLWithString:@"http://192.168.0.111/DatingService/Wink.svc/processWink/"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    
    NSString *str_url=[[NSString alloc]initWithFormat:@"{\"selectedUserID\":\"%@\",\"userID\":\"%@\"}",userid_string,login_select];
    
    NSLog(@"str_url:%@",str_url);
    [request appendPostData:[str_url dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    //[request addRequestHeader:@"Accept" value:@"application/json"];
    [request setRequestMethod:@"POST"];
    [request setDelegate:self];
    [request startAsynchronous];




}
-(IBAction)view_btn:(id)sender
{
    UIButton *tapped=(UIButton*)sender;
    
   if([tapped.currentImage isEqual:[UIImage imageNamed:@"rateview_btn.png"]])
   {
       UIImage *buttonImage=[UIImage imageNamed:@"viewgifts_btn.png"];
       [tapped setImage:buttonImage forState:UIControlStateNormal]; 
       rate_vote_tbl.hidden=NO;
       gifts_scroll.hidden=YES;
       
       nogift_lbl.hidden=YES;
       gift_rate_lbl.text=@"Ratings";
       NSLog(@"Mani1");
   
   }
    
   else 
   {
       
       UIImage *buttonImage=[UIImage imageNamed:@"rateview_btn.png"];
       [tapped setImage:buttonImage forState:UIControlStateNormal]; 
       rate_vote_tbl.hidden=YES;
       gifts_scroll.hidden=NO;
       
       
       if ([gift_desc_arr count]==0)
       {
           nogift_lbl.hidden=NO;
       }
      
       //nogift_lbl.hidden=NO;
       gift_rate_lbl.text=@"Gifts";
       NSLog(@"Mani2");

   }
    

}
-(IBAction)main_back
{

    CGRect frame = profile_view.frame;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    frame.origin.x =321;
    frame.origin.y =130;
    profile_view.frame = frame;
    
    [UIView commitAnimations];

}
-(void)json_call
{
   //[self readlogin];
    
    NSLog(@"login_select:%@",login_select);
    @try
    {
   
    
    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];

    if (view_profile_bool==TRUE)
    {
         str_country = [[NSString alloc]initWithFormat:@"http://192.168.0.111/DatingService/userProfile.svc/retrieveProfile/%@",global_string];
    }
    else 
    {
        NSLog(@"login_selc");
        str_country = [[NSString alloc]initWithFormat:@"http://192.168.0.111/DatingService/userProfile.svc/retrieveProfile/%@",login_select];

    }
      
    
   
       // str_country = [[NSString alloc]initWithFormat:@"http://192.168.0.111/DatingService/userProfile.svc/retrieveProfile/3"];
    
    NSLog(@"str_country :%@",str_country);
    
    NSMutableURLRequest *request =[[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:str_country]];
    
    NSData *returnData = [ NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil ];
    
    NSString *returnString = [[NSString alloc]initWithData:returnData encoding:NSUTF8StringEncoding];
    
   NSLog(@"returnString:*%@*",returnString);
    
    
    NSDictionary *dict=[returnString JSONValue];
   // NSLog(@"dict:%@",dict);
    
    
    if (dict==nil||dict==NULL)
    {
        NSLog(@"dict failed");
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"No Response From Server" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    
    else 
    
    {
        
          for (NSDictionary *info in dict)
    {
        
        
        NSLog(@"info:%@",info);
        
      
        userid_string =[[NSString alloc]initWithFormat:@"%@",[info objectForKey:@"userID"]];
        NSLog(@"userid:%@",userid_string);
        global_gift_to_id=[[NSString alloc]initWithFormat:@"%@",userid_string];
        
        member_string =[info objectForKey:@"userType"];
        if (member_string == (NSString*)[NSNull null])
            
        {
            member_string=@"Not available";
            
        }
        user_arr=[[NSMutableArray alloc]init];
        [user_arr addObject:member_string];
        //member_txt.text=member_string;

        
        name_string =[info objectForKey:@"userName"];
        [user_arr addObject:name_string];
       // username_txt.text=name_string;
        
        
        age_string =[[NSString alloc]initWithFormat:@"%@",[info objectForKey:@"userAge"]];
        if (age_string == (NSString*)[NSNull null]||[age_string isEqualToString:@""]||[age_string isEqualToString:@"<null>"])
            
        {
            age_string=[[NSString alloc]initWithFormat:@"Not Available"];            
        }
        [user_arr addObject:age_string];
        
        bday_string =[info objectForKey:@"BirthDay"];
        
        if ([bday_string isEqualToString:@""]||bday_string==nil||bday_string==NULL)
        {
            bday_string=@"Not Available";
        }
        [user_arr addObject:bday_string];
        bday_txt.text=bday_string;

        
        gender_string =[info objectForKey:@"Gender"];
    
        [user_arr addObject:gender_string];
        
        
        gender_type=[[NSString alloc]initWithFormat:@"%@",[info objectForKey:@"isMale"]];
        gender_string_global = [NSString stringWithString:gender_type];
        NSLog(@"gender_type:%@",gender_type);
       // gender_txt.text=gender_string;
        
        
        email_string =[info objectForKey:@"VerifiedEmail"];
        if (email_string == (NSString*)[NSNull null])
            
        {
            email_string=@"Not available";
            
        }
        [user_arr addObject:email_string];
        //email_txt.text=email_string;

        
        
        mob_string =[info objectForKey:@"VerifiedMobile"];
        if (mob_string == (NSString*)[NSNull null])
            
        {
            mob_string=@"Not available";
            
        }
        [user_arr addObject:mob_string];
     
        //edulevel_txt.text=edulevel_string;
        
        
        lastLogin_string =[info objectForKey:@"lastLogin"];
        if (lastLogin_string == (NSString*)[NSNull null]||[lastLogin_string isEqualToString:@""])
            
        {
            lastLogin_string=@"Not available";
            
        }
        
        [user_arr addObject:lastLogin_string];

           edulevel_string =[info objectForKey:@"EducationLevel"];
        NSLog(@"edulevel_string:%@",edulevel_string);
        
        
        if (edulevel_string == (NSString*)[NSNull null])

        {
            edulevel_string=@"Not available";
            
        }
        //edulevel_txt.text=edulevel_string;
         [user_arr addObject:edulevel_string];
        
             
        race_string =[info objectForKey:@"Ethnicity"];
        if (race_string == (NSString*)[NSNull null])
            
        {
            race_string=@"Not available";
            
        }

        [user_arr addObject:race_string];
        

        //race_txt.text=race_string;
        eyecolor_string =[info objectForKey:@"EyesColorType"];
        if (eyecolor_string == (NSString*)[NSNull null])
            
        {
            eyecolor_string=@"Not available";
            
        }

        
       // eyescolor_txt.text=eyecolor_string;
        
        [user_arr addObject:eyecolor_string];
        
        haircolor_string =[info objectForKey:@"HairColorType"];
        if (haircolor_string == (NSString*)[NSNull null])
            
        {
            haircolor_string=@"Not available";
            
        }
       [user_arr addObject:haircolor_string];
        
       // haircolor_txt.text=haircolor_string;
        
        
        smoker_string =[info objectForKey:@"SmokerType"];
        if (smoker_string == (NSString*)[NSNull null])
            
        {
            smoker_string=@"Not available";
            
        }
        
        [user_arr addObject:smoker_string];

        //smoker_txt.text=smoker_string;
        
        
        
       // mob_txt.text=mob_string;
        
        drinker_string =[info objectForKey:@"DrinkerType"];
        if (drinker_string == (NSString*)[NSNull null])
            
        {
            drinker_string=@"Not available";
            
        }
        
        //drinker_txt.text=drinker_string;

        
          [user_arr addObject:drinker_string];
        
        
        
        looking_string =[info objectForKey:@"LookingFor"];
        if (looking_string == (NSString*)[NSNull null]||[looking_string isEqualToString:@""])
            
        {
            looking_string=@"Not available";
            
        }

        
        //looking_txt.text=looking_string;
          [user_arr addObject:looking_string]; 
        
        
              
        
        height_string =[[NSString alloc]initWithFormat:@"%@",[info objectForKey:@"userHeight"]];
        if (height_string == (NSString*)[NSNull null]||[height_string isEqualToString:@"<null>"])
            
        {
            height_string=[[NSString alloc]initWithFormat:@"Not Available"];
            
        }
        [user_arr addObject:height_string]; 

        //height_txt.text=height_string;
        
        
        weight_string =[[NSString alloc]initWithFormat:@"%@",[info objectForKey:@"userWeight"]];
        if (weight_string == (NSString*)[NSNull null]||[weight_string isEqualToString:@"<null>"])
            
        {
            weight_string=[[NSString alloc]initWithFormat:@"Not Available"];
            
        }
        [user_arr addObject:weight_string]; 

       // weight_txt.text=weight_string;
        
        if([gender_type isEqualToString:@"0"])
        {

        bust_string =[info objectForKey:@"userVitalStatsBust"];
        if (bust_string == (NSString*)[NSNull null])
            
        {
            bust_string=@"Not available";
            
        }
        [user_arr addObject:bust_string]; 

        
        //bust_txt.text=bust_string;
        
        hips_string =[info objectForKey:@"userVitalStatsHips"];
        if (hips_string == (NSString*)[NSNull null])
            
        {
            hips_string=@"Not available";
            
        }

        
       // hips_txt.text=hips_string;
        [user_arr addObject:hips_string]; 

        waist_string =[info objectForKey:@"userVitalStatsWaist"];
        if (waist_string == (NSString*)[NSNull null])
            
        {
            waist_string=@"Not available";
            
        }

        
        //waist_txt.text=waist_string;

        [user_arr addObject:waist_string]; 

       
        }else
        {
            
            [header_arr1 removeObjectAtIndex:17];
            [header_arr1 removeObjectAtIndex:18];
            [header_arr1 removeObjectAtIndex:19];
            [header_arr1 replaceObjectAtIndex:17 withObject:@"Tagline" ];
            [header_arr1 replaceObjectAtIndex:18 withObject:@"Interested In" ];
            [header_arr1 replaceObjectAtIndex:19 withObject:@"Short Desc" ];
            [header_arr1 replaceObjectAtIndex:20 withObject:@"Long Desc" ];
            [header_arr1 replaceObjectAtIndex:21 withObject:@"Search Keywords" ];
            

            
        }
        
        tagline_string =[info objectForKey:@"userTagline"];
        if (tagline_string == (NSString*)[NSNull null]||[tagline_string isEqualToString:@""])
            
        {
            tagline_string=@"Not available";
            
        }
        else 
        {
            status_lbl.text=tagline_string;
        }
        //tagline_txt.text=tagline_string;
        
         [user_arr  addObject:tagline_string];
        
        int_string =[info objectForKey:@"InterestedIn"];
        if (int_string == (NSString*)[NSNull null]||[int_string isEqualToString:@""])
            
        {
            int_string=@"Not available";
            
        }
        
        //interested_txt.text=int_string;
        [user_arr  addObject:int_string];
        
       
        
        shortdesc_string =[info objectForKey:@"userShortDescription"];
        if (shortdesc_string == (NSString*)[NSNull null]||[shortdesc_string isEqualToString:@""])
            
        {
            
            shortdesc_string=@"Not available";
            
        }

               [user_arr  addObject:shortdesc_string];

        
        longdesc_string=[info objectForKey:@"userLongDescription"];
        if (longdesc_string == (NSString*)[NSNull null]||[longdesc_string isEqualToString:@""])
            
        {
            longdesc_string=@"Not available";
            
        }
        
        // long_desc.text=longdesc_string;
        
        
        [user_arr  addObject:longdesc_string];
        
        
        keywords_string=[[NSString alloc]initWithFormat:@"%@",[info                                                   objectForKey:@"userKeywords"]];
        if (keywords_string == (NSString*)[NSNull null]||[keywords_string isEqualToString:@""])
            
        {
            keywords_string=@"Not available";
            
        }
        
        
        //looking_txt.text=looking_string;
        [user_arr addObject:keywords_string];
        
        
       if(([global_string intValue]==[global_string intValue]))
       {
           
           
           
           //////////////////////// Latitude////////////////////////////
           
           latitude_string=[[NSString alloc]initWithFormat:@"%@",[info objectForKey:@"latitude"]];
           NSLog(@"latitude in retrive profile:%@",latitude_string);
           if (latitude_string == (NSString*)[NSNull null])
               
           {
               
               latitude_string=@"";
           }
           else if([latitude_string isEqualToString:@""]||[latitude_string isEqualToString:@"null"]||[latitude_string isEqualToString:@"(null)"]||[latitude_string isEqualToString:@"<null>"]||[latitude_string isEqualToString:@"0"])
           {
               latitude_string=@"";
           }
           
           [latitude_arr addObject:latitude_string];
           NSLog(@"latitude_arr:%@",latitude_arr);
           
           
           
           //////////////longitude/////////////////////
           
           longtude_String=[[NSString alloc]initWithFormat:@"%@",[info objectForKey:@"longitude"]];
           NSLog(@"longitude in retrive profile:%@",longtude_String);
           if (longtude_String == (NSString*)[NSNull null])
               
           {
               longtude_String=@"";
           }
           else if([longtude_String isEqualToString:@""]||[longtude_String isEqualToString:@"null"]||[longtude_String isEqualToString:@"(null)"]||[longtude_String isEqualToString:@"<null>"]||[longtude_String isEqualToString:@"0"])
           {
               longtude_String=@"";
           }
           
           [longtude_arr addObject:longtude_String];
           NSLog(@"longtitude_arr:%@",longtude_arr);
           
           [self LatitudeAndLongitude];
           
           
           
        
       }else{
           NSLog(@"loging current user");
           
       }
        [self performSelectorOnMainThread:@selector(display_image) withObject:nil waitUntilDone:YES];
        
            [self performSelectorOnMainThread:@selector(loadtbl) withObject:nil waitUntilDone:YES];

        
    }

    
       
     
      
    
    if ([name_string isEqualToString:@"(null)"]||[name_string isEqualToString:@""]||name_string==nil||name_string==NULL)
    {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Not Available" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
    }
    else
    {
        
        
        
        
    }
        
    }
    [pool release];
    }
    
    @catch (NSException *exception)
    {
        NSLog(@"main: Caught %@: %@", [exception name], [exception reason]);
    }
}

-(void)LatitudeAndLongitude
{
    NSString *lati_str = [[NSString alloc]initWithFormat:@"%@",[latitude_arr objectAtIndex:0]];
    
    NSString *long_str = [[NSString alloc]initWithFormat:@"%@",[longtude_arr objectAtIndex:0]];
    
    NSLog(@"get lati wh:%@",lati_str);
    NSLog(@"get long wh:%@",long_str);
    
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
        
    distance_Km_show_lbl.text=show_Distance;

}







-(void)call_gifts
{
    @try
    {
    gift_user_img_arr=[[NSMutableArray alloc]init];
    gift_touser_arr=[[NSMutableArray alloc]init];
    gift_fromuser_arr=[[NSMutableArray alloc]init];
    gift_desc_arr=[[NSMutableArray alloc]init];
    final_gifts_arr=[[NSMutableArray alloc]init];
    
  NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];

    if (view_profile_bool==TRUE)
    {
    str_gift_url=[[NSString alloc]initWithFormat:@"http://192.168.0.111/DatingService/userProfile.svc/retrieveUserGifts/%@",global_string];
    }
    else 
    {
        str_gift_url=[[NSString alloc]initWithFormat:@"http://192.168.0.111/DatingService/userProfile.svc/retrieveUserGifts/%@",login_select];
    }
    
    NSMutableURLRequest *request =[[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:str_gift_url]];
    
    NSData *returnData = [ NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil ];
    
    NSString *returnString = [[NSString alloc]initWithData:returnData encoding:NSUTF8StringEncoding];
    
  //  NSLog(@"returnString:*%@*",returnString);
    
    
    NSDictionary *dict=[returnString JSONValue];
 //   NSLog(@"dict:%@",dict);
    
    
        if (dict==nil||dict==NULL)
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"No Response From Server" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
        
        
        else {
            
   
    for (NSDictionary *info in dict)
    {
        
        gift_image_url =[info objectForKey:@"giftImageURL"];
        if (gift_image_url == (NSString*)[NSNull null])
            
        {
               
        }
        
        else 
        {
                     [gift_user_img_arr addObject:gift_image_url];
            NSLog(@"profile_user_img_arr:%@",gift_user_img_arr);
        }
        
        gift_to_user=[info objectForKey:@"toUserID"];
        [gift_touser_arr addObject:gift_to_user];
        
        gift_from_user=[info objectForKey:@"fromUserID"];
        [gift_fromuser_arr addObject:gift_from_user];

        gift_desc=[info objectForKey:@"giftDescription"];
        [gift_desc_arr addObject:gift_desc];

        

        
    }
    
    
    for (int i=0; i<[gift_user_img_arr count]; i++)
    {
               
        NSString *string_final=[[NSString alloc]initWithFormat:@"%@",[gift_user_img_arr objectAtIndex:i]];
        
        NSString *str_image_url_1 = [[NSString alloc]initWithFormat:@"http://192.168.0.111/Dating/images/gifts/"];
        
        NSString  *str_image_url_12 =[[NSString alloc]initWithFormat:@"%@",[str_image_url_1 stringByAppendingString:string_final]];
        
        
        [final_gifts_arr addObject:str_image_url_12];
        NSLog(@"final_gifts_arr:%@",final_gifts_arr);
        

    }
    
  [self performSelectorOnMainThread:@selector(display_gift) withObject:nil waitUntilDone:YES];
    }
   [pool release];
    }
    @catch (NSException *exception)
    {
        NSLog(@"main: Caught %@: %@", [exception name], [exception reason]);
    }
}

-(IBAction)Wink_user
{
    
    remove_list_boolvalue=FALSE;
    fav_list_boolvalue=FALSE;
    wink_bool_value=TRUE;
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Wink" message:@"Send a wink to user?" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel",nil];
    [alert show];
    [alert release];


}
-(void)display_gift
{
    
  /*  if ([gift_desc_arr count]==0)
    {
        nogift_lbl.hidden=NO;
    }
    else
    {
        nogift_lbl.hidden=YES;
        
    }

      */
    
    if([final_gifts_arr count]==0)
    {
       nogift_lbl.hidden=NO; 
    }
    else
    {
        nogift_lbl.hidden=YES;
    }
    int var1 = [final_gifts_arr count];
    
    NSLog(@"count:%d",[final_gifts_arr count]);
    NSLog(@"count_var:%d",var1);
    
    int var2= var1/1;
    int count=0;
	int offset1 =1;
   
    int x=10,y=5;
    for (int row = 0; row<var2;row++)
    {
        NSLog(@"row:%d",row);
        x=0;
        offset1=1;
        NSLog(@"x:%d",x);

        for (int col = 0; col<2;col++)
        {  
            NSLog(@"col:%d",col);
            if(count<var1)
            {
				
                NSLog(@"y:%d",y);

                
//                gift_imageview=[[UIImageView alloc]initWithFrame:CGRectMake(x+offset1,y, 65, 60)];
//
//                
//                [gifts_scroll addSubview:gift_imageview];
//             
                
                
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake(x+offset1,y, 65, 60);
				btn.backgroundColor=[UIColor clearColor];
                
                if (view_profile_bool==TRUE)
                {
                    
                   
                }
                else
                {
                     //[btn addTarget:self action:@selector(gift_select:) forControlEvents:UIControlEventTouchUpInside];
                }
				     
                
				[gifts_scroll addSubview:btn];
				btn.tag =count;

                
                      
                NSString *str_lbl=[[NSString alloc]initWithFormat:@"%@",[gift_desc_arr objectAtIndex:count]];
                
                UILabel *dateLbl = [[UILabel alloc]initWithFrame:CGRectMake(x+offset1, y+40,80, 55)];
                dateLbl.text = str_lbl;
                dateLbl.backgroundColor = [UIColor clearColor];
                dateLbl.font = [UIFont systemFontOfSize:10];
                dateLbl.textColor =[UIColor whiteColor]; 
                dateLbl.lineBreakMode=UILineBreakModeWordWrap;
                dateLbl.numberOfLines = 2;
                [gifts_scroll addSubview:dateLbl];

                
                
                NSString *gift=[[NSString alloc]initWithFormat:@"%@",[final_gifts_arr objectAtIndex:count]];
                
                NSLog(@"Gift:%@",gift);
                
                
                
                AsyncImageView1 *imgPhoto = [[AsyncImageView1 alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 65.0f, 60.0f)];
                imgPhoto.contentMode = UIViewContentModeScaleAspectFill;
                imgPhoto.clipsToBounds = YES;
                imgPhoto.tag = ASYNC_IMAGE_TAG;
                [btn addSubview:imgPhoto];
                
                
                AsyncImageView1 *imageView1 = (AsyncImageView1 *)[btn viewWithTag:ASYNC_IMAGE_TAG];
                //cancel loading previous image for cell
                [[AsyncImageLoader sharedLoader] cancelLoadingURL:imageView1.imageURL];
                imageView1.imageURL = [NSURL URLWithString:[final_gifts_arr objectAtIndex:count]];
                
                
             //   NSLog(@"gift:%@",gift);
//                [gift_imageview setImageFromUrl:gift
//                                       completion:^(void) 
//                 {}];
                
             [gifts_scroll setContentSize:CGSizeMake(157, y+80)];
                   
                x+=35;
				offset1=offset1+x;
				
            }
            else
            {
				NSLog(@"sdfsdfs ");
            }
            
			count++;
        }
        y+=80;
    }


   }

- (IBAction)btnKeyboardDisappear:(id)sender {
    
    [self.view endEditing:YES];
}

-(IBAction)gift_select:(UIButton*)sender
{

    view_profile_bool=FALSE;
    nogift_lbl.hidden=YES;
    UIButton *gift_btn=(UIButton*)sender;
    
    int gift_id=gift_btn.tag;
    
    
    view_profile_bool=TRUE;
    global_string=[[NSString alloc]initWithFormat:@"%@",[gift_fromuser_arr objectAtIndex:gift_id]];
    
    [self viewDidLoad];
    

}
-(void)call_images
{// [self readlogin];
    
    
    NSLog(@"enter call images");
    @try
    {

    profile_img.image=Nil;
    
    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
    
   

    profile_user_img_arr=[[NSMutableArray alloc]init];
    final_img_arr=[[NSMutableArray alloc]init];
    user_file_desc_arr=[[NSMutableArray alloc]init];
    user_file_id=[[NSMutableArray alloc]init];
    file_type_arr=[[NSMutableArray alloc]init];
        profile_pic_arr = [[NSMutableArray alloc]init];
        profile_user_img_arr = [[NSMutableArray alloc]init];
    if (view_profile_bool==TRUE)
    {
      str_image_url = [[NSString alloc]initWithFormat:@"http://192.168.0.111/DatingService/userProfile.svc/retrieveFiles/%@",global_string];
        NSLog(@"str_image_url:%@",str_image_url);
    }
    
    else
    {
        str_image_url = [[NSString alloc]initWithFormat:@"http://192.168.0.111/DatingService/userProfile.svc/retrieveFiles/%@",login_select];
    }
  
    
  
    NSMutableURLRequest *request =[[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:str_image_url]];
    
    NSData *returnData = [ NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil ];
    
    NSString *returnString = [[NSString alloc]initWithData:returnData encoding:NSUTF8StringEncoding];
    
   NSLog(@"returnStringRetriveFiles:*%@*",returnString);
    
    
    NSDictionary *dict=[returnString JSONValue];
   NSLog(@"dictRetriveFiles:%@",dict);
    
    
        if (dict==nil||dict==NULL)
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"No Response From Server" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
        
        
        else {
            
    
    for (NSDictionary *info in dict)
    {
        
        profile_user_img =[info objectForKey:@"userFileScreenshotURL"];
        //if (profile_user_img == (NSString*)[NSNull null]||[profile_user_img isEqualToString:@"null"]|| [profile_user_img isEqualToString:@"(null)"]||[profile_user_img isEqualToString:@"<null>"]||profile_user_img==nil||profile_user_img==NULL )
            
        //{
           
            
            
        //}
        
        //else
        //{
           // [profile_user_img_arr addObject:profile_user_img];
           // NSLog(@"profile_user_img_arr:%@",profile_user_img_arr);
        //}
        
        [profile_user_img_arr addObject:profile_user_img];
        NSLog(@"profile_user_img_arr:%@",profile_user_img_arr);

        
        
        user_file_desc=[info objectForKey:@"userFileDescription"];
        
        
         [user_file_desc_arr addObject:user_file_desc];

        user_file_id_str=[[NSString alloc]initWithFormat:@"%@",[info objectForKey:@"userFileID"]];
        [user_file_id addObject:user_file_id_str];
        
        NSLog(@"user_file_id:%@",user_file_id);
        
        user_file_type=[[NSString alloc]initWithFormat:@"%@",[info objectForKey:@"userFileTypeID"]];
        [file_type_arr addObject:user_file_type];
        NSLog(@"file_type:%@",file_type_arr);
        
        profilePic_string = [[NSString alloc]initWithFormat:@"%@",[info objectForKey:@"userFileURL"]];
        NSLog(@"userFileUrlTy:%@",profilePic_string);
        [profile_pic_arr addObject:profilePic_string];
        NSLog(@"profile_pic_arr:%@",profile_pic_arr);
        
        

    }

  
    for (int i=0; i<[profile_user_img_arr count]; i++)
    {
        
        NSString *string_final=[[NSString alloc]initWithFormat:@"%@",[profile_user_img_arr objectAtIndex:i]];
        
       // NSRange rangeUrl = [string_final rangeOfString:@".com"];
        
        //NSLog(@"rangeOfUrlCheck:%lu",(unsigned long)rangeUrl.length);
        
        NSLog(@"string_final img:%@",string_final);
        NSString *value = [string_final substringWithRange:NSMakeRange(0, 4)];
        
        if ([value isEqualToString:@"http"]) {
            
        
        [final_img_arr addObject:string_final];
            NSLog(@"final_img_arr:%@",final_img_arr);
            
        }else{
        NSLog(@"socialUrl:%@",value);
        
        NSString *str_image_url_1 = [[NSString alloc]initWithFormat:@"http://192.168.0.111/Dating/Uploads/"];
        
        
     NSString  *str_image_url_12 =[[NSString alloc]initWithFormat:@"%@",[str_image_url_1 stringByAppendingString:string_final]];
       
     str_image_url_12=[str_image_url_12 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]; 
        
        [final_img_arr addObject:str_image_url_12];
        NSLog(@"final_img_arr:%@",final_img_arr);
        }
        
              
    }
    
      /*
    
        
        for (int l=0; l<[profile_user_img_arr count]; l++)
            
        {
            
            
            NSString *string_final=[[NSString alloc]initWithFormat:@"%@",[profile_user_img_arr objectAtIndex:l]];
            
            string_final=[string_final stringByReplacingOccurrencesOfString:@"<null>" withString:@""];
            NSLog(@"string final image:%@",string_final);
            
            
            NSLog(@"string final value:%@",string_final);
            
            if ([string_final isEqualToString:@"male_icon.png"]||[string_final isEqual:@"profile_pic.png"]||[string_final isEqualToString:@""]||[string_final isEqualToString:@"<null>"]||[string_final isEqualToString:@"(null)"])
                
            {
                NSLog(@"male or female");
                if ([gender_type isEqualToString:@"1"]||[fgender isEqualToString:@"male"])
                {
                    
                    NSLog(@"male icon");
                    new_image_string=[[NSString alloc]initWithFormat:@"http://192.168.0.111/Dating/images/NoPhotoMale.jpg"];
                    
                }
                else if ([gender_type isEqualToString:@"0"]||[fgender isEqualToString:@"female"])
                {
                   
                    NSLog(@"female icon");
                    new_image_string=[[NSString alloc]initWithFormat:@"http://192.168.0.111/Dating/images/NoPhotoFemale.jpg"];
                    
                }
                
                
            }
       
            else
            {
                NSLog(@"upload icon");
                NSString *str_image_url_1 = [[NSString alloc]initWithFormat:@"http://192.168.0.111/Dating/Uploads/"];
                
                new_image_string =[[NSString alloc]initWithFormat:@"%@",[str_image_url_1 stringByAppendingString:string_final]];
                
                
                
                new_image_string=[new_image_string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                NSLog(@"new_image_string:%@",new_image_string);
                
            }
            [final_img_arr addObject:new_image_string];
        }
        
        
       */ 
        
        
    [self performSelectorOnMainThread:@selector(display_image) withObject:nil waitUntilDone:YES];

    }
     [pool release];
    }
    @catch (NSException *exception)
    {
        NSLog(@"main: Caught %@: %@", [exception name], [exception reason]);
    }

    
}

-(void)display_image
{
    @try{
    NSLog(@"enter the display image");
    int offset;
   ac = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(2, 2, 15, 15)];
        
        
        //ac.frame = CGRectMake(2, 2, 15, 15);
        //ac.center = profile_img.center;
        //[ac resignFirstResponder];
        [ac startAnimating];
        [profile_img addSubview:ac];
    [profile_img bringSubviewToFront:ac];
    
   if(profile_img.image==nil)
    {
        
    }
    
    //if([fgender isEqualToString:@"male"]||[fgender isEqualToString:@"female"])
   /*
    if ([new_image_string isEqualToString:@""]||[new_image_string isEqualToString:@"<null>"]||[new_image_string isEqualToString:@"(null)"])
    {
        NSLog(@"enter into new_image_string");
    
    if([fgender isEqualToString:@"male"])
    {
        gender_string_global =@"1";
        profile_user_imgFacebook=[[NSString alloc]initWithFormat:@"http://192.168.0.111/Dating/images/NoPhotoMale.jpg"];
        
    }else if([fgender isEqualToString:@"male"])
    {
        gender_string_global =@"0";
        profile_user_imgFacebook=[[NSString alloc]initWithFormat:@"http://192.168.0.111/Dating/images/NoPhotoFemale.jpg"];
    }
    [profile_img setImageFromUrl:profile_user_imgFacebook
                      completion:^(void)
     {}];
    [self performSelector:@selector(stopAnimating:) withObject:ac afterDelay:1.0];
 
}
*/
    int imagecount =[final_img_arr count];
    
    if ([final_img_arr count]==0)
    {
        NSLog(@"final image zero");
        NSString *profile_user_img1;
        NSLog(@"global_socialIDChec:%@",global_socialLogID);
        //if([global_socialLogID isEqualToString:@""]||[global_socialLogID isEqualToString:NULL] || [global_socialLogID isEqualToString:@"null"]||global_socialLogID == NULL){
            
          //  global_socialLogID =@"";
        if ([gender_string_global isEqualToString:@"0"])
        {
            NSLog(@"enter in profile gender");
      
              profile_user_img1=[[NSString alloc]initWithFormat:@"http://192.168.0.111/Dating/images/NoPhotoFemale.jpg"];
        }
        
        else
        {
            NSLog(@"enter in profile gender2");
             profile_user_img1=[[NSString alloc]initWithFormat:@"http://192.168.0.111/Dating/images/NoPhotoMale.jpg"];
        }
    /*
    }else{
            NSLog(@"checkimg");
            
            if ([global_SocialCheck isEqualToString:@"fbPic"]) {
                
            
            NSLog(@"globalFbPic");
             profile_user_img1=[[NSString alloc]initWithFormat:@"http://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1",global_socialLogID];
        
            }else if ([global_SocialCheck isEqualToString:@"googlePic"]){
                
                NSLog(@"globalGglePic");
                profile_user_img1=[[NSString alloc]initWithFormat:@"%@",global_socialLogID];
                
                
            }else if ([global_SocialCheck isEqualToString:@""]){
                
                
                
            }
            
         }
        */
        NSLog(@"profile_user_img1:%@",profile_user_img1);
        [profile_img setImageFromUrl:profile_user_img1
                          completion:^(void)
         {}];
        [self performSelector:@selector(stopAnimating:) withObject:ac afterDelay:1.0];
        [ac stopAnimating];
        
    }
    
    
    else
    {
    for (int row = 0; row<[final_img_arr count];row++)
	{
        
        offset +=1;

        
        
        UIButton *scroll_btn = [UIButton buttonWithType:UIButtonTypeCustom];
        scroll_btn.frame = CGRectMake(12+row*60,6, 50, 50);
        scroll_btn.backgroundColor=[UIColor clearColor];
        [scroll_btn setBackgroundImage:[UIImage imageNamed:@"profile_bg.png"]forState:UIControlStateNormal];  
        
    
        [scroll_btn addTarget:self action:@selector(image_selct:) forControlEvents:UIControlEventTouchUpInside];
       
         
        
        [img_scroll addSubview:scroll_btn];
        [img_scroll setScrollEnabled:YES];
        scroll_btn.tag =row;

                      
        AsyncImageView1 *imgPhoto = [[AsyncImageView1 alloc] initWithFrame:CGRectMake(2.0f, 2.0f, 50.0f, 50.0f)];
        imgPhoto.contentMode = UIViewContentModeScaleAspectFill;
        imgPhoto.clipsToBounds = YES;
        imgPhoto.tag = ASYNC_IMAGE_TAG;
        [scroll_btn addSubview:imgPhoto];
        
        
        AsyncImageView1 *imageView1 = (AsyncImageView1 *)[scroll_btn viewWithTag:ASYNC_IMAGE_TAG];
        //cancel loading previous image for cell
        [[AsyncImageLoader sharedLoader] cancelLoadingURL:imageView1.imageURL];
        imageView1.imageURL = [NSURL URLWithString:[final_img_arr objectAtIndex:row]];

        imagecount = [final_img_arr count];
        NSLog(@"imagecount%d",imagecount); 
        img_scroll.contentSize = CGSizeMake(50*imagecount+80, 70.0);
        
         if ([[file_type_arr objectAtIndex:row] rangeOfString:[NSString stringWithFormat:@"1"]].location != NSNotFound) 
         {
             
        selectedDJImage =[[NSString alloc]initWithFormat:@"%@",[final_img_arr objectAtIndex:row]];
        
        NSLog(@"selectedDJImage1:%@",selectedDJImage);
        [profile_img setImageFromUrl:selectedDJImage
                          completion:^(void) 
         {}];
             [self performSelector:@selector(stopAnimating:) withObject:ac afterDelay:1.0];
                       
             [ac stopAnimating];

         }
         else 
         {
            NSLog(@"enter in profile pic");
             /*
             selectedDJImage =[[NSString alloc]initWithFormat:@"%@",[final_img_arr objectAtIndex:row]];
             
             NSLog(@"selectedDJImage NsNotFound:%@",selectedDJImage);
             [profile_img setImageFromUrl:selectedDJImage
                               completion:^(void)
              {}];
             [self performSelector:@selector(stopAnimating:) withObject:ac afterDelay:1.0];
             
             
             NSLog(@"enter in profile pic");
             if ([gender_type isEqualToString:@"1"])
             {
                 
                 NSLog(@"male icon");
                 new_image_string=[[NSString alloc]initWithFormat:@"http://192.168.0.111/Dating/images/NoPhotoMale.jpg"];
                 
             }
             else if ([gender_type isEqualToString:@"0"])
             {
                 
                 NSLog(@"female icon");
                 new_image_string=[[NSString alloc]initWithFormat:@"http://192.168.0.111/Dating/images/NoPhotoFemale.jpg"];
                 
             }
             
             
             [profile_img setImageFromUrl:new_image_string
                               completion:^(void)
              {}];
             [self performSelector:@selector(stopAnimating:) withObject:ac afterDelay:1.0];
             
             */
         
         }
        
      		
	}
        
    
    }
  
    }@catch(NSException *e) {
        NSLog(@"ExceptionImage:%@",e);
    }
    
    
}




-(void)stopAnimating:(UIActivityIndicatorView*)ac1
{
    [ac1 stopAnimating];
    [ac stopAnimating];
}


-(void)readlogin
{
    NSString *query = [[NSString alloc] initWithFormat:@"select * from login ORDER BY id DESC LIMIT 1;"];
	sqlite3_stmt *stmt;
	int x = sqlite3_prepare_v2(database,[query UTF8String],-1, &stmt, nil);
	if (x == SQLITE_OK) 
	{
		// Loop through the results and add them to the feeds array
		while(sqlite3_step(stmt) == SQLITE_ROW) 
		{
			NSString *loginstr = [[NSString alloc]initWithUTF8String:(char *)sqlite3_column_text(stmt, 1)];
            NSLog(@"loginstr:%@",loginstr);
            
            login_select=[[NSString alloc]initWithFormat:@"%@",loginstr];
            NSLog(@"login_select:%@",login_select);
            
		}
        
        
	}
	sqlite3_finalize(stmt);	
    
    global_gift_id=[[NSString alloc]initWithFormat:@"%@",login_select];

    
}
-(void)call_votes
{// [self readlogin];
    @try
    {
         NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
    only_rate_arr=[[NSMutableArray alloc]init];
    only_votes_arr=[[NSMutableArray alloc]init];

   
    if (view_profile_bool==TRUE)
    {
        
        string_url = [[NSString alloc]initWithFormat:@"http://192.168.0.111/DatingService/userProfile.svc/retrieveUserRating/%@",global_string];
    }
    else
    {
        string_url = [[NSString alloc]initWithFormat:@"http://192.168.0.111/DatingService/userProfile.svc/retrieveUserRating/%@",login_select];
    }
    NSMutableURLRequest *request =[[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:string_url]];
    
    NSData *returnData = [ NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil ];
    
    NSString *returnString = [[NSString alloc]initWithData:returnData encoding:NSUTF8StringEncoding];
   
   // NSLog(@"returnString:*%@*",returnString);
    if ([returnString isEqualToString:@"[]"])
    {
        
        //        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Ratings Not Available" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        //        [alert show];
        //        [alert release];
    }
    
    
    
    
    else 
    {
        
        
        NSDictionary *dict=[returnString JSONValue];
       // NSLog(@"dictvotes:%@",dict);
        
        
        if (dict==nil||dict==NULL)
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"No Response From Server" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
        
        
        else {
            
            
            for (NSDictionary *info in dict)
            {
                
                only_votes_str=[[NSString alloc]initWithFormat:@"%@",[info objectForKey:@"votes"]];
                NSLog(@"votes_string:%@",only_votes_str);
                              
                only_rate_str=[[NSString alloc]initWithFormat:@"%@",[info objectForKey:@"rating"]];
                
                NSLog(@"rating:%@",only_rate_str);
                
                           
                
            }
            
            
            
            [activity hide];
            //[self performSelectorOnMainThread:@selector(load_votes) withObject:nil waitUntilDone:YES];
        }
        
    }
    
    [pool release];
    }
    @catch (NSException *exception)
    {
        NSLog(@"main: Caught %@: %@", [exception name], [exception reason]);
    }
    
}
-(void)fetch_ratings
{
    @try {
        
          NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
    rating_arr=[[NSMutableArray alloc]init];
    rating_desc_arr=[[NSMutableArray alloc]init];
    voting_arr=[[NSMutableArray alloc]init];
    rating_user_arr=[[NSMutableArray alloc]init];
    final_arr=[[NSMutableArray alloc]init];
    [self readlogin];
     if (view_profile_bool==TRUE)
     {
    
     str_image_url12 = [[NSString alloc]initWithFormat:@"http://192.168.0.111/DatingService/userProfile.svc/retrieveUserRatingDetails/%@",global_string];
     }
     else
     {
         str_image_url12 = [[NSString alloc]initWithFormat:@"http://192.168.0.111/DatingService/userProfile.svc/retrieveUserRatingDetails/%@",login_select];
     }
    NSMutableURLRequest *request =[[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:str_image_url12]];
    
    NSData *returnData = [ NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil ];
    
    NSString *returnString = [[NSString alloc]initWithData:returnData encoding:NSUTF8StringEncoding];
    
   NSLog(@"returnStringRatings:*%@*",returnString);
    if ([returnString isEqualToString:@"[]"])
    {
        
      // UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Ratings Not Available" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        //[alert show];
        //[alert release];
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
    
               
        
        rating_desc_show_str=[[NSString alloc]initWithFormat:@"%@",[info objectForKey:@"userRatingDescription"]];
        
        NSLog(@"rating_desc_show_str:%@",rating_desc_show_str);

        [rating_desc_arr addObject:rating_desc_show_str];
        
           rating_str=[[NSString alloc]initWithFormat:@"From %@",[info objectForKey:@"userName"]];
        NSLog(@"rating_str:%@",rating_str);

        [rating_user_arr addObject:rating_str];
        
        rate_show=[[NSString alloc]initWithFormat:@"%@",[info objectForKey:@"userRating"]];
        NSLog(@"rate_show:%@",rate_show);

        [rating_arr addObject:rate_show];
        NSLog(@"rating_arr:%@",rating_arr);

       
    }
    
    
    
   
        }
    
    }
    [activity hide];
   [self performSelectorOnMainThread:@selector(load_rating) withObject:nil waitUntilDone:YES];
    [pool release];
    }
    
    @catch (NSException *exception)
    {
        NSLog(@"main: Caught %@: %@", [exception name], [exception reason]);
    }
}
-(void)load_rating
{
    /*
     int offset1;

    NSString  *str_votes =[[NSString alloc]initWithFormat:@"(%@)",[voting_arr objectAtIndex:0]];
    
    votes_lbl.text=str_votes;
    
    
    final_rate=[[NSString alloc]initWithFormat:@"From %@",[rating_user_arr objectAtIndex:0]];
    
    rate_user_lbl.text=final_rate;
    
    
    desc_show=[[NSString alloc]initWithFormat:@"%@..",[rating_desc_arr objectAtIndex:0]];
    rate_desc_lbl.text=desc_show;
    
    
    
    rate_count_str=[[NSString alloc]initWithFormat:@"%@",[rating_arr objectAtIndex:0]];
    
    NSLog(@"rate_count_str:%@",rate_count_str);
    
    rate_count=[rate_count_str integerValue];
    
    for (int i=0; i<rate_count; i++)
    {
        
        
       
        offset1 +=1;
        star_imageview=[[UIImageView alloc]initWithFrame:CGRectMake(6+i*10,7, 12, 12)];
        NSLog(@"scroll_image:%f",star_imageview.frame.origin.x);
        
        star_imageview.image=[UIImage imageNamed:@"star.png"]; 
        [rate_scroll addSubview:star_imageview];
        
        scrollview.contentSize = CGSizeMake(10*rate_count+15, 20.0);	  
        

        
    }
    
    */

    [rate_vote_tbl reloadData];
}

-(void)load_votes
{

    int offset1;
    
    only_rate_int=[only_rate_str integerValue];
         
    for (int i=0; i<only_rate_int; i++)
    {
        
        
        
        offset1 +=1;
        votes_imageview=[[UIImageView alloc]initWithFrame:CGRectMake(6+i*10,7, 12, 12)];
        NSLog(@"scroll_image:%f",votes_imageview.frame.origin.x);
        
        votes_imageview.image=[UIImage imageNamed:@"star.png"]; 
        [votes_scrollview addSubview:votes_imageview];
        
        scrollview.contentSize = CGSizeMake(10*only_rate_int+15, 20.0);	  
        
        
        
    }

    int votes_x=votes_imageview.frame.origin.x;
    
    UILabel *votes_new_lbl=[[UILabel alloc]initWithFrame:CGRectMake(votes_x+12, 39, 34, 21)];
    
    
    
    NSString  *str_votes =[[NSString alloc]initWithFormat:@"(%@)",only_votes_str];
    
    votes_new_lbl.text=str_votes;
    votes_new_lbl.textColor=[UIColor whiteColor];
    votes_new_lbl.font=[UIFont fontWithName:@"Georgia" size:15.0];
    votes_new_lbl.backgroundColor=[UIColor clearColor];
    [self.view addSubview:votes_new_lbl];
    [votes_new_lbl superview];
    
//    final_rate=[[NSString alloc]initWithFormat:@"From %@",[rating_user_arr objectAtIndex:0]];
//    
//    rate_user_lbl.text=final_rate;
//    
//    
//    desc_show=[[NSString alloc]initWithFormat:@"%@..",[rating_desc_arr objectAtIndex:0]];
//    rate_desc_lbl.text=desc_show;
//    
//    rate_count_str=[[NSString alloc]initWithFormat:@"%@",[rating_arr objectAtIndex:0]];
//    
//    NSLog(@"rate_count_str:%@",rate_count_str);
    
    


}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == profile_tbl)
    {
        return [user_arr count];
    }
       else  if (tableView==rating_tbl)
    {
        return [rating_arr_name count];  
    }
       else  if (tableView==rate_vote_tbl)
       {
           return [rating_user_arr count];  
       }
    return nil;

    
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    Profile_cell *cell1;
    Rating_cell *cell2;
    vote_cell *cell3;
    
    
    if (tableView==profile_tbl) 
    
        
    {
    
    static NSString *cellIdentifier1 = @"cellIdentifier1";
    
    cell1 = (Profile_cell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
    if (cell1 == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Profile_cell"
                                                     owner:self options:nil];
        for (id oneObject in nib) if ([oneObject isKindOfClass:[Profile_cell class]])
            cell1 = (Profile_cell *)oneObject;
    }		
    cell1.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell1.age_lbl.text = [user_arr objectAtIndex:indexPath.row];
    
   
        
        cell1.name_lbl.text=[header_arr1 objectAtIndex:[indexPath row]];
   
   
//    
    
    return cell1;
}

else if(tableView== rating_tbl)
{

    static NSString *cellIdentifier2 = @"cellIdentifier2";
    
    cell2 = (Rating_cell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier2];
    if (cell2 == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Rating_cell"
                                                     owner:self options:nil];
        for (id oneObject in nib) if ([oneObject isKindOfClass:[Rating_cell class]])
            cell2 = (Rating_cell *)oneObject;
    }		
    cell2.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell2.rate_lbl.text = [rating_arr_name objectAtIndex:indexPath.row];
    
         
    return cell2;



}
else {
    
    static NSString *cellIdentifier2 = @"cellIdentifier3";
    
    cell3 = (vote_cell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier2];
    if (cell3 == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"vote_cell"
                                                     owner:self options:nil];
        for (id oneObject in nib) if ([oneObject isKindOfClass:[vote_cell class]])
            cell3 = (vote_cell *)oneObject;
    }		
     cell3.selectionStyle = UITableViewCellSelectionStyleNone;
    
     cell3.user_lbl.text = [rating_user_arr objectAtIndex:indexPath.row];
     cell3.msg_lbl.text = [rating_desc_arr objectAtIndex:indexPath.row];
    
    tbl_scroll=[[UIScrollView alloc]init];
    [tbl_scroll setFrame:CGRectMake(0,2, 200, 25)];
    tbl_scroll.clipsToBounds = YES;
	tbl_scroll.delegate = self;
    [cell3.contentView addSubview:tbl_scroll];

    NSString *rating_str_cell=[[NSString alloc]initWithFormat:@"%@",[rating_arr objectAtIndex:indexPath.row]];
    
    NSInteger rate_int=[rating_str_cell integerValue];
    
    
    int offset1;
    
    for (int i=0; i<rate_int; i++)
    {
        
        
        
        offset1 +=1;
        tbl_imageview=[[UIImageView alloc]initWithFrame:CGRectMake(6+i*10,2, 12, 12)];
        NSLog(@"scroll_image:%f",tbl_imageview.frame.origin.x);
        
        tbl_imageview.image=[UIImage imageNamed:@"star.png"]; 
        [tbl_scroll addSubview:tbl_imageview];
        
        tbl_scroll.contentSize = CGSizeMake(10*rate_int+15, 20.0);	  
        
        
        
    }
    

    
    
    
    
    return cell3;

}
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==rating_tbl)
    {
        rating_id_select=[[NSString alloc]initWithFormat:@"%@",[rating_arr_id objectAtIndex:[indexPath row]]];
        
        rating_name_select=[[NSString alloc]initWithFormat:@"%@",[rating_arr_name objectAtIndex:[indexPath row]]];
        rating_lbl_show.text=rating_name_select;
        [self hide_ratelist_popup];
        
    }
    else 
    {
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView==rating_tbl)
    {
        return 36;
    }
    else  if (tableView==profile_tbl)

    {
          return 38;
    }
    else  if (tableView==rate_vote_tbl)
        
    {
        return 65;
    }else{
        
    }

    return 01;
	
}
-(IBAction)Moreclick
{
    [self show_more_popup];
    
}
-(IBAction)Rate_user
{
    votes_imageview.hidden=YES;
    votes_imageview.image=Nil;
    votes_scrollview.hidden=YES;
    [votes_scrollview removeFromSuperview];
 [self hide_more_popup];
    
    [self show_rate_popup];  

}
-(IBAction)request
{
    votes_imageview.hidden=YES;
    votes_imageview.image=Nil;
    votes_scrollview.hidden=YES;
    [votes_scrollview removeFromSuperview];

  [self hide_more_popup];
    
    request_sel_id=[[NSString alloc]initWithFormat:@"%@",userid_string];
    RequestView *preview=[[RequestView alloc]initWithNibName:@"RequestView" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:preview animated:NO];

    
    

}
-(IBAction)cancel
{

    [self hide_more_popup];
    //[self viewDidLoad];

}
-(void)show_more_popup
{
    more_view.alpha=0.0;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.10];
    more_view.alpha=1.0;
    [UIView commitAnimations];
    


}
-(void)hide_more_popup
{
    more_view.alpha=1.0;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.10];
    more_view.alpha=0.0;
    [UIView commitAnimations];

}

-(IBAction)rate_close
{

    [self hide_rate_popup];

}
-(void)show_rate_popup
{
    rate_view.alpha=0.0;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.10];
    rate_view.alpha=1.0;
    [UIView commitAnimations];


}
-(void)hide_rate_popup
{
    rate_view.alpha=1.0;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.10];
    rate_view.alpha=0.0;
    [UIView commitAnimations];


}

-(void)show_ratelist_popup
{
    rating_tbl_view.alpha=0.0;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.10];
    rating_tbl_view.alpha=1.0;
    [UIView commitAnimations];


}
-(void)hide_ratelist_popup

{
    rating_tbl_view.alpha=1.0;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.10];
    rating_tbl_view.alpha=0.0;
    [UIView commitAnimations];



}
-(IBAction)rating_list_call
{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
      hud.labelText = @"Loading...";
    
    [self performSelector:@selector(rating_json) withObject:nil afterDelay:3.0];

}


-(void)rating_json
{
    rating_arr_name=[[NSMutableArray alloc]init];
    rating_arr_id=[[NSMutableArray alloc]init];
    
    rating_url = [[NSString alloc]initWithFormat:@"http://192.168.0.111/DatingService/getList.svc/getRating/%@",gender_type];

NSMutableURLRequest *request =[[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:rating_url]];

NSData *returnData = [ NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil ];

NSString *returnString = [[NSString alloc]initWithData:returnData encoding:NSUTF8StringEncoding];

//NSLog(@"returnString:*%@*",returnString);


NSDictionary *dict=[returnString JSONValue];
//NSLog(@"dict:%@",dict);
    
    if (dict==nil||dict==NULL)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"No Response From Server" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    
    
    else {
        
        
for (NSDictionary *info in dict)
{
    
    
  //  NSLog(@"info:%@",info);
    
    
    rating_id =[[NSString alloc]initWithFormat:@"%@",[info objectForKey:@"id"]];
    [rating_arr_id addObject:rating_id]; 
    
    rating_name =[info objectForKey:@"name"];
    [rating_arr_name addObject:rating_name];
   
   
       
    
   }
    }
    
    [self loadtbl_rating];
    

}
-(void)loadtbl_rating
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];

    [rating_tbl reloadData];
    
    [self show_ratelist_popup];
    
    

}
-(IBAction)submit_rating
{


    if ([rating_lbl_show.text isEqualToString:@""]||[rating_lbl_show.text isEqualToString:@"null"]||[rating_lbl_show.text isEqualToString:@"(null)"]||rating_lbl_show==nil||rating_lbl_show==NULL)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"select rating from list" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];

        
    }
    
    else
    {
        
        if ([rating_lbl_show.text isEqualToString:@""]||[rating_lbl_show.text isEqualToString:@"null"]||[rating_lbl_show.text isEqualToString:@"(null)"]||rating_lbl_show==nil||rating_lbl_show==NULL)  
        {
            
            rating_desc_str=[[NSString alloc]initWithFormat:@"null"];
            
        }
        else 
        {
            rating_desc_str=[[NSString alloc]initWithFormat:@"%@",rating_desc_txt.text];
        }
        
        
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Rating" message:@"Proceed To Submit Rating & Testimonial For Datee?" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel",nil];
        [alert show];
        [alert release];

        
        rating_bool=TRUE;
        fav_list_boolvalue=FALSE;
        remove_list_boolvalue=FALSE;
        wink_bool_value=FALSE;
       //[self viewDidLoad];


    }
}

-(void)sumbit_json
{
    
    NSURL *url = [NSURL URLWithString:@"http://192.168.0.111/DatingService/userProfile.svc/processRatings/"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    NSString *str_url=[[NSString alloc]initWithFormat:@"{\"selectedUserID\":\"%@\",\"userID\":\"%@\",\"userRating\":\"%@\",\"userRatingDescription\":\"%@\"}",userid_string,login_select,rating_id_select,rating_desc_str];
    
    NSLog(@"str_url:%@",str_url);
    [request appendPostData:[str_url dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    //[request addRequestHeader:@"Accept" value:@"application/json"];
    [request setRequestMethod:@"POST"];
    [request setDelegate:self];
    [request startAsynchronous];
    // Start hud
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:rate_view animated:YES];
    hud.labelText = @"Processing...";
   // rating_bool

}
-(IBAction)list_close
{
   // NSLog(@"list_close enter");

    [self hide_ratelist_popup];
    //[self viewDidLoad];


}


-(void)show_desc_view

{

    
    
    CGRect frame = desc_view.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:2.0];
	frame.origin.y = 0;
	desc_view.frame = frame;
	[UIView commitAnimations];

    

}
-(void)hide_desc_view
{
    CGRect frame = desc_view.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:2.0];
	frame.origin.y = -480;
	desc_view.frame = frame;
	[UIView commitAnimations];

}
-(void)show_edit_image_view
{
    
    edit_image_view.alpha=0.0;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.10];
    edit_image_view.alpha=1.0;
    [UIView commitAnimations];

    
}
-(void)hide_edit_image_view
{
    
    edit_image_view.alpha=1.0;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.10];
    edit_image_view.alpha=0.0;
    [UIView commitAnimations];

}
-(IBAction)Add_image
{
    [self show_edit_image_view];

}
-(IBAction)close_addimage
{
    star_imageview.hidden=NO;
    gifts_scroll.hidden=NO;
    [self call_images];
    

   [self hide_edit_image_view];
   
    Profile_view *pv = [[Profile_view alloc]initWithNibName:@"Profile_view" bundle:[NSBundle mainBundle]];
    
    [self.navigationController pushViewController:pv animated:YES];
}
-(IBAction)edit_desc
{
   
    [self show_desc_view];
}
-(IBAction)close_desc
{
    [self hide_desc_view];
    
    
}
-(IBAction)image_selct:(UIButton*)sender
{
    
    star_imageview.hidden=YES;
    star_imageview.image=Nil;
    rate_scroll.hidden=YES;
    [rate_scroll removeFromSuperview];
    
    
    votes_imageview.hidden=YES;
    votes_imageview.image=Nil;
    votes_scrollview.hidden=YES;
    [votes_scrollview removeFromSuperview];
    
    UIButton *btn_click=(UIButton*)sender;
    
    
    int btn_tag=btn_click.tag;
    selected_detail_image=[[NSString alloc]initWithFormat:@"%@",[final_img_arr objectAtIndex:btn_tag]];
    
    file_id=[[NSString alloc]initWithFormat:@"%@",[user_file_id objectAtIndex:btn_tag]];
    
    
    edit_desc_str=[[NSString alloc]initWithFormat:@"%@",[user_file_desc_arr objectAtIndex:btn_tag]];
    
    if ([edit_desc_str isEqualToString:@""]||edit_desc_str==nil||edit_desc_str==NULL||[edit_desc_str isEqualToString:@"null"]) 
    {
        edit_desc_str=@"";
    }
    
    desc_txtview.text=edit_desc_str;
    desc_lbl.text=edit_desc_str;
    
    NSLog(@"selectedDJImage2:%@",selected_detail_image);
    [show_big_imageview setImageFromUrl:selected_detail_image
                      completion:^(void) 
     {}];
    
    
    [self detail_image];
    [self show_edit_image_view];
 
}
-(void)detail_image
{

       
    int imagecount =[final_img_arr count];
    
    int offset;
    
    for (int row = 0; row<[final_img_arr count];row++)
	{
        
        offset +=1;
        //        scroll_imageview=[[UIImageView alloc]initWithFrame:CGRectMake(8+row*60,4, 57, 50)];
        //        NSLog(@"scroll_image:%f",scroll_imageview.frame.origin.x);
        //        [img_scroll addSubview:scroll_imageview];
        
        
        UIButton *scroll_btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        scroll_btn1.frame = CGRectMake(8+row*60,5, 57, 45);
        scroll_btn1.backgroundColor=[UIColor clearColor];
        [scroll_btn1 addTarget:self action:@selector(small_image:) forControlEvents:UIControlEventTouchUpInside];    
        [sel_scrollview addSubview:scroll_btn1];
        scroll_btn1.tag =row;
        
        
        
        
        AsyncImageView1 *imgPhoto = [[AsyncImageView1 alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 57.0f, 45.0f)];
        imgPhoto.contentMode = UIViewContentModeScaleAspectFill;
        imgPhoto.clipsToBounds = YES;
        imgPhoto.tag = ASYNC_IMAGE_TAG;
        [scroll_btn1 addSubview:imgPhoto];
        
        
        AsyncImageView1 *imageView1 = (AsyncImageView1 *)[scroll_btn1 viewWithTag:ASYNC_IMAGE_TAG];
        //cancel loading previous image for cell
        [[AsyncImageLoader sharedLoader] cancelLoadingURL:imageView1.imageURL];
        imageView1.imageURL = [NSURL URLWithString:[final_img_arr objectAtIndex:row]];
        
        imagecount = [final_img_arr count];
        NSLog(@"imagecount%d",imagecount); 
        sel_scrollview.contentSize = CGSizeMake(60*imagecount+80, 70.0);	  
        
	}
    
    



}

-(IBAction)small_image:(UIButton*)sender
{
    
    UIButton *btn_click=(UIButton*)sender;
    
    
    int btn_tag=btn_click.tag;
    
    selected_detail_image=[[NSString alloc]initWithFormat:@"%@",[final_img_arr objectAtIndex:btn_tag]];
    
    file_id=[[NSString alloc]initWithFormat:@"%@",[user_file_id objectAtIndex:btn_tag]];
    
    
   
    
    
    
    edit_desc_str=[[NSString alloc]initWithFormat:@"%@",[user_file_desc_arr objectAtIndex:btn_tag]];
    
    if ([edit_desc_str isEqualToString:@""]||edit_desc_str==nil||edit_desc_str==NULL||[edit_desc_str isEqualToString:@"null"]) 
    {
        edit_desc_str=@"";
    }
    
    
     edit_desc_str=[[NSString alloc]initWithFormat:@"%@",[user_file_desc_arr objectAtIndex:btn_tag]];
    desc_lbl.text=edit_desc_str;
    desc_txtview.text=edit_desc_str;
    
    NSLog(@"selectedDJImage3:%@",selected_detail_image);
    [show_big_imageview setImageFromUrl:selected_detail_image
                             completion:^(void) 
     {}];


}

-(IBAction)desc_ok
{

    edit_bool=TRUE;
    del_bool=FALSE;
    default_bool=FALSE;
    fav_list_boolvalue=FALSE;
    remove_list_boolvalue=FALSE;
    wink_bool_value=FALSE;
    rating_bool=FALSE;
      upload_bool=FALSE;

    [self hide_desc_view];
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Process to edit file description?" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel",nil];
    [alert show];
    [alert release];
    [self call_images];
    
}
-(IBAction)Del_pic
{
    edit_bool=FALSE;
    del_bool=TRUE;
    default_bool=FALSE;
    fav_list_boolvalue=FALSE;
    remove_list_boolvalue=FALSE;
    wink_bool_value=FALSE;
    rating_bool=FALSE;
      upload_bool=FALSE;

    /*
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading...";
    
    [self readlogin];
    NSURL *url = [NSURL URLWithString:@"http://192.168.0.111/DatingService/userProfile.svc/deleteFile/"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    
    NSString *str_url=[[NSString alloc]initWithFormat:@"{\"userFileID\":\"419\"}"];
    
    NSLog(@"str_url:%@",str_url);
    [request appendPostData:[str_url dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    //[request addRequestHeader:@"Accept" value:@"application/json"];
    [request setRequestMethod:@"POST"];
    [request setDelegate:self];
    [request startAsynchronous];
*/
    /*
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading...";
    
    [self readlogin];
    NSURL *url = [NSURL URLWithString:@"http://192.168.0.111/DatingService/userProfile.svc/editFileDescription/"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    
    NSString *str_url=[[NSString alloc]initWithFormat:@"{\"userFileDescription\":\"dxjsldkk\",\"userFileID\":\"419\"}"];
    
    NSLog(@"str_url:%@",str_url);
    [request appendPostData:[str_url dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    //[request addRequestHeader:@"Accept" value:@"application/json"];
    [request setRequestMethod:@"POST"];
    [request setDelegate:self];
    [request startAsynchronous];
    
    */
    
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Process to delete file?" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel",nil];
    [alert show];
    [alert release];


}

- (BOOL)textViewShouldReturn:(UITextView *)textView

{   
	    
    
    [textView resignFirstResponder];
	return YES;
    
}


- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    NSLog(@"textViewShouldEndEditing");
    
       
    
   	[textView resignFirstResponder];
	return YES;
    
    
}
- (void)textViewDidBeginEditing:(UITextView *)textView 
{      
    
	NSLog(@"textFieldDidBeginEditingProfile");
    
}

- (void)textViewDidEndEditing:(UITextView *)textView { 
    [textView resignFirstResponder];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range 
 replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        // Return FALSE so that the final '\n' character doesn't get added
        return NO;
    }
        return YES;
}
-(void)delete_pic
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:edit_image_view animated:YES];
    hud.labelText = @"Loading...";
    
    [self readlogin];
    NSURL *url = [NSURL URLWithString:@"http://192.168.0.111/DatingService/userProfile.svc/deleteFile/"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    
    NSString *str_url=[[NSString alloc]initWithFormat:@"{\"userFileID\":\"%@\"}",file_id];
    
    NSLog(@"str_url:%@",str_url);
    [request appendPostData:[str_url dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    //[request addRequestHeader:@"Accept" value:@"application/json"];
    [request setRequestMethod:@"POST"];
    [request setDelegate:self];
    [request startAsynchronous];
    //[self call_images];
}
-(void)edit_description
{
    if ([desc_txtview.text isEqualToString:@""]||[desc_txtview.text isEqualToString:@"null"]||[desc_txtview.text isEqualToString:@"(null)"]||desc_txtview.text ==nil||desc_txtview.text ==nil)
    {
        edit_desc_str=@"null";
        
    }
    else 
    {
        edit_desc_str=[[NSString alloc]initWithFormat:@"%@",desc_txtview.text];
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:edit_image_view animated:YES];
    hud.labelText = @"Loading...";
    
       NSURL *url = [NSURL URLWithString:@"http://192.168.0.111/DatingService/userProfile.svc/editFileDescription/"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    
    NSString *str_url=[[NSString alloc]initWithFormat:@"{\"userFileDescription\":\"%@\",\"userFileID\":\"%@\"}",edit_desc_str,file_id];
    
    NSLog(@"str_urlimgdesc:%@",str_url);
    [request appendPostData:[str_url dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    //[request addRequestHeader:@"Accept" value:@"application/json"];
    [request setRequestMethod:@"POST"];
    [request setDelegate:self];
    [request startAsynchronous];
    desc_lbl.text = desc_txtview.text;

}
-(void)default_image
{

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:edit_image_view animated:YES];
    hud.labelText = @"Loading...";
    
    [self readlogin];
    NSURL *url = [NSURL URLWithString:@"http://192.168.0.111/DatingService/userProfile.svc/setDefaultPic/"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    
    NSString *str_url=[[NSString alloc]initWithFormat:@"{\"userID\":\"%@\",\"userFileID\":\"%@\"}",login_select,file_id];
    
    NSLog(@"str_url:%@",str_url);
    [request appendPostData:[str_url dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    //[request addRequestHeader:@"Accept" value:@"application/json"];
    [request setRequestMethod:@"POST"];
    [request setDelegate:self];
    [request startAsynchronous];
}



-(IBAction)Add_profile_image
{

    star_imageview.hidden=YES;
    star_imageview.image=Nil;
    rate_scroll.hidden=YES;
    [rate_scroll removeFromSuperview];
    
    votes_imageview.hidden=YES;
    votes_imageview.image=Nil;
    votes_scrollview.hidden=YES;
    [votes_scrollview removeFromSuperview];

    [self show_upload_image];

}
-(IBAction)Use_profile_pic
{
    edit_bool=FALSE;
    del_bool=FALSE;
    default_bool=TRUE;
    fav_list_boolvalue=FALSE;
    remove_list_boolvalue=FALSE;
    wink_bool_value=FALSE;
    rating_bool=FALSE;
    upload_bool=FALSE;
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Process to change profile picture?" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel",nil];
    [alert show];
    [alert release];
    



}

-(IBAction)upload_image
{
    edit_bool=FALSE;
    del_bool=FALSE;
    default_bool=FALSE;
    fav_list_boolvalue=FALSE;
    remove_list_boolvalue=FALSE;
    wink_bool_value=FALSE;
    rating_bool=FALSE;
    upload_bool=TRUE;
    gifts_scroll.hidden=YES;

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:add_desc_view animated:YES];
    hud.labelText = @"Loading...";
    
    [self readlogin];
    NSURL *url = [NSURL URLWithString:@"http://192.168.0.111/DatingService/userProfile.svc/addFile/"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    
    NSString *str_url=[[NSString alloc]initWithFormat:@"{\"userFileDescription\":\"%@\",\"userFileURL\":\"pic_new.png\",\"userFileScreenshotURL\":\"pic_new.png\",\"userID\":\"%@\"}",desc_lbl.text,login_select];
    
    NSLog(@"str_url:%@",str_url);
    [request appendPostData:[str_url dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    //[request addRequestHeader:@"Accept" value:@"application/json"];
    [request setRequestMethod:@"POST"];
    [request setDelegate:self];
    [request startAsynchronous];
    [self viewDidLoad];


}
-(void)show_upload_image
{

    
    CGRect frame = add_desc_view.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:1.0];
	frame.origin.y = 0;
    frame.size.height=580;
	add_desc_view.frame = frame;
	[UIView commitAnimations];

    
    str_img_txtView = [[NSString alloc]initWithFormat:@"%@",add_desc_txtview.text];

}
-(void)hide_upload_image
{
    
    CGRect frame = add_desc_view.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:1.0];
	frame.origin.y = -580;
	add_desc_view.frame = frame;
	[UIView commitAnimations];



}

-(IBAction)close_profile
{

    [self hide_upload_image];
   // gifts_scroll.hidden=YES;
  //  [self viewDidLoad];

}
-(void)success_upload
{
    NSLog(@"succes_upload...");
    
      int int_value1=[fetch_uid intValue];

    [self readlogin];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:add_desc_view animated:YES];
    hud.labelText = @"Loading...";
    
    NSLog(@"AddImg1:%@",profile_add_image.image);
    imageData = UIImageJPEGRepresentation(profile_add_image.image, 90);
    NSLog(@"imageData2:%@",imageData);
    NSString *urlString1 =[[NSString alloc]initWithFormat:@"http://192.168.0.111/DatingService/Photos.svc/uploadPhoto?fname=pic_new.png&uid=%@&type=2&fid=%d",login_select,int_value1];
    NSLog(@"urlString1:%@",urlString1);
    
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString1]] autorelease];
    [request setValue:@"text/plain" forHTTPHeaderField:@"content-type"];
    [request setHTTPMethod:@"POST"];
    
    [request setValue:[NSString stringWithFormat:@"%d", [imageData length]] forHTTPHeaderField:@"content-length"];
    [request setHTTPBody:imageData];
    
    [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSLog(@"returnDataImgSu:%@",returnData);
    
    if (returnData==nil)
    { [MBProgressHUD hideHUDForView:add_desc_view animated:YES];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Image upload failed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
    }
    else
    {
//        [MBProgressHUD hideHUDForView:add_desc_view animated:YES];
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Image uploaded" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//        [alert release];
        
        
        [self success_upload_1];
        
             
    }

    

//    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"upload  changed sucessfully" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//    [alert show];
//    [alert release];


}
-(void)success_upload_1
{

     int int_value2=[fetch_uid intValue];
        
    NSLog(@"AddImg2:%@",profile_add_image);
    imageData1 = UIImageJPEGRepresentation(profile_add_image.image, 90);
    NSLog(@"imageData1:%@",imageData1);
    NSString *urlString1 =[[NSString alloc]initWithFormat:@"http://192.168.0.111/DatingService/Photos.svc/uploadPhoto?fname=pic_new.png&uid=%@&type=3&fid=%d",login_select,int_value2];
    NSLog(@"urlString1:%@",urlString1);
    
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString1]] autorelease];
    [request setValue:@"text/plain" forHTTPHeaderField:@"content-type"];
    [request setHTTPMethod:@"POST"];
    
    [request setValue:[NSString stringWithFormat:@"%d", [imageData1 length]] forHTTPHeaderField:@"content-length"];
    [request setHTTPBody:imageData1];
    
    [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSLog(@"returnData:%@",returnData);
    
    if (returnData==nil)
    { [MBProgressHUD hideHUDForView:add_desc_view animated:YES];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Image upload failed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
    }
    else
    {
        [MBProgressHUD hideHUDForView:add_desc_view animated:YES];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Image uploaded" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
        [self hide_upload_image];
        [self viewDidLoad];
        
    //[self performSelectorInBackground:@selector(call_images) withObject:nil];

        
        
    }


}

-(IBAction)Edit_info
{

    edit_bool=TRUE;
    sign_in_bool=FALSE;
    
    
    Update_profile *update_profile=[[Update_profile alloc]initWithNibName:@"Update_profile" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:update_profile animated:YES];
    
    
    
    
}   

-(IBAction)Chat_list
{

    chat_id=[[NSString alloc]initWithFormat:@"%@",userid_string];
    
    global_Chat_id = [[NSString alloc]initWithFormat:@"%@",chat_id];
    NSLog(@"global_Chat_id in profile_view%@",global_Chat_id);
    Chat_list  *chat_list=[[Chat_list alloc]initWithNibName:@"Chat_list" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:chat_list animated:NO];

}
- (void)viewDidUnload
{
    [distance_show_lbl release];
    distance_show_lbl = nil;
    [distance_Km_show_lbl release];
    distance_Km_show_lbl = nil;
    [global_msg_btn release];
    global_msg_btn = nil;
    [btnkeyboardDisapper release];
    btnkeyboardDisapper = nil;
    [global_msg_icon release];
    global_msg_icon = nil;
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
    /*
    [distance_show_lbl release];
    [distance_Km_show_lbl release];
    [global_msg_btn release];
     */
    [btnkeyboardDisapper release];
    [global_msg_icon release];
    [super dealloc];
}
- (IBAction)global_msg_click:(id)sender {
    
    Chat_view *chatViewObj = [[Chat_view alloc]initWithNibName:@"Chat_view" bundle:[NSBundle mainBundle]];
    
    [self.navigationController pushViewController:chatViewObj animated:YES];

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    
    
    
    
	[textField resignFirstResponder];
    
    
	
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	NSLog(@"textFieldShouldBeginEditing");
    
    [self.view endEditing:YES];
    
	return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
	NSLog(@"textFieldDidBeginEditing");
    [self.view endEditing:YES];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField;
{
	NSLog(@"textFieldDidEndEditing");
    [textField resignFirstResponder];
    
	//nameString = [[NSString alloc]initWithFormat:@"%@",text1.text];
	
}

/*
       - (void)dealloc {
           //[backToPrevious release];
           [super dealloc];
       }
 */
/*
       - (void)viewDidUnload {
           [backToPrevious release];
           backToPrevious = nil;
           [super viewDidUnload];
       }
 */
@end
