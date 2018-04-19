//
//  Login.m
//  iDate
//
//  Created by D M R on 16/08/12.
//  Copyright (c) 2012 iHubTechnologies. All rights reserved.
//

#import "Login.h"
#import "Free_signup.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "JSON.h"
#import "MBProgressHUD.h"
#import "Signup.h"
#import "AppDelegate.h"
#import "Profile_view.h"
#import "User_list.h"
#import "MBProgressHUD.h"
#import "RootViewController.h"
#import "Freinds_view.h"
@interface Login ()
{
    //NSString * latiDulicat;
    //NSString * longDuplicat;
}

@end

@implementation Login
//@synthesize locationManager;
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
    
    
    lbl_partner_website_name.text = global_partner_websitename;
    
    [super viewDidLoad];
     activity =[[LabeledActivityIndicatorView alloc]initWithController:self andText:@"Processing..."];
    //running = false;
    //latitudeReplace = [[NSString alloc]init];
    //longitudeReplace = [[NSString alloc]init];
  /*
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    [locationManager startUpdatingLocation];
    CLLocation *location = [locationManager location];
    
    // Configure the new event with information from the location
    
    CLLocationCoordinate2D coordinate = [location coordinate];
    latitude = [NSMutableString stringWithFormat:@"%f", coordinate.latitude];
    longitude = [NSMutableString stringWithFormat:@"%f", coordinate.longitude];
    
    NSLog(@"LatitudeLogin : %@", latitude);
    NSLog(@"LongitudeLogin : %@",longitude);
    
    latitudeReplace = [[NSString alloc]init];
    longitudeReplace = [[NSString alloc]init];
    
    latitudeReplace = [latitude stringByReplacingOccurrencesOfString:@"." withString:@"-"];
    longitudeReplace = [longitude stringByReplacingOccurrencesOfString:@"." withString:@"-"];
    
    
    NSLog(@"LatitudeLoginReplace : %@", latitudeReplace);
    NSLog(@"LongitudeLoginReplace : %@",longitudeReplace);
    
     latiDulicat = [[NSString alloc]initWithString:latitudeReplace];
    longDuplicat = [[NSString alloc]initWithString:longitudeReplace];
    
*/
    
    // Do any additional setup after loading the view from its nib.
}
-(IBAction)login
{
    /*if(running==false)
    {
        running = true;
        startTime =[NSDate timeIntervalSinceReferenceDate];
        
        [self updateTime];
        
    }
    */
    /*
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    [locationManager startUpdatingLocation];
    CLLocation *location = [locationManager location];
    
    // Configure the new event with information from the location
    
    CLLocationCoordinate2D coordinate = [location coordinate];
    latitude = [NSMutableString stringWithFormat:@"%f", coordinate.latitude];
    longitude = [NSMutableString stringWithFormat:@"%f", coordinate.longitude];
    
    NSLog(@"LatitudeLogin : %@", latitude);
    NSLog(@"LongitudeLogin : %@",longitude);
    
    latitudeReplace = [[NSString alloc]init];
    longitudeReplace = [[NSString alloc]init];
    
    latitudeReplace = [latitude stringByReplacingOccurrencesOfString:@"." withString:@"-"];
    longitudeReplace = [longitude stringByReplacingOccurrencesOfString:@"." withString:@"-"];
    
    
    NSLog(@"LatitudeLoginReplace : %@", latitudeReplace);
    NSLog(@"LongitudeLoginReplace : %@",longitudeReplace);
    
    
    */
    
    [id_text resignFirstResponder];
    [passwd_text resignFirstResponder];
           
    MBProgressHUD *hud1 = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud1.labelText = @"Processing..";          
   
    [self performSelector:@selector(login_call) withObject:nil afterDelay:0.0];
   
    
}
/*
-(void)updateTime
{
    //if(running==false) return;
    NSTimeInterval currentTime =[NSDate timeIntervalSinceReferenceDate];
    NSTimeInterval elapsed = currentTime - startTime;
    
    int mins = (int)(elapsed/60.0);
    elapsed-=mins * 60;
    int secs = (int)(elapsed);
    elapsed -=secs;
    int fraction = elapsed * 10.0;
    NSLog(@"%u m:%0.2u.%u f:",mins,secs,fraction);
}
*/
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    

    
        
    
	[textField resignFirstResponder];
    
    
	
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	NSLog(@"textFieldShouldBeginEditing");
    

    
	return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
	NSLog(@"textFieldDidBeginEditing");
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField;
{
	NSLog(@"textFieldDidEndEditing");
    [textField resignFirstResponder];
	//nameString = [[NSString alloc]initWithFormat:@"%@",text1.text];
	
}
- (BOOL)textViewShouldReturn:(UITextView *)textView

