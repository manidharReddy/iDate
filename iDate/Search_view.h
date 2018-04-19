//
//  Search_view.h
//  iDate
//
//  Created by D M R on 13/09/12.
//  Copyright (c) 2012 iHubTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Search_view : UIViewController<UIAlertViewDelegate,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UIScrollViewDelegate>

{

    IBOutlet UIScrollView *scrollview;
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
    
    
    IBOutlet UIButton *int_dating_btn;
    IBOutlet UIButton *int_flirting_btn;
    IBOutlet UIButton *int_relation_btn;
    IBOutlet UIButton *int_frd_btn;
    IBOutlet UIButton *int_chatting_btn;
    IBOutlet UIButton *int_other_btn;
    IBOutlet UIButton *int_business_btn;
    

    
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
    
    
    
    
    IBOutlet UIButton *global_msg_btn;
    IBOutlet UIButton *country_btn;
    IBOutlet UIButton *race_btn;
    IBOutlet UIButton *haircolor_btn;
    IBOutlet UIButton *eyescolor_btn;
    IBOutlet UIButton *edulevel_btn;
    IBOutlet UIButton *drinker_btn;
    IBOutlet UIButton *car_btn;
    IBOutlet UIButton *bike_btn;
    IBOutlet UIButton *guys_btn;
    IBOutlet UIButton *ladies_btn;
    IBOutlet UITextField *keyword_txt;
     IBOutlet UITextField *age_txt;
    IBOutlet UIButton *smoker_btn;
    
    IBOutlet UIButton *male_btn;
    IBOutlet UIButton *female_btn;
    IBOutlet UIButton *all_btn;
    NSString *genderString;
    NSString *car_string;
    NSString *bike_string;
    NSString *ladies_string;
    NSString *guys_string;
    int select;
    
    IBOutlet UILabel *country_txt;
    IBOutlet UILabel *education_txt;
    IBOutlet UILabel *hair_txt;
    IBOutlet UILabel *eye_txt;
    IBOutlet UILabel *drinker_txt;
    IBOutlet UILabel *smoker_txt;
    IBOutlet UILabel *race_txt;
    IBOutlet UILabel *lang_txt;
    IBOutlet UITextField *age_to_txt;
    IBOutlet UITextField *age_from_txt;
    IBOutlet UITextField *height_to_txt;
    IBOutlet UITextField *height_from_txt;
    IBOutlet UITextField *weight_to_txt;
    IBOutlet UITextField *weight_from_txt;
    
    
    NSString *height_from_string;
    NSString *height_to_string;
    NSString *weight_from_string;
    NSString *weight_to_string;
    NSString *age_from_string;
    NSString *age_to_string;
    NSString *keyword_string;
      
}

-(IBAction)country_pressed;
-(IBAction)state_pressed;
-(IBAction)lang_pressed;
-(IBAction)haircolor_pressed;
-(IBAction)eyecolor_pressed;
-(IBAction)edu_pressed;
//-(IBAction)int_pressed;
-(IBAction)drink_pressed;
-(IBAction)smoke_pressed;
-(IBAction)city_pressed;
-(IBAction)race_pressed;
- (IBAction)click_msg_chatWindow:(id)sender;

//-(IBAction)clickPickerCanel:(id)sender;
//-(IBAction)clickPickerDone:(id)sender;

-(IBAction)clickPickerCanel1:(id)sender;
-(IBAction)clickPickerDone1:(id)sender;

//-(IBAction)clickPickerCane2:(id)sender;
//-(IBAction)clickPickerDone2:(id)sender;

//-(IBAction)clickPickerCanel3:(id)sender;
//-(IBAction)clickPickerDone3:(id)sender;

-(IBAction)clickPickerCanel4:(id)sender;
-(IBAction)clickPickerDone4:(id)sender;

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

-(IBAction)menupage;

-(void)country_json_call;

-(void)state_json_call;

-(void)city_json_call;

-(void)hair_json_call;

-(void)eye_json_call;

-(void)edu_json_call;

-(void)lang_json_call;

-(void)drink_json_call;

-(void)smoke_json_call;
-(void)race_json_call;


-(IBAction)car_tap:(id)sender;
-(IBAction)bike_tap:(id)sender;
-(IBAction)guy_tap:(id)sender;
-(IBAction)int_business:(id)sender;
-(IBAction)int_chatting:(id)sender;
-(IBAction)int_flirting:(id)sender;
-(IBAction)int_relation:(id)sender;
-(IBAction)int_frd:(id)sender;
-(IBAction)int_dating:(id)sender;
-(IBAction)int_others:(id)sender;
-(IBAction)search;
-(void)check_others;
-(void)searching;
@end
