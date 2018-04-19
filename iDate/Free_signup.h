//
//  Free_signup.h
//  iDate
//
//  Created by D M R on 08/08/12.
//  Copyright (c) 2012 iHubTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDPageControl.h"
#import "Vital_stats_view.h"


@interface Free_signup : UIViewController<UIScrollViewDelegate,UITextViewDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate>
{
    DDPageControl *pageControl;
    IBOutlet UIScrollView *scroll;
    IBOutlet UITextView *txtview;
    BOOL pageControlUsed;
    
    IBOutlet UIView *View_1;
    IBOutlet UIView *View_2;
    IBOutlet UIView *View_3;
    IBOutlet UIView *View_4;
    IBOutlet UIView *View_5;
    IBOutlet UIView *View_6;
    IBOutlet UIView *View_7;
    IBOutlet UIView *View_8;
    IBOutlet UIView *upload_view;
    
    ///////////////upload_view/////////////////
    IBOutlet UITextField *userfile_desc;
//    IBOutlet UITextField *email_txt;
//    IBOutlet UITextField *realname_txt;
//    IBOutlet UITextField *mob_txt;

    
   
///////////////View_1/////////////////
    
    IBOutlet UIButton *male_btn;
    IBOutlet UIButton *female_btn;
    IBOutlet UITextField *name_txt;
    IBOutlet UITextField *passwd_txt;
    IBOutlet UITextField *email_txt;
    IBOutlet UITextField *realname_txt;
    IBOutlet UITextField *mob_txt;
    
    
    ///////////////View_2/////////////////
    
    IBOutlet UIButton *dob_btn;
    IBOutlet UIButton *country_btn;
    IBOutlet UIButton *state_btn;
    IBOutlet UIButton *city_btn;
    IBOutlet UIButton *lang_btn;
    IBOutlet UITextField *height_txt;
    
    ///////////////View_3/////////////////
    
    IBOutlet UITextField *weight_txt;
    IBOutlet UITextField *waist_txt;
    IBOutlet UITextField *hips_txt;
    IBOutlet UITextField *bust_txt;
    IBOutlet UITextField *cupsize_txt;
    IBOutlet UITextField *vital_txt;
    IBOutlet UIButton *race_btn;
    
    ///////////////View_4/////////////////
    
     IBOutlet UIButton *haircolor_btn;
    IBOutlet UIButton *eyescolor_btn;
    IBOutlet UIButton *edulevel_btn;
    IBOutlet UIButton *drinker_btn;
    IBOutlet UIButton *car_btn;
    IBOutlet UIButton *bike_btn;
    IBOutlet UIButton *guys_btn;
    IBOutlet UIButton *ladies_btn;
    
    ///////////////View_5/////////////////
    
    IBOutlet UIButton *interest_btn;
    IBOutlet UITextField *tagline_txt;
    IBOutlet UITextView *short_desc;
    IBOutlet UITextView *long_desc;
    
    ///////////////View_6/////////////////

    
    IBOutlet UITextView *keyword_txt;
    IBOutlet UITextField *bookingfee_txt;
    IBOutlet UITextField *bookinghr_txt;
      IBOutlet UIButton *smoker_btn;
    ///////////////View_7/////////////////
    
    IBOutlet UITextView *userdesc_txt;
    IBOutlet UITextView *useradd_txt;
    
    
    ////////////////////////////////view/////////
    
    IBOutlet UIView *lang_tblcontain_view;
    IBOutlet UIView *dobview;
    IBOutlet UIView *country_view;
    IBOutlet UIView *state_view;
    IBOutlet UIView *city_view;
    IBOutlet UIView *lang_view;
    IBOutlet UIView *haircolor_view;
    IBOutlet UIView *eyescolor_view;
    IBOutlet UIView *education_view;
    IBOutlet UIView *interest_view;
    IBOutlet UIView *drinker_view;
    IBOutlet UIView *smoker_view;
    IBOutlet UIView *race_view;
   

     ////////////////////////////////pickerarr/////////
    
