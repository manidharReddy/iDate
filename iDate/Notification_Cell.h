//
//  Notification_Cell.h
//  iDate
//
//  Created by Aparna Reddy Challa on 18/12/12.
//  Copyright (c) 2012 Google Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Notification_Cell : UITableViewCell
{
    IBOutlet UILabel *notification_Date;
    
    IBOutlet UILabel *notification_msg;
}
@property (retain, nonatomic) IBOutlet UILabel *notification_Date;
@property (retain, nonatomic) IBOutlet UILabel *notification_msg;

@end
