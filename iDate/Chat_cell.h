//
//  Chat_cell.h
//  iDate
//
//  Created by D M R on 30/08/12.
//  Copyright (c) 2012 iHubTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Chat_cell : UITableViewCell
{
    IBOutlet UILabel *user_name;
    IBOutlet UILabel *user_msg;
    IBOutlet UIImageView *profile_img;
    IBOutlet UILabel *message_count;
    IBOutlet UIButton *upgrade_btn;
 
    IBOutlet UIButton *image_roundbtn;
    
    IBOutlet UIImageView *round_image;
    
}
@property (retain, nonatomic) IBOutlet UIButton *image_roundbtn;
@property (retain, nonatomic) IBOutlet UIImageView *round_image;
@property(nonatomic, retain) IBOutlet UILabel *user_name;
@property(nonatomic, retain) IBOutlet UILabel *user_msg;
@property(nonatomic, retain)IBOutlet UIImageView *profile_img;
@property(nonatomic, retain)IBOutlet UILabel *message_count;
@property(nonatomic, retain)IBOutlet UIButton *upgrade_btn;
-(void)hideTheImage;
-(void)hideTheImageV;
@end
