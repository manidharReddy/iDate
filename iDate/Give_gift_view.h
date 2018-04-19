//
//  Give_gift_view.h
//  iDate
//
//  Created by D M R on 12/09/12.
//  Copyright (c) 2012 iHubTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Give_gift_view : UIViewController<UIScrollViewDelegate,UITextViewDelegate,UIAlertViewDelegate>
{

    IBOutlet UIButton *global_msg_btn;
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
    NSString  *str_image_url_12;
    IBOutlet UIView *pop_upview;
    IBOutlet UITextView *gift_desc_txtview;
    NSString *gift_select;
    
    NSString  *gift_select_new;
    IBOutlet UIButton *gift_done;
    NSString *desc_string; UIButton *btn;
    NSString *gift_select1;
    NSString *gift_select3;
NSString *gift_select2;
    NSString *gift_select4;
    BOOL image_boool;
    NSMutableDictionary *gift_dict;
    NSMutableArray *gift_dict_arr;
    
    NSMutableArray *gift_select_id_arr;
     NSMutableArray *gift_select_name_arr;
    int gift1;
    int gift2;
   
}
- (IBAction)click_msg_chatWindow:(id)sender;
-(void)call_gifts;
//-(void)display_gifts;
-(IBAction)close;
-(IBAction)sendgifts;
-(void)send_call;
-(IBAction)menupage;
-(IBAction)gift_back;
-(IBAction)gift_done_click;
-(void)dictionary_check;
@end
