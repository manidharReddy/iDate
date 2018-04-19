//
//  Freinds_view.m
//  iDate
//
//  Created by D M R on 28/09/12.
//  Copyright (c) 2012 iHubTechnologies. All rights reserved.
//

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
#import "Add_freind_cell.h"
#import <AddressBook/AddressBook.h>
#define ASYNC_IMAGE_TAG 9999
#define FONT_SIZE 18.0f
#define CELL_CONTENT_WIDTH 320.0f
#define CELL_CONTENT_MARGIN 10.0f
//#define USING_ARC 1
static NSString* kAppId = @"438746826175336";
@interface Freinds_view ()

@end

@implementation Freinds_view
@synthesize logoutView = _logoutView,loginView  = _loginView,headerView = _headerView,addRunView = _addRunView,myRunController = _myRunController;
@synthesize managedObjectContext;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
//        self.title = NSLocalizedString(@"Connect", @"Connect");
//        self.tabBarItem.image = [UIImage imageNamed:@"connectmenu"];
        
        NSLog(@"enter in nibname");
        
        _permissions =  [[NSArray arrayWithObjects: 
						  @"publish_stream",@"read_stream", @"offline_access",@"friends_events",@"friends_birthday",@"email",@"read_mailbox",@"share_item",@"publish_actions",nil] retain];
        
        NSLog(@"exit in nibname");
    
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
        [self  FbFriendWallPostCall];
    }
    
    //  [self performSelector:@selector(FbFriendWallPostCall) withObject:nil afterDelay:0.1 ];
}

/**
 * FBSessionDelegate
 */ 

-(IBAction)shareButtonClick:(id)sender{
    
    
    
}

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
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message post" message:@"Message is posted" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [alert release]; 
}

-(void)delay
{
    string_contact = [[NSString alloc]init];
    array_name = [[NSMutableArray alloc]init];
    array_phoneNum = [[NSMutableArray alloc]init];
    sections = [[NSMutableDictionary alloc] init];
   [self GetContactInformation];
    
    
    BOOL found;
    
    // Loop through the books and create our keys
    for (NSDictionary *book in ContactsAddressArray)
    {
        @try
        {
            NSString *c = [[book objectForKey:@"name"] substringToIndex:1];
            NSLog(@"C:%@",c);
            
            found = NO;
            
            for (NSString *str in [sections allKeys])
            {
            
                if ([str isEqualToString:c])
                {
                    
                    found = YES;
                }
            }
            
            if (!found)
            {
                [sections setValue:[[NSMutableArray alloc] init] forKey:c];
            }
        
        }
        @catch (NSException *exception)
        {
            NSLog(@"Exception name:%@ || Exception Reason:%@",[exception name],[exception reason]);
        }
    }
    
    // Loop again and sort the books into their respective keys
    for (NSDictionary *book in ContactsAddressArray)
    {
        @try{
            [[sections objectForKey:[[book objectForKey:@"name"] substringToIndex:1]] addObject:book];
        }
        @catch (NSException *exception)
        {
            NSLog(@"Exception name:%@ || Exception Reason:%@",[exception name],[exception reason]);
        }
    }
    
    // Sort each section array
    for (NSString *key in [sections allKeys])
    {
        
        [[sections objectForKey:key] sortUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]]];
    }
    
    [add_btk_tbl reloadData];
    
    // [self read_fb_profile];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    email_arr=[[NSMutableArray alloc]init];
  date_frds_tbl.hidden=YES;
//    share_view.frame=CGRectMake(0,0,320, 480);
//    [self.view addSubview:share_view];
//    share_view.alpha=0.0;
     NSLog(@"enter in viewdidload");
   
     [self delay];
    // Do any additional setup after loading the view from its nib.
}

