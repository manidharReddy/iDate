//
//  Dating_articles.h
//  iDate
//
//  Created by D M R on 14/09/12.
//  Copyright (c) 2012 iHubTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Dating_articles : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UIButton *global_msg_btn;
    IBOutlet UITableView *tblview;
    NSMutableArray *partenercontent_id_arr;
    NSMutableArray *partenerContent_Title_arr;
    NSMutableArray *partenerdate_arr;
    NSString *login_select;
    NSString *partener_str;

}
-(void)dating_articles_call;
//-(void)dating_articles_detail;
-(IBAction)mainmenu;
- (IBAction)click_msg_chatWindow:(id)sender;
@end
