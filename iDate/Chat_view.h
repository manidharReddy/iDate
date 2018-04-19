//
//  Chat_view.h
//  iDate
//
//  Created by D M R on 30/08/12.
//  Copyright (c) 2012 iHubTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Chat_view : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
//    /////////search/////////////
//    IBOutlet UISearchBar *searchBar;
//	BOOL searching;
//	BOOL letUserSelectRow;
    
    NSArray *arr;
    
    IBOutlet UIButton *global_msg_btn;
    NSMutableArray *listOfItems;
    NSMutableArray *copyListOfItems;
    IBOutlet UITableView *chat_tbl;
    
    IBOutlet UIButton *upgrade_btn;
    
    NSMutableArray *user_name_arr;
    NSMutableArray *user_msg_arr;
    NSMutableArray *msg_count;
    NSMutableArray *display_upgrade;
    NSMutableArray *user_id;
    NSString  *name_string;
    NSString *login_select;
    UIButton *checkBox;
    NSString *image_get_string;
    NSString *final_image_str;
    NSString *gender_type;
    NSString *urlImage;
    
    
    NSMutableArray *image_get_arr;
    NSMutableArray *final_image_arr;
    NSMutableArray *gender_arr;

}
-(void)refreshChatView;
-(void)chatdisplay;
-(void)readlogin;
-(IBAction)Add_freind;
-(IBAction)connectclick:(UIButton*)sender;
- (IBAction)click_msg_chatWindow:(id)sender;


@end
