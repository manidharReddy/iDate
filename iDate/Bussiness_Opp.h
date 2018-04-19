//
//  Bussiness_Opp.h
//  iDate
//
//  Created by Aparna Reddy Challa on 07/01/13.
//  Copyright (c) 2013 Google Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Menupage.h"

@interface Bussiness_Opp : UIViewController
{
    IBOutlet UIButton *global_msg_btn;
    
    IBOutlet UITextView *bussenessOpp_textview;
}
- (IBAction)Show_Menu_click:(id)sender;
- (IBAction)click_msg_chatWindow:(id)sender;

@end
