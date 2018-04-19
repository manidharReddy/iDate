//
//  Chat_list.h
//  iDate
//
//  Created by D M R on 24/09/12.
//  Copyright (c) 2012 iHubTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIBubbleTableViewDataSource.h"

@class UIBubbleTableView;
@interface Chat_list : UIViewController<UIBubbleTableViewDataSource,UITextViewDelegate,UIScrollViewDelegate>
{
    IBOutlet UIBubbleTableView *bubbleTable;
    
    NSMutableArray *bubbleData;
    IBOutlet UITextView *chat_txt_view;
   IBOutlet UIScrollView *scroll;
    NSMutableArray *id_arr;
    NSMutableArray *from_user_id;
    NSMutableArray *type_arr;
   
    IBOutlet UIView *bubble_msg_view;
    
    IBOutlet UIButton *btnKeyBoardDissmis;
    IBOutlet UIButton *global_msg_btn;
    NSString *name_string;
    NSString *from_string;
    NSString *message_str;
    NSString *type_string;
    NSString *login_select;
    NSString *final_display;
    NSString *responseString;
    IBOutlet UIButton *del_btn;
    IBOutlet UIButton *backToProfile;
}
-(IBAction)send_msg;
-(void)call_json;
-(void)call_json1;
-(void)sorting_arr;
-(IBAction)menupage;
-(void)readlogin;
-(void)delete_chat;
-(void)delete_final;
-(void)load_chat;
-(void)call_other;
-(void)delete_chat;
- (IBAction)btnClickKeyBoardDissmis:(id)sender;

-(IBAction)Back;

@end
