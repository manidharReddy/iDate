//
//  Menupage.m
//  iDate
//
//  Created by D M R on 07/08/12.
//  Copyright (c) 2012 iHubTechnologies. All rights reserved.
//

#import "Menupage.h"
#import"Signup.h"
#import "Profile_view.h"
#import "AppDelegate.h"
#import "RootViewController.h"
#import "Chat_view.h"
#import "Favorites_list.h"
#import "User_list.h"
#import "Settings_view.h"
#import "Search_view.h"
#import "Dating_articles.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "JSON.h"
#import "JSON1.h"

@interface Menupage ()

@end

@implementation Menupage

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(IBAction)My_profile
{
globalCheckFavorites =@"";
    view_profile_bool=FALSE;
    Profile_view *preview=[[Profile_view alloc]initWithNibName:@"Profile_view" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:preview animated:NO];


}
-(IBAction)Dating_articles
{
    //dating_bool=TRUE;
    Dating_articles *root=[[Dating_articles alloc]initWithNibName:@"Dating_articles" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:root animated:NO];


}

-(IBAction)search
{
Search_view *preview=[[Search_view alloc]initWithNibName:@"Search_view" bundle:[NSBundle mainBundle]];
[self.navigationController pushViewController:preview animated:NO];

}

-(IBAction)Settings_click
{
    Settings_view *root=[[Settings_view alloc]initWithNibName:@"Settings_view" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:root animated:NO];


}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    notification_round_image.hidden=NO;
    notification_total_lbl.hidden=NO;
    
    
    lbl_partnerwebsitename.text = global_partner_websitename;
    
    //lbl_partnerwebsitename.text = global_partner_websitename;
    //messageIconShow.hidden = YES;
    
    [self readlogin];
    
    
    
    //callMessageByTimer = [NSTimer scheduledTimerWithTimeInterval:60.0 target:self selector:@selector(callMessage) userInfo:nil repeats:YES];
    
    
    //[noti_message_arr count];
    
    [self performSelector:@selector(messagesNotification) withObject:nil];
    NSLog(@"global_show_msg_iconstr =%@",global_show_msg_iconstr);
    
    if([global_show_msg_iconstr isEqualToString:@"1"])
    {
        
        messageIconShow.hidden=NO;
        
    }else if([global_show_msg_iconstr isEqualToString:@"0"])
    {
        messageIconShow.hidden=YES;
    }
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [notification_Button release];
    notification_Button = nil;
    [notification_round_image release];
    notification_round_image = nil;
    [notification_total_lbl release];
    notification_total_lbl = nil;
    [messageIconShow release];
    messageIconShow = nil;
    [lbl_partnerwebsitename release];
    lbl_partnerwebsitename = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (IBAction)NewsArctles_click:(id)sender {
    NewsArticles *newsA=[[NewsArticles alloc]initWithNibName:@"NewsArticles" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:newsA animated:NO];

}

- (IBAction)BussinesOpp_click:(id)sender {
    
    Bussiness_Opp *bussinesView = [[Bussiness_Opp alloc]initWithNibName:@"Bussiness_Opp" bundle:[NSBundle mainBundle]];
    
    [self.navigationController pushViewController:bussinesView animated:NO];
}

- (IBAction)unReadMessageClick:(id)sender {
    
    Chat_view *preview=[[Chat_view alloc]initWithNibName:@"Chat_view" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:preview animated:NO];

    
}

- (IBAction)Latitude:(id)sender {
    
    LatitudeCalac *lati=[[LatitudeCalac alloc]initWithNibName:@"LatitudeCalac" bundle:[NSBundle mainBundle]];
    
    [self.navigationController pushViewController:lati animated:NO];
    
}

- (IBAction)notification_Click_btn:(id)sender {
    
    //notification_round_image.hidden=YES;
    //notification_total_lbl.hidden=YES;
    
    if(noti_label_count !=0)
    {
    Notification_Details *noti=[[Notification_Details alloc]initWithNibName:@"Notification_Details" bundle:[NSBundle mainBundle]];
    
    [self.navigationController pushViewController:noti animated:NO];
    
    }else{
        
    }
    
}

- (IBAction)Logout:(id)sender {
    
    global_back=0;
    
    RootViewController *rootMenu = [[RootViewController alloc]init];
    [rootMenu logoutMenu:(id)sender];
    
    
    
    [self performSelector:@selector(back:) withObject:nil afterDelay:1.0];
    
}

