//
//  News_Details.m
//  iDate
//
//  Created by Aparna Reddy Challa on 07/01/13.
//  Copyright (c) 2013 Google Inc. All rights reserved.
//

#import "News_Details.h"
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
#import "NewsArticles.h"
#import "Chat_view.h"
@interface News_Details ()

@end

@implementation News_Details
@synthesize label_title_display;
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
        
        global_msg_btn.hidden=NO;
        
    }else
    {
        global_msg_btn.hidden=YES;
    }
    
    
    MBProgressHUD *hud1 = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
         hud1.labelText = @"Loading...";
    
    [self performSelector:@selector(dating_articles_detail) withObject:nil afterDelay:1.0];
    
    
}
-(void)dating_articles_detail
{
    
    NSString *str_country = [[NSString alloc]initWithFormat:@"http://192.168.0.111/datingservice/validationService.svc/newsDetails/%@",global_partenerNews_str];
    
    NSLog(@"str_country new articles:%@",str_country);
    
    NSMutableURLRequest *request =[[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:str_country]];
    
    NSData *returnData = [ NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil ];
    
    NSString *returnString = [[NSString alloc]initWithData:returnData encoding:NSUTF8StringEncoding];
    
    NSLog(@"returnString:*%@*",returnString);
    
    
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
        NSString *dating_detail=[[NSString alloc]initWithFormat:@"%@",[info objectForKey:@"partnerContent"]];
        txtview.text= dating_detail;
        
        
        
       // NSString *con_username=[[NSString alloc]initWithFormat:@"%@",[info objectForKey:@"userName"]];
        
        
        NSString *con_date=[[NSString alloc]initWithFormat:@"%@",[info objectForKey:@"partnerContentCreationDate"]];
        final_display=[[NSString alloc]initWithFormat:@"Content Created on %@",con_date];
        
        contribute_lbl.text=final_display;
        
        
        
        
        
        
        
        
        if ([dating_detail isEqualToString:@"(null)"]||[dating_detail isEqualToString:@""]||dating_detail==nil||dating_detail==NULL)
        {
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Data Not Available" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
            
        }
        
        
    }
    label_title_display.text = [[NSString alloc]initWithFormat:@"%@",global_artilce_content_str];
    
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    }
}
-(IBAction)mainmenu
{
    
    Menupage *preview=[[Menupage alloc]initWithNibName:@"Menupage" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:preview animated:NO];
    
    
    
}
-(IBAction)back
{
    
    NewsArticles *newsA=[[NewsArticles alloc]initWithNibName:@"NewsArticles" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:newsA animated:NO];
    
    
    
    
    
}

- (IBAction)click_msg_chatWindow:(id)sender {
    
    Chat_view *chatView = [[Chat_view alloc]initWithNibName:@"Chat_view" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:chatView animated:YES];

    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [global_msg_btn release];
    //[_label_title_display release];
    [super dealloc];
}
- (void)viewDidUnload {
    [global_msg_btn release];
    global_msg_btn = nil;
    [self setLabel_title_display:nil];
    [super viewDidUnload];
}
@end
