//
//  NewsArticles.m
//  iDate
//
//  Created by Aparna Reddy Challa on 07/01/13.
//  Copyright (c) 2013 Google Inc. All rights reserved.
//

#import "NewsArticles.h"
#import "Signup.h"
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
#import "Chat_view.h"
#import "News_Cell.h"
#import "News_Details.h"

@interface NewsArticles ()

@end

@implementation NewsArticles

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
    
    
    [self performSelector:@selector(dating_articles_call) withObject:nil afterDelay:1.0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [newsTableView release];
    [global_msg_btn release];
    [super dealloc];
}
- (void)viewDidUnload {
    [newsTableView release];
    newsTableView = nil;
    [global_msg_btn release];
    global_msg_btn = nil;
    [super viewDidUnload];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    return [partenerContent_Title_arr count];
    
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    News_Cell *cell;
    
    
    static NSString *cellIdentifier = @"cellIdentifier ";
    
    cell = (News_Cell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"News_Cell"
                                                     owner:self options:nil];
        for (id oneObject in nib) if ([oneObject isKindOfClass:[News_Cell class]])
            cell = (News_Cell *)oneObject;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.news_lbl.text=[partenerContent_Title_arr objectAtIndex:[indexPath row]];
    cell.newsDate_lbl.text=[partenerdate_arr objectAtIndex:[indexPath row]];
   	
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 42;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    //
    //
    //
    global_partenerNews_str=[[NSString alloc]initWithFormat:@"%@",[partenercontent_id_arr objectAtIndex:[indexPath row]]];
    
    global_artilce_content_str = [[NSString alloc]initWithFormat:@"%@",[partenerContent_Title_arr objectAtIndex:[indexPath row]]];
    
     News_Details *newD = [[News_Details alloc]initWithNibName:@"News_Details" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:newD animated:NO];
    
    
    
    
    
}

-(void)dating_articles_call
{
    partenercontent_id_arr=[[NSMutableArray alloc]init];
    partenerContent_Title_arr=[[NSMutableArray alloc]init];
    partenerdate_arr=[[NSMutableArray alloc]init];
    
    
    NSString *str_country = [[NSString alloc]initWithFormat:@"http://192.168.0.111/datingservice/validationService.svc/aboutnews/2"];
    NSLog(@"str_country:%@",str_country);
    
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
        NSString *pid=[[NSString alloc]initWithFormat:@"%@",[info objectForKey:@"partenerContentID"]];
        [partenercontent_id_arr addObject:pid];
        
        
        NSString *ptitle=[[NSString alloc]initWithFormat:@"%@",[info objectForKey:@"partenerContentTitle"]];
        [partenerContent_Title_arr addObject:ptitle];
        
        NSString *pdate=[[NSString alloc]initWithFormat:@"%@",[info objectForKey:@"partnerContentCreationDate"]];
        [partenerdate_arr addObject:pdate];
        
        
    }
    
    
    if ([partenerContent_Title_arr count]==0)
    { [MBProgressHUD hideHUDForView:self.view animated:YES];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Not available" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
    }
    
    else
    {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [newsTableView reloadData];
    }
    
    }
    
}

- (IBAction)show_menu:(id)sender {
    
    Menupage *preview=[[Menupage alloc]initWithNibName:@"Menupage" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:preview animated:NO];
    
}

- (IBAction)click_msg_chatWindow:(id)sender {
    
    Chat_view *chatView = [[Chat_view alloc]initWithNibName:@"Chat_view" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:chatView animated:YES];

    
}
@end
