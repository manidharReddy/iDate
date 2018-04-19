//
//  News_Cell.h
//  iDate
//
//  Created by Aparna Reddy Challa on 07/01/13.
//  Copyright (c) 2013 Google Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface News_Cell : UITableViewCell
{
    IBOutlet UILabel *news_lbl;
    
    IBOutlet UILabel *newsDate_lbl;
}
@property (retain, nonatomic) IBOutlet UILabel *news_lbl;
@property (retain, nonatomic) IBOutlet UILabel *newsDate_lbl;

@end
