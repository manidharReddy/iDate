//
//  Terms_View.h
//  iDate
//
//  Created by D M R on 17/08/12.
//  Copyright (c) 2012 iHubTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol Terms_ViewDelegate;
@interface Terms_View : UIViewController

{
    IBOutlet UIButton *btn;
    IBOutlet UILabel *lbl_partnerwebsitename;

}
-(IBAction)back;
@property (assign, nonatomic) id <Terms_ViewDelegate>delegate;
@end
@protocol Terms_ViewDelegate<NSObject>
- (void)doneButtonClicked:(Terms_View*)SMSUser;
- (void)cancelButtonClickedForEmail:(Terms_View*)SMSUser;
@end