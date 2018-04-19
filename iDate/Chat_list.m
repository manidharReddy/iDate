//
//  Chat_list.m
//  iDate
//
//  Created by D M R on 24/09/12.
//  Copyright (c) 2012 iHubTechnologies. All rights reserved.
//

#import "Chat_list.h"
#import "UIBubbleTableView.h"
#import "UIBubbleTableViewDataSource.h"
#import "NSBubbleData.h"
#import "DDPageControl.h"
#import "Signup.h"
#import "Menupage.h"
#import "AsyncImageView.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"
#import "Profile_view.h"
#import "AsyncImageView1.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "JSON.h"
#import "JSON1.h"
#import "Chat_view.h"
@interface Chat_list ()

@end

@implementation Chat_list

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
/*
- (void) viewDidAppear:(BOOL)animated
{
    NSLog(@"view did appear");
    [super viewDidAppear:animated];
    if (bubbleTable.contentSize.height > bubbleTable.frame.size.height)
        {
            NSLog(@"buuble enter");
            CGPoint offset = CGPointMake(0, bubbleTable.contentSize.height - bubbleTable.frame.size.height);
            [bubbleTable setContentOffset:offset animated:YES];
            }
}
*/
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
    /*
    if([global_Chat_id isEqualToString:@"null"]!=1){
        
        NSLog(@"globalchat:%@",global_Chat_id);
        //[backToProfile setImage:[UIImage imageNamed:@"left.png"] forState:UIControlStateNormal];
        //global_string=[[NSString alloc]initWithFormat:@"%@",global_Chat_id];
        
    }else{
        //NSLog(@"enter one");
        //global_Chat_id = [[NSString alloc]initWithFormat:@"%@",NULL];
        //[backToProfile setImage:[UIImage imageNamed:@"mainmenu.png"] forState:UIControlStateNormal];
        
    }
    */
    
    [self readlogin];
    
    
    scroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0,40, 320, 460)];
    //scroll.backgroundColor=[UIColor redColor];
    scroll.scrollEnabled=YES;
	scroll.userInteractionEnabled=YES;
    scroll.pagingEnabled = YES;
    scroll.showsHorizontalScrollIndicator = NO;
    scroll.showsVerticalScrollIndicator = NO;
    scroll.scrollsToTop = NO;
    scroll.delegate = self;
    [self.view addSubview:scroll];
    
    bubble_msg_view.frame =CGRectMake(0, 0, 320, 460);
    [scroll addSubview:bubble_msg_view];
    
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading Chat...";
    [del_btn setImage:[UIImage imageNamed:@"delete7.png"] forState:UIControlStateNormal];
  
  // [self performSelector:@selector(call_json) withObject:nil afterDelay:1.0];
    [self performSelectorInBackground:@selector(readedMessage) withObject:nil];
 [self performSelectorInBackground:@selector(call_json) withObject:nil];
    
   // [self scrollToBottomAnimated:NO];
    
   
    // Do any additional setup after loading the view from its nib.
}
-(IBAction)send_msg
{

    //[self readlogin];
    
    NSString *chat_str=[[NSString alloc]initWithFormat:@"%@",chat_txt_view.text];
    
    NSURL *url = [NSURL URLWithString:@"http://192.168.0.111/DatingService/chat.svc/processSendMessage/"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    NSString *str_url=[[NSString alloc]initWithFormat:@"{\"userMessage\":\"%@\",\"fromUserID\":\"%@\",\"toUserID\":\"%@\"}",chat_str,login_select,chat_id];
    
    
//NSString *str_url=[[NSString alloc]initWithFormat:@"{\"userMessage\":\"%@\",\"fromUserID\":\"757\",\"toUserID\":\"685\"}",chat_str];
    
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
        
        
	}else {
        NSLog(@"%s (%1d)", sqlite3_errmsg(database), sqlite3_errcode(database));
    }
	sqlite3_finalize(stmt);	
    
    //sqlite3_close(database);

}
/*
-(void)viewWillAppear:(BOOL)animated
{
    [bubbleTable reloadData];
    int lastRowNumber = [bubbleTable numberOfRowsInSection:0] - 1;
    NSIndexPath* ip = [NSIndexPath indexPathForRow:lastRowNumber inSection:0];
    [bubbleTable scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionBottom animated:NO];
}
 */
