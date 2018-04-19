//
//  User_list.m
//  iDate
//
//  Created by D M R on 23/08/12.
//  Copyright (c) 2012 iHubTechnologies. All rights reserved.
//

#import "User_list.h"
#import "MBProgressHUD.h"
#import "Friend_cell.h"
#import "AsyncImageView.h"
#import "Profile_view.h"
#import "AppDelegate.h"
#import "Menupage.h"
#import "JSON.h"
#define ASYNC_IMAGE_TAG 9999
#define LABEL_TAG 8888
@interface User_list ()

@end

@implementation User_list

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading users...";
    
    [self performSelector:@selector(profile_json_call) withObject:nil afterDelay:3.0];
   
    name_arr=[[NSMutableArray alloc]init];
    image_arr=[[NSMutableArray alloc]init];
    age_arr=[[NSMutableArray alloc]init];
    id_arr=[[NSMutableArray alloc]init];
    gender_arr=[[NSMutableArray alloc]init];
    race_arr=[[NSMutableArray alloc]init];
    gender_image_arr=[[NSMutableArray alloc]init];
    
    listOfItems = [[NSMutableArray alloc] init];

    
    NSDictionary *countriesToLiveInDict = [NSDictionary dictionaryWithObject:name_arr forKey:@"name"];
    
    //NSArray *countriesLivedInArray = [NSArray arrayWithObjects:@"India", @"U.S.A", nil];
    NSDictionary *countriesLivedInDict = [NSDictionary dictionaryWithObject:name_arr forKey:@"name"];
    
    [listOfItems addObject:countriesToLiveInDict];
    [listOfItems addObject:countriesLivedInDict];
    
    //Initialize the copy array.
    copyListOfItems = [[NSMutableArray alloc] init];
    
    //Set the title
    //self.navigationItem.title = @"Countries";
    
    //Add the search bar
    profile_tbl.tableHeaderView = searchBar;
    searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    
    searching = NO;
    letUserSelectRow = YES;
    

    // Do any additional setup after loading the view from its nib.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
  
        if (searching)
            return 1;
        else
            return [listOfItems count];
        
   }

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (searching)
        return [copyListOfItems count];
    else {
        
        //Number of rows it should expect should be based on the section
        NSDictionary *dictionary = [listOfItems objectAtIndex:section];
        NSArray *array = [dictionary objectForKey:@"name"];
        return [array count];
    }
 
       // return [name_arr count];
   
    
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
  
    Friend_cell *cell1;
  
   
             
        static NSString *cellIdentifier1 = @"cellIdentifier1";
        
        cell1 = (Friend_cell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
        if (cell1 == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Friend_cell"
                                                         owner:self options:nil];
            for (id oneObject in nib) if ([oneObject isKindOfClass:[Friend_cell class]])
                cell1 = (Friend_cell *)oneObject;
        }		
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        
    if(searching) {
        cell1.lbl1.text = [copyListOfItems objectAtIndex:indexPath.row];
        
        cell1.lbl2.text=[age_arr objectAtIndex:[indexPath row]];
        
        
        
        NSString *gender_image_string=[[NSString alloc]initWithFormat:@"%@",[gender_arr objectAtIndex:[indexPath row]]];
        
        
        if ([gender_image_string isEqualToString:@"0"])
        {
            str_profile_image=[[NSString alloc]initWithFormat:@"http://192.168.0.111/Dating/images/NoPhotoFemale.jpg"];
            cell1.gender_image.image=[UIImage imageNamed:@"female_icon.png"];
            
        }
        
        else
        {
            str_profile_image=[[NSString alloc]initWithFormat:@"http://192.168.0.111/Dating/images/NoPhotoMale.jpg"];
            cell1.gender_image.image=[UIImage imageNamed:@"male_icon.png"];
        }
        NSString *urlString1 = [NSString stringWithFormat:@"%@",str_profile_image];
        NSURL *url1 = [NSURL URLWithString:urlString1];
        
        //============== for big img ===========////////
        CGRect frame;
        frame.origin.x = 4;
        frame.origin.y = 7;
        frame.size.width = 30;
        frame.size.height = 30;
        
        AsyncImageView *asyncImageView = [[[AsyncImageView alloc] initWithFrame:frame] autorelease];
        asyncImageView.tag = ASYNC_IMAGE_TAG;
        //[cell1.profile_img addSubview:asyncImageView];
        [asyncImageView loadImageFromURL:url1];
        
        cell1.ethinicity_lbl.text=[race_arr objectAtIndex:[indexPath row]];
    }
    else 
        
    {
        
        //First get the dictionary object
        NSDictionary *dictionary = [listOfItems objectAtIndex:indexPath.section];
        NSArray *array = [dictionary objectForKey:@"name"];
        NSString *cellValue = [array objectAtIndex:indexPath.row];
        cell1.lbl1.text=cellValue;
        
        cell1.lbl2.text=[age_arr objectAtIndex:[indexPath row]];
        
        
        
        NSString *gender_image_string=[[NSString alloc]initWithFormat:@"%@",[gender_arr objectAtIndex:[indexPath row]]];
        
        
        if ([gender_image_string isEqualToString:@"0"])
        {
            str_profile_image=[[NSString alloc]initWithFormat:@"http://192.168.0.111/Dating/images/NoPhotoFemale.jpg"];
            cell1.gender_image.image=[UIImage imageNamed:@"female_icon.png"];
            
        }
        
        else
        {
            str_profile_image=[[NSString alloc]initWithFormat:@"http://192.168.0.111/Dating/images/NoPhotoMale.jpg"];
            cell1.gender_image.image=[UIImage imageNamed:@"male_icon.png"];
        }
        NSString *urlString1 = [NSString stringWithFormat:@"%@",str_profile_image];
        NSURL *url1 = [NSURL URLWithString:urlString1];
        
        //============== for big img ===========////////
        CGRect frame;
        frame.origin.x = 4;
        frame.origin.y = 7;
        frame.size.width = 30;
        frame.size.height = 30;
        
        AsyncImageView *asyncImageView = [[[AsyncImageView alloc] initWithFrame:frame] autorelease];
        asyncImageView.tag = ASYNC_IMAGE_TAG;
        //  [cell1.profile_img addSubview:asyncImageView];
        [asyncImageView loadImageFromURL:url1];
        
        cell1.ethinicity_lbl.text=[race_arr objectAtIndex:[indexPath row]];
        //cell.text = cellValue;
    }

        
        
         
    return cell1;

    }


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==profile_tbl)
    {
        view_profile_bool=TRUE;
        global_string=[[NSString alloc]initWithFormat:@"%@",[id_arr objectAtIndex:[indexPath row]]];
        
        Profile_view *preview=[[Profile_view alloc]initWithNibName:@"Profile_view" bundle:[NSBundle mainBundle]];
        [self.navigationController pushViewController:preview animated:NO];
        
    }
    else
    {
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
	  return 63;
	
}
#pragma mark Search Bar 