     IBOutlet UIDatePicker *dob_picker;
     IBOutlet UIPickerView *country_picker;
     IBOutlet UIPickerView *state_picker;
     IBOutlet UIPickerView *city_picker;
     IBOutlet UIPickerView *lang_picker;
     IBOutlet UIPickerView *haircolor_picker;
     IBOutlet UIPickerView *eyescolor_picker;
     IBOutlet UIPickerView *education_picker;
     IBOutlet UIPickerView *interest_picker;
     IBOutlet UIPickerView *drinker_picker;
     IBOutlet UIPickerView *smoker_picker;
      IBOutlet UIPickerView *race_picker;
    
    IBOutlet UITableView *lang_tabel_view;
    NSMutableArray *country_arr;
    NSMutableArray *city_arr;
    NSMutableArray *state_arr;
    NSMutableArray *lang_arr;
    NSMutableArray *haircolor_arr;
    NSMutableArray *eyecolor_arr;
    NSMutableArray *education_arr;
    NSMutableArray *interest_arr;
    NSMutableArray *drinker_arr;
    NSMutableArray *smoker_arr;
    NSMutableArray *race_arr;
    
    ////////////////////////////////////////////
    
    
    
    NSMutableArray *country_arr_number;
    NSMutableArray *city_arr_number;
    NSMutableArray *state_arr_number;
    NSMutableArray *lang_arr_number;
    NSMutableArray *haircolor_arr_number;
    NSMutableArray *eyecolor_arr_number;
    NSMutableArray *education_arr_number;
    NSMutableArray *interest_arr_number;
    NSMutableArray *drinker_arr_number;
    NSMutableArray *smoker_arr_number;
    NSMutableArray *race_arr_number;
    NSMutableArray *lang_edit_arr;
    NSMutableArray *lang_name_edit_arr;
    
    ////////////////////////dob////////////////////

    

    NSString *day_string;
    NSString *month_string;
    NSString *year_string;
    
    ////////////////////////country////////////////////
    
    NSArray *lang_store_ids;
    
    NSString *country_id_str;
    NSString *country_name_str;
    
    NSString *country_selectedid;
    NSString *country_string;
    
    NSString *state_string;
    
    NSString *state_id_str;
    NSString *state_name_str;
    NSString *state_selectedid;

    
    NSString *city_string;
    NSString *city_id_str;
    NSString *city_name_str;
    NSString *city_selectedid;

    ////////////////////////language////////////////////
 
    NSString *lang_string;
    NSString *lang_id_str;
    NSString *lang_name_str;
    NSString *lang_selectedid;
    NSString *check_lang_ids;
    NSString *haircolor_string;
    NSString *haircolor_id_str;
    NSString *haircolor_name_str;
    NSString *haircolor_selectedid;
        
    NSString *eyecolor_string;
    NSString *eyecolor_id_str;
    NSString *eyecolor_name_str;
    NSString *eyecolor_selectedid;
    
    NSString *edu_string;
    NSString *edu_id_str;
    NSString *edu_name_str;
    NSString *edu_selectedid;
        
    NSString *race_string;
    NSString *race_id_str;
    NSString *race_name_str;
    NSString *race_selectedid;
    
    NSString *drinker_string;
    NSString *drinker__id_str;
    NSString *drinker__name_str;
    NSString *drinker__selectedid;
    
    NSString *smoker_string;
    NSString *smoker_id_str;
    NSString *smoker_name_str;
    NSString *smoker_selectedid;
    
    
    
    NSString *height_string;
    NSString *booking_string;
    NSString *booking_hr;
    NSString *bust_string;
    NSString *hips_string;
    NSString *cup_string;
    NSString *weight_string;
    NSString *waist_string;
    
    NSString *vitalstat;
    NSString *keyword_string;
    NSString *user_add_string;
    NSString *user_desc_string;
    NSString *long_desc_string;
    NSString *short_desc_string;
    NSString *tagline_string;
    NSString *mobile_string;
    
    
    NSString *interest_string;
    NSString *interest_male;
    NSString *interest_female;
    NSString *interest_Business;
    NSString *interest_chatting;
    NSString *interest_dating;
    NSString *interest_flirting;
    NSString *interest_friendship;
    NSString *interest_relationship;
    NSString *interest_other_activity;
    
