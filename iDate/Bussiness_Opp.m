//
//  Bussiness_Opp.m
//  iDate
//
//  Created by Aparna Reddy Challa on 07/01/13.
//  Copyright (c) 2013 Google Inc. All rights reserved.
//

#import "Bussiness_Opp.h"
#import "Chat_view.h"

@interface Bussiness_Opp ()

@end

@implementation Bussiness_Opp

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
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [bussenessOpp_textview release];
    [global_msg_btn release];
    [super dealloc];
}
- (void)viewDidUnload {
    [bussenessOpp_textview release];
    bussenessOpp_textview = nil;
    [global_msg_btn release];
    global_msg_btn = nil;
    [super viewDidUnload];
}
- (IBAction)Show_Menu_click:(id)sender {
    
    
     Menupage *menu=[[Menupage alloc]initWithNibName:@"Menupage" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:menu animated:NO];

    
    
}

- (IBAction)click_msg_chatWindow:(id)sender {
    
    Chat_view *chatView = [[Chat_view alloc]initWithNibName:@"Chat_view" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:chatView animated:YES];

    
}
@end
