//
//  vote_cell.h
//  iDate
//
//  Created by D M R on 04/10/12.
//  Copyright (c) 2012 iHubTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface vote_cell :  UITableViewCell
{
    IBOutlet UILabel *user_lbl;
    IBOutlet UILabel *msg_lbl;;
    
    
    
    
}
@property(nonatomic, retain) IBOutlet UILabel *user_lbl;
@property(nonatomic, retain) IBOutlet UILabel *msg_lbl;
@end
