//
//  User_list.h
//  iDate
//
//  Created by D M R on 23/08/12.
//  Copyright (c) 2012 iHubTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@interface User_list : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
{
    NSMutableArray *name_arr;
    NSMutableArray *image_arr;
    NSMutableArray *age_arr;
    NSMutableArray *id_arr;
    NSMutableArray *gender_arr;
    NSMutableArray *race_arr;
    NSMutableArray *gender_image_arr;
    
    NSString *name_string;
    NSString *image_string;
    NSString *age_string;
    NSString *id_string;
    NSString *gender_string;
    NSString *race_string;
    NSString *str_profile_image;

    IBOutlet UITableView *profile_tbl;
    IBOutlet UISearchBar *searchBar;
	BOOL searching;
	BOOL letUserSelectRow;
    
    NSArray *arr;
    
    NSMutableArray *listOfItems;
    NSMutableArray *copyListOfItems;
   
    
    NSMutableArray *listOfItems1;
    NSMutableArray *copyListOfItems1;

}
-(IBAction)mainmenu;
-(void)profile_json_call;
- (void) searchTableView;
- (IBAction)doneSearching_Clicked:(id)sender;
@end
