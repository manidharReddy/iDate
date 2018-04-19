//
//  Facebook_cell.m
//  iDate
//
//  Created by D M R on 20/10/12.
//  Copyright (c) 2012 iHubTechnologies. All rights reserved.
//

#import "Facebook_cell.h"

@interface Facebook_cell ()

@end

@implementation Facebook_cell

@synthesize lbl1,profile_img,lbl2,check_btn_fb;
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

-(void)clickCheckButton:(id)sender
{
    UIButton *tappedButton = (UIButton*)sender;
    
  	if([tappedButton.currentImage isEqual:[UIImage imageNamed:@"unclick_new.png"]])
    {
        [tappedButton setImage:[UIImage imageNamed:@"click_new.png"] forState:UIControlStateNormal];
		
        
    }
    
    
	else
	{
		
        [tappedButton setImage:[UIImage imageNamed:@"unclick_new.png"] forState:UIControlStateNormal];
		
		
        
        
	}
    
}

- (void)dealloc {
    [check_btn_fb release];
    [check_btn_fb release];
    [super dealloc];
}
- (IBAction)Click_checkButton:(id)sender {
    
    UIButton *tappedButton = (UIButton*)sender;
    
  	if([tappedButton.currentImage isEqual:[UIImage imageNamed:@"unclick_new.png"]])
    {
        [tappedButton setImage:[UIImage imageNamed:@"click_new.png"] forState:UIControlStateNormal];
		
        
    }
    
    
	else
	{
		
        [tappedButton setImage:[UIImage imageNamed:@"unclick_new.png"] forState:UIControlStateNormal];
		
		
        
        
	}
    
    
}

- (IBAction)check_btn_fb:(id)sender {
    
    UIButton *tappedButton = (UIButton*)sender;
    
  	if([tappedButton.currentImage isEqual:[UIImage imageNamed:@"unclick_new.png"]])
    {
        [check_btn_fb setImage:[UIImage imageNamed:@"click_new.png"] forState:UIControlStateNormal];
		
        
    }
    
    
	else
	{
		
        [check_btn_fb setImage:[UIImage imageNamed:@"unclick_new.png"] forState:UIControlStateNormal];
		
		
        
        
	}
    
}
@end
