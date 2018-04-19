//
//  Give_gift_view.m
//  iDate
//
//  Created by D M R on 12/09/12.
//  Copyright (c) 2012 iHubTechnologies. All rights reserved.
//

#import "Give_gift_view.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "JSON.h"
#import "JSON1.h"
#import "MBProgressHUD.h"
#import "UIImageView+DispatchLoad.h"
#import "AsyncImageView.h"
#import "AsyncImageView1.h"
#import "AppDelegate.h"
#import "Menupage.h"
#import "Profile_view.h"
#import "Chat_view.h"
#import<SystemConfiguration/SystemConfiguration.h>
#define ASYNC_IMAGE_TAG 9999
#define FONT_SIZE 18.0f
#define CELL_CONTENT_WIDTH 320.0f
#define CELL_CONTENT_MARGIN 10.0f
@interface Give_gift_view ()

@end

@implementation Give_gift_view

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
    
    
    
    gifts_scroll=[[UIScrollView alloc]init];
    [gifts_scroll setFrame:CGRectMake(20,80,320,356)];
    gifts_scroll.clipsToBounds = YES;
	gifts_scroll.delegate = self;
    [self.view addSubview:gifts_scroll];
    gift_select_new=[[NSString alloc]init];
    gift_done.hidden=YES;
//    CGRect frame = pop_upview.frame;
//    pop_upview.frame = frame;

    pop_upview.frame=CGRectMake(10,100,311, 200);
    [self.view addSubview:pop_upview];
    pop_upview.alpha=0.0;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
       hud.labelText = @"Loading...";
    [self performSelectorInBackground:@selector(call_gifts) withObject:nil];
    
    
    
    gift_dict=[[NSMutableDictionary alloc]init];
    gift_select_id_arr=[[NSMutableArray alloc]init];
    gift_select_name_arr=[[NSMutableArray alloc]init];
    gift_select4=[[NSString alloc]init];
    
    
  //  [self performSelector:@selector(call_gifts) withObject:nil afterDelay:2.0];
    // Do any additional setup after loading the view from its nib.
}
-(void)dictionary_check
{

    
}
- (IBAction)click_msg_chatWindow:(id)sender {
    
    Chat_view *chatView = [[Chat_view alloc]initWithNibName:@"Chat_view" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:chatView animated:YES];
    
}