-(IBAction)menupage
{

    Menupage *menu=[[Menupage alloc]initWithNibName:@"Menupage" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:menu animated:NO];

}
- (void)requestFinished:(ASIHTTPRequest *)request
{    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if (request.responseStatusCode == 400) {
        if (del_chat_bool==TRUE)
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Deletion failed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
            del_chat_bool=FALSE;

        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Sending failed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
        }

        
    } else if (request.responseStatusCode == 403) {
        if (del_chat_bool==TRUE)
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Deletion failed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
            del_chat_bool=FALSE;


        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Sending failed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
        }

    } else if (request.responseStatusCode == 200) {
        
        responseString = [NSString stringWithFormat:@"%@",[request responseString]];
        NSLog(@"responseString:%@",responseString);
        
        if (responseString==nil||responseString==NULL)
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"No Response From Server" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
        
        
        else {
            
       // responseString = [responseString stringByReplacingOccurrencesOfString:@""
                                                                  // withString:@""];
        
        
        
        //NSDictionary *responseDict = [responseString JSONValue];
        
      //  NSString *responseStr =[NSString stringWithFormat:@"%@",responseDict];
        
        NSString *textMax = [NSString stringWithFormat:@"%i",[chat_txt_view.text length]];
        
       // NSLog(@"enter in response string Bool:%i",[responseString isEqualToString:@"success"]);
        NSLog(@"responseString1:%@",responseString);
        
        
        if(![responseString isEqualToString:@"success"])
        {
            NSLog(@"enter in response string success");

            chat_txt_view.text =@"";
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Message Sent Successfully." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        [alert release];
        [self performSelectorInBackground:@selector(call_json) withObject:nil];
        
        }
        else if([responseString isEqualToString:@"Please Enter The Message."])
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please Enter The Message." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
            
            
        }else if([textMax intValue]>500)
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Message Maximum Length Is 500." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
            
        }
       /* else{
            NSLog(@"responseString last:%@",responseString);
        }
        */
            //chat_txt_view.text=@"";
       // [self performSelectorInBackground:@selector(call_json) withObject:nil];
                      
                    //  [self performSelector:@selector(call_other) withObject:nil afterDelay:7.0];
        }         //}
            
            
        } else {
            
            
            if (del_chat_bool==TRUE)
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Deletion failed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                [alert release];
                del_chat_bool=FALSE;


            }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Sending failed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
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
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Sending failed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [alert release]; if (del_chat_bool==TRUE)
    {
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Sending failed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }

}

-(void)readedMessage
{
   // [self readlogin];
    
    NSString *mesg_readed_str =[[NSString alloc]initWithFormat:@"http://192.168.0.111/DatingService/chat.svc/NewMessages/%@/%@",login_select,chat_id];
    
    NSLog(@"ReadedMsg:%@",mesg_readed_str);
    
    NSMutableURLRequest *request =[[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:mesg_readed_str]];
    
    NSData *returnData = [ NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil ];
    
    NSString *returnString = [[NSString alloc]initWithData:returnData encoding:NSUTF8StringEncoding];
    
    NSLog(@"returnString:*%@*",returnString);
    
    
    NSDictionary *dict_readed_msg=[returnString JSONValue];
    
    NSLog(@"returnStringReadedMsg:*%@*",dict_readed_msg);
    
    
}



