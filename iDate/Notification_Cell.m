//
//  Notification_Cell.m
//  iDate
//
//  Created by Aparna Reddy Challa on 18/12/12.
//  Copyright (c) 2012 Google Inc. All rights reserved.
//

#import "Notification_Cell.h"

@implementation Notification_Cell
@synthesize notification_msg,notification_Date;
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

- (void)dealloc {
    [notification_Date release];
    [notification_msg release];
    //[_notification_Date release];
    //[_notification_msg release];
    [super dealloc];
}
@end
