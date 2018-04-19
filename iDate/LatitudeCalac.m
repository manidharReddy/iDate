//
//  LatitudeCalac.m
//  iDate
//
//  Created by Aparna Reddy Challa on 19/12/12.
//  Copyright (c) 2012 Google Inc. All rights reserved.
//

#import "LatitudeCalac.h"
#import <AddressBook/AddressBook.h>
#import <MessageUI/MessageUI.h>
#import "Add_freind_cell.h"
#import "JSON.h"
#import "Chat_view.h"
#import "Freinds_view.h"
#import "Facebook_cell.h"
#import "AppDelegate.h"
#import "AsyncImageView1.h"
#import "Menupage.h"
#import "FBConnect.h"
#import "AsyncImageView.h"
#import "UIImageView+DispatchLoad.h"
#import "FBLoginButton.h"
#import "UserInfo.h"
#import "MyRunViewController.h"
#import "Session.h"
//#import "Add_freind_cell.h"
//#import <AddressBook/AddressBook.h>
#define ASYNC_IMAGE_TAG 9999
#define FONT_SIZE 18.0f
#define CELL_CONTENT_WIDTH 320.0f
#define CELL_CONTENT_MARGIN 10.0f
#define FRIENDS_PER_LOAD    30
//#define USING_ARC 1
static NSString* kAppId = @"438746826175336";


@interface LatitudeCalac ()

@end

@implementation LatitudeCalac
@synthesize logoutView = _logoutView,loginView  = _loginView,headerView = _headerView,addRunView = _addRunView,myRunController = _myRunController,facebook=_facebook,checkBox_btn;
@synthesize managedObjectContext;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        NSLog(@"testEnterid");
        _permissions =  [[NSArray arrayWithObjects:
						  @"publish_stream",@"read_stream", @"offline_access",@"user_about_me",@"user_birthday",@"user_likes",@"user_education_history",@"user_hometown",@"user_website",@"user_work_history", @"offline_access",@"user_events",@"friends_events",@"user_birthday",@"friends_birthday",@"manage_pages",@"email",@"read_mailbox",@"share_item",@"publish_actions",@"video_upload",nil] retain];
        
    }
    return self;
}


- (void) login
{
	[_facebook authorize:kAppId permissions:_permissions delegate:self];
}

- (void) logout {
	[_session unsave];
	[_facebook logout:self];
}


-(void) fbDidLogin
{
    //[Initial_fbActivity hide];
    
	[_logoutView removeFromSuperview];
	[_addRunView removeFromSuperview];
	
	_fbButton.isLoggedIn         = YES;
	[_fbButton updateImage];
	_addRunButton.hidden = NO;
	
	_userInfo = [[[[UserInfo alloc] initializeWithFacebook:_facebook andDelegate: self]
				  autorelease]
				 retain];
	[_userInfo requestAllInfo];
	
    if (self.loginView.isHidden==NO)
    {
    }
    else {
        [self.view addSubview:self.loginView];
    }
    
    
    if (_isFbDialogCall==NO)
    {
        _isFbDialogCall=YES;
        //[self  FbFriendWallPostCall];
        
        [self requestFriendList];
    }
    
    //  [self performSelector:@selector(FbFriendWallPostCall) withObject:nil afterDelay:0.1 ];
}

/**
 * FBSessionDelegate
 */


-(void) fbDidLogout
{
	[_session unsave];
	[_loginView removeFromSuperview];
	[self.view addSubview:_logoutView];
	_fbButton.isLoggedIn         = NO;
	[_fbButton updateImage];
	_addRunButton.hidden = YES;
}

/*
 * UserInfoLoadDelegate
 */
- (void)userInfoDidLoad
{
	[_session setSessionWithFacebook:_facebook andUid:_userInfo.uid];
	[_session save];
	
	_myRunController = [[MyRunViewController alloc] init];
	_myRunController.userInfo = _userInfo;
	_myRunController.view.frame = CGRectMake(0, 0, 320, 460);
	[self.myRunController viewWillAppear:YES];
	[_loginView addSubview:self.myRunController.view];
}


- (void)userInfoFailToLoad
{
    _fbButton.isLoggedIn = NO;
	_addRunButton.hidden = YES;
	[self.view addSubview:self.logoutView];
	
}

- (void)requestFriendList {
    NSString *url = [NSString stringWithFormat:@"me/friends?limit=%d&offset=%d", FRIENDS_PER_LOAD, _pageNo*FRIENDS_PER_LOAD];
    [self.facebook requestWithGraphPath:url andDelegate:self];
}


//////////////////////////////////////////////////////////////////////////////////////////////////

-(void)facebookcall
{
    _session = [[Session alloc] init];
    _facebook = [[_session restore] retain];
    if (_facebook == nil) {
        _facebook = [[[[Facebook alloc] init] autorelease] retain];
        _fbButton.isLoggedIn = NO;
        _addRunButton.hidden = YES;
        [self.view addSubview:self.logoutView];
    }
    else
    {
        _fbButton.isLoggedIn = YES;
        _addRunButton.hidden = NO;
        [self fbDidLogin];
        [self.view addSubview:self.loginView];
    }
    
    [_fbButton updateImage];
    
    [[self view] addSubview:[self headerView]];
    [_headerView addSubview:_fbButton];
    //////////////////////////////////////////////////////
    
    _fbButton =[[FBLoginButton alloc]init];
    if (_fbButton.isLoggedIn)
    {
        [self logout];
    }
    else
    {
        [self login];
    }
}


-(void)FbFriendWallPostCall
{
    
    
    
    
    
    NSString *str1=[[NSString alloc]initWithFormat:@"%@, wants to sent request from idate",fname];
    NSLog(@"str1:%@",str1);
    
    
    NSString *stri = [NSString stringWithFormat:@"/%@/feed",id_select];
    NSLog(@"stri:%@",stri);
    
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   
                                   kAppId, @"app_id",
                                   @"https://www.google.co.in/", @"link",
                                   @"iDate", @"name",
                                   @"Cool, new iPhone App", @"caption",
                                   str1, @"description",
                                   id_select, @"to",
                                   nil];
    
    [_facebook dialog:@"feed" andParams:params andDelegate:self];
    
    
    
    
    
}


