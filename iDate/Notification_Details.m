//
//  Notification_Details.m
//  iDate
//
//  Created by Aparna Reddy Challa on 18/12/12.
//  Copyright (c) 2012 Google Inc. All rights reserved.
//

#import "Notification_Details.h"
#import "Menupage.h"
#import "Chat_view.h"

@interface Notification_Details ()

@end

@implementation Notification_Details

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
    
    
    
    //global_Message_arr = [[NSMutableArray alloc]init];
    //global_messageCreation_arr = [[NSMutableArray alloc]init];
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [notification_table release];
    [global_msg_btn release];
    [super dealloc];
}
- (void)viewDidUnload {
    [notification_table release];
    notification_table = nil;
    [global_msg_btn release];
    global_msg_btn = nil;
    [super viewDidUnload];
}
- (IBAction)MainMenu:(id)sender {
    
    Menupage *preview=[[Menupage alloc]initWithNibName:@"Menupage" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:preview animated:NO];
    
}

- (IBAction)click_msg_chatWindow:(id)sender {
    Chat_view *chatView = [[Chat_view alloc]initWithNibName:@"Chat_view" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:chatView animated:YES];

    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    return 2;
    
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Notification_Cell *cell;
    
    
    static NSString *cellIdentifier = @"cellIdentifier ";
    
    cell = (Notification_Cell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Notification_Cell"
                                                     owner:self options:nil];
        for (id oneObject in nib) if ([oneObject isKindOfClass:[Notification_Cell class]])
            cell = (Notification_Cell *)oneObject;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //cell.notification_Date.text = [[NSString alloc]initWithFormate:@"%@",[global_messageCreation_arr objectAtIndex:[indexPath row]];
    //cell.notification_msg.text=@"Notification MSG";
   	cell.notification_Date.text = [global_messageCreation_arr objectAtIndex:[indexPath row]];
    cell.notification_msg.text=[global_Message_arr objectAtIndex:[indexPath row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 42;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    
    
    
    
}


@end
