//
//  Search_list.h
//  iDate
//
//  Created by D M R on 13/09/12.
//  Copyright (c) 2012 iHubTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Search_view.h"
#import "MNMBottomPullToRefreshManager.h"

@interface Search_list : UIViewController<CLLocationManagerDelegate,UIScrollViewDelegate,UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,MNMBottomPullToRefreshManagerClient>
//<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,CLLocationManagerDelegate,MNMBottomPullToRefreshManagerClient,UIScrollViewDelegate>
{
    IBOutlet UIView *heart_image_view;
    NSMutableArray *name_arr;
    NSMutableArray *image_arr;
    NSMutableArray *age_arr;
    NSMutableArray *id_arr;
    NSMutableArray *gender_arr;
    NSMutableArray *race_arr;
    NSMutableArray *height_arr;
    NSMutableArray *weight_arr;
    NSMutableArray *bust_arr;
    NSMutableArray *hips_arr;
    NSMutableArray *waist_arr;
    NSMutableArray *cup_arr;
    NSMutableArray *edu_level_arr;
    NSMutableArray *drinker_arr;
    NSMutableArray *smoker_arr;
    NSMutableArray *last_login_arr;
    NSMutableArray *tagline_arr;
    NSMutableArray *gender_image_arr;
     NSMutableArray *vital_arr;
    NSMutableArray *final_img_arr;
    NSMutableArray *latitude_arr;
    NSMutableArray *longtude_arr;
    NSMutableArray *display_latlong_arr;
    
    NSMutableArray *gender_image_src_arr;
    
    NSString *searchUseId;
    NSString *str_profile_image;
    NSString *name_string;
    NSString *image_string;
    NSString *age_string;
    NSString *id_string;
    NSString *gender_string;
    NSString *race_string;
    NSString *height_string;
    NSString *weight_string;
    NSString *waist_string;
    NSString *hips_string;
    NSString *bust_string;
    NSString *cup_string;
    NSString *edulevel_string;
    NSString *drinker_string;
    NSString *smoker_string;
    NSString *tagline_string;
    NSString *lastLogin_string;
    NSString *vital_string;
    NSString *new_age_string;
    NSString *new_image_string;
    NSString *urlString1;
    NSString *latitude_string;
    NSString *longtude_String;
    NSString *latitude_current_string;
    NSString *longtude_current_String;
    NSString *display_lati_long_str;
    NSString *login_select;
    int nameCount;
    int naddCount,nPercent,k;
    MNMBottomPullToRefreshManager *pullToRefreshManager_;
    
    double  lat1;
    double  lat2;
    double long1;
    double long2;
    
    
    int var1;
    
    
    int var2;
    int count;
	int offset1;
    
    int x,y,num,nums;
    UIActivityIndicatorView *spinny;
    
    IBOutlet UIImageView *default_heart_image;
    
    CLLocationManager *locationManager;
    
    IBOutlet UITableView *profile_tbl;
    IBOutlet UISearchBar *searchBar;
	BOOL searching;
	BOOL letUserSelectRow;
    
    NSArray *arr;
    
    NSMutableArray *listOfItems;
    NSMutableArray *copyListOfItems;
    
    
    NSMutableArray *listOfItems1;
    NSMutableArray *copyListOfItems1;
    
    NSDictionary *responseDict;
    
    
    NSUInteger numberOfItemsToDisplay;
    int h,i,j;
    int reloads_ ;
    
    NSString *show_Distance;
    NSMutableArray *show_Distance_arr;
    
    NSMutableArray *id_list_items;
    NSMutableArray *gender_list_items;
    NSMutableArray *race_list_items;
    NSMutableArray *image_list_items;
    NSMutableArray *name_list_items;
    NSMutableArray *age_list_items;
    NSMutableArray *distance_list_items;
    
    IBOutlet UIButton *global_msg_btn;
    
    IBOutlet UIImageView *black_imageView;
    
    IBOutlet UIView *Search_profile_view;
    IBOutlet UIScrollView *thumb_scroll;
    
    IBOutlet UIButton *show_gridTotable_btn;
    
    IBOutlet UITableView *profile_list_tableView;
    IBOutlet UIButton *search_done;
    //BOOL letUserSelectRow;
    //BOOL searching;
}
@property (nonatomic, retain) CLLocationManager *locationManager;
-(IBAction)mainmenu;
-(void)profile_json_call;
//- (void) searchTableView;
//-(void)loadtbl;
- (IBAction)doneSearching_Clicked:(id)sender;

- (IBAction)show_GridorTable_Click:(id)sender;
- (IBAction)click_msg_Chatwindow:(id)sender;

@end