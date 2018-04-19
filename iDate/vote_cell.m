//
//  vote_cell.m
//  iDate
//
//  Created by D M R on 04/10/12.
//  Copyright (c) 2012 iHubTechnologies. All rights reserved.
//

#import "vote_cell.h"

@interface vote_cell ()

@end

@implementation vote_cell

@synthesize user_lbl,msg_lbl;
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
