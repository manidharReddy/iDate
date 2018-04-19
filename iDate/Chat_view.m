//
//  Chat_view.m
//  iDate
//
//  Created by D M R on 30/08/12.
//  Copyright (c) 2012 iHubTechnologies. All rights reserved.
//

#import "Chat_view.h"
#import "Chat_cell.h"
#import "AppDelegate.h"
#import "JSON.h"
#import "JSON1.h"
#import "MBProgressHUD.h"
#import "Menupage.h"
#import "Chat_list.h"
#import "Freinds_view.h"
#import "AsyncImageView1.h"
#import "LatitudeCalac.h"
#define ASYNC_IMAGE_TAG 9999


@interface Chat_view ()

@end

@implementation Chat_view

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
    
    if([global_show_msg_iconstr isEqualToString:@"1"])
    {
        
        global_msg_btn.hidden=NO;
        
    }else
    {
        global_msg_btn.hidden=YES;
    }
    
    NSLog(@"refresh view");
    [self readlogin];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    
    user_name_arr=[[NSMutableArray alloc]init];
    msg_count=[[NSMutableArray alloc]init];
    user_msg_arr=[[NSMutableArray alloc]init];
    display_upgrade=[[NSMutableArray alloc]init];
    user_id=[[NSMutableArray alloc]init];

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading...";

    [self performSelector:@selector(chatdisplay) withObject:nil afterDelay:1.0];
    
       //Set the title
    //self.navigationItem.title = @"Countries";
    
    //Add the search bar
    
    //Chat_cell *cellObj =[[Chat_cell alloc]init];
       

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"count username:%i",[user_name_arr count]);
    return [user_name_arr count];
    //NSLog(@"count username:%i",[user_name_arr count]);
    // return [name_arr count];
    
    
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    Chat_cell *cell1;
    
    
    
    static NSString *cellIdentifier1 = @"cellIdentifier1";
    
    cell1 = (Chat_cell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
    if (cell1 == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Chat_cell"
                                                     owner:self options:nil];
        for (id oneObject in nib) if ([oneObject isKindOfClass:[Chat_cell class]])
            cell1 = (Chat_cell *)oneObject;
    }		
    cell1.selectionStyle = UITableViewCellSelectionStyleNone;
    
          
        //First get the dictionary object
    NSString *nameChat_str=[[NSString alloc]initWithFormat:@"%@",[user_name_arr objectAtIndex:[indexPath row]]];
    cell1.user_name.text =nameChat_str;
    
    
    //[user_name_arr objectAtIndex:[indexPath row]];
    NSLog(@"username in chat view:%@",[user_name_arr objectAtIndex:[indexPath row]]);
        cell1.user_msg.text=[user_msg_arr objectAtIndex:[indexPath row]];
    
    
        NSLog(@"Good");
    
               
      // cell1.message_count.text=[msg_count objectAtIndex:[indexPath row]];
  

    NSString *megssagCount_str=[[NSString alloc]initWithFormat:@"%@",[msg_count objectAtIndex:[indexPath row]]];
    if ([megssagCount_str isEqualToString:@"0"])
    {
        
        [cell1 hideTheImage];
        
       cell1.message_count.text=megssagCount_str;
        // cell1.message_count.hidden =YES;
        //cell1.round_image.hidden =YES;
    }
    else
    {
        //cell1.message_count.hidden =NO;
        //cell1.round_image.hidden =NO;
        
        [cell1 hideTheImageV];
         cell1.message_count.text=megssagCount_str;
        
    }
    
    
    
    
    
    
    
    
       // cell1.profile_img.image= [final_image_arr objectAtIndex:[indexPath row]];
    
    
        NSString *display_str=[[NSString alloc]initWithFormat:@"%@",[display_upgrade objectAtIndex: [indexPath row]]];
        if ([display_str isEqualToString:@"false"])
        {
             //cell1.upgrade_btn.hidden =YES;
        }
        else
        {
            //cell1.upgrade_btn.hidden =NO;
        }
        

            checkBox=[UIButton buttonWithType:UIButtonTypeCustom];
            checkBox.tag=indexPath.row;
            NSLog(@"tag:%d",checkBox.tag);
    
            checkBox.frame=CGRectMake(260,35,20,20);
           [checkBox setImage:[UIImage imageNamed:@"delete7.png"] forState:UIControlStateNormal];
            [cell1.contentView addSubview:checkBox];
            [checkBox addTarget:self action:@selector(connectclick:) forControlEvents:UIControlEventTouchUpInside];
           

        //cell.text = cellValue;
   
    urlImage = [NSString stringWithFormat:@"%@",[final_image_arr objectAtIndex:[indexPath row]]];
    
    //NSString *urlString1 = [NSString stringWithFormat:@"%@",str_profile_image];
    // NSURL *url1 = [NSURL URLWithString:urlString1];
    
    //============== for big img ===========////////
    
    AsyncImageView1 *imgPhoto = [[AsyncImageView1 alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 55.0f, 47.0f)];
    //imgPhoto.layer.masksToBounds = YES;
    //imgPhoto.layer.cornerRadius = 10.0;
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
    imageView1.imageURL = [NSURL URLWithString:urlImage];
    

    
    
    
    return cell1;
    
}