{
	NSLog(@"textViewShouldReturn");

    
    
    
    [textView resignFirstResponder];
	return YES;
    
}


-(void)login_call
{

    
    [id_text resignFirstResponder];
    [passwd_text resignFirstResponder];
    
    if ([id_text.text isEqualToString:@""]||[id_text.text isEqualToString:@"(null)"]||id_text.text==nil||id_text.text==NULL)
    {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"All the fields are mandatory" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
    }
    
    else
    {
        
        
        if (check_bool==TRUE)
        {
            
            str = [[NSString alloc ]initWithFormat:@"http://192.168.0.111/DatingService/signUp.svc/socialLogin/%@",id_text.text];
            //global_show_msg_iconstr = [NSString stringWithFormat:@"%i",0];
            global_show_msg_iconstr =@"0";
            
            str=[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSLog(@"str:%@",str);
        }
        
        else
        {
            @try{
            global_socialLogID =@"";
                global_SocialCheck=@"";
            global_show_msg_iconstr =@"0";
                //global_show_msg_iconstr = [NSString stringWithFormat:@"%i",0];
                NSString * nameLog =id_text.text;
                NSString *replacUsername = [ nameLog stringByReplacingOccurrencesOfString:@" " withString:@"_"];
            str = [[NSString alloc ]initWithFormat:@"http://192.168.0.111/DatingService/signUp.svc/login/%@/%@",replacUsername,passwd_text.text];

               
            
            
            str=[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
             
            NSLog(@"str:%@",str);
            }
            
                @catch (NSException *exception)
                {
                    NSLog(@"Exception name:%@ || Exception Reason:%@",[exception name],[exception reason]);
                }
        }
        
        
        
        
        NSMutableURLRequest *request =[[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:str]];
        
        NSData *returnData = [ NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil ];
        
        NSString *returnString = [[NSString alloc]initWithData:returnData encoding:NSUTF8StringEncoding];
        
        NSLog(@"returnString:*%@*",returnString);
        
        
        NSDictionary *dict=[returnString JSONValue];
        NSLog(@"dict:%@",dict);
        
        if (check_bool==TRUE)
        {
            NSString *str_result=[dict objectForKey:@"socialLoginResult"];
            NSLog(@"str_result:%@",str_result);
             global_login_type=@"";
            
            if ([str_result isEqualToString:@"Success"])
            {
                
                //
                //                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Login successfully" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                //                    [alert show];
                //                    [alert release];
                
                
                
                check_bool=FALSE;
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                
                Freinds_view *root=[[Freinds_view alloc]initWithNibName:@"Freinds_view" bundle:[NSBundle mainBundle]];
                [self.navigationController pushViewController:root animated:NO];
                
                
            }
            
        }
        else
            
        {
            global_login_type=@"";
            NSDictionary *dict1=[dict objectForKey:@"loginResult"];
            NSLog(@"dict1:%@",dict1);
            NSString *str_result=[dict1 objectForKey:@"result"];
            NSLog(@"str_result456:%@",str_result);
            
            NSString *str_userid=[dict1 objectForKey:@"userID"];
            NSLog(@"str_userid:%@",str_userid);
            if ([str_result isEqualToString:@"Success"])
            {
                
                
                //                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Login successfully" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                //                    [alert show];
                //                    [alert release];
                
                login_id=[[NSString alloc]initWithFormat:@"%@",str_userid];
                [self insertlogin];
                
                check_bool=FALSE;
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                //[self insertlogin];
                RootViewController *root=[[RootViewController alloc]initWithNibName:@"RootViewController" bundle:[NSBundle mainBundle]];
                [self.navigationController pushViewController:root animated:NO];
                
                
            }
            else
            {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Login failed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                [alert release];
                
            }
            
        }
        
    }
    
    
    
    


}

-(void)insertlogin
{
     sqlite3_stmt *stmt3;
    //char *errorMsg4;
    char *update4 = "insert into login values (?,?,?);";
    
    int x1 = sqlite3_prepare_v2(database, update4, -1, &stmt3, nil);
    
    if (x1 == SQLITE_OK)
    {
        sqlite3_bind_text(stmt3, 1, NULL,-1, NULL);
        sqlite3_bind_text(stmt3, 2, [login_id UTF8String],-1, NULL);
        sqlite3_bind_text(stmt3, 3, [passwd_text.text UTF8String],-1, NULL);
           
    }
    if (sqlite3_step(stmt3) != SQLITE_DONE)
        //NSLog(@"Error: %",errorMsg4);
    sqlite3_finalize(stmt3); 
    
    id_text.text=Nil;
    passwd_text.text=Nil;

    
   // callMessageByTimer = [NSTimer scheduledTimerWithTimeInterval:60.0 target:self selector:@selector(callMessage) userInfo:nil repeats:YES];
    
    
}
/*
-(void)callMessage
{
    [self readlogin];
    NSString *str_unreadMsg = [[NSString alloc]initWithFormat:@"http://192.168.0.111/DatingService/Notifications.svc/unReadMsg/%@",login_select];
    
    NSLog(@"str_unreadMsg:%@",str_unreadMsg);
    
    NSMutableURLRequest *request =[[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:str_unreadMsg]];
    
    NSData *returnData = [ NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil ];
    
    NSString *returnString = [[NSString alloc]initWithData:returnData encoding:NSUTF8StringEncoding];
    
    NSLog(@"returnString:*%@*",returnString);
    
    //NSDictionary *dict=[returnString JSONValue];
    
    //play_sound_global_string=@"0";
    
    NSString *unReadMssg = [[NSString alloc]initWithString:returnString];
    global_unredmsg_bool_str =[NSString stringWithString:unReadMssg];
    
    NSLog(@"unRead Messages:%@",unReadMssg);
    if([unReadMssg isEqualToString:@"true"])
    {
        
        global_show_msg_iconstr = [NSString stringWithFormat:@"%i",1];
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
        
        global_show_msg_iconstr = [NSString stringWithFormat:@"%i",0];
        
        NSLog(@"Enter in False Msg");
       // messageIconShow.hidden = YES;
    }
    
    
    
 
    
    
}
*/
-(void)readlogin
{
    NSString *query = [[NSString alloc] initWithFormat:@"select * from login;"];
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
            
		}
        
        
	}
	sqlite3_finalize(stmt);	
    
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
        NSString *responseString = [request responseString];
        NSLog(@"responseString:%@",responseString);
        NSDictionary *responseDict = [responseString JSONValue];
        NSLog(@"responseDict:%@",responseDict);
        NSString *unlockCode = [responseDict objectForKey:@"unlock_code"];
        
        if ([unlockCode compare:@"com.razeware.test.unlock.cake"] == NSOrderedSame) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Thank You For Signing Up!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
            
        } else {        
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Sign up failed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
            
        }
        
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
-(IBAction)back
{
//    Signup *preview=[[Signup alloc]initWithNibName:@"Signup" bundle:[NSBundle mainBundle]];
//    [self.navigationController pushViewController:preview animated:NO];
    
    RootViewController *root=[[RootViewController alloc]initWithNibName:@"RootViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:root animated:NO];

}
-(IBAction)registr
{

    Free_signup *preview=[[Free_signup alloc]initWithNibName:@"Free_signup" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:preview animated:NO];


}
- (void)viewDidUnload
{
    [lbl_partner_website_name release];
    lbl_partner_website_name = nil;
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
    [lbl_partner_website_name release];
    [super dealloc];
}
@end