- (void)request:(FBRequest*)request didLoad:(id)result
{
    
    if ([result isKindOfClass:[NSDictionary class]]) {
        NSLog(@"---> %@", result);
        result = [(NSDictionary*)result objectForKey:@"data"];
        
        if ([result isKindOfClass:[NSArray class]]) {
            NSArray *data = (NSArray*)result;
            NSLog(@"data array:%@",data);
            if (!_friends) {
                NSLog(@"enter into _friends");
                _friends = [NSMutableArray array];
            }
            for (NSDictionary *newFriend in result) {
                NSLog(@"enter into newFriend");
                int ndx = 0;
                for (NSDictionary *friend in _friends) {
                    NSLog(@"enter into newFriend2");
                    NSString *name = [friend objectForKey:@"name"];
                    NSLog(@"name of facebook:%@",name);
                    NSString *newName = [newFriend objectForKey:@"name"];
                    NSLog(@"name of facebook1:%@",newName);
                    if ([name compare:newName]==NSOrderedDescending)
                        break;
                    ndx++;
                }
                [_friends insertObject:newFriend atIndex:ndx];
                NSLog(@"_friends list:%@",_friends);
            }
            
            if ([data count]==FRIENDS_PER_LOAD) {
                _pageNo++;
                [self requestFriendList];
            }
            else {
                // reload the view...
                [facebook_table_view reloadData];
            }
        }
    }

   /*
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message post" message:@"Message is posted" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [alert release];

    */
    [self getFriendsFB];
    
   // [facebook_table_view reloadData];
    }



-(void)getFriendsFB
{
    NSLog(@"enter into getFriendsFB");
    frnd_id_fb = [[NSMutableArray alloc]init];
    frnd_name_fb = [[NSMutableArray alloc]init];
    NSLog(@"friends in get:%@",_friends);
    
    for (NSDictionary *frndFB in _friends) {
        
        
        NSString *id_frnd_fb = [[NSString alloc]initWithFormat:@"%@",[frndFB objectForKey:@"id"]];
        [frnd_id_fb  addObject:id_frnd_fb];
        NSLog(@"frnd id in fb:%@",frnd_id_fb);
        
        
        NSString *name_frnd_fb = [[NSString alloc]initWithFormat:@"%@",[frndFB objectForKey:@"name"]];
        [frnd_name_fb  addObject:name_frnd_fb];
        NSLog(@"frnd name in fb:%@",frnd_name_fb);
        
        
        
    }
    [facebook_table_view reloadData];
   // [self getFriendsFB];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    if([global_show_msg_iconstr isEqualToString:@"1"])
    {
        
        global_msg_btn.hidden=NO;
        
    }else
    {
        global_msg_btn.hidden=YES;
    }
    
    
    
    
    email_arr=[[NSMutableArray alloc]init];
    
    name_list_items = [[NSMutableArray alloc]init];
    number_list_items = [[NSMutableArray alloc]init];
    email_list_items = [[NSMutableArray alloc]init];
    phone_list_items = [[NSMutableArray alloc]init];
    company_list_items = [[NSMutableArray alloc]init];
    selected_ids_fb = [[NSMutableArray alloc]init];
    selected_names_fb = [[NSMutableArray alloc]init];
    phoneContactNum_arr = [[NSMutableArray alloc]init];
    phoneContactname_arr = [[NSMutableArray alloc]init];
    suggested_frnds =[[NSMutableArray alloc]init];
    
    b=0;

    [select_Deselect_btn setTag:2];
    
    checked_done_click.hidden=YES;
    searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    searchBar.delegate=self;
    [self.view addSubview:searchBar];
    contact_adress_table.tableHeaderView=searchBar;
    searchBar.backgroundColor=[UIColor cyanColor];
    //searchBar.backgroundColor=[UIColor redColor];
    searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    searching = NO;
    searchBar.placeholder=@"Search By Name";
    letUserSelectRow = YES;
    search_done.hidden=YES;
    facebook_table_view.hidden=YES;
    [self delay];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)HomeMenu:(id)sender {
    Menupage *menu=[[Menupage alloc]initWithNibName:@"Menupage" bundle:[NSBundle mainBundle]];
    
    [self.navigationController pushViewController:menu animated:NO];
    
    
}

- (IBAction)LatitudeCalc:(id)sender {
    
    }

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    
}

- (IBAction)smsSend_done_click:(id)sender {
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init] ;
    for(int k=0;k<[phoneContactNum_arr count];k++)
    {
        NSString *contactNumber = [[NSString alloc]initWithFormat:@"%@",[phoneContactNum_arr objectAtIndex:k]];
        if([MFMessageComposeViewController canSendText])
        {
            NSLog(@"enter into sendmsg");
            
            NSString *smsSnd_str = @"you got a invitation from iDate";
            controller.messageComposeDelegate = self;
            controller.body =[NSString stringWithString:smsSnd_str];
            controller.recipients = [NSArray arrayWithObjects:contactNumber, nil];
            
            
            //[self presentViewController:controller animated:YES completion:nil];
        }
        
    }
    
    
    
    
    
    
}
- (IBAction)facebook_btn_click:(id)sender {
    
    b=0;
    contact_adress_table.hidden=YES;
    facebook_table_view.hidden=NO;
    
    phone_addres_btn.hidden =YES;
    checked_done_click.hidden= NO;
    [select_Deselect_btn setTitle:@"SelectAll" forState:UIControlStateNormal];
    [select_Deselect_btn setTag:0];
    
    [facebook_table_view reloadData];
    [self facebookcall];
    //[self requestFriendList];

}

- (IBAction)search_Done:(id)sender {
    
    [self doneSearching_Clicked:(id)sender];
}

