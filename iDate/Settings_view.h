//
//  Settings_view.h
//  iDate
//
//  Created by D M R on 13/09/12.
//  Copyright (c) 2012 iHubTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioServices.h>
#import <AVFoundation/AVFoundation.h>

@interface Settings_view : UIViewController<UITextFieldDelegate,UIAlertViewDelegate,AVAudioPlayerDelegate>
{

    IBOutlet UITextField *old_paswd_txt;
    IBOutlet UITextField *new_passwd_txt;
    IBOutlet UITextField *reenter_passwd_txt;
    IBOutlet UIView *pop_up_view;
    NSString *login_select;
    BOOL change_bool;
    BOOL deactivate_bool;
    IBOutlet UIButton *play_btn;
    IBOutlet UIButton *vibrate_btn;
    IBOutlet UIButton *notification_btn;
    AVAudioPlayer *soundPlayer;
    BOOL rating_bool;

    IBOutlet UIButton *global_msg_btn;
}

- (IBAction)click_msg_ChatWindow:(id)sender;

-(IBAction)change_password;
-(IBAction)Deactivate_account;
-(void)show_pop_up;
-(IBAction)close;
-(IBAction)chang_done;
-(void)deactivate_call;
-(void)readlogin;
-(IBAction)menupage;
-(void)check_other_value;
-(IBAction)vibrate_btn:(id)sender;
-(IBAction)play_btn:(id)sender;
-(IBAction)notification_btn:(id)sender;
-(IBAction)Rate_idate;
-(void)rating_call;

@end
