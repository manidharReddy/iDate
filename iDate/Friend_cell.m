//
//  Friend_cell.m
//  iDate
//
//  Created by D M R on 17/08/12.
//  Copyright (c) 2012 iHubTechnologies. All rights reserved.
//

#import "Friend_cell.h"


@implementation Friend_cell

@synthesize lbl1,lbl2,profile_img,ethinicity_lbl,gender_image,distanceShow_lbl;
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
    [distanceShow_lbl release];
    [distanceShow_lbl release];
    [super dealloc];
}
@end
