//
//  RequestView.m
//  iDate
//
//  Created by D M R on 18/09/12.
//  Copyright (c) 2012 iHubTechnologies. All rights reserved.
//

#import "RequestView.h"
#import "JSON.h"
#import "AppDelegate.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "JSON.h"
#import "JSON1.h"
#import "MBProgressHUD.h"
#import "UIImageView+DispatchLoad.h"

@interface RequestView ()

@end

@implementation RequestView

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
    // Do any additional setup after loading the view from its nib.
    
    if([global_show_msg_iconstr isEqualToString:@"1"])
    {
        
        globa_msg_btn.hidden=NO;
        
    }else
    {
        globa_msg_btn.hidden=YES;
    }
    
    
    
    
    
    
}

- (void)viewDidUnload
{
    [globa_msg_btn release];
    globa_msg_btn = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (IBAction)msg_click_chatWindow:(id)sender {
    
    Chat_view *chatView = [[Chat_view alloc]initWithNibName:@"Chat_view" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:chatView animated:YES];
}

-(IBAction)request_btn
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"The Request Will Cost 1000 Love Credits Should Dater Agreed To Release His Contact Number To You. Proceed To Request Permission From username For His Contact Number?" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel",nil];
    [alert show];
    [alert release];

    request_contact_bool=TRUE;
    requset_email_bool=FALSE;
}
-(IBAction)request_email
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"The Request Will Cost 1000 Love Credits Should Dater Agreed To Release His Email Address To You. Proceed To Request Permission From username For His Contact Number?" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel",nil];
    [alert show];
    [alert release];
    request_contact_bool=FALSE;
    requset_email_bool=TRUE;





}
-(IBAction)back
{
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)request_contact_json
{
    [self readlogin];
    
    
    NSURL *url = [NSURL URLWithString:@"http://192.168.0.111/DatingService/userProfile.svc/requestContactNumber/"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    NSString *str_url=[[NSString alloc]initWithFormat:@"{\"selectedUserID\":\"%@\",\"userID\":\"%@\"}",request_sel_id,login_select];
    
    NSLog(@"str_url:%@",str_url);
    [request appendPostData:[str_url dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    //[request addRequestHeader:@"Accept" value:@"application/json"];
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
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (requset_email_bool==TRUE)
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Cannot request email address" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Cannot request contact number" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
       
        
    } else if (request.responseStatusCode == 403) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (requset_email_bool==TRUE)
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Cannot request email address" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Cannot request contact number" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
        }

    } else if (request.responseStatusCode == 200) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSString *responseString = [request responseString];
        NSLog(@"responseString:%@",responseString);
        NSDictionary *responseDict = [responseString JSONValue];
        NSLog(@"responseDict:%@",responseDict);
        NSString *unlockCode = [responseDict objectForKey:@"unlock_code"];
        
        if ([unlockCode compare:@"com.razeware.test.unlock.cake"] == NSOrderedSame) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:responseString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
            
        } else { 
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if (requset_email_bool==TRUE)
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Cannot request email address" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                [alert release];
            }
            else {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Cannot request contact number" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                [alert release];
            }

            
        }
        
    } else {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (requset_email_bool==TRUE)
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Cannot request email address" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Cannot request contact number" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
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
    
    if (requset_email_bool==TRUE)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Cannot request email address" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Cannot request contact number" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
}

    

-(void)request_email_json
{ [self readlogin];
        
    NSURL *url = [NSURL URLWithString:@"http://192.168.0.111/DatingService/userProfile.svc/requestEmailAddress/"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    NSString *str_url=[[NSString alloc]initWithFormat:@"{\"selectedUserID\":\"%@\",\"userID\":\"%@\"}",request_sel_id,login_select];
    
    NSLog(@"str_url:%@",str_url);
    [request appendPostData:[str_url dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    //[request addRequestHeader:@"Accept" value:@"application/json"];
    [request setRequestMethod:@"POST"];
    [request setDelegate:self];
    [request startAsynchronous];
    // Start hud
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading...";
    


}

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
            NSLog(@"login_select:%@",login_select);
            
		}
        
        
	}
	sqlite3_finalize(stmt);	
    
   
    
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"Alert index:%d",buttonIndex);
    
    if(buttonIndex==0)
    {
        if (requset_email_bool==TRUE)
        {
            [self request_email_json];
        }
        else if (request_contact_bool==TRUE)
        {
            [self request_contact_json];
        }
     }
    else if(buttonIndex==1)
    {
        
    }
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [globa_msg_btn release];
    [super dealloc];
}
@end