    NSString *editparanthese;
    NSString *deselectLangids;
    NSString *car_string;
    NSString *bike_string;
    NSString *ladies_string;
    NSString *guys_string;
    NSDate *date1; 
    NSString *str;
    NSString *dateselect1;
    NSString *genderString;
    int pageNumber;
    NSInteger pageview;
    int select;
    
    IBOutlet UIImageView *profile_image;
    IBOutlet UIButton *take_pic;
    IBOutlet UIButton *select_image;
    IBOutlet UIButton *notification_btn;
    NSString *notifystring;
      UIImage *globImg;
    IBOutlet UIButton *terms_btn;
    NSString *terms_string;
    
    IBOutlet UILabel *lbl_partnerwebsitename;
    NSData *imageData;
    NSString *urlString;
    NSString *fetch_uid;
    
    BOOL check_user_bool;
    
    IBOutlet UITextView *int_textview;
    IBOutlet UITextView *lang_textview;
   // Vital_stats_view *vital_view;
    
    IBOutlet UIToolbar *tab_btns_tbl;
    IBOutlet UIButton *int_dating_btn;
    IBOutlet UIButton *int_flirting_btn;
    IBOutlet UIButton *int_relation_btn;
    IBOutlet UIButton *int_frd_btn;
    IBOutlet UIButton *int_chatting_btn;
    IBOutlet UIButton *int_other_btn;
    IBOutlet UIButton *int_business_btn;
    NSString *string_contact;
    NSString *language_select_new;
    NSString *final_str;
    IBOutlet UIButton *vital_btn;
    
    NSString *userfile_string;
    NSString *screenshot_string;
    NSString *responseString;
    
    NSString *race_str;
    NSString *country_select_str;
    NSString *state_select_str;
    NSString *city_select_str;
    NSString *lang_select_str;
    NSString *race_select_str;
    NSString *hair_select_str;
    NSString *eye_select_str;
    NSString *edu_select_str;
    NSString *drinker_select_str;
    NSString *smoker_select_str;
    
    
    
  //  NSMutableArray *selectedRows;
    
    
}

//-(void)uploadimage;
-(void)postimages_2;
-(IBAction)vitalclick;
-(IBAction)Register;
-(IBAction)country_pressed;
-(IBAction)state_pressed;
-(IBAction)lang_pressed;
-(IBAction)haircolor_pressed;
-(IBAction)eyecolor_pressed;
-(IBAction)edu_pressed;
-(IBAction)int_pressed;
-(IBAction)drink_pressed;
-(IBAction)smoke_pressed;
-(IBAction)city_pressed;
-(IBAction)race_pressed;

-(IBAction)clickPickerCanel:(id)sender;
-(IBAction)clickPickerDone:(id)sender;

-(IBAction)clickPickerCanel1:(id)sender;
-(IBAction)clickPickerDone1:(id)sender;

-(IBAction)clickPickerCane2:(id)sender;
-(IBAction)clickPickerDone2:(id)sender;

-(IBAction)clickPickerCanel3:(id)sender;
-(IBAction)clickPickerDone3:(id)sender;

-(IBAction)clickPickerCanel4:(id)sender;
-(IBAction)clickPickerDone4:(id)sender;
- (IBAction)clickPickerReset3:(id)sender;

-(IBAction)clickPickerCanel5:(id)sender;
-(IBAction)clickPickerDone5:(id)sender;

-(IBAction)clickPickerCanel6:(id)sender;
-(IBAction)clickPickerDone6:(id)sender;

-(IBAction)clickPickerCanel7:(id)sender;
-(IBAction)clickPickerDone7:(id)sender;


-(IBAction)clickPickerCanel8:(id)sender;
-(IBAction)clickPickerDone8:(id)sender;