-(void)call_gifts
{

    gift_user_img_arr=[[NSMutableArray alloc]init];
    gift_touser_arr=[[NSMutableArray alloc]init];
    gift_fromuser_arr=[[NSMutableArray alloc]init];
    gift_desc_arr=[[NSMutableArray alloc]init];
    final_gifts_arr=[[NSMutableArray alloc]init];
    
    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
    

   
        str_gift_url=[[NSString alloc]initWithFormat:@"http://192.168.0.111/DatingService/getList.svc/getGifts/"];
    

    NSMutableURLRequest *request =[[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:str_gift_url]];
    
    NSData *returnData = [ NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil ];
    
    NSString *returnString = [[NSString alloc]initWithData:returnData encoding:NSUTF8StringEncoding];
    
    NSLog(@"returnString:*%@*",returnString);
    
    
    NSDictionary *dict=[returnString JSONValue];
    if (dict==nil||dict==NULL)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"No Response From Server" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    
    
    else {
        
    NSLog(@"dict:%@",dict);
    for (NSDictionary *info in dict)
    {
        
        gift_image_url =[info objectForKey:@"giftImageURL"];
        if (gift_image_url == (NSString*)[NSNull null])
            
        {
            
            
            
            
        }
        
        else 
        {
            // [gift_desc_arr removeAllObjects];
            [gift_user_img_arr addObject:gift_image_url];
            NSLog(@"profile_user_img_arr:%@",gift_user_img_arr);
        }
        
        gift_to_user=[info objectForKey:@"giftID"];
        [gift_touser_arr addObject:gift_to_user];
        
       
        gift_desc=[info objectForKey:@"giftDescription"];
        [gift_desc_arr addObject:gift_desc];
        
        
        
        
    }
    
    
    for (int i=0; i<[gift_user_img_arr count]; i++)
    {
        
        NSString *string_final=[[NSString alloc]initWithFormat:@"%@",[gift_user_img_arr objectAtIndex:i]];
        
        NSString *str_image_url_1 = [[NSString alloc]initWithFormat:@"http://192.168.0.111/Dating/images/gifts/"];
        
        str_image_url_12 =[[NSString alloc]initWithFormat:@"%@",[str_image_url_1 stringByAppendingString:string_final]];
        
        
        [final_gifts_arr addObject:str_image_url_12];
        NSLog(@"final_gifts_arr:%@",final_gifts_arr);
        
        
   
        //        [self performSelector:@selector(display_gift) withObject:nil afterDelay:10.0];
        
        
    }
    
   // [self performSelector:@selector(display_gift) withObject:nil afterDelay:2.0];
    [self performSelectorOnMainThread:@selector(display_gift) withObject:nil waitUntilDone:YES];

    }
    [pool release];
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

-(void)display_gift
{
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    int var1 = [final_gifts_arr count];
    
    NSLog(@"count:%d",[final_gifts_arr count]);
    NSLog(@"count_var:%d",var1);
    
    int var2= var1/4;
    int count=0;
	int offset1 =1;
    
    int x=0,y=5;
    for (int row = 0; row<var2;row++)
    {
        NSLog(@"row:%d",row);
        x=0;
       // offset1=1;
        NSLog(@"x:%d",x);
        
        for (int col = 0; col<4;col++)
        {  
            NSLog(@"col:%d",col);
            if(count<var1)
            {
				
                NSLog(@"y:%d",y);
                
                            
                NSString *str_lbl=[[NSString alloc]initWithFormat:@"%@",[gift_desc_arr objectAtIndex:count]];
                

                
                btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake(x, y, 50, 50);
				btn.backgroundColor=[UIColor clearColor];
                UIImage *buttonImage=[UIImage imageNamed:@"no_select.png"];
                [btn setBackgroundImage:buttonImage forState:UIControlStateNormal]; 
                

				[btn addTarget:self action:@selector(iconselect:) forControlEvents:UIControlEventTouchUpInside];         
       
				[gifts_scroll addSubview:btn];
				btn.tag =count;

                
                
                
                
                UILabel *dateLbl = [[UILabel alloc]initWithFrame:CGRectMake(x,y+40,70, 55)];
                dateLbl.text = str_lbl;
                dateLbl.backgroundColor = [UIColor clearColor];
                dateLbl.font = [UIFont systemFontOfSize:10];
                dateLbl.textColor =[UIColor blackColor]; 
                dateLbl.lineBreakMode=UILineBreakModeWordWrap;
                dateLbl.numberOfLines = 3;
                [gifts_scroll addSubview:dateLbl];
                

                
                AsyncImageView1 *imgPhoto = [[AsyncImageView1 alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 50.0f, 50.0f)];
                imgPhoto.contentMode = UIViewContentModeScaleAspectFill;
                imgPhoto.clipsToBounds = YES;
                imgPhoto.tag = ASYNC_IMAGE_TAG;
                [btn addSubview:imgPhoto];
              
                
                AsyncImageView1 *imageView1 = (AsyncImageView1 *)[btn viewWithTag:ASYNC_IMAGE_TAG];
                //cancel loading previous image for cell
                [[AsyncImageLoader sharedLoader] cancelLoadingURL:imageView1.imageURL];
                imageView1.imageURL = [NSURL URLWithString:[final_gifts_arr objectAtIndex:count]];
                NSLog(@"Track Image:%@",[final_gifts_arr objectAtIndex:count]);
                NSLog(@"images display:%@",imageView1.image);

                 
                [gifts_scroll setContentSize:CGSizeMake(320,y+80)];
                
                x=x+80;
				offset1=offset1+x;
				
            }
            else
            {
				NSLog(@"sdfsdfs ");
            }
            
			count++;
        }
        y+=100;
    }
    
    
}
-(IBAction)close
{

    pop_upview.alpha=1.0;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.10];
    pop_upview.alpha=0.0;
    [UIView commitAnimations];
    


}
-(IBAction)menupage
{
    Menupage *preview=[[Menupage alloc]initWithNibName:@"Menupage" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:preview animated:NO];

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"Alert index:%d",buttonIndex);
    
    if(buttonIndex==0)
    {
        [self send_call];        //[self mailaction];
    }
    else if(buttonIndex==1)
    {
        
    }
}
-(void)send_call
{
    if ([gift_desc_txtview.text isEqualToString: @""]||[gift_desc_txtview isEqual:@"null"]||gift_desc_txtview.text==nil||gift_desc_txtview.text==NULL||[gift_desc_txtview.text isEqualToString:@" "])
    {
        desc_string=[[NSString alloc]initWithFormat:@"null"];
    }
    
    else
    {
         desc_string=[[NSString alloc]initWithFormat:@"%@",gift_desc_txtview.text];
    }
    
       
    
    
    
    for (int i=0; i<[gift_select_id_arr count]; i++)
    {
        
        gift_select3=[[NSString alloc]initWithFormat:@"%@,",[gift_select_id_arr objectAtIndex:i]];
        
        NSLog(@"gift_select3:%@",gift_select3);
        
        
        gift_select4=[gift_select4 stringByAppendingString:gift_select3];
        NSLog(@"gift_select4:%@",gift_select4);
        
    }
    
    if ( [gift_select4 length]> 0 )
    {
        gift_select4 = [gift_select4 substringToIndex:[gift_select4 length] - 1];
    }
    
    else
    {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please select gift to send" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel",nil];
        [alert show];
        [alert release];
        
    }
    
    NSLog(@"gift_select4:%@",gift_select4);
    

    NSLog(@"gift_select4:%@",gift_select4);

    pop_upview.alpha=1.0;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.10];
    pop_upview.alpha=0.0;
    [UIView commitAnimations];
    
    NSURL *url = [NSURL URLWithString:@"http://192.168.0.111/DatingService/Gifts.svc/processGift/"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    
    NSString *str_url=[[NSString alloc]initWithFormat:@"{\"fromUserID\":\"%@\",\"toUserID\":\"%@\",\"selectedGiftIDs\":\"%@\",\"userMessage\":\"%@\"}",global_gift_id,global_gift_to_id,gift_select4,desc_string];
    
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

- (BOOL)textViewShouldReturn:(UITextView *)textView

{   
	NSLog(@"textViewShouldReturn");
    
       
    
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
{          // became first responder'
    
      
	NSLog(@"textFieldDidBeginEditingGive");
    
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

-(IBAction)sendgifts
{

       UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Proceed To Send Gifts?" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel",nil];
        [alert show];
        [alert release];
        
      
    
}
- (void)requestFinished:(ASIHTTPRequest *)request
{    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if (request.responseStatusCode == 400) {
        
        NSError *error = [request error];
        NSLog(@"error:%@",error);

        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Gift sending failed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
    } else if (request.responseStatusCode == 403) {
        
        NSError *error = [request error];
        NSLog(@"error:%@",error);

        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Gift sending failed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    } else if (request.responseStatusCode == 200) {
        NSString *responseString = [request responseString];
        NSLog(@"responseStringGifts:%@",responseString);
        NSDictionary *responseDict = [responseString JSONValue];
        NSLog(@"responseDict:%@",responseDict);
        NSString *unlockCode = [responseDict objectForKey:@"unlock_code"];
        
        if ([unlockCode compare:@"com.razeware.test.unlock.cake"] == NSOrderedSame) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Gift sent" message:responseString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
            
            pop_upview.alpha=1.0;
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.10];
            pop_upview.alpha=0.0;
            [UIView commitAnimations];

            UIImage *buttonImage=[UIImage imageNamed:@"no_select.png"];
            [btn setBackgroundImage:buttonImage forState:UIControlStateNormal];
            
            NSString *subResponse = [NSString stringWithFormat:@"%@",[responseString substringWithRange:NSMakeRange(1, 9)]];
            
            NSLog(@"SubString:%@",subResponse);
           // NSLog(@"[subResponse isEqualToString:]=%i",[subResponse isEqualToString:@"You Need"]);
           
            if ([subResponse isEqualToString:@"You Need"]==0) {
                NSLog(@"sub enter");
                Give_gift_view *gift_view=[[Give_gift_view alloc]initWithNibName:@"Give_gift_view" bundle:[NSBundle mainBundle]];
                [self.navigationController pushViewController:gift_view animated:NO];
                //[self viewDidLoad];
            }
            
            
        } else {  
            
            NSError *error = [request error];
            NSLog(@"error:%@",error);

            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Gift sending failed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
            
        }
        
    } else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Gift sending failed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    
}

