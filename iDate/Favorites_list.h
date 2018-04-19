//
//  Favorites_list.h
//  iDate
//
//  Created by D M R on 03/09/12.
//  Copyright (c) 2012 iHubTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Favorites_list : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
{
    /////////search/////////////
    IBOutlet UISearchBar *searchBar;
	BOOL searching;
	BOOL letUserSelectRow;
    
    IBOutlet UIButton *global_msg_btn;
    NSArray *arr;
    
    NSMutableArray *listOfItems;
    NSMutableArray *copyListOfItems;
    IBOutlet UITableView *fav_tbl;
    
    NSMutableArray *user_id_arr;
    NSMutableArray *user_name_arr;
    NSMutableArray *gender_arr;
    NSMutableArray *age_arr;
    NSMutableArray *user_id;
    NSString  *name_string;
    NSString *login_select;
    NSString *fav_image_string;
    NSString *new_image_string;
    NSString *urlString1;
    NSMutableArray *fav_image_src_arr;
    NSMutableArray *final_img_arr;
    
    
    
    
    
}
- (IBAction)click_msg_chatWindow:(id)sender;
-(void)favoritedisplay;
-(void)readlogin;
-(IBAction)mainmenu;
@end
