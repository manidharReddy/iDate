//
//  Notification_Details.h
//  iDate
//
//  Created by Aparna Reddy Challa on 18/12/12.
//  Copyright (c) 2012 Google Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Menupage.h"
#import "Notification_Cell.h"
#import "AppDelegate.h"

@interface Notification_Details : UIViewController<UITableViewDataSource,UITableViewDelegate>
{

    IBOutlet UIButton *global_msg_btn;
    IBOutlet UITableView *notification_table;
}
- (IBAction)MainMenu:(id)sender;
- (IBAction)click_msg_chatWindow:(id)sender;

@end