- (IBAction)getContactList:(id)sender {
    b=0;
    contact_adress_table.hidden=NO;
    facebook_table_view.hidden=YES;
    checked_done_click.hidden=YES;
    phone_addres_btn.hidden=NO;
    [contact_adress_table reloadData];
    [select_Deselect_btn setTitle:@"SelectAll" forState:UIControlStateNormal];
    [select_Deselect_btn setTag:2];
    
    
}
-(void)delay
{
    string_contact = [[NSString alloc]init];
    contactName_arr = [[NSMutableArray alloc]init];
    contactNumber_arr = [[NSMutableArray alloc]init];
    contactPhone_arr = [[NSMutableArray alloc]init];
    contactEmail_arr = [[NSMutableArray alloc]init];
    contactCompany_arr = [[NSMutableArray alloc]init];
    
    [self contactAddress];
    
   // NSString *contact_total_str = [[NSString alloc]initWithFormat:@"%@",ContactsAddressArray];
    // NSDictionary *responseDict = [contact_total_str JSONValue];
    //BOOL found;
    
    // Loop through the books and create our keys
    for (NSDictionary *book in ContactsAddressArray)
    {
        @try
        {
             contactName_str= [[NSString alloc]initWithFormat:@"%@",[book objectForKey:@"name"]];
             [contactName_arr addObject:contactName_str];
             NSLog(@"Contact Name:%@",contactName_arr);
            
            contactNumb_str= [[NSString alloc]initWithFormat:@"%@",[book objectForKey:@"phone"]];
            contactNumb_str1=[contactNumb_str stringByReplacingOccurrencesOfString:@"(\n" withString:@""];
            contactNumb_str2=[contactNumb_str1 stringByReplacingOccurrencesOfString:@"\n)" withString:@""];
            contactNumb_trim_str = [contactNumb_str2 stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

            [contactNumber_arr addObject:contactNumb_str2];
            NSLog(@"Contact Number:%@",contactNumber_arr);
            
            contactPhone_str= [[NSString alloc]initWithFormat:@"%@",[book objectForKey:@"phoneType"]];
            [contactPhone_arr addObject:contactPhone_str];
            NSLog(@"Contact Phone:%@",contactPhone_arr);
            
            contactEmail_str= [[NSString alloc]initWithFormat:@"%@",[book objectForKey:@"email"]];
            [contactEmail_arr addObject:contactEmail_str];
            NSLog(@"Contact Email:%@",contactEmail_arr);
            
            contactCompany_str= [[NSString alloc]initWithFormat:@"%@",[book objectForKey:@"company"]];
            [contactCompany_arr addObject:contactCompany_str];
            NSLog(@"Contact Company:%@",contactCompany_arr);
            
            
            
        }
        @catch (NSException *exception)
        {
            NSLog(@"Exception name:%@ || Exception Reason:%@",[exception name],[exception reason]);
        }
    }
    
    // Sort each section array
    
    [contact_adress_table reloadData];
    
}



-(void)contactAddress
{

    ContactsAddressArray = [[NSMutableArray alloc] init];

    int i;
    
ABAddressBookRef addressBook = ABAddressBookCreate();
// NSMutableArray *addresses = (__bridge_transfer NSMutableArray *)ABAddressBookCopyArrayOfAllPeople(addressBook);
NSMutableArray *addresses = (NSMutableArray *)ABAddressBookCopyArrayOfAllPeople(addressBook);
NSInteger addressesCount = [addresses count];

for (i=0;i<addressesCount;i++)
{
    NSMutableDictionary *dicContactInfo = [[NSMutableDictionary alloc] init];
    // ABRecordRef record = (__bridge ABRecordRef)[addresses objectAtIndex:i];
    ABRecordRef record = (ABRecordRef)[addresses objectAtIndex:i];
    
    // NSString *firstName = [(__bridge NSString *)ABRecordCopyValue(record, kABPersonFirstNameProperty) capitalizedString];
    NSString *firstName = [(NSString *)ABRecordCopyValue(record, kABPersonFirstNameProperty) capitalizedString];
    //NSString *lastName = (__bridge NSString *)ABRecordCopyValue(record, kABPersonLastNameProperty);
    NSString *lastName = (NSString *)ABRecordCopyValue(record, kABPersonLastNameProperty);
    // NSString *com = (__bridge NSString *)ABRecordCopyValue(record,kABPersonOrganizationProperty);
    NSString *com = (NSString *)ABRecordCopyValue(record,kABPersonOrganizationProperty);
    
    
    if ([com isEqualToString:@"(null)"]||[com isEqualToString:@"null"]||[com isEqualToString:@""]||com==nil||com==NULL)
    {
        com=[[NSString alloc]initWithFormat:@"Not available"];
    }
    else
    {
        
    }
    
    
    ABMultiValueRef PhoneAddRef = ABRecordCopyValue(record, kABPersonPhoneProperty);
    ABMultiValueRef emailAddRef = ABRecordCopyValue(record, kABPersonEmailProperty);
    
    //			int RecordId=(int )ABRecordGetRecordID(record);
    NSString *firstLastName = @"";
    NSMutableArray *PhoneOfPerson=[[NSMutableArray alloc]init];
    NSMutableArray *PhoneTypeOfperson=[[NSMutableArray alloc]init];
    
    NSString *EmailOfPerson =@"";
    if (([lastName length] == 0) && ([firstName length] != 0) )
    {
        firstLastName = firstName;
    }
    else if (([lastName length] != 0) && ([firstName length] == 0))
    {
        firstLastName = lastName;
    }
    else if (([lastName length] == 0) && ([firstName length] == 0))
    {
        firstLastName = @"";
        
    }
    else if (([com length] == 0) && ([com length] == 0))
    {
        com = @"Not available";
        
    }
    
    else
    {
        firstLastName = [firstName stringByAppendingString:[NSString stringWithFormat:@" %@",lastName]];
    }
    
    if((int) ABMultiValueGetCount(PhoneAddRef)>0)
    {
        //PhoneOfPerson=(__bridge NSMutableArray*)ABMultiValueCopyArrayOfAllValues(PhoneAddRef);
        PhoneOfPerson=(NSMutableArray*)ABMultiValueCopyArrayOfAllValues(PhoneAddRef);
        
        
        
        
        
        for(int i=0;i<(int) ABMultiValueGetCount(PhoneAddRef);i++)
        {
            // str=(__bridge NSString*)ABMultiValueCopyLabelAtIndex(PhoneAddRef,i);
            NSString* str=(NSString*)ABMultiValueCopyLabelAtIndex(PhoneAddRef,i);
            str=[str stringByReplacingOccurrencesOfString:@"_" withString:@""];
            str=[str stringByReplacingOccurrencesOfString:@"$" withString:@""];
            str=[str stringByReplacingOccurrencesOfString:@"!" withString:@""];
            str=[str stringByReplacingOccurrencesOfString:@"<" withString:@""];
            str=[str stringByReplacingOccurrencesOfString:@">" withString:@""];
            str=[str stringByReplacingOccurrencesOfString:@"(" withString:@""];
            str=[str stringByReplacingOccurrencesOfString:@")" withString:@""];
            str=[str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            str=[str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            
            [PhoneTypeOfperson addObject:str];
        }
        
    }
    
    if((int) ABMultiValueGetCount(emailAddRef)>0)
        EmailOfPerson=(NSString*)ABMultiValueCopyValueAtIndex(emailAddRef,0);
    //EmailOfPerson=(__bridge NSString*)ABMultiValueCopyValueAtIndex(emailAddRef,0);
    else
        EmailOfPerson=@"";
    
    [dicContactInfo setValue:firstLastName forKey:@"name"];
    [dicContactInfo setObject:PhoneOfPerson forKey:@"phone"];
    [dicContactInfo setObject:PhoneTypeOfperson forKey:@"phoneType"];
    [dicContactInfo setValue:EmailOfPerson forKey:@"email"];
    [dicContactInfo setObject:com forKey:@"company"];
    
    if([[dicContactInfo valueForKey:@"phone"]count]==0 ||  [[[dicContactInfo valueForKey:@"phone"] objectAtIndex:0] isEqualToString:@""] || [[[dicContactInfo valueForKey:@"phone"] objectAtIndex:0] length] == 0)
    {
    }
    else
        [ContactsAddressArray addObject:dicContactInfo];
    //[dicContactInfo release];
    
    
    if(PhoneAddRef){
        
        CFRelease(PhoneAddRef);
    }if(emailAddRef)
    {
        CFRelease(emailAddRef);
    }if(record)
    {
        CFRelease(record);
    }if(firstName)
    {
        CFRelease(firstName);
    }
    if(lastName)
    {
        CFRelease(lastName);
    }if(com)
    {
        CFRelease(com);
    }if(PhoneOfPerson)
    {
        CFRelease(PhoneOfPerson);
    }if(EmailOfPerson)
    {
        CFRelease(EmailOfPerson);
    }
}
NSLog(@"Contacts:%@",ContactsAddressArray);
NSLog(@"Contacts.count:%d",ContactsAddressArray.count);
CFRelease(addresses);

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    if(tableView==contact_adress_table)
    {
    if (searching)
    {
        return 1;
    }
    else
    {
        return 1;
    }
    }else
        return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView==contact_adress_table)
    {
    if (searching)
    {
        return [name_list_items count];
    
    } else
    {
        
    return [contactName_arr count];
    }
    }else if(tableView==facebook_table_view)
    {
        NSLog(@"facebook friend count%i",[frnd_name_fb count]);
           return [frnd_name_fb count];
        //NSLog(@"facebook friend count%i",[_friends count]);
    
    }else
        return 1;
    

    // return [name_arr count];
    
    
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSLog(@"enter in a cell for row at index");
    Add_freind_cell *cell1;
    Facebook_cell *cell;
    
    if(tableView==contact_adress_table){
        
    static NSString *cellIdentifier1 = @"cellIdentifier1";
    
    cell1 = (Add_freind_cell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
    if (cell1 == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Add_freind_cell"
                                                     owner:self options:nil];
        for (id oneObject in nib) if ([oneObject isKindOfClass:[Add_freind_cell class]])
            cell1 = (Add_freind_cell *)oneObject;
    }
    cell1.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    //First get the dictionary object
    if(searching){
        cell1.lbl1.text=[name_list_items objectAtIndex:[indexPath row]];
        
    }else
    {
        NSLog(@"tag9");
    cell1.lbl1.text=[contactName_arr objectAtIndex:[indexPath row]];
    
    }
        
        
       if(b!=0)
       {
        checkBoxAdd_btn=[UIButton buttonWithType:UIButtonTypeCustom];
        checkBoxAdd_btn.tag=indexPath.row;
        NSLog(@"tag1:%d",checkBoxAdd_btn.tag);
        
        checkBoxAdd_btn.frame=CGRectMake(10,18,20,20);
        [checkBoxAdd_btn setImage:[UIImage imageNamed:@"click_new.png"] forState:UIControlStateNormal];
        [cell1.contentView addSubview:checkBoxAdd_btn];
        [checkBoxAdd_btn addTarget:self action:@selector(check_box_click_address:) forControlEvents:UIControlEventTouchUpInside];
        
       }else{
           @try{
           checkBoxAdd_btn=[UIButton buttonWithType:UIButtonTypeCustom];
           checkBoxAdd_btn.tag=indexPath.row;
           NSLog(@"tag2:%d",checkBoxAdd_btn.tag);
           
           checkBoxAdd_btn.frame=CGRectMake(10,18,20,20);
           [checkBoxAdd_btn setImage:[UIImage imageNamed:@"unclick_new.png"] forState:UIControlStateNormal];
           [cell1.contentView addSubview:checkBoxAdd_btn];
           [checkBoxAdd_btn addTarget:self action:@selector(check_box_click_address:) forControlEvents:UIControlEventTouchUpInside];
               NSLog(@"tag6");
               
           }
           @catch (NSException *excep) {
               NSLog(@"ExceptionCatchContacts:%@",excep);
           }
           
       }
        
        NSLog(@"tag7");
        return cell1;
    
    
    }else if (tableView==facebook_table_view)
    {
        
        NSLog(@"enter into cell");
        static NSString *cellIdentifier = @"cellIdentifier ";
        
        cell = (Facebook_cell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil)
        {
            NSLog(@"enter into cell0");
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Facebook_cell"
                                                         owner:self options:nil];
            for (id oneObject in nib) if ([oneObject isKindOfClass:[Facebook_cell class]])
                cell = (Facebook_cell *)oneObject;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSLog(@"enter into cell1");
        NSLog(@"enter into cell value:%@",frnd_name_fb);
        
        if (frnd_name_fb) {
            NSLog(@"enter into cell4");
           // NSDictionary *friend = [fr objectAtIndex:indexPath.row];
            
            cell.lbl1.text = [frnd_name_fb objectAtIndex:indexPath.row];
            cell.accessoryView = nil;
            
            
            if(b!=0)
            {
                checkBox_btn=[UIButton buttonWithType:UIButtonTypeCustom];
                checkBox_btn.tag=indexPath.row;
                NSLog(@"tag3:%d",checkBox_btn.tag);
                
                checkBox_btn.frame=CGRectMake(15,18,20,20);
                [checkBox_btn setImage:[UIImage imageNamed:@"click_new.png"] forState:UIControlStateNormal];
                [cell.contentView addSubview:checkBox_btn];
                [checkBox_btn addTarget:self action:@selector(check_box_click:) forControlEvents:UIControlEventTouchUpInside];
                
            }else{
                checkBox_btn=[UIButton buttonWithType:UIButtonTypeCustom];
                checkBox_btn.tag=indexPath.row;
                NSLog(@"tag4:%d",checkBox_btn.tag);
                
                checkBox_btn.frame=CGRectMake(15,18,20,20);
                [checkBox_btn setImage:[UIImage imageNamed:@"unclick_new.png"] forState:UIControlStateNormal];
                [cell.contentView addSubview:checkBox_btn];
                [checkBox_btn addTarget:self action:@selector(check_box_click:) forControlEvents:UIControlEventTouchUpInside];
                
            }
            
            
            
            
        }
        else {
            
            UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            [activityView startAnimating];
            cell.accessoryView = activityView;
            cell.textLabel.text = @"Loading...";
        }
        //return cell;
       // cell.lbl1.text=[_friends objectAtIndex:[indexPath row]];
        
        /*
        cell.profile_img.clipsToBounds = YES;
        cell.profile_img.layer.cornerRadius=10.0;
        
        cell.profile_img.layer.borderWidth = 1.0;
        
        urlString1 = [NSString stringWithFormat:@"%@",[frd_image_arr objectAtIndex:[indexPath row]]];
        
        
       // NSURL *url1 = [NSURL URLWithString:urlString1];
        
        AsyncImageView1 *imgPhoto = [[AsyncImageView1 alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 52.0f, 52.0f)];
        imgPhoto.layer.masksToBounds = YES;
        imgPhoto.layer.cornerRadius = 10.0;
        imgPhoto.contentMode = UIViewContentModeScaleAspectFill;
        imgPhoto.clipsToBounds = YES;
        imgPhoto.tag = ASYNC_IMAGE_TAG;
        [cell.profile_img  addSubview:imgPhoto];
        
        
        // imgPhoto.layer.cornerRadius = 9;
        
        
        
        
        AsyncImageView1 *imageView1 = (AsyncImageView1 *)[cell viewWithTag:ASYNC_IMAGE_TAG];
        imageView1.layer.masksToBounds = YES;
        // imageView1.layer.cornerRadius =10.0;
        //cancel loading previous image for cell
        [[AsyncImageLoader sharedLoader] cancelLoadingURL:imageView1.imageURL];
        imageView1.imageURL = [NSURL URLWithString:urlString1];
        */
        NSLog(@"enter into cell6");
        return cell;
    }
    
    NSLog(@"tag8");
    
    //return nil;
        
    
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didselect");
    /*
    @try{
        
        chat_id=[[NSString alloc]initWithFormat:@"%@",[user_id objectAtIndex:[indexPath row]]];
        NSLog(@"chat_id string:%@",chat_id);
        //[self performSelector:@selector(delayChat_list) withObject:nil afterDelay:3.0];
        
        Chat_list *chat_list=[[Chat_list alloc]initWithNibName:@"Chat_list" bundle:[NSBundle mainBundle]];
        [self.navigationController pushViewController:chat_list animated:NO];
        
    }
    @catch (NSException *exception) {
        NSLog(@"main exception%@%@%@",[exception name],[exception reason],[exception userInfo]);
    }
     */
    
    //Facebook_cell *FbCellObj = [[Facebook_cell alloc]init];
    
    //[FbCellObj check_btn_fb];
    
    //[FbCellObj Click_checkButton:nil];
    /*
     NSString *addIDS_str =[[NSString alloc]initWithFormat:@"%@",[frnd_id_fb objectAtIndex:[indexPath row]]];
     [selected_ids_fb addObject:addIDS_str];
    
     NSLog(@"selcted_ids_fb:%@",selected_ids_fb);
    
    NSString *namesFB_str =[[NSString alloc]initWithFormat:@"%@",[frnd_name_fb objectAtIndex:[indexPath row]]];
    [selected_names_fb addObject:namesFB_str];
    
    NSLog(@"selcted_names_fb:%@",selected_names_fb);
    */
    //selected_ids_fb = [frnd_id_fb objectAtIndex:[indexPath row]];
    //selected_names_fb = [[NSMutableArray alloc]initWithArray:[frnd_name_fb objectAtIndex:[indexPath row]]];
    
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 45;
	
}

- (void) searchBarTextDidBeginEditing:(UISearchBar *)theSearchBar {
	
	//This method is called again when the user clicks back from teh detail view.
	//So the overlay is displayed on the results, which is something we do not want to happen.
	search_done.hidden=NO;
    if(searching)
        
		return;
	
	
	searching = NO;
	letUserSelectRow = NO;
	contact_adress_table.scrollEnabled = NO;
    NSLog(@"searchBarTextDidBegin5");
    
    // [self searchBarTextDidEndEditing:theSearchBar];
    
    
	
}

- (void)searchBar:(UISearchBar *)theSearchBar textDidChange:(NSString *)searchText {
    
	//Remove all objects first.
    [name_list_items removeAllObjects];
    [number_list_items removeAllObjects];
    [phone_list_items removeAllObjects];
    [email_list_items removeAllObjects];
    [company_list_items removeAllObjects];
    if([searchText length] > 0) {
        
        
        searching = YES;
        letUserSelectRow = YES;
        contact_adress_table.scrollEnabled = YES;
        [self searchTableView];
        NSLog(@"searchBarTextDidBegin1");
    }
    else {
        
        //		[self.tableView insertSubview:ovController.view aboveSubview:self.parentViewController.view];
        
        searching = NO;
        letUserSelectRow = YES;
        contact_adress_table.scrollEnabled = NO;
        NSLog(@"searchBarTextDidBegin2");
        
        
        [self searchBarSearchButtonClicked:nil ];
        
        
        
    }
    
    
    [contact_adress_table reloadData];
    
}
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar1
{
    [searchBar resignFirstResponder];
    return YES;
    NSLog(@"secr button click2");
    
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar1
{
    [searchBar resignFirstResponder];
    [self doneSearching_Clicked:nil];
    
    NSLog(@"secr button click1");
    // [self searchBarSearchButtonClicked:searchBar1];
}
- (void) searchBarSearchButtonClicked:(UISearchBar *)theSearchBar {
    
    //[self searchTableView];
    [searchBar resignFirstResponder];
    // [self searchBarSearchButtonClicked:theSearchBar];
    NSLog(@"secr button click");
    
}
- (void) searchTableView {
    
    NSString *searchText = searchBar.text;
    //for (NSString *sTemp in playemailarr)
    for (int s=0; s<[contactName_arr count]; s++)
    {
        NSString *sTempName = [contactName_arr objectAtIndex:s];
        NSString *sTempNumber = [contactNumber_arr objectAtIndex:s];
        NSString *sTempPhone = [contactPhone_arr objectAtIndex:s];
        NSString *sTempEmail = [contactEmail_arr objectAtIndex:s];
        NSString*sTempCompany= [contactCompany_arr objectAtIndex:s];
        
        
        NSRange titleResultsRange = [sTempName rangeOfString:searchText options:NSCaseInsensitiveSearch];
        if (titleResultsRange.length > 0)
        {
            [name_list_items addObject:sTempName];
            [number_list_items addObject:sTempNumber];
            [phone_list_items addObject:sTempPhone];
            [email_list_items addObject:sTempEmail];
            [company_list_items addObject:sTempCompany];
            
        }
    }
    [contact_adress_table reloadData];
   // NSLog(@"image_list_items:%@",image_list_items);
    
}

- (void) doneSearching_Clicked:(id)sender {
	
	
    //searchBar.text = @"";
	[searchBar resignFirstResponder];
	
	letUserSelectRow = YES;
	searching = NO;
	self.navigationItem.rightBarButtonItem = nil;
	contact_adress_table.scrollEnabled = YES;
	
    //	[ovController.view removeFromSuperview];
    //	[ovController release];
    //	ovController = nil;
	
	//[profile_list_tableView reloadData];
    
    search_done.hidden=YES;
    NSLog(@"searchBarTextDidBegin3");
    
}

-(IBAction)check_box_click:(id)sender
{
	UIButton *tappedButton = (UIButton*)sender;
    int tagValue = tappedButton.tag;
    
  	if([tappedButton.currentImage isEqual:[UIImage imageNamed:@"unclick_new.png"]])
    {
        [tappedButton setImage:[UIImage imageNamed:@"click_new.png"] forState:UIControlStateNormal];
		
        NSString *addIDS_str =[[NSString alloc]initWithFormat:@"%@",[frnd_id_fb objectAtIndex:tagValue]];
        [selected_ids_fb addObject:addIDS_str];
        
        NSLog(@"selcted_ids_fb:%@",selected_ids_fb);
        
        NSString *namesFB_str =[[NSString alloc]initWithFormat:@"%@",[frnd_name_fb objectAtIndex:tagValue]];
        [selected_names_fb addObject:namesFB_str];
        
        NSLog(@"selcted_names_fb:%@",selected_names_fb);
        
        
    }
    
    
	else
	{
		[tappedButton setImage:[UIImage imageNamed:@"unclick_new.png"] forState:UIControlStateNormal];
		
		//[selected_names_fb replaceObjectAtIndex:tagValue withObject:@""];
        //[selected_ids_fb replaceObjectAtIndex:tagValue withObject:@""];
        //int countObj = [selected_ids_fb count];
        int e=0;
        while (e<[selected_ids_fb count]) {
            
            NSString *id_fb_str = [[NSString alloc]initWithFormat:@"%@",[selected_ids_fb objectAtIndex:e]];
            NSString *id_fb_old_str = [[NSString alloc]initWithFormat:@"%@",[frnd_id_fb objectAtIndex:tagValue]];
            
            if([id_fb_str isEqualToString:id_fb_old_str]!=0)
            {
                NSLog(@"enter in if loop:%@",[selected_ids_fb objectAtIndex:e]);
                NSLog(@"enter in if loop tag:%@",[frnd_id_fb objectAtIndex:tagValue]);
                
                [selected_ids_fb removeObjectAtIndex:e];
                [selected_names_fb removeObjectAtIndex:e];
                
            }
            e++;
        }
        
        
        
	}
    
}

-(IBAction)check_box_click_address:(id)sender
{
	UIButton *tappedButton = (UIButton*)sender;
    int tagValue = tappedButton.tag;
    
   	if([tappedButton.currentImage isEqual:[UIImage imageNamed:@"unclick_new.png"]])
    {
        [tappedButton setImage:[UIImage imageNamed:@"click_new.png"] forState:UIControlStateNormal];
		
        NSString *contactname_str =[[NSString alloc]initWithFormat:@"%@",[contactName_arr objectAtIndex:tagValue]];
        [phoneContactname_arr addObject:contactname_str];
        
        NSLog(@"phoneContactname_arr:%@",phoneContactname_arr);
        
        NSString *contactnumb_str =[[NSString alloc]initWithFormat:@"%@",[contactNumber_arr objectAtIndex:tagValue]];
        [phoneContactNum_arr addObject:contactnumb_str];
        
        NSLog(@"phoneContactnum_arr:%@",phoneContactNum_arr);
        
        
    }
    
    
	else
	{
		[tappedButton setImage:[UIImage imageNamed:@"unclick_new.png"] forState:UIControlStateNormal];
		
		//[phoneContactname_arr removeObjectAtIndex:tagValue];
        //[phoneContactNum_arr removeObjectAtIndex:tagValue];
        
        
        
        int u=0;
        while (u<[phoneContactNum_arr count]) {
            
            NSString *phone_contct_str = [[NSString alloc]initWithFormat:@"%@",[phoneContactNum_arr objectAtIndex:u]];
            NSString *phone_contct_old_str = [[NSString alloc]initWithFormat:@"%@",[contactNumber_arr objectAtIndex:tagValue]];
            
            if([phone_contct_str isEqualToString:phone_contct_old_str]!=0)
            {
                NSLog(@"enter in if loop phone:%@",[phoneContactNum_arr objectAtIndex:u]);
                NSLog(@"enter in if loop phone tag:%@",[contactNumber_arr objectAtIndex:tagValue]);
                
                [phoneContactname_arr removeObjectAtIndex:u];
                [phoneContactNum_arr removeObjectAtIndex:u];
                
            }
            u++;
        }
        
        
        
	}
    
}




/*
-(void)inviteFreind_click:(id)sender
{
    
    
    
    
    NSArray *email_arr1=[[NSArray alloc]initWithObjects:emailshow,nil];
    
    
    MFMailComposeViewController *mailController = [[MFMailComposeViewController alloc] init];
    
    mailController.mailComposeDelegate = self;
    
    [mailController setSubject:@"Cool new iPhone app."];
    
    
    
    
    NSString *emailBody = [NSString stringWithFormat:@"Iphone app"];
    
    [mailController setMessageBody:emailBody isHTML:YES];
    [mailController setToRecipients:email_arr1];
    
    [self presentModalViewController:mailController animated:YES];
    
    [mailController release];
    
    NSLog(@"sdslkjflajljfla");
    
    
}
*/
-(IBAction)connectclick:(UIButton*)sender
{
    // fbimage=nil;
    UIButton *tapped_btn=(UIButton*)sender;
    int indx=tapped_btn.tag;
    
    id_select=[[NSString alloc]initWithFormat:@"%@",[frd_id_arr objectAtIndex:indx]];
    name_select=[[NSString alloc]initWithFormat:@"%@",[frd_name_arr objectAtIndex:indx]];
    image_select=[[NSString alloc]initWithFormat:@"%@",[frd_image_arr objectAtIndex:indx]];
    fbname_lbl.text=name_select;
    NSLog(@"image_select:%@",image_select);
    NSLog(@"name_select:%@",name_select);
    
    
    // [self show_view];
    AsyncImageView1 *imgPhoto = [[AsyncImageView1 alloc] initWithFrame:CGRectMake(0.0f, -0.0f, 50.0f, 55.0f)];
    imgPhoto.contentMode = UIViewContentModeScaleAspectFill;
    imgPhoto.clipsToBounds = YES;
    imgPhoto.tag = ASYNC_IMAGE_TAG;
    [share_view  addSubview:imgPhoto];
    // imgPhoto.layer.cornerRadius = 9;
    
    AsyncImageView1 *imageView1 = (AsyncImageView1 *)[fbimage viewWithTag:ASYNC_IMAGE_TAG];
    //cancel loading previous image for cell
    [[AsyncImageLoader sharedLoader] cancelLoadingURL:imageView1.imageURL];
    imageView1.imageURL = [NSURL URLWithString:image_select];
    
    
    [self facebookcall];
    // [self performSelector:@selector(stopAnimating:) withObject:ac afterDelay:1.0];
}

-(IBAction)connectclick1:(UIButton*)sender

{
    
}
- (void)mailComposeController:(MFMailComposeViewController*)mailController didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error

{
    
    [self becomeFirstResponder];
    
    [self dismissModalViewControllerAnimated:YES];
    
}


-(void)stopAnimating:(UIActivityIndicatorView*)ac1

{
    [ac1 stopAnimating];
}

-(void)show_view
{
    share_view.alpha=0.0;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1.0];
    share_view.alpha=1.0;
    [UIView commitAnimations];
    
}
-(IBAction)invite
{
    
    NSString *str1=[[NSString alloc]initWithFormat:@"%@, sent you the request",fname];
    NSLog(@"str1:%@",str1);
    
    NSString *stri = [NSString stringWithFormat:@"/%@/feed",id_select];
    NSLog(@"stri:%@",stri);
    
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   kAppId, @"app_id",
                                   @"https://www.google.co.in/", @"link",
                                   @"iDate", @"name",
                                   @"Cool,new iPhone App", @"caption",
                                   fname, @"description",
                                   id_select, @"to",
                                   nil];
    
    NSLog(@"paramds:%@",params);
    
    [_facebook dialog:@"feed" andParams:params andDelegate:self];
    
    
    [self hide_view];
}
-(void)hide_view
{
    share_view.alpha=1.0;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1.0];
    share_view.alpha=0.0;
    [UIView commitAnimations];
    
    
}
-(void)read_fb_profile
{
    frd_id_arr = [[NSMutableArray alloc]init];
	frd_name_arr= [[NSMutableArray alloc]init];
	frd_image_arr =[[NSMutableArray alloc]init];
	
    //	UIImage *friendimage;
	// Open the database from the users filessytem
	//		// Setup the SQL Statement and compile it for faster access
	NSString *query = [[NSString alloc] initWithString:@"select distinct frd_id,frd_name,frd_image from freinds_profile ORDER BY frd_name"];
	sqlite3_stmt *stmt;
	int x = sqlite3_prepare_v2(database,[query UTF8String],-1, &stmt, nil);
	if (x == SQLITE_OK)
	{
		// Loop through the results and add them to the feeds array
		//if(sqlite3_step(stmt)==SQLITE_ROW)
		while(sqlite3_step(stmt) == SQLITE_ROW)
		{
			// Read the data from the result row
			NSString *friendid1 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 0)];
            NSString *friendimg = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 1)];
			NSString *friendname = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 2)];
            
			[frd_id_arr addObject:friendid1];
			[frd_name_arr addObject:friendname];
			[frd_image_arr addObject:friendimg];
			
			
		}
	}
	// Release the compiled statement from memory
	sqlite3_finalize(stmt);
	
    
    if ([frd_id_arr count]==0)
    {
        
    }
    
    else
    {
        
        [facebook_table_view reloadData];
    }
    
	NSLog(@"recnoData:%@",frd_id_arr);
    
	NSLog(@"bookData1:%@",frd_name_arr);
	NSLog(@"recnoData2:%@",frd_image_arr);
	
    
}
-(IBAction)facebook_frd
{
    
    contact_adress_table.hidden=YES;
    facebook_table_view.hidden=NO;
    
}
-(IBAction)Contact_frd
{
    
    contact_adress_table.hidden=NO;
    facebook_table_view.hidden=YES;
    
    
}


