//
//  Search_cell_view.h
//  iDate
//
//  Created by D M R on 13/09/12.
//  Copyright (c) 2012 iHubTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Search_cell_view : UITableViewCell
{
    IBOutlet UILabel *user_name;
    IBOutlet UILabel *age_lbl;
    IBOutlet UILabel *race_lbl;
    IBOutlet UILabel *tagline_lbl;
    IBOutlet UILabel *height_lbl;
    IBOutlet UILabel *weight_lbl;
    IBOutlet UILabel *edu_lbl;
    IBOutlet UILabel *vital_lbl;
    IBOutlet UILabel *drink_lbl;
    IBOutlet UILabel *smoke_lbl;
    IBOutlet UILabel *last_login;
    IBOutlet UIImageView *profile_img;
    IBOutlet UIImageView *gender_img;
    
    
    IBOutlet UILabel *distance_display;
    
    
}
@property (retain, nonatomic) IBOutlet UILabel *distance_display;
@property(nonatomic, retain) IBOutlet UILabel *user_name;
@property(nonatomic, retain) IBOutlet UILabel *age_lbl;
@property(nonatomic, retain) IBOutlet UILabel *race_lbl;
@property(nonatomic, retain) IBOutlet UILabel *tagline_lbl;
@property(nonatomic, retain) IBOutlet UILabel *height_lbl;
@property(nonatomic, retain) IBOutlet UILabel *weight_lbl;
@property(nonatomic, retain) IBOutlet UILabel *edu_lbl;
@property(nonatomic, retain) IBOutlet UILabel *vital_lbl;
@property(nonatomic, retain) IBOutlet UILabel *drink_lbl;
@property(nonatomic, retain) IBOutlet UILabel *smoke_lbl;
@property(nonatomic, retain) IBOutlet UILabel *last_login;

@property(nonatomic, retain)IBOutlet UIImageView *profile_img;
@property(nonatomic, retain)IBOutlet UIImageView *gender_img;
@end
