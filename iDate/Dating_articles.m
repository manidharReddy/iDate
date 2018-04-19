//
//  Dating_articles.m
//  iDate
//
//  Created by D M R on 14/09/12.
//  Copyright (c) 2012 iHubTechnologies. All rights reserved.
//

#import "Dating_articles.h"
#import "Dating_cell.h"
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
#import "Details_detail.h"
#import "Chat_view.h"
@interface Dating_articles ()

@end

@implementation Dating_articles

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
    
    
    
    MBProgressHUD *hud1 = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
           hud1.labelText = @"Loading...";
    [self performSelector:@selector(dating_articles_call) withObject:nil afterDelay:2.0];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [global_msg_btn release];
    global_msg_btn = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
   
        return [partenerContent_Title_arr count];
       
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Dating_cell *cell;
  
   
        static NSString *cellIdentifier = @"cellIdentifier ";
        
        cell = (Dating_cell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Dating_cell"
                                                         owner:self options:nil];
            for (id oneObject in nib) if ([oneObject isKindOfClass:[Dating_cell class]])
                cell = (Dating_cell *)oneObject;
        }		
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.lbl2.text=[partenerContent_Title_arr objectAtIndex:[indexPath row]];
         cell.lbl1.text=[partenerdate_arr objectAtIndex:[indexPath row]];
   	
      
    
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
        global_partener_str=[[NSString alloc]initWithFormat:@"%@",[partenercontent_id_arr objectAtIndex:[indexPath row]]];
    
    global_artilce_content_str = [[NSString alloc]initWithFormat:@"%@",[partenerContent_Title_arr objectAtIndex:[indexPath row]]];
    
    Details_detail *preview=[[Details_detail alloc]initWithNibName:@"Details_detail" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:preview animated:NO];

    
        
 
    
}

-(void)dating_articles_call
{
    partenercontent_id_arr=[[NSMutableArray alloc]init];
    partenerContent_Title_arr=[[NSMutableArray alloc]init];
    partenerdate_arr=[[NSMutableArray alloc]init];
    
    
    NSString *str_country = [[NSString alloc]initWithFormat:@"http://192.168.0.111/DatingService/getDetails.svc/getPContents/1/100"];
    NSLog(@"str_country:%@",str_country);
    
    NSMutableURLRequest *request =[[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:str_country]];
    
    NSData *returnData = [ NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil ];
    
    NSString *returnString = [[NSString alloc]initWithData:returnData encoding:NSUTF8StringEncoding];
    
    NSLog(@"returnString:*%@*",returnString);
    
    
    NSDictionary *dict=[returnString JSONValue];
    NSLog(@"dict:%@",dict);
    
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
        [tblview reloadData];
    }
    
    
    
}
-(IBAction)mainmenu
{
    
    
    Menupage *preview=[[Menupage alloc]initWithNibName:@"Menupage" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:preview animated:NO];
    
    
}

- (IBAction)click_msg_chatWindow:(id)sender {
    
    Chat_view *chatView = [[Chat_view alloc]initWithNibName:@"Chat_view" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:chatView animated:YES];
    
    
    
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
