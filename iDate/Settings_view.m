//
//  Settings_view.m
//  iDate
//
//  Created by D M R on 13/09/12.
//  Copyright (c) 2012 iHubTechnologies. All rights reserved.
//

#import "Settings_view.h"
#import "AppDelegate.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "JSON.h"
#import "JSON1.h"
#import "MBProgressHUD.h"
#import "UIImageView+DispatchLoad.h"
#import "Menupage.h"
#import <AudioToolbox/AudioServices.h>
#import "Chat_view.h"
@interface Settings_view ()

@end

@implementation Settings_view

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
    
    if([global_show_msg_iconstr isEqualToString:@"1"])
    {
        
        global_msg_btn.hidden=NO;
        
    }else
    {
        global_msg_btn.hidden=YES;
    }
    
    
    pop_up_view.frame=CGRectMake(7,100,311, 200);
    [self.view addSubview:pop_up_view];
    pop_up_view.alpha=0.0;

    // Do any additional setup after loading the view from its nib.
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
- (IBAction)click_msg_ChatWindow:(id)sender {
    
    Chat_view *chatView = [[Chat_view alloc]initWithNibName:@"Chat_view" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:chatView animated:YES];
}

-(IBAction)change_password
{
    change_bool=TRUE;
    deactivate_bool=FALSE;
    
    [self show_pop_up];

}
-(IBAction)Deactivate_account
{
    
    change_bool=FALSE;
    deactivate_bool=TRUE;

    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Proceed Account Deactivation?" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel",nil];
    [alert show];
    [alert release];
    

}

-(void)show_pop_up
{

    pop_up_view.alpha=0.0;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1.0];
    pop_up_view.alpha=1.0;
    [UIView commitAnimations];


}

-(void)deactivate_call
{

    [self readlogin];
    NSURL *url = [NSURL URLWithString:@"http://192.168.0.111/DatingService/userProfile.svc/deactivateAccount/"];
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
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading...";
    

}


- (void)requestFinished:(ASIHTTPRequest *)request
{    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if (request.responseStatusCode == 400) {
        
        NSError *error = [request error];
        NSLog(@"error:%@",error);
        if (change_bool==TRUE)
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Password not changed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Account not deactivated" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
      
        
    } else if (request.responseStatusCode == 403) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];

        if (change_bool==TRUE)
        {
            pop_up_view.alpha=1.0;
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:1.0];
            pop_up_view.alpha=0.0;
            [UIView commitAnimations];
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Password not changed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Account not deactivated" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
    } else if (request.responseStatusCode == 200) {
        NSString *responseString = [request responseString];
        NSLog(@"responseString:%@",responseString);
        responseString=[responseString stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        NSDictionary *responseDict = [responseString JSONValue];
        NSLog(@"responseDict:%@",responseDict);
        NSString *unlockCode = [responseDict objectForKey:@"unlock_code"];
        
        if ([unlockCode compare:@"com.razeware.test.unlock.cake"] == NSOrderedSame) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];

            if (change_bool==TRUE)
            {
                pop_up_view.alpha=1.0;
                [UIView beginAnimations:nil context:NULL];
                [UIView setAnimationDuration:1.0];
                pop_up_view.alpha=0.0;
                [UIView commitAnimations];
              
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"You Have Changed Your Password Successfully." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                [alert release];
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:responseString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                [alert release];
            }

            
                      
            
            
            
        } else {  
            [MBProgressHUD hideHUDForView:self.view animated:YES];

            if (change_bool==TRUE)
            {
                pop_up_view.alpha=1.0;
                [UIView beginAnimations:nil context:NULL];
                [UIView setAnimationDuration:1.0];
                pop_up_view.alpha=0.0;
                [UIView commitAnimations];

                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Password not changed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                [alert release];
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Account not deactivated" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                [alert release];
            }
        }
        
    } else {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];

        if (change_bool==TRUE)
        {
            pop_up_view.alpha=1.0;
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:1.0];
            pop_up_view.alpha=0.0;
            [UIView commitAnimations];

            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Password not changed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Account not deactivated" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
        }

    }
    
}

