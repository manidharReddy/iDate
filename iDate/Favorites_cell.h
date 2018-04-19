//
//  Favorites_cell.h
//  iDate
//
//  Created by D M R on 03/09/12.
//  Copyright (c) 2012 iHubTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Favorites_cell :UITableViewCell
{
    IBOutlet UILabel *user_name;
    IBOutlet UILabel *age_lbl;
    IBOutlet UIImageView *profile_img;
    IBOutlet UIImageView *gender_img;

    
    
    
}
@property(nonatomic, retain) IBOutlet UILabel *user_name;
@property(nonatomic, retain) IBOutlet UILabel *age_lbl;
@property(nonatomic, retain)IBOutlet UIImageView *profile_img;
@property(nonatomic, retain)IBOutlet UIImageView *gender_img;
@end
