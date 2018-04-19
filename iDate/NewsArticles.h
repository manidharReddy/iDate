//
//  NewsArticles.h
//  iDate
//
//  Created by Aparna Reddy Challa on 07/01/13.
//  Copyright (c) 2013 Google Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsArticles : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UIButton *global_msg_btn;
    IBOutlet UITableView *newsTableView;
    NSMutableArray *partenercontent_id_arr;
    NSMutableArray *partenerContent_Title_arr;
    NSMutableArray *partenerdate_arr;
    NSString *login_select;
    NSString *partener_str;

    
}
-(void)dating_articles_call;
//-(void)dating_articles_detail;

- (IBAction)show_menu:(id)sender;
- (IBAction)click_msg_chatWindow:(id)sender;

@end
