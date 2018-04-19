//
//  Menupage.h
//  iDate
//
//  Created by D M R on 07/08/12.
//  Copyright (c) 2012 iHubTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Notification_Details.h"
#import "LatitudeCalac.h"
//#import <AudioToolbox/AudioServices.h>
//#import <AVFoundation/AVFoundation.h>
#import "Bussiness_Opp.h"
#import "NewsArticles.h"
@interface Menupage : UIViewController//<UIAlertViewDelegate,AVAudioPlayerDelegate>
{
    NSMutableArray *noti_message_arr;
    NSMutableArray *noti_message_Creation_arr;
    NSString *noti_message_str;
    NSString *noti_message_Creation_str;
    
    NSDictionary *responseDict;
    
    
    //NSTimer *callMessageByTimer;
    
    IBOutlet UILabel *lbl_partnerwebsitename;
    NSString *login_select;
    //AVAudioPlayer *soundPlayer;
    int noti_label_count;
    IBOutlet UIImageView *notification_round_image;
    IBOutlet UIButton *notification_Button;
    IBOutlet UILabel *notification_total_lbl;
    IBOutlet UIButton *messageIconShow;
}
- (IBAction)NewsArctles_click:(id)sender;
- (IBAction)BussinesOpp_click:(id)sender;
- (IBAction)unReadMessageClick:(id)sender;
- (IBAction)Latitude:(id)sender;
- (IBAction)notification_Click_btn:(id)sender;
- (IBAction)Logout:(id)sender;
-(IBAction)back:(id)sender;
-(IBAction)My_profile;
-(IBAction)Dating_articles;
-(IBAction)Chat;
-(IBAction)My_favorites;
-(IBAction)search;
-(IBAction)Settings_click;
-(void)backMen;
@end