-(IBAction)connectclick:(UIButton*)sender
{


    UIButton *tapped_btn=(UIButton*)sender;
    int indx=tapped_btn.tag;
    
    chat_id=[[NSString alloc]initWithFormat:@"%@",[user_id objectAtIndex:indx]];
    global_delete_msg_str = [[NSString alloc]initWithString:chat_id];
    
    //Chat_list *chatListObj = [[Chat_list alloc]init];
    
  //  [chatListObj delete_chat];
    
    //[self performSelector:@selector(viewDidLoad) withObject:nil afterDelay:2.0];
    
    [self delete_chat];

}

- (IBAction)click_msg_chatWindow:(id)sender {
}
-(void)delete_chat
{
    [self readlogin];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"You are about to delete a Message. Do you wish to proceed?" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel",nil];
    [alert show];
    [alert release];
    
    //[self readlogin];
    
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
        [self performSelector:@selector(refreshChatView) withObject:nil afterDelay:2.0];
        
        //[self viewDidLoad];
        
        //Chat_view *chatViewCal = [[Chat_view alloc]init];
        //[chatViewCal refreshChatView ];
        
        
        
        
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











-(void)refreshChatView
{
    
    //[chat_tbl reloadData];
    NSLog(@"refresh the chat view");
    //[self performSelectorInBackground:@selector(chatdisplay) withObject:nil ];
    //[self performSelectorOnMainThread:@selector(viewDidLoad) withObject:nil waitUntilDone:YES];
    //[self performSelectorInBackground:@selector(reloadtableData) withObject:nil ];
    //[self performSelector:@selector(reloadtableData) withObject:nil afterDelay:1.0];
    
    
    [self viewDidLoad];
    
    //Chat_view *chatView=[[Chat_view alloc]initWithNibName:@"Chat_view" bundle:[NSBundle mainBundle]];
    //[self.navigationController pushViewController:chatView animated:NO];
    
}
-(void)reloadtableData
{
    [chat_tbl reloadData];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didselect");
    @try{
    global_Chat_id = [[NSString alloc]initWithFormat:@"%@",@"null"];
    chat_id=[[NSString alloc]initWithFormat:@"%@",[user_id objectAtIndex:[indexPath row]]];
    NSLog(@"chat_id string:%@",chat_id);
        //[self performSelector:@selector(delayChat_list) withObject:nil afterDelay:3.0];
   
    Chat_list *chat_list=[[Chat_list alloc]initWithNibName:@"Chat_list" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:chat_list animated:NO];
    
    }
    @catch (NSException *exception) {
        NSLog(@"main exception%@%@%@",[exception name],[exception reason],[exception userInfo]);
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 60;
	
}

-(void)delayChat_list
{
    Chat_list *chat_list=[[Chat_list alloc]initWithNibName:@"Chat_list" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:chat_list animated:NO];
    
}
-(void)chatdisplay
{
   //[self readlogin];
   user_name_arr=[[NSMutableArray alloc]init];
   msg_count=[[NSMutableArray alloc]init];
   user_msg_arr=[[NSMutableArray alloc]init];
   display_upgrade=[[NSMutableArray alloc]init];
    user_id=[[NSMutableArray alloc]init];
    
    image_get_arr =[[NSMutableArray alloc]init];
    final_image_arr =[[NSMutableArray alloc]init];
    
    gender_arr = [[NSMutableArray alloc]init];

NSString *str_country = [[NSString alloc]initWithFormat:@"http://192.168.0.111/DatingService/chat.svc/displayMessageFromAll/%@",login_select];

NSLog(@"str_country:%@",str_country);

NSMutableURLRequest *request =[[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:str_country]];

NSData *returnData = [ NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil ];

NSString *returnString = [[NSString alloc]initWithData:returnData encoding:NSUTF8StringEncoding];

NSLog(@"returnString:*%@*",returnString);


NSDictionary *dict=[returnString JSONValue];




for (NSDictionary *info in dict)
{
    
     NSLog(@"info:%@",info);
    
     NSString  *id_string=[info objectForKey:@"userID"];
     [user_id addObject:id_string];
     NSLog(@"id_str:*%@*",id_string);
    
      name_string=[info objectForKey:@"userName"];
    if([name_string isEqualToString:@"\"<null>\""]||[name_string isEqualToString:@""]||[name_string isEqualToString:@"(null)"]||name_string==nil||name_string==NULL||name_string == (NSString*)[NSNull null]||[name_string isEqualToString:@"null"]||[name_string isEqualToString:@"<null>"])
    {
        name_string=@"";
    }
     [user_name_arr addObject:name_string];
     NSLog(@"user_name_arr:%@",user_name_arr);
    

    
       NSString  *msg_string=[[NSString alloc]initWithFormat:@"%@",[info objectForKey:@"userMessage"]];
       msg_string=[msg_string stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    if ([msg_string isEqualToString:@"\"<null>\""]||[msg_string isEqualToString:@""]||[msg_string isEqualToString:@"(null)"]||msg_string==nil||msg_string==NULL||msg_string == (NSString*)[NSNull null]||[msg_string isEqualToString:@"null"]||[msg_string isEqualToString:@"<null>"])
    {
        msg_string=[[NSString alloc]initWithFormat:@"No message"];
    }
    
     [user_msg_arr addObject:msg_string];
     NSLog(@"user_msg_arr:%@",user_msg_arr);
    
     NSString  *upgarde_string=[[NSString alloc]initWithFormat:@"%@",[info objectForKey:@"displayUpgradeButton"]];
     [display_upgrade addObject:upgarde_string];
    NSLog(@"display_upgrade:%@",display_upgrade);
    
    NSString  *msgcount_string=[[NSString alloc]initWithFormat:@"%@",[info objectForKey:@"countOfUnreadMessages"]];
    [msg_count addObject:msgcount_string];
    NSLog(@"display_upgrade:%@",display_upgrade);
    
    image_get_string =[[NSString alloc]initWithFormat:@"%@",[info objectForKey:@"userFileURL"]];
    NSLog(@"image_get_string1:%@",image_get_string);
    if([image_get_string isEqualToString:@"\"<null>\""]||[image_get_string isEqualToString:@""]||[image_get_string isEqualToString:@"(null)"]||image_get_string==nil||image_get_string==NULL||image_get_string == (NSString*)[NSNull null]||[image_get_string isEqualToString:@"null"]||[image_get_string isEqualToString:@"<null>"])
    {
        image_get_string =@"";
    }
    NSLog(@"Image_get:%@",image_get_string);
    [image_get_arr addObject:image_get_string];
    
    
    
    
        gender_type = [[NSString alloc]initWithFormat:@"%@",[info objectForKey:@"isMale"]];
    NSLog(@"gender_type:%@",gender_type);
    /*
    if([gender_type isEqualToString:@"\"<null>\""]||[gender_type isEqualToString:@""]||[gender_type isEqualToString:@"(null)"]||gender_type==nil||gender_type==NULL||gender_type == (NSString*)[NSNull null]||[gender_type isEqualToString:@"null"]||[gender_type isEqualToString:@"<null>"])
    {
        gender_type =@"";
    }
     */
      [gender_arr addObject:gender_type];
    
        
}
    for (int l=0; l<[image_get_arr count]; l++)
        
    {
        
        
        NSString *string_final=[[NSString alloc]initWithFormat:@"%@",[image_get_arr objectAtIndex:l]];
        NSString *value = [string_final substringWithRange:NSMakeRange(0, 4)];
        string_final=[string_final stringByReplacingOccurrencesOfString:@"<null>" withString:@""];
        NSLog(@"string final image:%@",string_final);
        
        
        NSLog(@"string final value:%@",string_final);
        
        if ([string_final isEqualToString:@"male_icon.png"]||[string_final isEqual:@"profile_pic.png"]||[string_final isEqualToString:@""]||[string_final isEqualToString:@"<null>"]||[string_final isEqualToString:@"(null)"])
            
        {
            
            if ([gender_type isEqualToString:@"1"])
            {
                
                
                final_image_str=[[NSString alloc]initWithFormat:@"http://192.168.0.111/Dating/images/NoPhotoMale.jpg"];
                
            }
            else if ([gender_type isEqualToString:@"0"])
            {
                
                
                final_image_str=[[NSString alloc]initWithFormat:@"http://192.168.0.111/Dating/images/NoPhotoFemale.jpg"];
                
            }
            
            [final_image_arr addObject:final_image_str];
            
        }else
            if ([value isEqualToString:@"http"]) {
                
                [final_image_arr addObject:string_final];
                NSLog(@"socialUrl:%@",value);
                
            }
        
        else
        {
            NSLog(@"upload icon");
            NSString *str_image_url_1 = [[NSString alloc]initWithFormat:@"http://192.168.0.111/Dating/Uploads/"];
            
            final_image_str =[[NSString alloc]initWithFormat:@"%@",[str_image_url_1 stringByAppendingString:string_final]];
            
            
            
            final_image_str=[final_image_str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSLog(@"new_image_string:%@",final_image_str);
        
            [final_image_arr addObject:final_image_str];
        }
    
    }
    
    
    
    
    //[chat_tbl reloadData];
    //[chat_tbl setNeedsDisplay];

if ([name_string isEqualToString:@"(null)"]||[name_string isEqualToString:@""]||name_string==nil||name_string==NULL)
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"You have no messages" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [alert release];
    
}
else
{
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    
}
 [chat_tbl reloadData];



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

-(IBAction)mainmenu
{
    
    Menupage *preview=[[Menupage alloc]initWithNibName:@"Menupage" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:preview animated:NO];
  //      
}
-(IBAction)Back
{

    [self.navigationController popViewControllerAnimated:YES];

}
-(IBAction)Add_freind
{
    
    LatitudeCalac *contactView = [[LatitudeCalac alloc]initWithNibName:@"LatitudeCalac" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:contactView animated:NO];
   
    
    //Freinds_view *freind_view=[[Freinds_view alloc]initWithNibName:@"Freinds_view" bundle:[NSBundle mainBundle]];
    //[self.navigationController pushViewController:freind_view animated:NO];


}
- (void)viewDidUnload
{
    [upgrade_btn release];
    upgrade_btn = nil;
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
    
    [upgrade_btn release];
    [user_msg_arr release];
    [chat_id release];
    [chat_tbl release];
    //[global_msg_btn release];
    
    
     [super dealloc];
}
@end
