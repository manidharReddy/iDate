//
//  Friend_cell.h
//  iDate
//
//  Created by D M R on 17/08/12.
//  Copyright (c) 2012 iHubTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Friend_cell :UITableViewCell
{
    IBOutlet UILabel *lbl1;
    IBOutlet UILabel *lbl2;
    IBOutlet UIImageView *profile_img;
    IBOutlet UILabel *ethinicity_lbl;
    IBOutlet UIImageView *gender_image;
    
    IBOutlet UILabel *distanceShow_lbl;
    
}
@property (retain, nonatomic) IBOutlet UILabel *distanceShow_lbl;
@property(nonatomic, retain) IBOutlet UILabel *lbl1;
@property(nonatomic, retain) IBOutlet UILabel *lbl2;
@property(nonatomic, retain)IBOutlet UIImageView *profile_img;
@property(nonatomic, retain)IBOutlet UILabel *ethinicity_lbl;
@property(nonatomic, retain)IBOutlet UIImageView *gender_image;
@end