- (IBAction)getLatLongClick:(id)sender {
    
    
}

- (IBAction)click_msg_chatWindow:(id)sender {
    
    Chat_view *chatView = [[Chat_view alloc]initWithNibName:@"Chat_view" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:chatView animated:YES];

    
}
- (void)dealloc {
    [contact_adress_table release];
    [search_done release];
    [facebook_table_view release];
    [checked_done_click release];
    [phone_addres_btn release];
    [select_Deselect_btn release];
    [global_msg_btn release];
    [checkBox_btn release];
    [super dealloc];
}
- (void)viewDidUnload {
    [contact_adress_table release];
    contact_adress_table = nil;
    [search_done release];
    search_done = nil;
    [facebook_table_view release];
    facebook_table_view = nil;
    [checked_done_click release];
    checked_done_click = nil;
    [phone_addres_btn release];
    phone_addres_btn = nil;
    [select_Deselect_btn release];
    select_Deselect_btn = nil;
    [global_msg_btn release];
    global_msg_btn = nil;
    [super viewDidUnload];
}
- (IBAction)post_invitFrnds:(id)sender {
   
    NSLog(@"enter into post_invite");
    friendsFB = [[NSMutableArray alloc]init];
   // NSMutableDictionary *addFrnds = [[NSMutableDictionary alloc]init];
    
    NSLog(@"enter into post_invite1");
    for(int c=0;c<[selected_ids_fb count];c++)
    {
        
        NSLog(@"enter into post_invite2");
        
        NSString *getID = [[NSString alloc]initWithFormat:@"%@",[selected_ids_fb objectAtIndex:c]];
        NSLog(@"enter into post_invite3:%@",getID);
        
        [suggested_frnds addObject:getID];
        NSLog(@"enter into if in post");
        
}
    
       NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:  kAppId, @"app_id",
                                   @"https://www.google.co.in/", @"link",
                                   @"iDate", @"name",
                                   @"Cool, new iPhone App", @"caption",
                                   @"My Title", @"title",
                                   @"Check this app out...",  @"message",
                                   [suggested_frnds componentsJoinedByString:@","], @"to",
                                   nil];
    
    NSLog(@"enter into post_invite8:%@",params);
    
    //[self.facebook dialog:@"apprequests" andParams:params andDelegate:nil];
    
    [self.facebook dialog:@"stream.publish" andParams:params andDelegate:nil];
}