-(IBAction)back:(id)sender
{
    
    
    UIButton *tappedButton1 = (UIButton*)sender;
	int indx2 = tappedButton1.tag;
    global_back = indx2;
    //global_backMenu_string=[[NSString alloc]initWithFormat:@"%i",indx2];
    
    NSLog(@"global_backMenu_string:%@",global_backMenu_string);

    RootViewController *fav=[[RootViewController alloc]initWithNibName:@"RootViewController" bundle:[NSBundle mainBundle]];
    
    [self.navigationController pushViewController:fav animated:NO];
    

}

-(void)backMen
{
    
    
    RootViewController *fav=[[RootViewController alloc]init];
    
    [self.navigationController pushViewController:fav animated:YES];
    
    
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
            //global_notification_mssg_str = [[NSString alloc]initWithString:login_select];
            NSLog(@"login_select:%@",login_select);
            
		}
        
        
	}
	sqlite3_finalize(stmt);
    
}



/*
-(void)callMessage
{
    
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
        messageIconShow.hidden = NO;
        
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
        messageIconShow.hidden = YES;
    }
        
    
    
    
    
    
}
 */

-(IBAction)Chat
{
    Chat_view *preview=[[Chat_view alloc]initWithNibName:@"Chat_view" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:preview animated:NO];

}
-(IBAction)My_favorites
{
    Favorites_list *fav=[[Favorites_list alloc]initWithNibName:@"Favorites_list" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:fav animated:NO];


}

-(void)messagesNotification_Get
{
    noti_message_arr = [[NSMutableArray alloc]init];
    noti_message_Creation_arr = [[NSMutableArray alloc]init];
    global_Message_arr = [[NSMutableArray alloc]init];
    global_messageCreation_arr = [[NSMutableArray alloc]init];
    
    
    
    NSLog(@"response dic message: %@",responseDict);
    
     
     for (NSDictionary *info in responseDict)
     {
     
     NSLog(@"info_message:%@",info);
     
     
     noti_message_str=[info objectForKey:@"userMessage"];
     [noti_message_arr addObject: noti_message_str];
     
     [global_Message_arr addObject:noti_message_str];
     
     NSLog(@"noti_message_str:*%@*", noti_message_str);
     
     
     noti_message_Creation_str=[info objectForKey:@"userMsgeCreationDate"];
     [noti_message_Creation_arr addObject:noti_message_Creation_str];
     
     [global_messageCreation_arr addObject:noti_message_Creation_str];
     
     NSLog(@"name_noti_message_creation_arr:%@", noti_message_Creation_str);
     
     
     
     
     
     }
     
     notification_total_lbl.text =[NSString stringWithFormat:@"%i",[noti_message_arr count]];
    noti_label_count = [notification_total_lbl.text intValue];

    if(noti_label_count!=0)
    {
        NSLog(@"enter in noti label2");
        notification_round_image.hidden=NO;
        
        
    }else{
       
        NSLog(@"enter in noti label");
        notification_total_lbl.text=@"";
        notification_round_image.hidden=YES;
        
    }
     
    
    
}

-(void)messagesNotification
{
    NSURL *url = [NSURL URLWithString:@"http://192.168.0.111/DatingService/notifications.svc/notificationMessage/"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    
    NSString *str_url=[[NSString alloc]initWithFormat:@"{\"userID\":\"%@\"}",global_notification_mssg_str];
    
    NSLog(@"str_url:%@",str_url);
    [request appendPostData:[str_url dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    //[request addRequestHeader:@"Accept" value:@"application/json"];
    [request setRequestMethod:@"POST"];
    [request setDelegate:self];
    [request startAsynchronous];

    //[self messagesNotification_Get];
    
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if (request.responseStatusCode == 400) {
        
        NSError *error = [request error];
        NSLog(@"errormessage1:%@",error);
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Message not found" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
        
        
        
    } else if (request.responseStatusCode == 403) {
        
        NSError *error = [request error];
        NSLog(@"errormessage2:%@",error);
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Message not found" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
        
    } else if (request.responseStatusCode == 200)
    {
        NSLog(@"SuccessFull1");
        
        NSString *responseString = [request responseString];
        NSLog(@"responseString message:%@",responseString);
        responseDict = [[NSDictionary alloc]init];
        responseDict = [responseString JSONValue];
        NSLog(@"responseDict:%@",responseDict);
        
        [self messagesNotification_Get];
        
    }
    else
    {
        
        NSLog(@"Search not found1");
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Search not found" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
            }
    
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(@"error:%@",error);
    NSLog(@"Search not found2");
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Search not found" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [alert release];
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
    [notification_Button release];
    [notification_round_image release];
    [notification_total_lbl release];
    [messageIconShow release];
     */
    [lbl_partnerwebsitename release];
    [super dealloc];
}
@end