- (void) searchBarTextDidBeginEditing:(UISearchBar *)theSearchBar {
	
	//This method is called again when the user clicks back from teh detail view.
	//So the overlay is displayed on the results, which is something we do not want to happen.
	if(searching)
		return;
	
	//Add the overlay view.
    //	if(ovController == nil)
    //		ovController = [[OverlayViewController alloc] initWithNibName:@"OverlayView" bundle:[NSBundle mainBundle]];
	
    //	CGFloat yaxis = self.navigationController.navigationBar.frame.size.height;
    //	CGFloat width = self.view.frame.size.width;
    //	CGFloat height = self.view.frame.size.height;
	
	//Parameters x = origion on x-axis, y = origon on y-axis.
    //	CGRect frame = CGRectMake(0, yaxis, width, height);
    //	ovController.view.frame = frame;	
    //	ovController.view.backgroundColor = [UIColor grayColor];
    //	ovController.view.alpha = 0.5;
    //	
    //	ovController.rvController = self;
    //	
    //	[self.tableView insertSubview:ovController.view aboveSubview:self.parentViewController.view];
	
	searching = YES;
	letUserSelectRow = NO;
	profile_tbl.scrollEnabled = NO;
	
	//Add the done button.
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] 
                                               initWithBarButtonSystemItem:UIBarButtonSystemItemDone 
                                               target:self action:@selector(doneSearching_Clicked:)] autorelease];
}

- (void)searchBar:(UISearchBar *)theSearchBar textDidChange:(NSString *)searchText {
    
	//Remove all objects first.
	[copyListOfItems removeAllObjects];
	
	if([searchText length] > 0) {
		
		
		searching = YES;
		letUserSelectRow = YES;
		profile_tbl.scrollEnabled = YES;
		[self searchTableView];
	}
	else {
		
        //		[self.tableView insertSubview:ovController.view aboveSubview:self.parentViewController.view];
		
		searching = NO;
		letUserSelectRow = NO;
		profile_tbl.scrollEnabled = NO;
	}
	
	[profile_tbl reloadData];
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)theSearchBar {
	
	[self searchTableView];
     [searchBar resignFirstResponder];
}

- (void) searchTableView {
	
	NSString *searchText = searchBar.text;
	NSMutableArray *searchArray = [[NSMutableArray alloc] init];
	
	for (NSDictionary *dictionary in listOfItems)
	{
		NSArray *array = [dictionary objectForKey:@"name"];
		[searchArray addObjectsFromArray:array];
	}
	
	for (NSString *sTemp in searchArray)
	{
		NSRange titleResultsRange = [sTemp rangeOfString:searchText options:NSCaseInsensitiveSearch];
		
		if (titleResultsRange.length > 0)
			[copyListOfItems addObject:sTemp];
	}
	
	[searchArray release];
	searchArray = nil;
}