-(IBAction)clickPickerCanel9:(id)sender;
-(IBAction)clickPickerDone9:(id)sender;

-(IBAction)clickPickerCanel10:(id)sender;
-(IBAction)clickPickerDone10:(id)sender;

-(IBAction)clickPickerCanel11:(id)sender;
-(IBAction)clickPickerDone11:(id)sender;

/////////////////////////////

//-(void)show_dob_picker;
-(void)hide_dob_picker;

//-(void)show_country_picker;
-(void)hide_country_picker;

//-(void)show_state_picker;
-(void)hide_state_picker;

//-(void)show_city_picker;
-(void)hide_city_picker;

//-(void)show_lang_picker;
-(void)hide_lang_picker;

//-(void)show_haircolor_picker;
-(void)hide_haircolor_picker;

//-(void)show_eyecolor_picker;
-(void)hide_eyecolor_picker;

//-(void)show_edu_picker;
-(void)hide_edu_picker;

//-(void)show_interest_picker;
-(void)hide_interest_picker;

//-(void)show_drinker_picker;
-(void)hide_drinker_picker;

//-(void)show_smoker_picker;
-(void)hide_smoker_picker;

-(void)hide_race_picker;


////////////////method////////////

-(void)check_compulsory_field;

-(void)othercheck_field;

-(void)country_json_call;

-(void)state_json_call;

-(void)city_json_call;

-(void)hair_json_call;

-(void)eye_json_call;

-(void)edu_json_call;

-(void)lang_json_call;

-(void)drink_json_call;

-(void)smoke_json_call;

//-(void)interest_json_call;
-(void)race_json_call;

-(IBAction)car_tap:(id)sender;
-(IBAction)bike_tap:(id)sender;
-(IBAction)guy_tap:(id)sender;
-(IBAction)ladies_tap:(id)sender;
-(IBAction)select_image;
-(IBAction)take_image;
-(IBAction)notify_tap:(id)sender;
-(IBAction)terms_condition;
-(IBAction)back;
- (IBAction)toggelEdit:(id)sender;
- (IBAction)clickDone:(id)sender;

-(IBAction)terms_tap:(id)sender;
-(void)postimages;

/////check user/////
-(void)check_user;
-(void)signing_in;
-(void)call_vital_stats;


-(IBAction)int_business:(id)sender;
-(IBAction)int_chatting:(id)sender;
-(IBAction)int_flirting:(id)sender;
-(IBAction)int_relation:(id)sender;
-(IBAction)int_frd:(id)sender;
-(IBAction)int_dating:(id)sender;
-(IBAction)int_others:(id)sender;
-(void)adding_view;
-(void)insertlogin;

-(void)country_validation;
-(void)state_validation;
-(void)city_validation;
-(void)height_validation;
-(void)weight_validation;
-(void)lang_validation;
-(void)hair_validation;
-(void)eye_validation;
-(void)edu_validation;
-(void)drinker_validation;
-(void)smoker_validation;
-(void)race_validation;
-(void)drive_car_validation;
-(void)drive_bike_validation;
-(void)guys_validation;
-(void)ladies_validation;
-(void)booking_fee_validation;
-(void)booking_hr_validation;
-(void)keyword_validation;
-(void)cup_validation;
-(void)waist_validation;
-(void)bust_validation;
-(void)hip_validation;
-(void)long_desc_validation;
-(void)short_desc_validation;
-(void)user_add_validation;
-(void)user_desc_validation;
-(void)tagline_validation;
-(void)mobile_validation;

-(void)showing_alert;
-(void)go_to_login;
-(void)name_validation;
-(void)email_validation;
-(void)real_name_validation;
-(void)password_validation;
@property (retain, nonatomic) IBOutlet UIBarButtonItem *doneLangButton;

@property (retain, nonatomic) IBOutlet UIBarButtonItem *editLangButton;
@property (nonatomic, strong) UIBarButtonItem *editButton;
@property (nonatomic, strong) UIBarButtonItem *cancelButton;
@property (nonatomic, strong) UIBarButtonItem *deleteButton;


@end
