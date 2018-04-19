//
//  Profile_view.h
//  iDate
//
//  Created by D M R on 18/08/12.
//  Copyright (c) 2012 iHubTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LabeledActivityIndicatorView.h"
#import <CoreLocation/CoreLocation.h>
#import "Favorites_list.h"
#import "Search_list.h"

@interface Profile_view : UIViewController<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,UITextViewDelegate,UIImagePickerControllerDelegate,CLLocationManagerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>
{
    LabeledActivityIndicatorView *activity;
    IBOutlet UIScrollView *scrollview;
    IBOutlet UIView *profile_view;
    
    IBOutlet UITextField *username_txt;
    IBOutlet UITextField *age_txt;
    IBOutlet UITextField *gender_txt;
    IBOutlet UITextField *member_txt;
    IBOutlet UITextField *email_txt;
    IBOutlet UITextField *mob_txt;
    IBOutlet UIImageView *profile_img;
    IBOutlet UITextField *bday_txt;
    
    ///////////////////////////////////////////////
    
    IBOutlet UITextField *race_txt;
    IBOutlet UITextField *height_txt;
    IBOutlet UITextField *weight_txt;
    IBOutlet UITextField *waist_txt;
    IBOutlet UITextField *hips_txt;
    IBOutlet UITextField *bust_txt;
        
    ///////////////////////////////////////////////
    
    IBOutlet UITextField *haircolor_txt;
    IBOutlet UITextField *eyescolor_txt;
    IBOutlet UITextField *edulevel_txt;
    IBOutlet UITextField *drinker_txt;
    IBOutlet UITextField *smoker_txt;
    IBOutlet UITextField *Speaks_txt;
    IBOutlet UITextField *looking_txt;
    IBOutlet UITextField *interested_txt;
    IBOutlet UITextField *drives_txt;

    
    IBOutlet UITextField *tagline_txt;
    IBOutlet UITextView *short_desc;
    IBOutlet UITextView *long_desc;

    NSString *login_select;
    
    
    NSString *name_string;
    NSString *bday_string;
    NSString *member_string;
    NSString *age_string;
    NSString *gender_string;
    NSString *email_string;
    NSString *mob_string;
    
    NSString *race_string;
    NSString *height_string;
    NSString *weight_string;
    NSString *waist_string;
    NSString *hips_string;
    NSString *bust_string;
    
    NSString *haircolor_string;
    NSString *eyecolor_string;
    NSString *edulevel_string;
    NSString *drinker_string;
    NSString *smoker_string;
    NSString *int_string;
    NSString *looking_string;
    NSString *keywords_string;

    NSString *tagline_string;
    NSString *shortdesc_string;
    NSString *longdesc_string;
    NSString *lastLogin_string;
    NSString *userid_string;
    NSString *fetch_uid;
    NSString *str_country;
    IBOutlet UILabel *votes_lbl;
    NSMutableArray *user_arr;
    IBOutlet UIView *user_profile_view;
    IBOutlet UIView *other_profile_view;
    IBOutlet UILabel *desc_lbl;
    NSString *decs_lbl_str;
    
    IBOutlet UIButton *backToPrevious;
    ///////Image/////
    
    NSString *profile_user_img;
    NSMutableArray *profile_user_img_arr;
    
    NSString *screenshot_img;
    NSString *user_id_string;
    NSString *user_id_img;
    NSString *user_file_desc;
    NSString *ratings_string;
    NSString *votes_string;
     NSMutableArray *user_file_desc_arr;
    NSMutableArray *final_img_arr;
    NSString *selectedDJImage;
    IBOutlet UIScrollView *img_scroll;
    
    IBOutlet UILabel *status_lbl;
    IBOutlet UITableView *profile_tbl;
    NSMutableArray *arr_tbl;
    UIImageView *scroll_imageview;
    NSMutableArray *header_arr;
    NSMutableArray *header_arr1;
      ////////Gifts////////
    