- (void)requestFailed:(ASIHTTPRequest *)request
{    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    NSError *error = [request error];
    NSLog(@"error:%@",error);
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Gift sending failed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [alert release];
}

-(IBAction)iconselect:(UIButton*)sender
{
    
        gift_done.hidden=NO;
    
    UIButton *tappedButton1 = (UIButton*)sender;
	int indx1 = tappedButton1.tag;
    
  	if([tappedButton1.currentBackgroundImage isEqual:[UIImage imageNamed:@"no_select.png"]])
    {
    
    UIImage *buttonImage=[UIImage imageNamed:@"gift_select.png"];
    [tappedButton1 setBackgroundImage:buttonImage forState:UIControlStateNormal]; 
    
	NSLog(@"indx:%d",indx1);
	gift_select =[[NSString alloc]initWithFormat:@"%@",[gift_touser_arr objectAtIndex:indx1]];
        
        [gift_select_id_arr addObject:gift_select];
        
	/*
    
    gift_select=[gift_select stringByAppendingFormat:@","];
    
    
 //   country_str=[country_str stringByAppendingFormat:@","];
    gift_select_new=[[NSString alloc]initWithFormat:@"%@",[gift_select_new stringByAppendingFormat:gift_select]];
    
    
 
    
    if ([gift_select_new isEqualToString:@"(null)"]||[gift_select_new isEqualToString:@"(null)"]||gift_select_new==nil||gift_select_new==NULL)
    {
        
    }
    
    else 
    {
        
    }*/
    }
    
    else
    {
        
        
             
        UIImage *buttonImage=[UIImage imageNamed:@"no_select.png"];
        [tappedButton1 setBackgroundImage:buttonImage forState:UIControlStateNormal]; 
        
        
        gift_select1 =[[NSString alloc]initWithFormat:@"%@",[gift_touser_arr objectAtIndex:indx1]];
           NSLog(@"gift_select1:%@",gift_select1);
        gift1=[gift_select1 intValue];
        
        gift2=[gift_select_id_arr indexOfObject:gift_select1];
        
        
        [gift_select_id_arr removeObjectAtIndex:gift2];
        NSLog(@"gift_select_id_arr:%@",gift_select_id_arr);
        
        
          /*
        gift_select2=[[NSString alloc]initWithFormat:@"%@",[gift_select1 stringByAppendingFormat:@","]];
          NSLog(@"gift_select1:%@",gift_select2);
        
        
        
        if (image_boool==FALSE)
        {
            image_boool=TRUE;
            gift_select3=[gift_select_new stringByReplacingOccurrencesOfString:gift_select2 withString:@"0,"];
            
             NSLog(@"gift_select3:%@",gift_select3);

        }
        else
        {
        
            gift_select4=[gift_select3 stringByReplacingOccurrencesOfString:gift_select2 withString:@"0,"];
            
             NSLog(@"gift_select4:%@",gift_select4);

        
        }

            
        
        */
        
        
        
       
        

        
        
             
        
    }
    
    
       
}
    
   

    

    
-(IBAction)gift_done_click
{
       pop_upview.alpha=0.0;
       [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.10];
          pop_upview.alpha=1.0;
        [UIView commitAnimations];

}

-(IBAction)gift_back
{

    Profile_view *profile_view=[[Profile_view alloc]initWithNibName:@"Profile_view" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:profile_view animated:NO];

}
- (void)viewDidUnload
{
    [global_msg_btn release];
    global_msg_btn = nil;
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
    [global_msg_btn release];
    [super dealloc];
}
@end
