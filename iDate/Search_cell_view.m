//
//  Search_cell_view.m
//  iDate
//
//  Created by D M R on 13/09/12.
//  Copyright (c) 2012 iHubTechnologies. All rights reserved.
//

#import "Search_cell_view.h"



@implementation Search_cell_view
@synthesize age_lbl,user_name,race_lbl,tagline_lbl,height_lbl,weight_lbl,edu_lbl,vital_lbl,drink_lbl,smoke_lbl,last_login,gender_img,profile_img,distance_display;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
// Release any retained subviews of the main view.
// e.g. self.myOutlet = nil;


- (void)dealloc {
    [distance_display release];
    //[_distance_display release];
    [super dealloc];
}
@end