- (void) doneSearching_Clicked:(id)sender {
	
	searchBar.text = @"";
	[searchBar resignFirstResponder];
	
	letUserSelectRow = YES;
	searching = NO;
	self.navigationItem.rightBarButtonItem = nil;
	profile_tbl.scrollEnabled = YES;
	
    //	[ovController.view removeFromSuperview];
    //	[ovController release];
    //	ovController = nil;
	
	[profile_tbl reloadData];
}

-(void)profile_json_call
{
    
    
     NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
    //[activity show];
    // http://192.168.0.111/Dating/Uploads/2_572216_datee_TN.jpg
    
    name_arr=[[NSMutableArray alloc]init];
    image_arr=[[NSMutableArray alloc]init];
    age_arr=[[NSMutableArray alloc]init];
    id_arr=[[NSMutableArray alloc]init];
    gender_arr=[[NSMutableArray alloc]init];
    race_arr=[[NSMutableArray alloc]init];
    gender_image_arr=[[NSMutableArray alloc]init];
    
    NSString *str_country = [[NSString alloc] initWithString:@"http://192.168.0.111/DatingService/getDetails.svc/scrollGallery/"];
    
    NSLog(@"str_country:%@",str_country);
    
    NSMutableURLRequest *request =[[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:str_country]];
    
    NSData *returnData = [ NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil ];
    
    NSString *returnString = [[NSString alloc]initWithData:returnData encoding:NSUTF8StringEncoding];
    
    NSLog(@"returnString:*%@*",returnString);
    
    
    NSDictionary *dict=[returnString JSONValue];
    if (dict==nil||dict==NULL)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"No Response From Server" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    
    
    else {
        
    
    NSDictionary *str123 = [dict objectForKey:@"scrollGalleryResult"];
    NSLog(@"str123:%@",str123);
    
    for (NSDictionary *info in str123)
    {
        
        NSLog(@"info:%@",info);
        
        id_string=[info objectForKey:@"userID"];
        [id_arr addObject:id_string];
        NSLog(@"id_str:*%@*",id_string);
        
        name_string=[info objectForKey:@"userName"];
        [name_arr addObject:name_string];
        NSLog(@"name_arr:%@",name_arr);
        
        age_string=[[NSString alloc]initWithFormat:@"%@",[info objectForKey:@"age"]];
        [age_arr addObject:age_string];
        
        gender_string=[info objectForKey:@"isMale"];
        [gender_arr addObject:gender_string];
        NSLog(@"name_arr:%@",gender_arr);
        
        race_string=[info objectForKey:@"Ethnicity"];
        
        if (race_string == (NSString*)[NSNull null])
            
        {
            race_string=@"Not available";
            
        }
        
        [race_arr addObject:race_string];
        NSLog(@"name_arr:%@",race_arr);
        
        listOfItems = [[NSMutableArray alloc] init];
        
        
        NSDictionary *countriesToLiveInDict = [NSDictionary dictionaryWithObject:name_arr forKey:@"name"];
        
        NSLog(@"countriesToLiveInDict:%@",countriesToLiveInDict);
        
        //NSArray *countriesLivedInArray = [NSArray arrayWithObjects:@"India", @"U.S.A", nil];
        NSDictionary *countriesLivedInDict = [NSDictionary dictionaryWithObject:name_arr forKey:@"name"];
        
        //[listOfItems addObject:countriesToLiveInDict];
        [listOfItems addObject:countriesLivedInDict];
        
        //Initialize the copy array.
        copyListOfItems = [[NSMutableArray alloc] init];
        
        //Set the title
        //self.navigationItem.title = @"Countries";
        
        //Add the search bar
        profile_tbl.tableHeaderView = searchBar;
        searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
        
        searching = NO;
        letUserSelectRow = YES;
        

        
    }
       
    
    if ([name_string isEqualToString:@"(null)"]||[name_string isEqualToString:@""]||name_string==nil||name_string==NULL)
    {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Not Available" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
    }
    else
    {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        
    }
    
    [pool release];
  
    
    
    [self performSelectorOnMainThread:@selector(tbl_load) withObject:nil waitUntilDone:YES];
    
    }
    
    
}
-(void)tbl_load
{
    
    [profile_tbl reloadData];

}
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBarX
{
    
    [searchBarX resignFirstResponder];
    
    return YES;
    
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBarY
{
    [searchBarY resignFirstResponder];
    
    
}

-(IBAction)mainmenu
{
    
    
    Menupage *preview=[[Menupage alloc]initWithNibName:@"Menupage" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:preview animated:NO];
    
    
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
