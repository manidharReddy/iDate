//
//  Freinds_view.h
//  iDate
//
//  Created by D M R on 28/09/12.
//  Copyright (c) 2012 iHubTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"
#import <MessageUI/MessageUI.h>

#import "FBLoginButton.h"
#import "UserInfo.h"
#import "MyRunViewController.h"
#import "Session.h"

#import <AddressBook/AddressBook.h>
#import "Add_freind_cell.h"
@interface Freinds_view : UIViewController<UITableViewDataSource,UITableViewDelegate,FBSessionDelegate, UserInfoLoadDelegate,FBDialogDelegate,FBRequestDelegate,MFMailComposeViewControllerDelegate,invite_frd_protocol_delegate>
{
    IBOutlet FBLoginButton* _fbButton;
    IBOutlet UIButton* _addRunButton;
    Facebook *_facebook;
    Session *_session;
    NSArray *_permissions;
    UserInfo *_userInfo;
    MyRunViewController *_myRunController;
    IBOutlet UITableView *date_frds_tbl;
    
    NSMutableArray *frd_id_arr;
    NSMutableArray *frd_name_arr;
    NSMutableArray *frd_image_arr;
    UIButton *checkBox;
    IBOutlet UIView *share_view;
    
    NSString *name_select;
    NSString *id_select;
    NSString *image_select;
    IBOutlet UIImageView *fbimage;
    IBOutlet UILabel *fbname_lbl;

    
    BOOL _isFbDialogCall;
    /////////Address bokk///////////
    IBOutlet UITableView *add_btk_tbl;
    NSMutableArray *array_name;
    NSMutableArray *array_phoneNum;
    NSIndexPath* lastIndexPath;
    NSMutableArray *array_email;
    NSMutableArray *array_company;
    
    NSArray *books;
    NSMutableDictionary *sections;
    NSString *string_contact;
    IBOutlet UIImageView *clockimage;
    NSArray *arr_email;
   
    NSMutableArray *email_arr;
    IBOutlet UIButton *fb_frd_btn;
    IBOutlet UIButton *contact_frd_btn;
    NSArray *arr_email1;
    
    NSString *nameshow;
    NSString *emailshow;
    NSString *companyshow;
    NSString *phoneshow;
    

    NSString *urlString1;
}
////////============ facebook ============
-(IBAction)shareButtonClick:(id)sender;
@property(nonatomic, retain) UIView *logoutView;
@property(nonatomic, retain) UIScrollView *loginView;
@property(nonatomic, retain) UIView *headerView;
@property(nonatomic, retain) UIView *addRunView;
@property(nonatomic, retain) MyRunViewController *myRunController;
@property(nonatomic, retain) NSManagedObjectContext *managedObjectContext;
///==========  endfacebook ========/////
-(void)read_fb_profile;
-(IBAction)mneu_page;
-(IBAction)connectclick:(UIButton*)sender;
-(void)show_view;
-(void)hide_view;
-(IBAction)close_view;
-(IBAction)invite;
-(IBAction)connectclick1:(UIButton*)sender;
-(IBAction)facebook_frd;
-(IBAction)Contact_frd;
-(void)delay;
-(void)GetContactInformation;
-(IBAction)btn_tap:(id)sender;
@end