-(void)call_json
{
    
    @try
    {
         // [self readlogin];
    
    
    message_arr=[[NSMutableArray alloc]init];
    id_arr=[[NSMutableArray alloc]init];
    from_user_id=[[NSMutableArray alloc]init];
    type_arr =[[NSMutableArray alloc]init];
    mesaage_arr=[[NSMutableArray alloc]init];
  
     NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
    
     NSString *str_country =[[NSString alloc]initWithFormat:@"http://192.168.0.111/DatingService/chat.svc/displayMessages/%@/%@",chat_id,login_select];
    
    NSLog(@"str_country:%@",str_country);
    
    NSMutableURLRequest *request =[[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:str_country]];
    
    NSData *returnData = [ NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil ];
    
    NSString *returnString = [[NSString alloc]initWithData:returnData encoding:NSUTF8StringEncoding];
    
    NSLog(@"returnString:*%@*",returnString);
    
    
    NSDictionary *dict=[returnString JSONValue];
    
    
    
    
    for (NSDictionary *info in dict)
    {
        
        NSLog(@"info:%@",info);
        
        NSString  *user_string=[[NSString alloc]initWithFormat:@"%@",[info objectForKey:@"fromUserID"]];
        
         NSString  *user_string_sender=[[NSString alloc]initWithFormat:@"%@",[info objectForKey:@"fromUserName"]];
        
              
        
        if ([user_string isEqualToString:login_select])
        {
            type_string=[[NSString alloc]initWithFormat:@"0"];
            
           
        }
        
        else 
        {
            type_string=[[NSString alloc]initWithFormat:@"1"];
        }
        [type_arr addObject:type_string];
        
        
        NSString  *user_time=[[NSString alloc]initWithFormat:@"%@",[info objectForKey:@"messageCreated"]];
        
        
        
        
        
        
        NSString  *msg_string=[[NSString alloc]initWithFormat:@"%@: %@\n:%@",user_string_sender,[info objectForKey:@"userMessage"],user_time];
        [message_arr addObject:msg_string];
        
        NSString  *message_id=[[NSString alloc]initWithFormat:@"%@",[info objectForKey:@"userMessageID"]];
        [mesaage_arr addObject:message_id];
        
        NSLog(@"mesaage_arr:%@",mesaage_arr);

        
                 
    }
    
    [self sorting_arr];
    
     [MBProgressHUD hideHUDForView:self.view animated:YES];
    [self performSelectorOnMainThread:@selector(load_chat) withObject:nil waitUntilDone:YES];

        
    [pool release];
    }
    @catch (NSException *exception)
    {
        NSLog(@"main: Caught %@: %@", [exception name], [exception reason]);
    }

    
}

