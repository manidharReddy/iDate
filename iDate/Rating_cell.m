//
//  Rating_cell.m
//  iDate
//
//  Created by D M R on 18/09/12.
//  Copyright (c) 2012 iHubTechnologies. All rights reserved.
//

#import "Rating_cell.h"

@interface Rating_cell ()

@end

@implementation Rating_cell
@synthesize rate_lbl,id_lbl;
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