    NSString *str_image_url;
    IBOutlet UIScrollView *gifts_scroll;
    NSString *gift_user_img;
    NSMutableArray *gift_user_img_arr;
    NSMutableArray *gift_touser_arr;
    NSMutableArray *gift_fromuser_arr;
    NSMutableArray *gift_desc_arr;
    
    NSMutableArray *final_gifts_arr;
    UIImageView *gift_imageview;
    
    NSString *gift_from_user;
    NSString *gift_image_url;
    NSString *gift_desc;
    NSString *gift_to_user;
    NSString *selected_gift;
    
    NSString *str_gift_url;
    NSMutableArray *Section_arr;
     NSMutableArray *Section_arr1;
     IBOutlet UIButton *view_profile_btn;
    IBOutlet UILabel *nogift_lbl;
    NSMutableArray *user_id_arr;
    IBOutlet UIButton *fav_btn;
    IBOutlet UIButton *remove_fav_btn;
    BOOL fav_list_boolvalue;
     BOOL remove_list_boolvalue;
    BOOL wink_bool_value;
    IBOutlet UIButton *wink_btn;
    
    IBOutlet UIView *more_view;
    IBOutlet UIView *rate_view;
    IBOutlet UIView *rating_tbl_view;
    
    IBOutlet UILabel *rating_lbl_show;
    IBOutlet UITextView *rating_desc_txt;
    IBOutlet UITableView *rating_tbl;
    
    IBOutlet UIButton *global_msg_icon;
    IBOutlet UIButton *global_msg_btn;
    NSString *rating_url;
    NSMutableArray *rating_arr_name;
     NSMutableArray *rating_arr_id;
    NSString *rating_id;
    NSString *rating_name;
    
    NSString *rating_id_select;
    NSString *rating_name_select;
    NSString *gender_type;
    NSString *rating_desc_str;

    
    BOOL rating_bool;
    BOOL allow_fav_bool;
    
    NSMutableArray *rating_arr;
    NSMutableArray *rating_user_arr;
    NSMutableArray *rating_desc_arr;
    NSMutableArray *voting_arr;
    
    NSString *rating_str;
    NSString *rating_user;
    NSString *rating_desc_show_str;
    NSString *votes_show_str;
    NSString *final_rate;
    NSString *rate_show;
    IBOutlet UILabel *rate_desc_lbl;
    IBOutlet UILabel *rate_user_lbl;
    IBOutlet UIScrollView *rate_scroll;
    NSInteger rate_count;
    NSString *rate_count_str;
    UIImageView *star_imageview;
    NSString *str_image_url12;
    NSString *desc_show;
    
    NSString *select_gift_from_id;
    
    
    IBOutlet UIView *edit_image_view;
    IBOutlet UIView *desc_view;
    IBOutlet UITextView *desc_txtview;
    ///
    
    IBOutlet UIImageView *show_big_imageview;
    NSString *selected_detail_image;
    IBOutlet UIScrollView *sel_scrollview;
    BOOL del_bool;
    BOOL edit_bool;
    BOOL default_bool;
    IBOutlet UIView *menu_view;
    
    NSMutableArray *user_file_id;
    NSString *user_file_id_str;
    NSString *file_id;
    NSString *edit_desc_str;
    IBOutlet UITextView *add_desc_txtview;
    IBOutlet UIView *add_desc_view;
    IBOutlet UIView *profile_image_view;
    IBOutlet UITextView *add_image_txtview;
    
    UIImage *globImg;
    IBOutlet UIImageView *profile_add_image;
    BOOL upload_bool;
    int get_user_id;
     NSData *imageData;
    NSData *imageData1;
    NSString *final_img_str;
    NSString *user_file_type;
    NSMutableArray *file_type_arr;
    
    
    ////////callvotes//////
    NSMutableArray *only_rate_arr;
    NSMutableArray *only_votes_arr;
    
    
    NSString *only_rate_str;
    NSString *only_votes_str;
    NSString *string_url;
    
    IBOutlet UIScrollView *votes_scrollview;
    IBOutlet UIImageView *votes_imageview;
    NSInteger only_rate_int;
    