- (IBAction)selectCheckAll:(id)sender {
    
    
    
    UIButton *tappedButton = (UIButton*)sender;
    int tagValue = tappedButton.tag;
    
  	if(tagValue == 0)
    {
        //[checkBox_btn setImage:[UIImage imageNamed:@"click_new.png"] forState:UIControlStateNormal];
        for(int d=0;d<[frnd_id_fb count];d++)
        {
            b=d;
        [checkBox_btn setImage:[UIImage imageNamed:@"click_new.png"] forState:UIControlStateNormal];
		
        NSString *addIDS_str =[[NSString alloc]initWithFormat:@"%@",[frnd_id_fb objectAtIndex:d]];
        [selected_ids_fb addObject:addIDS_str];
        
        NSLog(@"selcted_ids_fb:%@",selected_ids_fb);
        
        NSString *namesFB_str =[[NSString alloc]initWithFormat:@"%@",[frnd_name_fb objectAtIndex:d]];
        [selected_names_fb addObject:namesFB_str];
        
        NSLog(@"selcted_names_fb:%@",selected_names_fb);
        }
        [facebook_table_view reloadData];
        [select_Deselect_btn setTitle:@"DeselectAll" forState:UIControlStateNormal];
        [select_Deselect_btn setTag:1];
        
    }
    
    
	else if(tagValue ==1)
	{
        b=0;
        //[checkBox_btn setImage:[UIImage imageNamed:@"unclick_new.png"] forState:UIControlStateNormal];
        
        for (int g=0; g<[frnd_id_fb count]; g++) {
          [checkBox_btn setImage:[UIImage imageNamed:@"unclick_new.png"] forState:UIControlStateNormal];  
        
           
		
		int e=0;
        while (e<[selected_ids_fb count]) {
            
            NSString *id_fb_str = [[NSString alloc]initWithFormat:@"%@",[selected_ids_fb objectAtIndex:e]];
            NSString *id_fb_old_str = [[NSString alloc]initWithFormat:@"%@",[frnd_id_fb objectAtIndex:g]];
            
            if([id_fb_str isEqualToString:id_fb_old_str]!=0)
            {
                NSLog(@"enter in if loop:%@",[selected_ids_fb objectAtIndex:e]);
                NSLog(@"enter in if loop tag:%@",[frnd_id_fb objectAtIndex:g]);
                
                [selected_ids_fb removeObjectAtIndex:e];
                [selected_names_fb removeObjectAtIndex:e];
                
            }
            e++;
        }
        }
        [facebook_table_view reloadData];
        [select_Deselect_btn setTitle:@"SelectAll" forState:UIControlStateNormal];
        [select_Deselect_btn setTag:0];

        
	} else if(tagValue==2)
    {
        
            //[checkBoxAdd_btn setImage:[UIImage imageNamed:@"click_new.png"] forState:UIControlStateNormal];
        
        for (int h=0; h<[contactNumber_arr count]; h++) {
            
           // checkBoxAdd_btn.tag =h;
           
            b=h;
            
            //[checkBoxAdd_btn setImage:[UIImage imageNamed:@"click_new.png"] forState:UIControlStateSelected];
            
        [checkBoxAdd_btn setImage:[UIImage imageNamed:@"click_new.png"] forState:UIControlStateNormal];
            
            NSString *contactname_str =[[NSString alloc]initWithFormat:@"%@",[contactName_arr objectAtIndex:h]];
            
            [phoneContactname_arr addObject:contactname_str];
            
            NSLog(@"phoneContactname_arr:%@",phoneContactname_arr);
            
            NSString *contactnumb_str =[[NSString alloc]initWithFormat:@"%@",[contactNumber_arr objectAtIndex:h]];
            
            [phoneContactNum_arr addObject:contactnumb_str];
            
            NSLog(@"phoneContactnum_arr:%@",phoneContactNum_arr);
        
            
            }
        [contact_adress_table reloadData];
        [select_Deselect_btn setTitle:@"DeselectAll" forState:UIControlStateNormal];
        [select_Deselect_btn setTag:3];
        
        }
        
        
        else if(tagValue==3)
        {
            //[checkBoxAdd_btn setImage:[UIImage imageNamed:@"unclick_new.png"] forState:UIControlStateNormal];
            
            b=0;
            
            for (int a=0; a<[contactNumber_arr count]; a++) {
                
            
            [checkBoxAdd_btn setImage:[UIImage imageNamed:@"unclick_new.png"] forState:UIControlStateNormal];
            int u=0;
            while (u<[phoneContactNum_arr count]) {
                
                NSString *phone_contct_str = [[NSString alloc]initWithFormat:@"%@",[phoneContactNum_arr objectAtIndex:u]];
                NSString *phone_contct_old_str = [[NSString alloc]initWithFormat:@"%@",[contactNumber_arr objectAtIndex:a]];
                
                if([phone_contct_str isEqualToString:phone_contct_old_str]!=0)
                {
                    NSLog(@"enter in if loop phone:%@",[phoneContactNum_arr objectAtIndex:u]);
                    NSLog(@"enter in if loop phone tag:%@",[contactNumber_arr objectAtIndex:a]);
                    
                    [phoneContactname_arr removeObjectAtIndex:u];
                    [phoneContactNum_arr removeObjectAtIndex:u];
                    
                }
                u++;
            }
            }
            [contact_adress_table reloadData];
            [select_Deselect_btn setTitle:@"SelectAll" forState:UIControlStateNormal];
            [select_Deselect_btn setTag:2];

            
        }
    
}

- (IBAction)checked_done_click:(id)sender {
    
    friendsFB = [[NSMutableArray alloc]init];
    for(int c=0;c<[selected_names_fb count];c++)
    {
        NSString *getID = [[NSString alloc]initWithFormat:@"%@",[selected_ids_fb objectAtIndex:c]];
        NSString *getNames = [[NSString alloc]initWithFormat:@"%@",[selected_names_fb objectAtIndex:c]];
        
        NSString *appendFrnds = [getID stringByAppendingString:getNames];
        
        [friendsFB addObject:appendFrnds];
        
        NSDictionary *addFrnds = [friendsFB objectAtIndex:c];
        
        
        NSString *to = [addFrnds objectForKey:@"id"];
        NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       @"Check this app out...",  @"message",
                                       to, @"to",
                                       nil];
        [self.facebook dialog:@"apprequests" andParams:params andDelegate:nil];

    }
    
    
    
    
}
@end
