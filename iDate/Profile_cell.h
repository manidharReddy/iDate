//
//  Profile_cell.h
//  iDate
//
//  Created by D M R on 03/09/12.
//  Copyright (c) 2012 iHubTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Profile_cell :UITableViewCell
{
 
    IBOutlet UILabel *age_lbl;
    IBOutlet UILabel *name_lbl;
       
    
    
    
}

@property(nonatomic, retain) IBOutlet UILabel *age_lbl;
@property(nonatomic, retain) IBOutlet UILabel *name_lbl;
@end