-(void)load_lastMessage
{
    NSLog(@"load_lastMessage");
    [bubbleTable reloadData];
    [bubbleTable selectRowAtIndexPath:[NSIndexPath indexPathForRow:([message_arr count]) inSection:0] animated:NO scrollPosition:UITableViewScrollPositionBottom];
   // [bubbleTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:([mesaage_arr count]-1) inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
}
-(void)load_chat
{


    
    //NSArray *paths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:([message_arr count] - 1) inSection:0]];
    //[bubbleTable insertRowsAtIndexPaths:paths withRowAnimation:NO];
    [bubbleTable reloadData];
    
    //[self performSelector:@selector(load_lastMessage) withObject:nil afterDelay:1.0];
    
    
     //[bubbleTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:([message_arr count]-1) inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
    
    
  //  [bubbleTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];

    
    for (int i=0; i<[message_arr count];i++)
    {
       
    }
   
    
//[self performSelector:@selector(call_other) withObject:nil afterDelay:7.0];
    
}
-(void)call_other;
{

 [self performSelectorInBackground:@selector(call_json) withObject:nil];

}
-(void)call_json1
{
   // [self readlogin];
    
    NSString *str_country =[[NSString alloc]initWithFormat:@"http://192.168.0.111/DatingService/chat.svc/displayMessages/%@/%@",chat_id,login_select];
    
    NSLog(@"str_country:%@",str_country);
    
    NSMutableURLRequest *request =[[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:str_country]];
    
    NSData *returnData = [ NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil ];
    
    NSString *returnString = [[NSString alloc]initWithData:returnData encoding:NSUTF8StringEncoding];
    
    NSLog(@"returnString:*%@*",returnString);
    
    
    NSDictionary *dict=[returnString JSONValue];
    
    
    
    
    for (NSDictionary *info in dict)
    {
        
        NSLog(@"info:%@",info);
        
        
    
        
        NSString  *user_string_sender=[[NSString alloc]initWithFormat:@"%@",[info objectForKey:@"fromUserName"]];

        
        NSString  *user_string=[[NSString alloc]initWithFormat:@"%@",[info objectForKey:@"fromUserID"]];
        
        NSLog(@"user_string:%@",user_string);
        
        if ([user_string isEqualToString:login_select])
        {
            type_string=[[NSString alloc]initWithFormat:@"0"];
        }
        
        else 
        {
            type_string=[[NSString alloc]initWithFormat:@"1"];
        }
        [type_arr addObject:type_string];
        
        
        NSString  *user_time=[[NSString alloc]initWithFormat:@"%@",[info objectForKey:@"messageCreated"]];
        
      
        

        
        
        NSString  *msg_string=[[NSString alloc]initWithFormat:@"%@: %@\n:%@",user_string_sender,[info objectForKey:@"userMessage"],user_time];
        [message_arr addObject:msg_string];

        
        NSString  *message_id=[[NSString alloc]initWithFormat:@"%@",[info objectForKey:@"userMessageID"]];

        
         

        [mesaage_arr addObject:message_id];
        
        
    }
    
    [self sorting_arr];
    
    
    
 }
-(void)sorting_arr
{
  
     bubbleData = [[NSMutableArray alloc] init];
    for ( int i=0;i<[message_arr count]; i++)
    {
        
        NSString *type_sort=[[NSString alloc]initWithFormat:@"%@",[type_arr objectAtIndex:i]];
        
        NSLog(@"type_sort:%@",type_sort);
        
        NSInteger type_int=[type_sort integerValue];
        
        [bubbleData addObject:[NSBubbleData dataWithText:[message_arr objectAtIndex:i]  andType:type_int]];
        
        
    }
    

    
    bubbleTable.bubbleDataSource = self;
    
    bubbleTable.snapInterval = 130;
    bubbleTable.typingBubble = NSBubbleTypingTypeSomebody;
    
    
    //bubbleTable.scrollsToTop =NO;
    
    
  [MBProgressHUD hideHUDForView:self.view animated:YES];
  
[self scrollToBottomAnimated:YES];
}

- (void)scrollToBottomAnimated:(BOOL)animated {
    
    NSLog(@"end of the msg");
   // if ( [bubbleTable numberOfSections:1] > 0 && [tableView numberOfRowsInSection:10] > 0 )
   /*
    NSInteger numberOfRows = [bubbleTable numberOfRowsInSection:6];
                             // [bubbleData count]];
    if (numberOfRows) {
        NSLog(@"end of the msg2");
        [bubbleTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:numberOfRows inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:animated];
    }
    */
    @try{
        
        NSLog(@"end of the msg3 content size %f",bubbleTable.contentSize.height);
                NSLog(@"end of the msg3 frame size%f",bubbleTable.frame.size.height);
        
       
        if (bubbleTable.contentSize.height > bubbleTable.frame.size.height)
            {
                CGPoint offset = CGPointMake(0, bubbleTable.contentSize.height - bubbleTable.frame.size.height);
                [bubbleTable setContentOffset:offset animated:YES];
                }
        
       [bubbleTable setContentOffset:CGPointMake(0, CGFLOAT_MAX) animated:NO];
    
        }
    @catch (NSException *exception) {
        NSLog(@"main exception:%@",[exception name]);
    }
    
    
}



- (BOOL)textViewShouldReturn:(UITextView *)textView

