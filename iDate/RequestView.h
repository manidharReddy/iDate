//
//  RequestView.h
//  iDate
//
//  Created by D M R on 18/09/12.
//  Copyright (c) 2012 iHubTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Chat_view.h"


@interface RequestView : UIViewController<UIAlertViewDelegate>

{

    NSString  *login_select;
    BOOL request_contact_bool;
    BOOL requset_email_bool;
    IBOutlet UIButton *globa_msg_btn;
}
- (IBAction)msg_click_chatWindow:(id)sender;
-(IBAction)request_btn;
-(IBAction)request_email;
-(void)request_contact_json;
-(void)request_email_json;
-(void)readlogin;
-(IBAction)back;
@end
