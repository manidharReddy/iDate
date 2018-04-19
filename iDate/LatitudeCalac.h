//
//  LatitudeCalac.h
//  iDate
//
//  Created by Aparna Reddy Challa on 19/12/12.
//  Copyright (c) 2012 Google Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Menupage.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import <MessageUI/MessageUI.h>
//#import <UIKit/UIKit.h>
#import "FBConnect.h"
#import <MessageUI/MessageUI.h>

#import "FBLoginButton.h"
#import "UserInfo.h"
#import "MyRunViewController.h"
#import "Session.h"

//#import <AddressBook/AddressBook.h>
#import "Add_freind_cell.h"

//ABPeoplePickerNavigationControllerDelegate,

@interface LatitudeCalac : UIViewController<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,FBSessionDelegate, UserInfoLoadDelegate,FBDialogDelegate,FBRequestDelegate,MFMailComposeViewControllerDelegate,invite_frd_protocol_delegate,MFMessageComposeViewControllerDelegate>
{
    
    IBOutlet FBLoginButton* _fbButton;
    IBOutlet UIButton* _addRunButton;
    Facebook *_facebook;
    Session *_session;
    NSArray *_permissions;
    UserInfo *_userInfo;
    MyRunViewController *_myRunController;

    NSMutableArray *frd_id_arr;
    NSMutableArray *frd_name_arr;
    NSMutableArray *frd_image_arr;
    UIButton *checkBox;

     BOOL _isFbDialogCall;
    
    NSString *name_select;
    NSString *id_select;
    NSString *image_select;
    IBOutlet UIImageView *fbimage;
    IBOutlet UILabel *fbname_lbl;

    IBOutlet UITableView *contact_adress_table;
    NSMutableArray *ContactsAddressArray;
    NSMutableArray *contactName_arr;
    NSMutableArray *contactNumber_arr;
    NSMutableArray *contactPhone_arr;
    NSMutableArray *contactEmail_arr;
    NSMutableArray *contactCompany_arr;
    
    
    IBOutlet UIButton *global_msg_btn;
    int _pageNo;
    NSMutableArray *_friends;
    
    
    
    
    
    NSString *contactName_str;
    NSString *contactNumb_str;
    NSString *contactNumb_str1;
    NSString *contactNumb_str2;
    NSString *contactNumb_trim_str;
    NSString *contactPhone_str;
    NSString *contactEmail_str;
    NSString *contactCompany_str;
    
    
    
    
    
    NSMutableArray *name_list_items;
    NSMutableArray *number_list_items;
    NSMutableArray *phone_list_items;
    NSMutableArray *email_list_items;
    NSMutableArray *company_list_items;
    
    NSMutableArray *phoneContactNum_arr;
    NSMutableArray *phoneContactname_arr;
    
    
    IBOutlet UIButton *search_done;
    
    IBOutlet UISearchBar *searchBar;
	BOOL searching;
	BOOL letUserSelectRow;
    
    
    IBOutlet UITableView *facebook_table_view;
    
    NSMutableArray *email_arr;
    IBOutlet UIButton *fb_frd_btn;
    IBOutlet UIButton *contact_frd_btn;
    NSArray *arr_email1;
    
    NSString *urlString1;
    IBOutlet UIView *share_view;
    
    IBOutlet UIButton *select_Deselect_btn;
    
    NSMutableArray *friendsFB;
    NSMutableArray *frnd_name_fb;
    NSMutableArray *frnd_id_fb;
    
    NSMutableArray *selected_names_fb;
    NSMutableArray *selected_ids_fb;
    NSMutableArray *suggested_frnds;
    
    IBOutlet UIButton *checked_done_click;
    
    UIButton *checkBox_btn;
     UIButton *checkBoxAdd_btn;
    int b;
    IBOutlet UIButton *phone_addres_btn;
}
- (IBAction)post_invitFrnds:(id)sender;
- (IBAction)selectCheckAll:(id)sender;

- (IBAction)checked_done_click:(id)sender;
@property (nonatomic, retain) Facebook *facebook;
@property(nonatomic, retain) UIView *logoutView;
@property(nonatomic, retain) UIScrollView *loginView;
@property(nonatomic, retain) UIView *headerView;
@property(nonatomic, retain) UIView *addRunView;
@property(nonatomic, retain) MyRunViewController *myRunController;
@property(nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property(nonatomic,retain)UIButton *checkBox_btn;
- (IBAction)facebook_btn_click:(id)sender;

- (IBAction)search_Done:(id)sender;

- (IBAction)getContactList:(id)sender;
- (IBAction)getLatLongClick:(id)sender;
- (IBAction)click_msg_chatWindow:(id)sender;

- (IBAction)HomeMenu:(id)sender;
- (IBAction)LatitudeCalc:(id)sender;
- (IBAction)smsSend_done_click:(id)sender;

@end