{
    NSLog(@"textViewShouldReturn");
   
    CGRect frame = bubble_msg_view.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.5];
	frame.origin.y = 0;
	bubble_msg_view.frame = frame;
	[UIView commitAnimations];
    
    [textView resignFirstResponder];
	
    return YES;
    
}


- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    NSLog(@"textViewShouldEndEditing");
    CGRect frame = bubble_msg_view.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.5];
	frame.origin.y = 0;
	bubble_msg_view.frame = frame;
	[UIView commitAnimations];
    
    
   	[textView resignFirstResponder];
	return YES;
    
    
}
- (void)textViewDidBeginEditing:(UITextView *)textView 
{
    //[chat_txt_view resignFirstResponder];
   // [textView resignFirstResponder];
    CGRect frame = bubble_msg_view.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.5];
    //frame = CGAffineTransformIdentity;
	frame.origin.y = -205;
	bubble_msg_view.frame = frame;
	[UIView commitAnimations];

    
//[bubble_msg_view setTransform:CGAffineTransformMakeTranslation(10,200)];
	NSLog(@"textFieldDidBeginEditing");
    
    

    
    
    
}

- (void)textViewDidEndEditing:(UITextView *)textView { 
    
    [textView resignFirstResponder];
    
    
    CGRect frame = bubble_msg_view.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.5];
	frame.origin.y =0;
	bubble_msg_view.frame = frame;
	[UIView commitAnimations];
    NSLog(@"textFieldDidBeginEditing2");
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

- (void)viewDidUnload
{
    [global_msg_btn release];
    global_msg_btn = nil;
    [bubble_msg_view release];
    bubble_msg_view = nil;
    [btnKeyBoardDissmis release];
    btnKeyBoardDissmis = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
#pragma mark - UIBubbleTableViewDataSource implementation

- (NSInteger)rowsForBubbleTable:(UIBubbleTableView *)tableView
{
    return [bubbleData count];
    NSLog(@"bubblecount:%d",[bubbleData count]);
}

- (NSBubbleData *)bubbleTableView:(UIBubbleTableView *)tableView dataForRow:(NSInteger)row
{
    return [bubbleData objectAtIndex:row];
    
   
}



-(IBAction)delete:(UIButton*)tempBtn
{
    
//    NSString *stringdetect=[[NSString alloc]initWithFormat:@"%@",del_lbl.text];
//    [self readdatabase];
//    //	if([tempBtn.currentImage isEqual:[UIImage imageNamed:@"signin.png"]])
//    //	{
//    //    [tempBtn setImage:[UIImage imageNamed:@"donenew.png"] forState:UIControlStateNormal];
//    if ([stringdetect isEqualToString:@"Delete"])
//    {
//        del_lbl.text=@"Edit";
//        [tblview setEditing:YES animated:YES];
//        
//    }
//    
//    
//    else  if ([stringdetect isEqualToString:@"Edit"])
//        
//	{
//        del_lbl.text=@"Delete";
//        
//        [tblview setEditing:NO animated:YES];
//        
//        
//    }
    
}


-(IBAction)EditPressed
{
    if (!bubbleTable.editing && mesaage_arr.count>0) 
    {
        [del_btn setImage:[UIImage imageNamed:@"chat_done.png"] forState:UIControlStateNormal];
        //[editBtn setTitle:@"Done" forState:UIControlStateNormal];
        //editBtn.title = @"Done";
        [bubbleTable setEditing:YES animated:YES];
    }	
    else
    {
        [del_btn setImage:[UIImage imageNamed:@"delete7.png"] forState:UIControlStateNormal];
        //editBtn.title = @"Edit";
        [bubbleTable setEditing:NO animated:YES];
       // [self performSelector:@selector(UpdatePlaylistDBRows) withObject:nil afterDelay:0.1];
    }
}

-(void)delete_chat
{
    [self readlogin];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"You are about to delete a Message. Do you wish to proceed?" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel",nil];
    [alert show];
    [alert release];

    [self readlogin];

}

- (IBAction)btnClickKeyBoardDissmis:(id)sender {
    
    
    [self.view endEditing:YES];
    [self textViewShouldReturn:(id)sender];
    
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"Alert index:%d",buttonIndex);
    
    if(buttonIndex==0)
    {
        [self delete_final];
        
    }
    else  if(buttonIndex==1)
    {
        
    }
}

