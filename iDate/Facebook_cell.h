//
//  Facebook_cell.h
//  iDate
//
//  Created by D M R on 20/10/12.
//  Copyright (c) 2012 iHubTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Facebook_cell : UITableViewCell
{
    IBOutlet UILabel *lbl1;
    IBOutlet UILabel *lbl2;
    IBOutlet UIImageView *profile_img;
    
    IBOutlet UIButton *check_btn_fb;
    
    
}
@property (retain, nonatomic) IBOutlet UIButton *check_btn_fb;
@property(nonatomic, retain) IBOutlet UILabel *lbl1;
@property(nonatomic, retain) IBOutlet UILabel *lbl2;
@property(nonatomic, retain)IBOutlet UIImageView *profile_img;
- (IBAction)Click_checkButton:(id)sender;
- (IBAction)check_btn_fb:(id)sender;

@end
