//
//  Favorites_list.m
//  iDate
//
//  Created by D M R on 03/09/12.
//  Copyright (c) 2012 iHubTechnologies. All rights reserved.
//

#import "Favorites_list.h"
#import "JSON.h"
#import "JSON1.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "Favorites_cell.h"
#import "Menupage.h"
#import "Profile_view.h"
#import "AsyncImageView1.h"
#import "Chat_view.h"
#define ASYNC_IMAGE_TAG 9999
#define FONT_SIZE 18.0f
#define CELL_CONTENT_WIDTH 320.0f
#define CELL_CONTENT_MARGIN 10.0f



@interface Favorites_list ()

@end

@implementation Favorites_list

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
    
    if([global_show_msg_iconstr isEqualToString:@"1"])
    {
        
        global_msg_btn.hidden=NO;
        
    }else
    {
        global_msg_btn.hidden=YES;
    }
    
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading favorites...";

    [self performSelector:@selector(favoritedisplay) withObject:nil afterDelay:1.0];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [global_msg_btn release];
    global_msg_btn = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
       return 1;
    }

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [user_name_arr count];    
    
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    Favorites_cell *cell1;
    
    
    
    static NSString *cellIdentifier1 = @"cellIdentifier1";
    
    cell1 = (Favorites_cell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
    if (cell1 == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Favorites_cell"
                                                     owner:self options:nil];
        for (id oneObject in nib) if ([oneObject isKindOfClass:[Favorites_cell class]])
            cell1 = (Favorites_cell *)oneObject;
    }		
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
    
        cell1.user_name.text = [user_name_arr objectAtIndex:indexPath.row];
        
        cell1.age_lbl.text=[age_arr objectAtIndex:[indexPath row]];
               
    NSString *gender_check=[[NSString alloc]initWithFormat:@"%@",[gender_arr objectAtIndex:[indexPath row]]];
    
    if ([gender_check isEqualToString:@"1"])
    {
        cell1.gender_img.image=[UIImage imageNamed:@"male_icon.png"];

      }
        
    else
    {
        cell1.gender_img.image=[UIImage imageNamed:@"female_icon.png"];

    }
    urlString1 = [NSString stringWithFormat:@"%@",[final_img_arr objectAtIndex:[indexPath row]]];
    
    //NSString *urlString1 = [NSString stringWithFormat:@"%@",str_profile_image];
    // NSURL *url1 = [NSURL URLWithString:urlString1];
    
    //============== for big img ===========////////
    
    AsyncImageView1 *imgPhoto = [[AsyncImageView1 alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 55.0f, 50.0f)];
    //imgPhoto.layer.masksToBounds = YES;
    //imgPhoto.layer.cornerRadius = 10.0;
    imgPhoto.contentMode = UIViewContentModeScaleAspectFill;
    imgPhoto.clipsToBounds = YES;
    imgPhoto.tag = ASYNC_IMAGE_TAG;
    [cell1.profile_img  addSubview:imgPhoto];
    
    
    // imgPhoto.layer.cornerRadius = 9;
    
    
    
    
    AsyncImageView1 *imageView1 = (AsyncImageView1 *)[cell1 viewWithTag:ASYNC_IMAGE_TAG];
    imageView1.layer.masksToBounds = YES;
    // imageView1.layer.cornerRadius =10.0;
    //cancel loading previous image for cell
    [[AsyncImageLoader sharedLoader] cancelLoadingURL:imageView1.imageURL];
    imageView1.imageURL = [NSURL URLWithString:urlString1];
    

    
    return cell1;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    view_profile_bool=TRUE;
    
    globalCheckFavorites = [[NSString alloc]initWithFormat:@"%@",@"Favorites"];
    
    global_string=[[NSString alloc]initWithFormat:@"%@",[user_id objectAtIndex:[indexPath row]]];
    global_Chat_id = [[NSString alloc]initWithFormat:@"%@",global_Chat_id];
    Profile_view *preview=[[Profile_view alloc]initWithNibName:@"Profile_view" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:preview animated:NO];
    

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 63;
	
}

-(IBAction)mainmenu
{
    
    Menupage *preview=[[Menupage alloc]initWithNibName:@"Menupage" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:preview animated:NO];
    


}
- (IBAction)click_msg_chatWindow:(id)sender {
    
    Chat_view *chatView = [[Chat_view alloc]initWithNibName:@"Chat_view" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:chatView animated:YES];
  
}

