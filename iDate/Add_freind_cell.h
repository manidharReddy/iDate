//
//  Add_freind_cell.h
//  iDate
//
//  Created by D M R on 09/10/12.
//  Copyright (c) 2012 iHub Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol invite_frd_protocol_delegate;
@interface Add_freind_cell :  UITableViewCell
{
    IBOutlet UILabel *lbl1;
    IBOutlet UILabel *lbl2;
    IBOutlet UIImageView *profile_img;
    IBOutlet UILabel *ethinicity_lbl;
    IBOutlet UIImageView *gender_image;
    id <invite_frd_protocol_delegate>_delegate;
    IBOutlet UIButton *check_btn;

    
}
@property(nonatomic,assign)id <invite_frd_protocol_delegate>_delegate;

@property(nonatomic, retain) IBOutlet UILabel *lbl1;
@property(nonatomic, retain) IBOutlet UILabel *lbl2;
@property(nonatomic, retain)IBOutlet UIImageView *profile_img;
@property(nonatomic, retain)IBOutlet UILabel *ethinicity_lbl;
@property(nonatomic, retain)IBOutlet UIImageView *gender_image;
@property(nonatomic,retain) IBOutlet UIButton *check_btn;

@end
@protocol invite_frd_protocol_delegate<NSObject>

@optional

-(void)inviteFreind:(id)sender;

-(void)inviteFreind_click:(id)sender;
@end
