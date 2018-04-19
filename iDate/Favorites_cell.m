//
//  Favorites_cell.m
//  iDate
//
//  Created by D M R on 03/09/12.
//  Copyright (c) 2012 iHubTechnologies. All rights reserved.
//

#import "Favorites_cell.h"


@implementation Favorites_cell

@synthesize user_name,profile_img,age_lbl,gender_img;
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


@end
