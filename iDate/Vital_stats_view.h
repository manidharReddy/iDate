//
//  Vital_stats_view.h
//  iDate
//
//  Created by D M R on 11/09/12.
//  Copyright (c) 2012 iHubTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Free_signup.h"
@protocol Vital_sate_delegate;

@interface Vital_stats_view : UIViewController<UITextFieldDelegate>
{

    IBOutlet UITextField *waist_txt;
    IBOutlet UITextField *hips_txt;
    IBOutlet UITextField *bust_txt;
    IBOutlet UITextField *cup_txt;
   // Free_signup *free_signup;
}
-(IBAction)back;
@property (assign, nonatomic) id <Vital_sate_delegate>delegate;
@property(nonatomic,retain)UITextField *waist_txt;
@property(nonatomic,retain)UITextField *hips_txt;
@property(nonatomic,retain)UITextField *bust_txt;
@property(nonatomic,retain)UITextField *cup_txt;
@end
@protocol Vital_sate_delegate<NSObject>
- (void)doneButtonClicked1:(Vital_stats_view*)femaleuser;
- (void)cancelButtonClickedForEmail1:(Vital_stats_view*)femaleuser;
@end
