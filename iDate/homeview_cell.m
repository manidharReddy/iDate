//
//  homeview_cell.m
//  iDate
//
//  Created by D M R on 06/10/12.
//  Copyright (c) 2012 iHubTechnologies. All rights reserved.
//

#import "homeview_cell.h"

@interface homeview_cell ()

@end

@implementation homeview_cell

@synthesize lbl1,lbl2;
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