-(void)delete_final
{
    //del_chat_bool=TRUE;
    //NSString *chat_sel=[[NSString alloc]initWithFormat:@"%@",[mesaage_arr objectAtIndex:chat_index]];
    
    NSLog(@"chat_str:%@",global_delete_msg_str);
    
   // MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //hud.labelText = @"Loading...";
    
    NSString *str=[[NSString alloc]initWithFormat:@"http://192.168.0.111/DatingService/chat.svc/deleteAllMessages/%@/%@",global_delete_msg_str,login_select];
    NSLog(@"deleted service%@",str);
    
    NSMutableURLRequest *request =[[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:str]];
    
    NSData *returnData = [ NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil ];
    
    NSString *returnString = [[NSString alloc]initWithData:returnData encoding:NSUTF8StringEncoding];
    
    NSLog(@"returnString:*%@*",returnString);
    
    returnString=[returnString stringByReplacingOccurrencesOfString:@"\"" withString:@""];

    
    if ([returnString isEqualToString:@"Messages deleted"])
    {
        //[MBProgressHUD hideHUDForView:self.view animated:YES];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Message deleted" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
        Chat_view *chatViewCal = [[Chat_view alloc]init];
        [chatViewCal refreshChatView ];
        
        
        
        
        //[self delay_MenuClass];
        
      //  [self call_json];


    }
    else
    {
        //[MBProgressHUD hideHUDForView:self.view animated:YES];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Message Not deleted" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
        

    }
    // Start hud



}
-(IBAction)Back
{
    
    if([global_Chat_id isEqualToString:@"null"]!=1){
        NSLog(@"global_chat_id in chat_list:%@",global_Chat_id);
        //[backToProfile setImage:[UIImage imageNamed:@"left.png"] forState:UIControlStateNormal];
        global_string=[[NSString alloc]initWithFormat:@"%@",global_Chat_id];
        Profile_view *profile=[[Profile_view alloc]initWithNibName:@"Profile_view" bundle:[NSBundle mainBundle]];
        [self.navigationController pushViewController:profile animated:NO];
        
    }else{
        //[backToProfile setImage:[UIImage imageNamed:@"mainmenu.png"] forState:UIControlStateNormal];
        Chat_view *chat_ViewObj=[[Chat_view alloc]initWithNibName:@"Chat_view" bundle:[NSBundle mainBundle]];
        [self.navigationController pushViewController:chat_ViewObj animated:NO];

        //Menupage *preview=[[Menupage alloc]initWithNibName:@"Menupage" bundle:[NSBundle mainBundle]];
        //[self.navigationController pushViewController:preview animated:NO];

        //global_Chat_id = [[NSString alloc]initWithFormat:@"%@",NULL];
    }
    
    //Menupage *preview=[[Menupage alloc]initWithNibName:@"Menupage" bundle:[NSBundle mainBundle]];
    //[self.navigationController pushViewController:preview animated:NO];
   // [self performSelector:@selector(delay_MenuClass) withObject:nil afterDelay:3.0];
    
    /*
    Profile_view *profile=[[Profile_view alloc]initWithNibName:@"Profile_view" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:profile animated:NO];
    */
}
-(void)delay_MenuClass
{
    Chat_view *chatView=[[Chat_view alloc]initWithNibName:@"Chat_view" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:chatView animated:NO];
    
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
    [bubble_msg_view release];
    [btnKeyBoardDissmis release];
    [super dealloc];
}
@end
