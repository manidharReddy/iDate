//
//  Add_freind_cell.m
//  iDate
//
//  Created by D M R on 09/10/12.
//  Copyright (c) 2012 iHubTechnologies. All rights reserved.
//

#import "Add_freind_cell.h"

@interface Add_freind_cell ()

@end

@implementation Add_freind_cell

@synthesize lbl1,lbl2,profile_img,ethinicity_lbl,gender_image,_delegate,check_btn;
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
-(IBAction)applyClickBtn1:(UIButton*)sender

{
    
    
    if ([_delegate respondsToSelector:@selector(inviteFreind_click:)])
        
    {
        
        [_delegate inviteFreind_click:sender];
        
    }
    
}

@end