-(void)favoritedisplay
{
    [self readlogin];
    user_name_arr=[[NSMutableArray alloc]init];
    age_arr=[[NSMutableArray alloc]init];
    gender_arr=[[NSMutableArray alloc]init];
    user_id=[[NSMutableArray alloc]init];
    user_id_arr=[[NSMutableArray alloc]init];
    fav_image_src_arr =[[NSMutableArray alloc]init];
    final_img_arr =[[NSMutableArray alloc]init];

    NSString *str_country = [[NSString alloc]initWithFormat:@"http://192.168.0.111/DatingService/getDetails.svc/scrollGalleryFavorites/%@",login_select];
    
    NSLog(@"str_country:%@",str_country);
    
    NSMutableURLRequest *request =[[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:str_country]];
    
    NSData *returnData = [ NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil ];
    
    NSString *returnString = [[NSString alloc]initWithData:returnData encoding:NSUTF8StringEncoding];
    
    NSLog(@"returnString:*%@*",returnString);
    
    
    NSDictionary *dict=[returnString JSONValue];
   
    NSDictionary *str123 = [dict objectForKey:@"scrollGalleryFavoritesResult"];
    NSLog(@"str123:%@",str123);
    
    for (NSDictionary *info in str123)
    {
  
   
        
        NSLog(@"info:%@",info);
        
        NSString  *id_string=[[NSString alloc]initWithFormat:@"%@",[info objectForKey:@"userID"]];
        [user_id addObject:id_string];
        NSLog(@"id_str:*%@*",id_string);
        
        
        name_string=[info objectForKey:@"userName"];
        [user_name_arr addObject:name_string];
        NSLog(@"user_name_arr:%@",user_name_arr);
        
        
        
        NSString  *age_string=[[NSString alloc]initWithFormat:@"%@",[info objectForKey:@"age"]];
        NSLog(@"age in favorites:%@",age_string);
        if (age_string == (NSString*)[NSNull null])
            
        {
            age_string=@"";
            
        }
        else if([age_string isEqualToString:@""]||[age_string isEqualToString:@"null"]||[age_string isEqualToString:@"(null)"]||[age_string isEqualToString:@"<null>"])
        {
            //longtude_String=@"Not available";
            age_string=@"";
        }
        
        
        [age_arr addObject:age_string];
         NSLog(@"Favorites_age:%@",age_arr);
        
        
        
        NSString  *gender_string=[[NSString alloc]initWithFormat:@"%@",[info objectForKey:@"isMale"]];
        
        [gender_arr addObject:gender_string];
        NSLog(@"gender_arr in favorites:%@",gender_arr);
        
        fav_image_string=[[NSString alloc]initWithFormat:@"%@",[info objectForKey:@"userFileScreenshotURL"]];
        NSLog(@"image_string:%@",fav_image_string);
       
        
        @try{
            
            [fav_image_src_arr addObject:fav_image_string];
            //[gender_image_Search_arr addObject:image_string];
        }@catch (NSException *exception)
        {
            NSLog(@"main: gender_image Caught %@: %@", [exception name], [exception reason]);
        }

        
    }
    
    for (int l=0; l<[fav_image_src_arr count]; l++)
        
    {
        
        
        NSString *string_final=[[NSString alloc]initWithFormat:@"%@",[fav_image_src_arr objectAtIndex:l]];
        
        NSString *value = [string_final substringWithRange:NSMakeRange(0, 4)];
        
        NSString *isMalerFemal=[[NSString alloc]initWithFormat:@"%@",[gender_arr objectAtIndex:l]];
        
        string_final=[string_final stringByReplacingOccurrencesOfString:@"<null>" withString:@""];
        NSLog(@"string final image:%@",string_final);
        NSLog(@"string final value male or Female:%@",isMalerFemal);
        
        NSLog(@"string final value:%@",string_final);
        
        if ([string_final isEqualToString:@"male_icon.png"]||[string_final isEqual:@"profile_pic.png"]||[string_final isEqualToString:@""]||[string_final isEqualToString:@"<null>"]||[string_final isEqualToString:@"(null)"])
            
        {
            NSLog(@"male or female");
            if ([isMalerFemal isEqualToString:@"1"])
            {
                NSLog(@"string final value male:%@",isMalerFemal);
                NSLog(@"male icon");
                new_image_string=[[NSString alloc]initWithFormat:@"http://192.168.0.111/Dating/images/NoPhotoMale.jpg"];
                
            }
            else if ([isMalerFemal isEqualToString:@"0"])
            {
                NSLog(@"string final value female:%@",isMalerFemal);
                NSLog(@"female icon");
                new_image_string=[[NSString alloc]initWithFormat:@"http://192.168.0.111/Dating/images/NoPhotoFemale.jpg"];
                
            }
        [final_img_arr addObject:new_image_string];    
            
        }else
            if ([value isEqualToString:@"http"]) {
                
                [final_img_arr addObject:string_final];
                NSLog(@"socialUrl:%@",value);
                
            }
        
        else
        {
            NSLog(@"upload icon");
            NSString *str_image_url_1 = [[NSString alloc]initWithFormat:@"http://192.168.0.111/Dating/Uploads/"];
            
            new_image_string =[[NSString alloc]initWithFormat:@"%@",[str_image_url_1 stringByAppendingString:string_final]];
            
            
            
            new_image_string=[new_image_string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [final_img_arr addObject:new_image_string];
            
        }
    
    }
    
    
    if ([name_string isEqualToString:@"(null)"]||[name_string isEqualToString:@""]||name_string==nil||name_string==NULL)
    {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@" You don't have any Favorites" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
    }
    else
    {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        
    }
    [fav_tbl reloadData];
    
    
    
}
-(void)readlogin
{
    NSString *query = [[NSString alloc] initWithFormat:@"select * from login;"];
	sqlite3_stmt *stmt;
    
	int x = sqlite3_prepare_v2(database,[query UTF8String],-1, &stmt, nil);
	if (x == SQLITE_OK) 
	{
		// Loop through the results and add them to the feeds array
		
        while(sqlite3_step(stmt) == SQLITE_ROW)
		{
			NSString *loginstr = [[NSString alloc]initWithUTF8String:(char *)sqlite3_column_text(stmt, 1)];
            NSLog(@"loginstr:%@",loginstr);
            
            login_select=[[NSString alloc]initWithFormat:@"%@",loginstr];
            NSLog(@"login_select:%@",login_select);
            
		}
        
        
	}
	sqlite3_finalize(stmt);	
    

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


- (void)dealloc {
    [global_msg_btn release];
    [super dealloc];
}
@end
