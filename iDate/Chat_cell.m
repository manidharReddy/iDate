//
//  Chat_cell.m
//  iDate
//
//  Created by D M R on 30/08/12.
//  Copyright (c) 2012 iHubTechnologies. All rights reserved.
//

#import "Chat_cell.h"

@interface Chat_cell ()

@end

@implementation Chat_cell
@synthesize user_msg,user_name,profile_img,message_count,upgrade_btn,round_image,image_roundbtn;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)hideTheImage
{
    message_count.hidden=YES;
    round_image.hidden=YES;
}
-(void)hideTheImageV
{
    message_count.hidden=NO;
    round_image.hidden=NO;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
// Release any retained subviews of the main view.
// e.g. self.myOutlet = nil;


- (void)dealloc {
   // [round_image release];
    //[round_image release];
    //[image_roundbtn release];
    //[image_roundbtn release];
    [super dealloc];
 
}
 
@end
