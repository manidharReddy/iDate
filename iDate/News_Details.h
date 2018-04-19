//
//  News_Details.h
//  iDate
//
//  Created by Aparna Reddy Challa on 07/01/13.
//  Copyright (c) 2013 Google Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface News_Details : UIViewController
{
    IBOutlet UIButton *global_msg_btn;
    IBOutlet UITextView *txtview;
    IBOutlet UILabel *contribute_lbl;
    IBOutlet UILabel *contribute_date;
    IBOutlet UILabel *label_title_display;
    NSString *final_display;

}
@property (retain, nonatomic) IBOutlet UILabel *label_title_display;
-(void)dating_articles_detail;
-(IBAction)mainmenu;
-(IBAction)back;
- (IBAction)click_msg_chatWindow:(id)sender;


@end
