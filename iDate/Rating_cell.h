//
//  Rating_cell.h
//  iDate
//
//  Created by D M R on 18/09/12.
//  Copyright (c) 2012 iHubTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Rating_cell :  UITableViewCell
{
    IBOutlet UILabel *rate_lbl;
    IBOutlet UILabel *id_lbl;;
       
    
    
    
}
@property(nonatomic, retain) IBOutlet UILabel *rate_lbl;
@property(nonatomic, retain) IBOutlet UILabel *id_lbl;
@end
