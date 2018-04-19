//
//  Details_detail.h
//  iDate
//
//  Created by D M R on 14/09/12.
//  Copyright (c) 2012 iHubTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Details_detail : UIViewController
{

    IBOutlet UIButton *global_msg_btn;
     IBOutlet UITextView *txtview;
    IBOutlet UILabel *contribute_lbl;
    IBOutlet UILabel *contribute_date;
    NSString *final_display;
}
@property (retain, nonatomic) IBOutlet UILabel *label_title_display;
- (IBAction)click_msg_chatWindow:(id)sender;
-(void)dating_articles_detail;
-(IBAction)mainmenu;
-(IBAction)back;
@end