-(void)GetContactInformation
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
    



    


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"enter in numberofrowsinsection");
    if (tableView==add_btk_tbl)
    {
        NSLog(@"enter if in add_btk_tbl ");
        return [[sections valueForKey:[[[sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:section]] count];
        NSLog(@"exit in if");

    }
    
    else if (tableView==date_frds_tbl)
    {
        NSLog(@"enter if in date_frds_tbl ");
        return [frd_name_arr count];
        NSLog(@"enter if in frd_name_arr ");
       }else
           return 0;
    
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView==add_btk_tbl) {
        NSLog(@"enter if in   title date_frds_tbl ");
         return [[[sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:section];
    NSLog(@"exit if in date_frds_tbl ");
    }
    else
        return 0;

  


}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (tableView==add_btk_tbl) {
    return [[sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    }
    
    else
        return 0;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    NSLog(@"enter in cellfor row at index ");
    Facebook_cell *cell;
    Add_freind_cell *cell1;

    if (tableView==date_frds_tbl)
    {
        NSLog(@"enter if in cell for date_frds_tbl ");
        static NSString *cellIdentifier = @"cellIdentifier ";
        
        cell = (Facebook_cell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Facebook_cell"
                                                         owner:self options:nil];
            for (id oneObject in nib) if ([oneObject isKindOfClass:[Facebook_cell class]])
                cell = (Facebook_cell *)oneObject;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.lbl1.text=[frd_name_arr objectAtIndex:[indexPath row]];
        cell.profile_img.clipsToBounds = YES;
        cell.profile_img.layer.cornerRadius=10.0;
        
        cell.profile_img.layer.borderWidth = 1.0;
        urlString1 = [NSString stringWithFormat:@"%@",[frd_image_arr objectAtIndex:[indexPath row]]];
        
        
        NSURL *url1 = [NSURL URLWithString:urlString1];
        NSLog(@"url1:%@",url1);
        
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
        
        
        
      
        
//        checkBox=[UIButton buttonWithType:UIButtonTypeCustom];
//        checkBox.tag=indexPath.row;
//        NSLog(@"tag:%d",checkBox.tag);
//        
//        checkBox.frame=CGRectMake(235,25,56,22);
//        [checkBox setImage:[UIImage imageNamed:@"frd_invite.png"] forState:UIControlStateNormal];
//        [cell.contentView addSubview:checkBox];
//        [checkBox addTarget:self action:@selector(connectclick:) forControlEvents:UIControlEventTouchUpInside];
//        
       

    }
    else if(tableView==add_btk_tbl)
    {
        NSLog(@"enter if in cell for else date_frds_tbl ");
        static NSString *CellIdentifier1 = @"Cell1";
        
        cell1 = (Add_freind_cell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
        if (cell1 == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Add_freind_cell"
                                                         owner:self options:nil];
            for (id oneObject in nib) if ([oneObject isKindOfClass:[Add_freind_cell class]])
                cell1 = (Add_freind_cell *)oneObject;
        }
        NSDictionary *book = [[sections valueForKey:[[[sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
        NSLog(@"book:%@",book);
     
        //cell1._delegate=self;
        
        
        //cell1.check_btn.tag=indexPath.row;
        
         NSLog(@"tag123:%d",cell1.check_btn.tag);
        
        cell1.selectionStyle=UITableViewCellSelectionStyleNone;

        NSString *eamil_str=[[NSString alloc]initWithFormat:@"%@",[book objectForKey:@"email"]];
        [email_arr addObject:eamil_str];
       cell1.lbl1.text= [book objectForKey:@"name"];
         return cell1;
         
    
    }
   
 return cell;
  }

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    NSDictionary *book = [[sections valueForKey:[[[sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
    
    NSString *strshow = [book objectForKey:@"company"];
    NSLog(@"strshow:%@",strshow);
    
    NSString *strshow1 = [book objectForKey:@"name"];
    NSLog(@"strshow1:%@",strshow1);
    
    
    NSArray *strshow2 = [book objectForKey:@"phone"];
    NSLog(@"strshow2:%@",strshow2);
    
    
    
    
    NSString *strshow3 = [book objectForKey:@"email"];
    NSLog(@"strshow3:%@",strshow3);
    
    
    
    string_contact = [[NSString alloc]initWithFormat:@"%@",cell.detailTextLabel.text];
    //string_contact = [string_contact stringByAppendingFormat:@"%@,",cell.detailTextLabel.text];
    [string_contact retain];
    
    NSLog(@"string:%@",string_contact);
    
    nameshow=[[NSString alloc]initWithFormat:@"%@",strshow1];
    phoneshow=[[NSString alloc]initWithFormat:@"%@",[strshow2 objectAtIndex:0]];
    companyshow=[[NSString alloc]initWithFormat:@"%@",strshow];
    NSLog(@"companyshow:%@",companyshow);
    
    emailshow=[[NSString alloc]initWithFormat:@"%@",strshow3];
    
    NSLog(@"emailshow:%@",emailshow);
    
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView==add_btk_tbl) {
       // return 1;
       return [[sections allKeys] count];

    }
    else if(tableView==add_btk_tbl)
    {
    return 1;
    }
    return 1;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView==add_btk_tbl) {
        NSString *string = [[[sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:section];
        //red_strip
        UILabel *title1 = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 280, 24)];
        title1.text = string;
        title1.backgroundColor = [UIColor clearColor];
        title1.font = [UIFont fontWithName:@"Helvetica-Bold" size:12.0];
        
        UIView *headerView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 28)] autorelease];
        headerView.backgroundColor  =[UIColor clearColor];
        UIImage *headerimg =  [UIImage imageNamed:@"profile_bg.png"];
        UIImageView *headerimage =[[UIImageView alloc] initWithFrame:CGRectMake(0.0,-1.0, 320.0, 28.0)];
        
        headerimage.image =headerimg;
        [headerimage addSubview:title1];
        [headerView addSubview:headerimage];
        return headerView;

    }
    else
    {
    
    }
    return nil;
    
}
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
-(IBAction)btn_tap:(id)sender
{
    UIButton *tappedButton = (UIButton*)sender;
	
	if (tappedButton==fb_frd_btn)
	{
		[fb_frd_btn setImage:[UIImage imageNamed:@"facebook_frd.png"] forState:UIControlStateNormal];
		[contact_frd_btn setImage:[UIImage imageNamed:@"contact_frd.png"] forState:UIControlStateNormal];
        date_frds_tbl.hidden=NO;
        add_btk_tbl.hidden=YES;
	        
	}
	
	else
	{
		[fb_frd_btn setImage:[UIImage imageNamed:@"facebook1_frd.png"] forState:UIControlStateNormal];
		[contact_frd_btn setImage:[UIImage imageNamed:@"contact1_frd.png"] forState:UIControlStateNormal];
        add_btk_tbl.hidden=NO;
        date_frds_tbl.hidden=YES;

        
    }
    
}


-(IBAction)close_view
{
    [self hide_view];


}
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 63;
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
       
     [date_frds_tbl reloadData];
    }
    
	NSLog(@"recnoData:%@",frd_id_arr);
    
	NSLog(@"bookData1:%@",frd_name_arr);
	NSLog(@"recnoData2:%@",frd_image_arr);
	
   
}
-(IBAction)facebook_frd
{

    add_btk_tbl.hidden=YES;
    date_frds_tbl.hidden=NO;
    
}
-(IBAction)Contact_frd
{

    add_btk_tbl.hidden=NO;
    date_frds_tbl.hidden=YES;
    

}
-(IBAction)mneu_page
{
    Menupage *menu=[[Menupage alloc]initWithNibName:@"Menupage" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:menu animated:NO];

}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if(interfaceOrientation == UIInterfaceOrientationPortrait)
    {
        return YES;
    }
    else if(interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


@end