    //////////rating tbl//////
    IBOutlet UITableView *rate_vote_tbl;
    NSMutableArray *final_arr;
    IBOutlet UILabel *gift_rate_lbl;
    IBOutlet UIScrollView *tbl_scroll;
    UIImageView *tbl_imageview;
    //int gift_number;

    
    NSString *login_view;
    
    /////Distance/////////////
    
    IBOutlet UILabel *distance_show_lbl;
    
    IBOutlet UILabel *distance_Km_show_lbl;
    //CLLocationManager *locationManager;
    NSString *latitude_string;
    NSString *longtude_String;
    NSString *latitude_current_string;
    NSString *longtude_current_String;
    NSString *display_lati_long_str;
    NSString *show_Distance;
    NSString *profile_user_imgFacebook;
    NSString *str_img_txtView;
    
    
    NSMutableArray *latitude_arr;
    NSMutableArray *longtude_arr;
    
    double  lat1;
    double  lat2;
    double long1;
    double long2;
    
    
    NSString *new_image_string;
    
    NSString *profilePic_string;
    NSMutableArray *profile_pic_arr;
    UIActivityIndicatorView *ac;
    
    IBOutlet UIButton *btnkeyboardDisapper;
    
}
@property (nonatomic, retain) CLLocationManager *locationManager;

/////////////Methods////////////

-(void)json_call;
-(void)readlogin;
//-(void)fetch_gifts;
//-(void)fetch_favorites;
-(void)fetch_ratings;
-(void)call_gifts;
//-(void)call_ratings;
-(void)call_images;
-(void)display_image;
-(void)display_gift;
-(void)loadtbl;
-(void)favorite_call;
-(void)add_fav;
-(void)remove_fav;

-(void)wink_date;

////More view///////
-(void)show_more_popup;
-(void)hide_more_popup;
-(void)show_rate_popup;
-(void)hide_rate_popup;
-(void)show_ratelist_popup;
-(void)hide_ratelist_popup;
-(void)rating_json;
-(void)loadtbl_rating;
-(void)sumbit_json;
-(void)load_rating;
-(void)load_votes;
-(void)show_desc_view;
-(void)hide_desc_view;
-(void)show_edit_image_view;
-(void)hide_edit_image_view;
-(void)detail_image;
-(void)delete_pic;
-(void)edit_description;
-(void)default_image;
//-(void)show_add_profile_image;
//-(void)hide_add_profile_image;
-(void)show_upload_image;
-(void)hide_upload_image;
-(void)success_upload;
-(void)success_upload_1;
-(void)call_votes;
-(void)fav_result;



//////////IBAction//////////////////

- (IBAction)btnKeyboardDisappear:(id)sender;

-(IBAction)gift_select:(UIButton*)sender;
-(IBAction)image_selct:(UIButton*)sender;
-(IBAction)small_image:(UIButton*)sender;
//-(IBAction)rating_close;
-(IBAction)Add_image;




-(IBAction)back;

- (IBAction)global_msg_click:(id)sender;

//-(IBAction)ViewFullprofile;
-(IBAction)main_back;

-(IBAction)Remove_from_fav;

-(IBAction)Moreclick;
-(IBAction)Rate_user;
-(IBAction)request;
-(IBAction)cancel;

-(IBAction)Give_gifts;
-(IBAction)Wink_user;

-(IBAction)list_close;

-(IBAction)rate_close;
-(IBAction)submit_rating;

-(IBAction)rating_list_call;

-(IBAction)Use_profile_pic;
-(IBAction)Del_pic;
-(IBAction)edit_desc;
-(IBAction)desc_ok;
-(IBAction)close_desc;

-(IBAction)close_addimage;
-(IBAction)Add_profile_image;


-(IBAction)select_image;
-(IBAction)take_image;

-(IBAction)upload_image;
-(IBAction)close_profile;
-(IBAction)Edit_info;
-(IBAction)Chat_list;
-(IBAction)view_btn:(id)sender;

@end
