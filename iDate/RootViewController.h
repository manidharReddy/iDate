//
//  RootViewController.h
//  iDate
//
//  Created by D M R on 07/08/12.
//  Copyright (c) 2012 iHubTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDPageControl.h"
#import "LabeledActivityIndicatorView.h"
#import "MBProgressHUD.h"
#import <AudioToolbox/AudioServices.h>
#import <CoreLocation/CoreLocation.h>
//#import <AudioToolbox/AudioServices.h>
#import <AVFoundation/AVFoundation.h>
//#import "MNMBottomPullToRefreshManager.h"


@interface RootViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UISearchBarDelegate,CLLocationManagerDelegate,UIAlertViewDelegate,AVAudioPlayerDelegate>//,MNMBottomPullToRefreshManagerClient>
{
    IBOutlet UIView *how_it_works_view;
    IBOutlet UIView *dating_articles_view;
    IBOutlet UIView *dating_articles_view_list;
    IBOutlet UIImageView *lbl_image;
    
    IBOutlet UIView *profile_view_list;
    
    IBOutlet UITableView *tblview;
    IBOutlet UITableView *profile_tbl;
    DDPageControl *pageControl;
    IBOutlet UIScrollView *scroll;
    IBOutlet UITextView *txtview;
    BOOL pageControlUsed;
    NSMutableArray *name_arr;
    //NSMutableArray *image_arr;
    NSMutableArray *age_arr;
    NSMutableArray *id_arr;
    NSMutableArray *gender_arr;
    NSMutableArray *race_arr;
    NSMutableArray *gender_image_arr;
    NSMutableArray *final_img_arr;
    
    NSString *name_string;
    NSString *image_string;
    NSString *age_string;
    NSString *id_string;
    NSString *gender_string;
    NSString *race_string;
    NSString *str_profile_image;
    NSString *new_image_string;
    NSString *partnerWebsiteName_str;
  LabeledActivityIndicatorView *activity;
    NSData *imageData;
    NSString *urlString;
    NSString *urlString1;
    IBOutlet UIImageView *logoimageview;

        ///////Search////////////
    IBOutlet UISearchBar *searchBar;
	BOOL searching;
	BOOL letUserSelectRow;
    
    NSArray *arr;
    NSArray *arr1;
    
    NSMutableArray *listOfItems;
    NSMutableArray *copyListOfItems;
   
    
     NSMutableArray *id_list_items;
    NSMutableArray *gender_list_items;
    NSMutableArray *race_list_items;
    NSMutableArray *image_list_items;
    NSMutableArray *name_list_items;
    NSMutableArray *age_list_items;
  
    
    int pageNumber;
    NSInteger pageview;
    
    /////Dating articles//////
    NSMutableArray *partenercontent_id_arr;
    NSMutableArray *partenerContent_Title_arr;
    IBOutlet UITextView *dating_txtview;
    IBOutlet UIButton *Signup_btn;
    IBOutlet UIButton *Login_btn;
    IBOutlet UIButton *Signup_btn1;
    NSString *login_select;
    NSString *partener_str;
    IBOutlet UIImageView *default_imageview;
    IBOutlet UIImageView *header_image;
    IBOutlet UIButton *search_done;
    
    IBOutlet UIButton *user_menu;
    IBOutlet UIButton *works_menu;
    IBOutlet UIScrollView *thumb_scroll;
    
    UIImageView *thumb_image;
    IBOutlet UIButton *grid_btn1;
    IBOutlet UIButton *grid_btn2;
    IBOutlet UIButton *list_btn1;
    IBOutlet UIButton *list_btn2;
    IBOutlet UIView *logo_view;
    //////////////
    IBOutlet UIView *home_page_view;
    IBOutlet UITableView *home_tableview;
    NSMutableArray *partnercontent_arr;
    NSString *partner_str123;
    //IBOutlet uitable
    NSString *responseString_login;
    IBOutlet UITextView *partner_txtview;
    NSString *partner_string;
    NSURLConnection *connection;
    NSMutableData *receivedData;
    
    
    
    //Notifications
    IBOutlet UIImageView *notificationRoundImage;
    IBOutlet UILabel *notificationsTotalLbl;
    IBOutlet UIButton *notificationButton;

    AVAudioPlayer *soundPlayer;

    
    
    
    CLLocationManager *locationManager;
    NSMutableString *latitude ;
    NSMutableString *longitude;
    NSString *latitude_string;
    NSString *longitude_string;
    
    IBOutlet UILabel *lbl_partnerwebnamelist;
    //int nameCount;
    //int var1;
    //int reloads_ ;
    
    //int var2;
    //int count;
	//int offset1;
    
    //int x,y,num,nums;

    //int naddCount,nPercent,k;
   // MNMBottomPullToRefreshManager *pullToRefreshManager_;
    
    //UIActivityIndicatorView *spinny;
}
@property (retain, nonatomic) IBOutlet UILabel *lbl_partnerWebsiteName;
@property (nonatomic, retain) CLLocationManager *locationManager;
- (IBAction)notificationButtonClick:(id)sender;
-(IBAction)dating_list_back;
-(IBAction)Signip;
-(IBAction)mainmenu;
-(void)jsoncall;
-(IBAction)login;
-(void)profile_json_call;
//-(void)dating_articles_call;
//-(void)dating_articles_detail;
-(IBAction)upload;
- (void) searchTableView;
- (IBAction)doneSearching_Clicked:(id)sender;
-(void)readlogin;
-(IBAction)sign_check;
//-(void)tbl_load;
-(void)display_profile;
-(void)show_table;
-(void)show_grid;
-(IBAction)buttonTap:(id)sender;
-(IBAction)buttonTap1:(id)sender;
-(IBAction)Logout:(id)sender;
-(void)copy_viewdidload;
-(void)show_view;
-(void)call_logo_detail;
-(void)call_logo_json;
-(void)home_load;
-(void)logo_load;
-(void)display_json_call;
-(void)after_login_json;
-(void)after_parse;
-(void)logoutMenu:(id)sender;
-(void)showMenu;
-(BOOL)CheckNetwork;
- (BOOL) checkConnection:(const char*) host_name;

@end