- (void)requestFailed:(ASIHTTPRequest *)request
{    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if (change_bool==TRUE)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Password not changed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Account not deactivated" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
}

-(IBAction)chang_done

{
    [self readlogin];
    NSURL *url = [NSURL URLWithString:@"http://192.168.0.111/DatingService/userProfile.svc/changePassword/"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    /*
     NSString *str_url=[[NSString alloc]initWithFormat:@"{\"isMale\":\"%@\",\"userName\":\"%@\",\"userPassword\":\"%@\",\"userEmail\":\"%@\",\"userRealName\":\"%@\"}",genderString,name_txt.text,passwd_txt.text,email_txt.text,realname_txt.text];
     
     */
    
    
    NSString *str_url=[[NSString alloc]initWithFormat:@"{\"userID\":\"%@\",\"userPassword\":\"%@\",\"newuserPassword\":\"%@\"}",login_select,old_paswd_txt.text,new_passwd_txt.text];
    
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
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"Alert index:%d",buttonIndex);
    
    if(buttonIndex==0)
    {
        
        if (deactivate_bool==TRUE)
        {
             [self deactivate_call];
        }
        
        else if(change_bool==TRUE)
        {
        
        
        }
        else if(rating_bool==TRUE)
        {
            [self rating_call];
            
        }

          
    }
    else if(buttonIndex==1)
    {
        
    }
}
-(void)rating_call
{
  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.onlinedatingmodels.com/"]];

}
-(IBAction)close
{
    
    pop_up_view.alpha=1.0;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1.0];
    pop_up_view.alpha=0.0;
    [UIView commitAnimations];
    
        
}
-(IBAction)menupage
{
    Menupage *preview=[[Menupage alloc]initWithNibName:@"Menupage" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:preview animated:NO];

}
-(void)check_other_value
{




}
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

- (void)viewDidUnload
{
    [global_msg_btn release];
    global_msg_btn = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(IBAction)vibrate_btn:(id)sender
{
    
    UIButton *tappedButton = (UIButton*)sender;
	
	if([tappedButton.currentImage isEqual:[UIImage imageNamed:@"no.png"]])
        // {
	{
        
        vibrate_global_string = [[NSString alloc]initWithString:@"0"];
		[vibrate_btn setImage:[UIImage imageNamed:@"yes.png"] forState:UIControlStateNormal];
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate); 
        
        
	}
	
	else 
	{
        vibrate_global_string = [[NSString alloc]initWithString:@"0"];
		[vibrate_btn setImage:[UIImage imageNamed:@"no.png"] forState:UIControlStateNormal];
        // AudioServicesPlaySystemSound(!kSystemSoundID_Vibrate);
       
		
        
	}
    
}

-(IBAction)play_btn:(id)sender
{
    
    UIButton *tappedButton = (UIButton*)sender;
	
	if([tappedButton.currentImage isEqual:[UIImage imageNamed:@"no.png"]])
        // {
	{
        play_sound_global_string =[[NSString alloc]initWithString:@"0"];
        
		[play_btn setImage:[UIImage imageNamed:@"yes.png"] forState:UIControlStateNormal];
        
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
	
	else 
	{
        
        play_sound_global_string =[[NSString alloc]initWithString:@"1"];
		[play_btn setImage:[UIImage imageNamed:@"no.png"] forState:UIControlStateNormal];
        
		
        
	}
    
}
-(IBAction)notification_btn:(id)sender
{
    
    UIButton *tappedButton = (UIButton*)sender;
	
	if([tappedButton.currentImage isEqual:[UIImage imageNamed:@"no.png"]])

	{
        
		[notification_btn setImage:[UIImage imageNamed:@"yes.png"] forState:UIControlStateNormal];
        
        
	}
	
	else 
	{
		[notification_btn setImage:[UIImage imageNamed:@"no.png"] forState:UIControlStateNormal];
        
		
        
	}
    
}
-(IBAction)Rate_idate
{
    change_bool=FALSE;
    deactivate_bool=FALSE;
    rating_bool=TRUE;

    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Are you sure you want to rate iDate" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel",nil];
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
    [global_msg_btn release];
    [super dealloc];
}
@end
