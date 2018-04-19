//
//  Search_view.m
//  iDate
//
//  Created by D M R on 13/09/12.
//  Copyright (c) 2012 iHubTechnologies. All rights reserved.
//

#import "Search_view.h"
#import "Menupage.h"
#import "AppDelegate.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "JSON.h"
#import "JSON1.h"
#import "MBProgressHUD.h"
#import "UIImageView+DispatchLoad.h"
#import "Search_list.h"
#import "Chat_view.h"
@interface Search_view ()

@end

@implementation Search_view

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
    
  
    genderString = [[NSString alloc]initWithFormat:@""];
    interest_Business = [[NSString alloc]initWithFormat:@"0"];
    interest_chatting = [[NSString alloc]initWithFormat:@"0"];
    interest_flirting = [[NSString alloc]initWithFormat:@"0"];
    interest_relationship = [[NSString alloc]initWithFormat:@"0"];
    interest_friendship = [[NSString alloc]initWithFormat:@"0"];
    interest_dating = [[NSString alloc]initWithFormat:@"0"];
    interest_other_activity = [[NSString alloc]initWithFormat:@"0"];
    car_string = [[NSString alloc]initWithFormat:@"0"];
 country_selectedid= @"188";
    
    [scrollview setContentSize:CGSizeMake(320,1200)];
   
    //scrollview.frame = CGRectMake(0, -75, 320, 1400);
    [self.view addSubview:scrollview];
    country_view.frame = CGRectMake(0, 480, 320, 260);
	country_view.hidden = TRUE;
    [self.view addSubview:country_view];
    
    lang_view.frame = CGRectMake(0, 480, 320, 260);
	lang_view.hidden = TRUE;
    [self.view addSubview:lang_view];
    
    race_view.frame = CGRectMake(0, 480, 320, 260);
	race_view.hidden = TRUE;
    [self.view addSubview:race_view];
    
    
    
    
    haircolor_view.frame = CGRectMake(0, 480, 320, 260);
	haircolor_view.hidden = TRUE;
    [self.view addSubview:haircolor_view];
    
    
    
    eyescolor_view.frame = CGRectMake(0, 480, 320, 260);
	eyescolor_view.hidden = TRUE;
    [self.view addSubview:eyescolor_view];
    
    
    interest_view.frame = CGRectMake(0, 480, 320, 260);
	interest_view.hidden = TRUE;
    [self.view addSubview:interest_view];
    
    
    education_view.frame = CGRectMake(0, 480, 320, 260);
	education_view.hidden = TRUE;
    [self.view addSubview:education_view];
    
    drinker_view.frame = CGRectMake(0, 480, 320, 260);
	drinker_view.hidden = TRUE;
    [self.view addSubview:drinker_view];
    
    smoker_view.frame = CGRectMake(0, 480, 320, 260);
	smoker_view.hidden = TRUE;
    [self.view addSubview:smoker_view];
    

    // Do any additional setup after loading the view from its nib.
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    CGRect frame = scrollview.frame;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    frame.origin.x = 0;
    frame.origin.y = 37;
    scrollview.frame = frame;
    
    [UIView commitAnimations];
    
	[textField resignFirstResponder]; 
	

    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	NSLog(@"textFieldShouldBeginEditing");
    
   // if(textField == age_from_txt){
        
        CGRect frame = scrollview.frame;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        frame.origin.x = 0;
        frame.origin.y = -150;
        scrollview.frame = frame;
        
        [UIView commitAnimations];
        
        
    //}
        
    
	return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{         
	NSLog(@"textFieldDidBeginEditing");
    
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField;
{
	NSLog(@"textFieldDidEndEditing");
    [textField resignFirstResponder];
	//nameString = [[NSString alloc]initWithFormat:@"%@",text1.text];
	
}
-(void)scrollUpScroll{
    
    CGRect frame = scrollview.frame;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    frame.origin.x = 0;
    frame.origin.y = -210;
    scrollview.frame = frame;
    
    [UIView commitAnimations];
}

-(IBAction)country_pressed
{
    //[self scrollUpScroll];
    
    [self country_json_call];
    
	
}
-(IBAction)state_pressed
{
    [self state_json_call];
}
-(IBAction)city_pressed
{
    [self city_json_call];
}
-(IBAction)lang_pressed
{
    //[self scrollUpScroll];
    [self lang_json_call];    
    
}

-(IBAction)race_pressed
{
    //[self scrollUpScroll];
    [self race_json_call];
}

- (IBAction)click_msg_chatWindow:(id)sender {
    
    Chat_view *chatView = [[Chat_view alloc]initWithNibName:@"Chat_view" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:chatView animated:YES];
}
-(IBAction)haircolor_pressed
{
    [self scrollUpScroll];
    
    
    [self hair_json_call];
    
}

-(IBAction)eyecolor_pressed
{
    [self scrollUpScroll];
    [self eye_json_call];
    
}
-(IBAction)edu_pressed
{
    [self scrollUpScroll];
    [self edu_json_call];
}
-(IBAction)drink_pressed
{
    [self scrollUpScroll];
    [self drink_json_call];
}
-(IBAction)smoke_pressed
{
    [self scrollUpScroll];
    [self smoke_json_call];
    
}
-(void)country_json_call
{
    country_arr=[[NSMutableArray alloc]init];
    country_arr_number=[[NSMutableArray alloc]init];
    
    //            
    
    NSString *str_country = [NSString stringWithFormat:@"http://192.168.0.111/DatingService/getList.svc/getCountries/"];
    
    NSLog(@"str_country:%@",str_country);
    
    NSMutableURLRequest *request =[[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:str_country]];
    
    NSData *returnData = [ NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil ];
    
    NSString *returnString = [[NSString alloc]initWithData:returnData encoding:NSUTF8StringEncoding];
    
    NSLog(@"returnString_Countries:*%@*",returnString);
    
    
    NSDictionary *dict=[returnString JSONValue];
    
    if (dict==nil||dict==NULL)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"No Response From Server" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    
    
    else {
        
    NSDictionary *str123 = [dict objectForKey:@"getCountriesResult"];
    NSLog(@"str123 getCountriesResult:%@",str123);
    
    for (NSDictionary *info in str123)
    {
        
        
        NSLog(@"info_getCountriesResult:%@",info);
        
        country_id_str=[info objectForKey:@"id"];
        [country_arr_number addObject:country_id_str];
        NSLog(@"id_str_Country:*%@*",country_id_str);
        
        country_name_str=[info objectForKey:@"name"];
        [country_arr addObject:country_name_str];
        
        
    }
    
    
    
    if ([country_name_str isEqualToString:@"(null)"]||[country_name_str isEqualToString:@""]||country_name_str==nil||country_name_str==NULL)
    {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Country Not Available" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
    }
    else
    {
        
        country_view.hidden = FALSE;
        CGRect frame = country_view.frame;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:.5];
        frame.origin.y = 300;
        country_view.frame = frame;
        [UIView commitAnimations];
        
        [country_picker reloadAllComponents];
        select=0;
        
    }
    }
    
}
/*
-(IBAction)int_pressed:(id)sender{
    
}
-(IBAction)clickPickerCanel:(id)sender{
    
}
-(IBAction)clickPickerDone:(id)sender{
    
}
-(IBAction)clickPickerCane2:(id)sender{
    
}
-(IBAction)clickPickerDone2:(id)sender{
    
}
-(IBAction)clickPickerCanel3:(id)sender{
    
}
-(IBAction)clickPickerDone3:(id)sender{
    
}
 */
-(IBAction)clickPickerCanel1:(id)sender
{
    [self hairCancelDone];
     country_txt.text=@"";
    country_selectedid=@"";
    
    CGRect frame = country_view.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.5];
	frame.origin.y = 480;
	country_view.frame = frame;
	[UIView commitAnimations];
    
}
-(IBAction)clickPickerDone1:(id)sender
{
    [self hairCancelDone];
    country_selectedid=[[NSString alloc]initWithFormat:@"%@",[country_arr_number objectAtIndex:select]];
    
    CGRect frame = country_view.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.5];
	frame.origin.y = 880;
	country_view.frame = frame;
	[UIView commitAnimations];
    
}


-(IBAction)clickPickerCanel4:(id)sender
{
    [self hairCancelDone];
    lang_txt.text=@"";
    lang_selectedid=@"";
    CGRect frame = lang_view.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.5];
	frame.origin.y = 1280;
	lang_view.frame = frame;
	[UIView commitAnimations];
    
}
-(IBAction)clickPickerDone4:(id)sender
{
    [self hairCancelDone];
    lang_selectedid=[[NSString alloc]initWithFormat:@"%@",[lang_arr_number objectAtIndex:select]];
    CGRect frame = lang_view.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.5];
	frame.origin.y = 1280;
	lang_view.frame = frame;
	[UIView commitAnimations];
    
    
    
}

-(IBAction)clickPickerCanel5:(id)sender
{
    [self hairCancelDone];
    race_txt.text=@"";
    race_selectedid =@"";
    CGRect frame = race_view.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.5];
	frame.origin.y = 880;
	race_view.frame = frame;
	[UIView commitAnimations];
    
      
}
-(IBAction)clickPickerDone5:(id)sender
{
    [self hairCancelDone];
    race_selectedid=[[NSString alloc]initWithFormat:@"%@",[race_arr_number objectAtIndex:select]];
    race_txt.text=[[NSString alloc]initWithFormat:@"%@",[race_arr objectAtIndex:select]];
    CGRect frame = race_view.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.5];
	frame.origin.y = 880;
	race_view.frame = frame;
	[UIView commitAnimations];
    
       
}

-(void)hairCancelDone{
    
    CGRect frame = scrollview.frame;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    frame.origin.x = 0;
    frame.origin.y = 37;
    scrollview.frame = frame;
    
    [UIView commitAnimations];
    
}

-(IBAction)clickPickerCanel6:(id)sender
{
    [self hairCancelDone];
   hair_txt.text=@"";
    CGRect frame = haircolor_view.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.5];
	frame.origin.y = 1080;
	haircolor_view.frame = frame;
	[UIView commitAnimations];
    
    
}
-(IBAction)clickPickerDone6:(id)sender
{
    //   [race_btn setTitle:@"" forState:UIControlStateNormal];
    
    [self hairCancelDone];
    haircolor_selectedid=[[NSString alloc]initWithFormat:@"%@",[haircolor_arr_number objectAtIndex:select]];
    hair_txt.text=[[NSString alloc]initWithFormat:@"%@",[haircolor_arr objectAtIndex:select]];
    CGRect frame = haircolor_view.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.5];
	frame.origin.y = 1080;
	haircolor_view.frame = frame;
	[UIView commitAnimations];
    
    
    
}

-(IBAction)clickPickerCanel7:(id)sender
{
    [self hairCancelDone];
    eye_txt.text=@"";
    eyecolor_selectedid = @"";
    CGRect frame = eyescolor_view.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.5];
	frame.origin.y = 1580;
	eyescolor_view.frame = frame;
	[UIView commitAnimations];
    
    
}
-(IBAction)clickPickerDone7:(id)sender
{
    // [race_btn setTitle:@"" forState:UIControlStateNormal];
    
    [self hairCancelDone];
    eyecolor_selectedid=[[NSString alloc]initWithFormat:@"%@",[eyecolor_arr_number objectAtIndex:select]];
    eye_txt.text=[[NSString alloc]initWithFormat:@"%@",[eyecolor_arr objectAtIndex:select]];
    CGRect frame = eyescolor_view.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.5];
	frame.origin.y = 1580;
	eyescolor_view.frame = frame;
	[UIView commitAnimations];
    
    
    
}


-(IBAction)clickPickerCanel8:(id)sender
{
    [self hairCancelDone];
   education_txt.text=@"";
    edu_selectedid = @"";
    CGRect frame = education_view.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.5];
	frame.origin.y = 1380;
	education_view.frame = frame;
	[UIView commitAnimations];
    
}

-(IBAction)clickPickerDone8:(id)sender
{
    [self hairCancelDone];
    edu_selectedid=[[NSString alloc]initWithFormat:@"%@",[education_arr_number objectAtIndex:select]];
    education_txt.text=[[NSString alloc]initWithFormat:@"%@",[education_arr objectAtIndex:select]];
    CGRect frame = education_view.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.5];
	frame.origin.y = 1380;
	education_view.frame = frame;
	[UIView commitAnimations];
}

-(IBAction)clickPickerCanel9:(id)sender
{
    [self hairCancelDone];
    drinker_txt.text=@"";
    drinker__selectedid=@"";
    CGRect frame = drinker_view.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.5];
	frame.origin.y = 1580;
	drinker_view.frame = frame;
	[UIView commitAnimations];
    
    
    
}
-(IBAction)clickPickerDone9:(id)sender
{
    [self hairCancelDone];
    drinker__selectedid=[[NSString alloc]initWithFormat:@"%@",[drinker_arr_number objectAtIndex:select]];
    drinker_txt.text=[[NSString alloc]initWithFormat:@"%@",[drinker_arr objectAtIndex:select]];
    CGRect frame = drinker_view.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.5];
	frame.origin.y = 1580;
	drinker_view.frame = frame;
	[UIView commitAnimations];
    
    
}
-(IBAction)clickPickerCanel10:(id)sender
{
   
    interest_Business=[[NSString alloc]initWithFormat:@"0"];
    interest_chatting=[[NSString alloc]initWithFormat:@"0"];
    interest_dating=[[NSString alloc]initWithFormat:@"0"];
    interest_flirting=[[NSString alloc]initWithFormat:@"0"];
    interest_friendship=[[NSString alloc]initWithFormat:@"0"];
    interest_relationship=[[NSString alloc]initWithFormat:@"0"];
    interest_other_activity=[[NSString alloc]initWithFormat:@"0"];
    
    
    CGRect frame = interest_view.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.5];
	frame.origin.y = 1780;
	interest_view.frame = frame;
	[UIView commitAnimations];
    
    
}
-(IBAction)clickPickerDone10:(id)sender
{
    
    interest_string=[[NSString alloc]initWithFormat:@"%@",[interest_arr objectAtIndex:select]];
    
    if ([interest_string isEqualToString:@"Business Networking"]) 
        
    {
        interest_Business=[[NSString alloc]initWithFormat:@"1"];
        interest_chatting=[[NSString alloc]initWithFormat:@"0"];
        interest_dating=[[NSString alloc]initWithFormat:@"0"];
        interest_flirting=[[NSString alloc]initWithFormat:@"0"];
        interest_friendship=[[NSString alloc]initWithFormat:@"0"];
        interest_relationship=[[NSString alloc]initWithFormat:@"0"];interest_other_activity=[[NSString alloc]initWithFormat:@"0"];
    }
    
    
    
    CGRect frame = interest_view.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.5];
	frame.origin.y = 1780;
	interest_view.frame = frame;
	[UIView commitAnimations];
    
}
-(IBAction)clickPickerCanel11:(id)sender
{
    [self hairCancelDone];
    smoker_txt.text=@"";
    smoker_selectedid = @"";
    CGRect frame = smoker_view.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.5];
	frame.origin.y = 2080;
	smoker_view.frame = frame;
	[UIView commitAnimations];
    
}
-(IBAction)clickPickerDone11:(id)sender
{
    [self hairCancelDone];
    smoker_selectedid=[[NSString alloc]initWithFormat:@"%@",[smoker_arr_number objectAtIndex:select]];
    smoker_txt.text=[[NSString alloc]initWithFormat:@"%@",[smoker_arr objectAtIndex:select]];
    CGRect frame = smoker_view.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.5];
	frame.origin.y = 2080;
	smoker_view.frame = frame;
	[UIView commitAnimations];
    
}

-(void)state_json_call
{
    
    state_arr=[[NSMutableArray alloc]init];
    state_arr_number=[[NSMutableArray alloc]init];
    
    //            
    
    NSString *str_country = [NSString stringWithFormat:@"http://192.168.0.111/DatingService/getList.svc/getStates/%@",country_selectedid];
    
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
        
    NSDictionary *str123 = [dict objectForKey:@"getStatesResult"];
    NSLog(@"str123:%@",str123);
    
    for (NSDictionary *info in str123)
    {
        
        
        NSLog(@"info:%@",info);
        
        state_id_str=[info objectForKey:@"id"];
        [state_arr_number addObject:state_id_str];
        NSLog(@"id_str:*%@*",state_id_str);
        
        state_name_str=[info objectForKey:@"name"];
        [state_arr addObject:state_name_str];
        
        
    }
    
    
    
    if ([state_name_str isEqualToString:@"(null)"]||[state_name_str isEqualToString:@""]||state_name_str==nil||state_name_str==NULL)
    {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"State Not Available" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
    }
    else
    {
        
        state_view.hidden = FALSE;
        CGRect frame = state_view.frame;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:.5];
        frame.origin.y = 300;
        state_view.frame = frame;
        [UIView commitAnimations];
        
        [state_picker reloadAllComponents];
        
        select=0;
    }
    
    
    }
    
    
}
-(void)city_json_call
{
    
    city_arr=[[NSMutableArray alloc]init];
    city_arr_number=[[NSMutableArray alloc]init];
    
    //            
    
    NSString *str_country = [NSString stringWithFormat:@"http://192.168.0.111/DatingService/getList.svc/getCities/%@",state_selectedid];
    
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
        
    NSDictionary *str123 = [dict objectForKey:@"getCitiesResult"];
    NSLog(@"str123:%@",str123);
    
    for (NSDictionary *info in str123)
    {
        
        
        NSLog(@"info:%@",info);
        
        city_id_str=[info objectForKey:@"id"];
        [city_arr_number addObject:city_id_str];
        NSLog(@"id_str:*%@*",city_id_str);
        
        city_name_str=[info objectForKey:@"name"];
        [city_arr addObject:city_name_str];
        
        
    }
    
    
    
    if ([city_name_str isEqualToString:@"(null)"]||[city_name_str isEqualToString:@""]||city_name_str==nil||city_name_str==NULL)
    {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"City Not Available" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
    }
    else
    {
        
        city_view.hidden = FALSE;
        CGRect frame = city_view.frame;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:.5];
        frame.origin.y = 300;
        city_view.frame = frame;
        [UIView commitAnimations];
        
        [city_picker reloadAllComponents];
        
        select=0;
    }
    
    
    }
    
}
-(void)lang_json_call
{
    
    lang_arr=[[NSMutableArray alloc]init];
    lang_arr_number=[[NSMutableArray alloc]init];
    
    //            
    
    NSString *str_country = [NSString stringWithFormat:@"http://192.168.0.111/DatingService/getList.svc/getLanguages/"];
    
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
        
    NSDictionary *str123 = [dict objectForKey:@"getLanguagesResult"];
    NSLog(@"str123:%@",str123);
    
    for (NSDictionary *info in str123)
    {
        
        
        NSLog(@"info:%@",info);
        
        lang_id_str=[info objectForKey:@"id"];
        [lang_arr_number addObject:lang_id_str];
        NSLog(@"id_str:*%@*",lang_id_str);
        
        lang_name_str=[info objectForKey:@"name"];
        [lang_arr addObject:lang_name_str];
        
        
    }
    
    
    
    if ([lang_name_str isEqualToString:@"(null)"]||[lang_name_str isEqualToString:@""]||lang_name_str==nil||lang_name_str==NULL)
    {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Language Not Available" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
    }
    else
    {
        
        lang_view.hidden = FALSE;
        CGRect frame = lang_view.frame;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:.5];
        frame.origin.y = 300;
        lang_view.frame = frame;
        [UIView commitAnimations];
        
        [lang_picker reloadAllComponents];
        
        select=0;
        
    }
    
    }
    
}


-(void)race_json_call
{
    
    race_arr=[[NSMutableArray alloc]init];
    race_arr_number=[[NSMutableArray alloc]init];
    
    //            
    
    NSString *str_country = [NSString stringWithFormat:@"http://192.168.0.111/DatingService/getList.svc/getEthnicities/"];
    
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
        
    NSDictionary *str123 = [dict objectForKey:@"getEthnicitiesResult"];
    NSLog(@"str123:%@",str123);
    
    for (NSDictionary *info in str123)
    {
        
        
        NSLog(@"info:%@",info);
        
        race_id_str=[info objectForKey:@"id"];
        [race_arr_number addObject:race_id_str];
        NSLog(@"id_str:*%@*",race_id_str);
        
        race_name_str=[info objectForKey:@"name"];
        [race_arr addObject:race_name_str];
        
        
    }
    
    
    
    if ([race_name_str isEqualToString:@"(null)"]||[race_name_str isEqualToString:@""]||race_name_str==nil||race_name_str==NULL)
    {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Language Not Available" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
    }
    else
    {
        
              
        race_view.hidden = FALSE;
        CGRect frame1 = race_view.frame;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:.5];
        frame1.origin.y = 300;
        race_view.frame = frame1;
        [UIView commitAnimations];
        
        
        [race_picker reloadAllComponents];
        
    select=0;
    }
    
    
    }
    
    
    
    
}
-(void)hair_json_call
{
    
    
    haircolor_arr=[[NSMutableArray alloc]init];
    haircolor_arr_number=[[NSMutableArray alloc]init];
    
    //            
    
    NSString *str_country = [NSString stringWithFormat:@"http://192.168.0.111/DatingService/getList.svc/getHairColor/"];
    
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
        
    
    for (NSDictionary *info in dict)
    {
        
        
        NSLog(@"info:%@",info);
        
        haircolor_id_str=[info objectForKey:@"id"];
        [haircolor_arr_number addObject:haircolor_id_str];
        NSLog(@"id_str:*%@*",lang_id_str);
        
        haircolor_name_str=[info objectForKey:@"name"];
        [haircolor_arr addObject:haircolor_name_str];
        
        
    }
    
    
    
    if ([haircolor_name_str isEqualToString:@"(null)"]||[haircolor_name_str isEqualToString:@""]||haircolor_name_str==nil||haircolor_name_str==NULL)
    {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Language Not Available" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
    }
    else
    {
        
        haircolor_view.hidden = FALSE;
        CGRect frame1 = haircolor_view.frame;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:.5];
        frame1.origin.y = 300;
        haircolor_view.frame = frame1;
        [UIView commitAnimations];
        
        
        [haircolor_picker reloadAllComponents];
        
    select=0;
    }
    

    }
    
}
-(void)eye_json_call
{
    
    eyecolor_arr=[[NSMutableArray alloc]init];
    eyecolor_arr_number=[[NSMutableArray alloc]init];
    
    //            
    
    NSString *str_country = [NSString stringWithFormat:@"http://192.168.0.111/DatingService/getList.svc/getEyeColor/"];
    
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
        
    
    for (NSDictionary *info in dict)
    {
        
        
        NSLog(@"info:%@",info);
        
        eyecolor_id_str=[info objectForKey:@"id"];
        [eyecolor_arr_number addObject:eyecolor_id_str];
        NSLog(@"id_str:*%@*",eyecolor_id_str);
        
        eyecolor_name_str=[info objectForKey:@"name"];
        [eyecolor_arr addObject:eyecolor_name_str];
        
        
    }
    
    
    
    if ([eyecolor_name_str isEqualToString:@"(null)"]||[eyecolor_name_str isEqualToString:@""]||eyecolor_name_str==nil||eyecolor_name_str==NULL)
    {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Eyecolor Not Available" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
    }
    else
    {
        
        eyescolor_view.hidden = FALSE;
        CGRect frame1 = eyescolor_view.frame;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:.5];
        frame1.origin.y = 300;
        eyescolor_view.frame = frame1;
        [UIView commitAnimations];
        
        
        [eyescolor_picker reloadAllComponents];
        select=0;
        
    }
    }
    
}
-(void)edu_json_call
{
    
    education_arr=[[NSMutableArray alloc]init];
    education_arr_number=[[NSMutableArray alloc]init];
    
    //            
    
    NSString *str_country = [NSString stringWithFormat:@"http://192.168.0.111/DatingService/getList.svc/getEducationLevel/"];
    
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
        
    
    
    for (NSDictionary *info in dict)
    {
        
        
        NSLog(@"info:%@",info);
        
        edu_id_str=[info objectForKey:@"id"];
        [education_arr_number addObject:edu_id_str];
        NSLog(@"id_str:*%@*",edu_id_str);
        
        edu_name_str=[info objectForKey:@"name"];
        [education_arr addObject:edu_name_str];
        
        
    }
    
    
    
    if ([edu_name_str isEqualToString:@"(null)"]||[edu_name_str isEqualToString:@""]||edu_name_str==nil||edu_name_str==NULL)
    {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Education level Not Available" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
    }
    else
    {
        
        education_view.hidden = FALSE;
        CGRect frame1 = education_view.frame;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:.5];
        frame1.origin.y = 300;
        education_view.frame = frame1;
        [UIView commitAnimations];
        [education_picker reloadAllComponents];
       
        select=0;
        
    }

    }
    
}
-(void)drink_json_call
{
    drinker_arr=[[NSMutableArray alloc]init];
    drinker_arr_number=[[NSMutableArray alloc]init];
    
    //            
    
    NSString *str_country = [NSString stringWithFormat:@"http://192.168.0.111/DatingService/getList.svc/getDrikerType/"];
    
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
        
    
    for (NSDictionary *info in dict)
    {
        
        
        NSLog(@"info:%@",info);
        
        drinker__id_str=[info objectForKey:@"id"];
        [drinker_arr_number addObject:drinker__id_str];
        NSLog(@"id_str:*%@*",drinker__id_str);
        
        drinker__name_str=[info objectForKey:@"name"];
        [drinker_arr addObject:drinker__name_str];
        
        
    }
    
    
    
    if ([drinker__name_str isEqualToString:@"(null)"]||[drinker__name_str isEqualToString:@""]||drinker__name_str==nil||drinker__name_str==NULL)
    {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"DRinker type Not Available" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
    }
    else
    {
        
        drinker_view.hidden = FALSE;
        CGRect frame1 = drinker_view.frame;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:.5];
        frame1.origin.y = 300;
        drinker_view.frame = frame1;
        [UIView commitAnimations];
        
        
        [drinker_picker reloadAllComponents];
        
        select=0;
    }
    }
    
}
-(void)smoke_json_call
{
    
    smoker_arr=[[NSMutableArray alloc]init];
    smoker_arr_number=[[NSMutableArray alloc]init];
    
    //            
    
    NSString *str_country = [NSString stringWithFormat:@"http://192.168.0.111/DatingService/getList.svc/getSmokerType/"];
    
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
        
    
    for (NSDictionary *info in dict)
    {
        
        
        NSLog(@"info:%@",info);
        
        smoker_id_str=[info objectForKey:@"id"];
        [smoker_arr_number addObject:smoker_id_str];
        NSLog(@"id_str:*%@*",smoker_id_str);
        
        smoker_name_str=[info objectForKey:@"name"];
        [smoker_arr addObject:smoker_name_str];
        
        
    }
    
    
    
    if ([smoker_name_str isEqualToString:@"(null)"]||[smoker_name_str isEqualToString:@""]||smoker_name_str==nil||smoker_name_str==NULL)
    {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Smoker type Not Available" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
    }
    else
    {
        
        smoker_view.hidden = FALSE;
        CGRect frame1 = smoker_view.frame;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:.5];
        frame1.origin.y = 300;
        smoker_view.frame = frame1;
        [UIView commitAnimations];        
        
        [smoker_picker reloadAllComponents];
        select=0;
        
    }
    }
    
}
#pragma mark UIPickerView Delegate and datasource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    select=row;
    NSLog(@"select:%d",select);
    
    if (pickerView== country_picker) 
    {
        NSString *country_str=[country_arr objectAtIndex:row];
        country_txt.text=country_str;
        
        
    }
        
    
    else  if (pickerView== lang_picker) 
    {
        NSString *country_str=[lang_arr objectAtIndex:row];
        lang_txt.text=country_str;
        // [lang_btn setTitle:country_str forState:UIControlStateNormal];
        
    }
    else  if (pickerView== race_picker) 
    {
        NSString *country_str=[race_arr objectAtIndex:row];
        race_txt.text=country_str;
       
        
    }
    
    
    
    else  if (pickerView== haircolor_picker) 
    {
        NSString *country_str=[haircolor_arr objectAtIndex:row];
        hair_txt.text=country_str;
       
        
    }
    
    
    else  if (pickerView== eyescolor_picker) 
    {
        NSString *country_str=[eyecolor_arr objectAtIndex:row];
        eye_txt.text=country_str;
        
        
    }
    
    
       
    else  if (pickerView== education_picker) 
    {
        NSString *country_str=[education_arr objectAtIndex:row];
        education_txt.text=country_str;
               
    }
    else  if (pickerView== drinker_picker) 
    {
        NSString *country_str=[drinker_arr objectAtIndex:row];
        drinker_txt.text=country_str;
               
    }
    
    else  if (pickerView== smoker_picker) 
    {
        NSString *country_str=[smoker_arr objectAtIndex:row];
        smoker_txt.text=country_str;
       
        
    }
    
    
    
    
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView == country_picker)
    {
        return [country_arr count];
        
    }
    
    else  if (pickerView == state_picker)
    {
        return [state_arr count];
    }
    
    
    else  if (pickerView == city_picker)
    {
        return [city_arr count];
    }
    
    
    else  if (pickerView == lang_picker)
    {
        return [lang_arr count];
    }
    
    else  if (pickerView == race_picker)
    {
        return [race_arr count];
    }
    
    else  if (pickerView == haircolor_picker)
    {
        return [haircolor_arr count];
    }
    
    else  if (pickerView == eyescolor_picker)
    {
        return [eyecolor_arr count];
    }
    else  if (pickerView == education_picker)
    {
        return [education_arr count];
    }
    else  if (pickerView == interest_picker)
    {
        return [interest_arr count];
    }
    else  if (pickerView == drinker_picker)
    {
        return [drinker_arr count];
    }
    else  if (pickerView == smoker_picker)
    {
        return [smoker_arr count];
    }else{
        
    }
    return nil;
    
    
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    if (pickerView == country_picker)
    {
        return [country_arr objectAtIndex:row];        
    }
    
    else  if (pickerView == state_picker)
    {
        return [state_arr objectAtIndex:row];
    }
    
    
    else  if (pickerView == city_picker)
    {
        return[city_arr objectAtIndex:row];
    }
    
    
    else  if (pickerView == lang_picker)
    {
        return [lang_arr objectAtIndex:row];
    }
    
    else  if (pickerView == race_picker)
    {
        return [race_arr objectAtIndex:row];
    }
    
    else  if (pickerView == haircolor_picker)
    {
        return[haircolor_arr objectAtIndex:row];
    }
    
    else  if (pickerView == eyescolor_picker)
    {
        return [eyecolor_arr objectAtIndex:row];
    }
    else  if (pickerView == education_picker)
    {
        return[education_arr objectAtIndex:row];
    }
    else  if (pickerView == interest_picker)
    {
        return [interest_arr objectAtIndex:row];
    }
    else  if (pickerView == drinker_picker)
    {
        return [drinker_arr objectAtIndex:row];
    }
    else  if (pickerView == smoker_picker)
    {
        return [smoker_arr objectAtIndex:row];
    }else{
        
    }
    return nil;
    
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view 
{
    
    if (pickerView == country_picker)
    {
        UILabel *retval = (id)view;
        if (!retval)
        {
            
            retval= [[[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [pickerView rowSizeForComponent:component].width-5, [pickerView rowSizeForComponent:component].height)] autorelease];
        }
        retval.backgroundColor = [UIColor clearColor];
        retval.text = [country_arr objectAtIndex:row];
        retval.font = [UIFont systemFontOfSize:23];
        return retval;
        
    }
    else if (pickerView == state_picker)
        
    {
        UILabel *retval1 = (id)view;
        if (!retval1)
        {
            
            retval1= [[[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [pickerView rowSizeForComponent:component].width-5, [pickerView rowSizeForComponent:component].height)] autorelease];
        }
        retval1.backgroundColor = [UIColor clearColor];
        retval1.text = [state_arr objectAtIndex:row];
        retval1.font = [UIFont systemFontOfSize:23];
        return retval1;
        
    }
    
    
    else if (pickerView == city_picker)
        
    {
        UILabel *retval1 = (id)view;
        if (!retval1)
        {
            
            retval1= [[[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [pickerView rowSizeForComponent:component].width-5, [pickerView rowSizeForComponent:component].height)] autorelease];
        }
        retval1.backgroundColor = [UIColor clearColor];
        retval1.text = [city_arr objectAtIndex:row];
        retval1.font = [UIFont systemFontOfSize:23];
        return retval1;
        
    }
    
    
    else if (pickerView == lang_picker)
        
    {
        UILabel *retval2 = (id)view;
        if (!retval2)
        {
            
            retval2= [[[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [pickerView rowSizeForComponent:component].width-5, [pickerView rowSizeForComponent:component].height)] autorelease];
        }
        retval2.backgroundColor = [UIColor clearColor];
        retval2.text = [lang_arr objectAtIndex:row];
        retval2.font = [UIFont systemFontOfSize:23];
        return retval2;
        
    }
    else if (pickerView == race_picker)
        
    {
        UILabel *retval2 = (id)view;
        if (!retval2)
        {
            
            retval2= [[[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [pickerView rowSizeForComponent:component].width-5, [pickerView rowSizeForComponent:component].height)] autorelease];
        }
        retval2.backgroundColor = [UIColor clearColor];
        retval2.text = [race_arr objectAtIndex:row];
        retval2.font = [UIFont systemFontOfSize:23];
        return retval2;
        
    }
    
    
    else if (pickerView == haircolor_picker)
        
    {
        UILabel *retval3 = (id)view;
        if (!retval3)
        {
            
            retval3= [[[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [pickerView rowSizeForComponent:component].width-5, [pickerView rowSizeForComponent:component].height)] autorelease];
        }
        retval3.backgroundColor = [UIColor clearColor];
        retval3.text = [haircolor_arr objectAtIndex:row];
        retval3.font = [UIFont systemFontOfSize:23];
        return retval3;
        
    }
    
    
    
    
    else if (pickerView == eyescolor_picker)
        
    {
        UILabel *retval4 = (id)view;
        if (!retval4)
        {
            
            retval4= [[[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [pickerView rowSizeForComponent:component].width-5, [pickerView rowSizeForComponent:component].height)] autorelease];
        }
        retval4.backgroundColor = [UIColor clearColor];
        retval4.text = [eyecolor_arr objectAtIndex:row];
        retval4.font = [UIFont systemFontOfSize:23];
        return retval4;
        
    }
    
    
    
    else if (pickerView == education_picker)
        
    {
        UILabel *retval5 = (id)view;
        if (!retval5)
        {
            
            retval5= [[[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [pickerView rowSizeForComponent:component].width-5, [pickerView rowSizeForComponent:component].height)] autorelease];
        }
        retval5.backgroundColor = [UIColor clearColor];
        retval5.text = [education_arr objectAtIndex:row];
        retval5.font = [UIFont systemFontOfSize:23];
        return retval5;
        
    }
    
    
    
    else if (pickerView == drinker_picker)
        
    {
        UILabel *retval6 = (id)view;
        if (!retval6)
        {
            
            retval6= [[[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [pickerView rowSizeForComponent:component].width-5, [pickerView rowSizeForComponent:component].height)] autorelease];
        }
        retval6.backgroundColor = [UIColor clearColor];
        retval6.text = [drinker_arr objectAtIndex:row];
        retval6.font = [UIFont systemFontOfSize:23];
        return retval6;
        
    }
    
    
    else if (pickerView == smoker_picker)
        
    {
        UILabel *retval7 = (id)view;
        if (!retval7)
        {
            
            retval7= [[[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [pickerView rowSizeForComponent:component].width-5, [pickerView rowSizeForComponent:component].height)] autorelease];
        }
        retval7.backgroundColor = [UIColor clearColor];
        retval7.text = [smoker_arr objectAtIndex:row];
        retval7.font = [UIFont systemFontOfSize:23];
        return retval7;
        
    }
    
    
    else if (pickerView == city_picker)
        
    {
        UILabel *retval8 = (id)view;
        if (!retval8)
        {
            
            retval8= [[[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [pickerView rowSizeForComponent:component].width-5, [pickerView rowSizeForComponent:component].height)] autorelease];
        }
        retval8.backgroundColor = [UIColor clearColor];
        retval8.text = [city_arr objectAtIndex:row];
        retval8.font = [UIFont systemFontOfSize:23];
        return retval8;
        
    }
    
    else if (pickerView == interest_picker)
        
    {
        UILabel *retval8 = (id)view;
        if (!retval8)
        {
            
            retval8= [[[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [pickerView rowSizeForComponent:component].width-5, [pickerView rowSizeForComponent:component].height)] autorelease];
        }
        retval8.backgroundColor = [UIColor clearColor];
        retval8.text = [interest_arr objectAtIndex:row];
        retval8.font = [UIFont systemFontOfSize:23];
        return retval8;
        
    }
    
    return nil;
}


-(IBAction)buttonTap:(id)sender
{
    
       
	UIButton *tappedButton = (UIButton*)sender;
	
	if (tappedButton==male_btn)
	{
		[male_btn setImage:[UIImage imageNamed:@"Search_check.png"] forState:UIControlStateNormal];
		[female_btn setImage:[UIImage imageNamed:@"Search_uncheck.png"] forState:UIControlStateNormal];
        [all_btn setImage:[UIImage imageNamed:@"Search_uncheck.png"] forState:UIControlStateNormal];
		genderString = [[NSString alloc]initWithFormat:@"1"];
		NSLog(@"genderStringMale:%@",genderString);
          
	}
	
	else if (tappedButton==female_btn)
	{
		[female_btn setImage:[UIImage imageNamed:@"Search_check.png"] forState:UIControlStateNormal];
		[male_btn setImage:[UIImage imageNamed:@"Search_uncheck.png"] forState:UIControlStateNormal];
        [all_btn setImage:[UIImage imageNamed:@"Search_uncheck.png"] forState:UIControlStateNormal];
		genderString = [[NSString alloc]initWithFormat:@"0"];
		NSLog(@"genderStringFemale:%@",genderString);
        
      
	}
    
    else if (tappedButton==all_btn)
	{
		[female_btn setImage:[UIImage imageNamed:@"Search_uncheck.png"] forState:UIControlStateNormal];
		[male_btn setImage:[UIImage imageNamed:@"Search_uncheck.png"] forState:UIControlStateNormal];
        [all_btn setImage:[UIImage imageNamed:@"Search_check.png"] forState:UIControlStateNormal];
		genderString = [[NSString alloc]initWithFormat:@""];
		NSLog(@"genderStringFemale:%@",genderString);
        
        
	}

}


-(IBAction)car_tap:(id)sender
{
	UIButton *tappedButton = (UIButton*)sender;
	
    if([tappedButton.currentImage isEqual:[UIImage imageNamed:@"Search_uncheck.png"]])
    {
        [car_btn setImage:[UIImage imageNamed:@"Search_check.png"] forState:UIControlStateNormal];
		car_string = [[NSString alloc]initWithFormat:@"1"];
        
    }else{
        [car_btn setImage:[UIImage imageNamed:@"Search_uncheck.png"] forState:UIControlStateNormal];
		car_string = [[NSString alloc]initWithFormat:@"0"];
		
        
    }
    
    
    
    
    
    
	/*if (tappedButton==car_btn)        // {
	{
        
		[car_btn setImage:[UIImage imageNamed:@"Search_check.png"] forState:UIControlStateNormal];
		car_string = [[NSString alloc]initWithFormat:@"1"];
		
        
        [bike_btn setImage:[UIImage imageNamed:@"Search_uncheck.png"] forState:UIControlStateNormal];
		bike_string = [[NSString alloc]initWithFormat:@"0"];
        
	}
	
	else if(tappedButton==bike_btn)
	{
		[car_btn setImage:[UIImage imageNamed:@"Search_uncheck.png"] forState:UIControlStateNormal];
		car_string = [[NSString alloc]initWithFormat:@"0"];
		
        [bike_btn setImage:[UIImage imageNamed:@"Search_check.png"] forState:UIControlStateNormal];
		bike_string = [[NSString alloc]initWithFormat:@"1"];
		
        
	}
    */
}

-(IBAction)bike_tap:(id)sender
{
  UIButton *tappedButton = (UIButton*)sender;
    
    if([tappedButton.currentImage isEqual:[UIImage imageNamed:@"Search_uncheck.png"]])
    {
    
    [bike_btn setImage:[UIImage imageNamed:@"Search_check.png"] forState:UIControlStateNormal];
    bike_string = [[NSString alloc]initWithFormat:@"1"];
    }else
    {
        [bike_btn setImage:[UIImage imageNamed:@"Search_uncheck.png"] forState:UIControlStateNormal];
        bike_string = [[NSString alloc]initWithFormat:@"0"];
        
        
    }
}
-(IBAction)guy_tap:(id)sender
{
    
    
	UIButton *tappedButton = (UIButton*)sender;
	
    if (tappedButton==guys_btn)        // {
        
        // {
	{
        
		[guys_btn setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
		guys_string = [[NSString alloc]initWithFormat:@"1"];
		NSLog(@"genderStringMale:%@",genderString);
        
        [ladies_btn setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
		ladies_string = [[NSString alloc]initWithFormat:@"0"];
		NSLog(@"genderStringMale:%@",genderString);
        
	}
	
	else 
	{
		[guys_btn setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
		guys_string = [[NSString alloc]initWithFormat:@"0"];
		NSLog(@"genderStringMale:%@",genderString);
        
        
        [ladies_btn setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
		ladies_string = [[NSString alloc]initWithFormat:@"1"];
		NSLog(@"genderStringMale:%@",genderString);
        
        
	}
    
}
-(IBAction)ladies_tap:(id)sender
{
    
    
    UIButton *tappedButton = (UIButton*)sender;
	
	if([tappedButton.currentImage isEqual:[UIImage imageNamed:@"uncheck.png"]])
        // {
	{
        
		[ladies_btn setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
		ladies_string = [[NSString alloc]initWithFormat:@"1"];
		NSLog(@"genderStringMale:%@",genderString);
	}
	
	else 
	{
		[ladies_btn setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
		ladies_string = [[NSString alloc]initWithFormat:@"0"];
		NSLog(@"genderStringMale:%@",genderString);
        
	}
    
}

-(IBAction)int_business:(id)sender
{
    
    UIButton *tappedButton = (UIButton*)sender;
	
	if([tappedButton.currentImage isEqual:[UIImage imageNamed:@"Search_unclick.png"]])
        // {
	{
        
		[int_business_btn setImage:[UIImage imageNamed:@"Search_click.png"] forState:UIControlStateNormal];
		interest_Business = [[NSString alloc]initWithFormat:@"1"];
		NSLog(@"interest_Business:%@",interest_Business);
	}
	
	else 
	{
		[int_business_btn setImage:[UIImage imageNamed:@"Search_unclick.png"] forState:UIControlStateNormal];
		interest_Business = [[NSString alloc]initWithFormat:@"0"];
		NSLog(@"interest_Business:%@",interest_Business);
        
	}
    
}
-(IBAction)int_chatting:(id)sender
{
    
    UIButton *tappedButton = (UIButton*)sender;
	
	if([tappedButton.currentImage isEqual:[UIImage imageNamed:@"Search_unclick.png"]])
        // {
	{
        
		[int_chatting_btn setImage:[UIImage imageNamed:@"Search_click.png"] forState:UIControlStateNormal];
		interest_chatting = [[NSString alloc]initWithFormat:@"1"];
		NSLog(@"interest_chatting:%@",interest_chatting);
	}
	
	else 
	{
		[int_chatting_btn setImage:[UIImage imageNamed:@"Search_unclick.png"] forState:UIControlStateNormal];
		interest_chatting = [[NSString alloc]initWithFormat:@"0"];
		NSLog(@"interest_Business:%@",interest_chatting);
        
	}
    
}
-(IBAction)int_flirting:(id)sender
{
    UIButton *tappedButton = (UIButton*)sender;
	
	if([tappedButton.currentImage isEqual:[UIImage imageNamed:@"Search_unclick.png"]])
        // {
	{
        
		[int_flirting_btn setImage:[UIImage imageNamed:@"Search_click.png"] forState:UIControlStateNormal];
		interest_flirting = [[NSString alloc]initWithFormat:@"1"];
		NSLog(@"interest_Business:%@",interest_Business);
	}
	
	else 
	{
		[int_flirting_btn setImage:[UIImage imageNamed:@"Search_unclick.png"] forState:UIControlStateNormal];
		interest_flirting = [[NSString alloc]initWithFormat:@"0"];
		NSLog(@"interest_Business:%@",interest_Business);
        
	}
    
}
-(IBAction)int_relation:(id)sender
{
    UIButton *tappedButton = (UIButton*)sender;
	
	if([tappedButton.currentImage isEqual:[UIImage imageNamed:@"Search_unclick.png"]])
        // {
	{
        
		[int_relation_btn setImage:[UIImage imageNamed:@"Search_click.png"] forState:UIControlStateNormal];
		interest_relationship = [[NSString alloc]initWithFormat:@"1"];
		NSLog(@"interest_relationship:%@",interest_relationship);
	}
	
	else 
	{
		[int_relation_btn setImage:[UIImage imageNamed:@"Search_unclick.png"] forState:UIControlStateNormal];
		interest_relationship = [[NSString alloc]initWithFormat:@"0"];
		NSLog(@"interest_relationship:%@",interest_relationship);
        
	}
    
}
-(IBAction)int_frd:(id)sender
{
    UIButton *tappedButton = (UIButton*)sender;
	
	if([tappedButton.currentImage isEqual:[UIImage imageNamed:@"Search_unclick.png"]])
        // {
	{
        
		[int_frd_btn setImage:[UIImage imageNamed:@"Search_click.png"] forState:UIControlStateNormal];
		interest_friendship = [[NSString alloc]initWithFormat:@"1"];
		NSLog(@"interest_friendship:%@",interest_friendship);
	}
	
	else 
	{
		[int_frd_btn setImage:[UIImage imageNamed:@"Search_unclick.png"] forState:UIControlStateNormal];
		interest_friendship = [[NSString alloc]initWithFormat:@"0"];
		NSLog(@"interest_friendship:%@",interest_friendship);
        
	}
    
}
-(IBAction)int_dating:(id)sender
{
    UIButton *tappedButton = (UIButton*)sender;
	
	if([tappedButton.currentImage isEqual:[UIImage imageNamed:@"Search_unclick.png"]])
        // {
	{
        
		[int_dating_btn setImage:[UIImage imageNamed:@"Search_click.png"] forState:UIControlStateNormal];
		interest_dating = [[NSString alloc]initWithFormat:@"1"];
		NSLog(@"interest_dating:%@",interest_dating);
	}
	
	else 
	{
		[int_dating_btn setImage:[UIImage imageNamed:@"Search_unclick.png"] forState:UIControlStateNormal];
		interest_dating = [[NSString alloc]initWithFormat:@"0"];
		NSLog(@"interest_dating:%@",interest_dating);
        
	}
    
}
-(IBAction)int_others:(id)sender
{
    UIButton *tappedButton = (UIButton*)sender;
	
	if([tappedButton.currentImage isEqual:[UIImage imageNamed:@"Search_unclick.png"]])
        // {
	{
        
		[int_other_btn setImage:[UIImage imageNamed:@"Search_click.png"] forState:UIControlStateNormal];
		interest_other_activity = [[NSString alloc]initWithFormat:@"1"];
		NSLog(@"interest_other_activity:%@",interest_other_activity);
	}
	
	else 
	{
		[int_other_btn setImage:[UIImage imageNamed:@"Search_unclick.png"] forState:UIControlStateNormal];
		interest_other_activity = [[NSString alloc]initWithFormat:@"0"];
		NSLog(@"interest_other_activity:%@",interest_other_activity);
        
	}
    
}

-(IBAction)menupage
{
    Menupage *preview=[[Menupage alloc]initWithNibName:@"Menupage" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:preview animated:NO];

}
/*
- (void)requestFinished:(ASIHTTPRequest *)request
{    
    
    if (request.responseStatusCode == 400)
    {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Search failed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
    } 
    else if (request.responseStatusCode == 403)
    {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Search failed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    else if (request.responseStatusCode == 200) 
    {  
            NSString *responseString = [request responseString];
            NSLog(@"responseString1:%@",responseString);
            
        if ([responseString isEqualToString:@""]||[responseString isEqualToString:@"null"]||responseString==nil||responseString==NULL) 
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"No Result found" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
            
        else {
            
        
                  NSDictionary *responseDict = [responseString JSONValue];
            //NSLog(@"responseDict:%@",responseDict);
           // NSString *unlockCode = [responseDict objectForKey:@"unlock_code"];
        
            
           [MBProgressHUD hideHUDForView:self.view animated:YES];
                
        
        
//                              
//                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Search found" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                [alert show];
//                [alert release];
                
                
                
                
        Search_list *search_list=[[Search_list alloc]initWithNibName:@"Search_list" bundle:[NSBundle mainBundle]];
        [self.navigationController pushViewController:search_list animated:NO];
//            }
        }     
                
            } 
    else 
            {    
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Search failed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                [alert release];
                
            }
            

[MBProgressHUD hideHUDForView:self.view animated:YES];
Search_list *search_list=[[Search_list alloc]initWithNibName:@"Search_list" bundle:[NSBundle mainBundle]];
[self.navigationController pushViewController:search_list animated:NO];
}

*/
     

/*
- (void)requestFailed:(ASIHTTPRequest *)request
{    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    NSError *error = [request error];
    NSLog(@"error:%@",error);
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Search failed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [alert release];
}
*/

-(void)check_others
{
    
    if ([height_from_txt.text isEqualToString:@""]||[height_from_txt.text isEqualToString:@"(null)"]||height_from_txt.text == nil||height_from_txt.text==NULL)
        
    {
        
        height_from_string=[[NSString alloc]initWithFormat:@"0"];
        
    }
    else
    {
        BOOL valid;
        NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
        NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:height_from_txt.text];
        valid = [alphaNums isSupersetOfSet:inStringSet];    
        if (!valid) //
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please enter numeric for height" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
            
            
            
        }
        else 
        {
            NSString *height_str=height_from_txt.text;
            NSInteger height_integer=[height_str integerValue];
            
            if (height_integer>250)
            {
                //height_txt.text=@"";
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Height should not exceed 250 characters" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                [alert release];
                
            }
            else 
            {
                height_from_string=[[NSString alloc]initWithFormat:@"%d",height_integer];
                 NSLog(@"height_from_string:%@",height_from_string);
            }
            
        }
        
    }
    
    
    
    
    
    if ([height_to_txt.text isEqualToString:@""]||[height_to_txt.text isEqualToString:@"(null)"]||height_to_txt.text == nil||height_to_txt.text==NULL)
        
    {
        
        height_to_string=[[NSString alloc]initWithFormat:@"0"];
        
    }
    else
    {
        BOOL valid;
        NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
        NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:height_to_txt.text];
        valid = [alphaNums isSupersetOfSet:inStringSet];    
        if (!valid) //
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please enter numeric for height" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
            
            
            
        }
        else 
        {
            NSString *height_str=height_to_txt.text;
            NSInteger height_integer=[height_str integerValue];
            
            if (height_integer>250)
            {
                //height_txt.text=@"";
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Height should not exceed 250 characters" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                [alert release];
                
            }
            else 
            {
                height_to_string=[[NSString alloc]initWithFormat:@"%d",height_integer];
                
                NSLog(@"height_to_string:%@",height_to_string);
            }
            
        }
        
    }

    
    if ([weight_from_txt.text isEqualToString:@""]||[weight_from_txt.text isEqualToString:@"(null)"]||weight_from_txt.text == nil||weight_from_txt.text==NULL)
        
    {
        
        weight_from_string=[[NSString alloc]initWithFormat:@"0"];
        
    }
    else
    {
        BOOL valid;
        NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
        NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:weight_from_txt.text];
        valid = [alphaNums isSupersetOfSet:inStringSet];    
        if (!valid) //
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please enter numeric for height" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
            
            
            
        }
        else 
        {
            NSString *height_str=weight_from_txt.text;
            NSInteger height_integer=[height_str integerValue];
            
            if (height_integer>250)
            {
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Weight should not exceed 250 characters" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                [alert release];
                
            }
            else 
            {
                weight_from_string=[[NSString alloc]initWithFormat:@"%d",height_integer];
                
                 NSLog(@"weight_from_string:%@",weight_from_string);
            }
            
        }
        
    }

    
    if ([weight_to_txt.text isEqualToString:@""]||[weight_to_txt.text isEqualToString:@"(null)"]||weight_to_txt.text == nil||weight_to_txt.text==NULL)
        
    {
        
        weight_to_string=[[NSString alloc]initWithFormat:@"0"];
        
    }
    else
    {
        BOOL valid;
        NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
        NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:weight_to_txt.text];
        valid = [alphaNums isSupersetOfSet:inStringSet];    
        if (!valid) //
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please enter numeric for height" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
            
            
            
        }
        else 
        {
            NSString *height_str=weight_to_txt.text;
            NSInteger height_integer=[height_str integerValue];
            
            if (height_integer>250)
            {
                //height_txt.text=@"";
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Weight should not exceed 250 characters" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                [alert release];
                
            }
            else 
            {
                weight_to_string=[[NSString alloc]initWithFormat:@"%d",height_integer];
                NSLog(@"weight_to_string:%@",weight_to_string);
                
            }
            
        }
        
    }

    
   
    
    
    if ([age_from_txt.text isEqualToString:@""]||[age_from_txt.text isEqualToString:@"(null)"]||age_from_txt.text == nil||age_from_txt.text==NULL)
        
    {
        
        age_from_string=[[NSString alloc]initWithFormat:@"0"];
        
    }
    else
    {
        BOOL valid;
        NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
        NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:age_from_txt.text];
        valid = [alphaNums isSupersetOfSet:inStringSet];    
        if (!valid) //
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please enter numeric for height" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
            
            
            
        }
        else 
        {
            NSString *height_str=age_from_txt.text;
            NSInteger height_integer=[height_str integerValue];
            
            if (height_integer>250)
            {
                //height_txt.text=@"";
//                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Age should not exceed 250 characters" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                [alert show];
//                [alert release];
                
            }
            else 
            {
                age_from_string=[[NSString alloc]initWithFormat:@"%d",height_integer];
                NSLog(@"age_from_string:%@",age_from_string);

            }
            
        }
        
    }



    
    
    if ([age_to_txt.text isEqualToString:@""]||[age_to_txt.text isEqualToString:@"(null)"]||age_to_txt.text == nil||age_to_txt.text==NULL)
        
    {
        
        age_to_string=[[NSString alloc]initWithFormat:@"0"];
        
    }
    else
    {
        BOOL valid;
        NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
        NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:age_to_txt.text];
        valid = [alphaNums isSupersetOfSet:inStringSet];    
        if (!valid) //
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please enter numeric for height" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
            
            
            
        }
        else 
        {
            NSString *height_str=age_to_txt.text;
            NSInteger height_integer=[height_str integerValue];
            
            if (height_integer>250)
            {
                //height_txt.text=@"";
                //                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Age should not exceed 250 characters" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                //                [alert show];
                //                [alert release];
                
            }
            else 
            {
                age_to_string=[[NSString alloc]initWithFormat:@"%d",height_integer];
                NSLog(@"age_to_string:%@",age_to_string);

            }
            
        }
        
    }
    

    
    
    
    
    if ([keyword_txt.text isEqualToString:@""]||[keyword_txt.text isEqualToString:@"(null)"]||keyword_txt.text == nil||keyword_txt.text==NULL)
        
    {
        keyword_string=@"null";
        
        
    }
    else
    {
        NSString *string = keyword_txt.text;
        NSCharacterSet *alphanumericSet = [NSCharacterSet alphanumericCharacterSet];
        NSCharacterSet *numberSet = [NSCharacterSet decimalDigitCharacterSet];
        BOOL isAplhaNumericOnly= [[string stringByTrimmingCharactersInSet:alphanumericSet] isEqualToString:@""] && ![[string stringByTrimmingCharactersInSet:numberSet] isEqualToString:@""];
        
        NSLog(@"isAplhaNumericOnly: %d",isAplhaNumericOnly);
        
        
        if(isAplhaNumericOnly)
            
        {
            NSInteger keylength=[string length];
            
            if (keylength>500)
            {
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Keyword cannot exceed 500" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                [alert release];
                
            }
            else
            {
                keyword_string=[[NSString alloc]initWithFormat:@"%@",keyword_txt.text];
                
            }
            
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please use alphanumeric for keyword" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
            
        }
        
        
    }

    
    
    if ([country_selectedid isEqualToString:@""]||[country_selectedid isEqualToString:@"(null)"]||country_selectedid == nil||country_selectedid==NULL)
        
    {
        
        country_selectedid=[[NSString alloc]initWithFormat:@"0"];
        
        
    }
    else
    {
        
        
        
        
    }
    
    
    
    
    
        
       
    
    
    if ([haircolor_selectedid isEqualToString:@""]||[haircolor_selectedid isEqualToString:@"(null)"]||haircolor_selectedid == nil||haircolor_selectedid==NULL)
        
    {
        
        haircolor_selectedid=[[NSString alloc]initWithFormat:@"0"];
        
        
    }
    else
    {
        
        
        
        
    }
    
    if ([eyecolor_selectedid isEqualToString:@""]||[eyecolor_selectedid isEqualToString:@"(null)"]||eyecolor_selectedid == nil||eyecolor_selectedid==NULL)
        
    {
        
        eyecolor_selectedid=[[NSString alloc]initWithFormat:@"0"];
        
        
    }
    else
    {
        
        
        
        
    }
    
    if ([lang_selectedid isEqualToString:@""]||[lang_selectedid isEqualToString:@"(null)"]||lang_selectedid == nil||lang_selectedid==NULL)
        
    {
        
        lang_selectedid=[[NSString alloc]initWithFormat:@"0"];
        
        
    }
    else
    {
        
        
        
        
    }
    
    
    if ([drinker__selectedid isEqualToString:@""]||[drinker__selectedid isEqualToString:@"(null)"]||drinker__selectedid == nil||drinker__selectedid==NULL)
        
    {
        
        drinker__selectedid=[[NSString alloc]initWithFormat:@"0"];
        
        
    }
    else
    {
        
        
        
        
    }
    
    
    if ([smoker_selectedid isEqualToString:@""]||[smoker_selectedid isEqualToString:@"(null)"]||smoker_selectedid == nil||smoker_selectedid==NULL)
        
    {
        
        smoker_selectedid=[[NSString alloc]initWithFormat:@"0"];
        
        
    }
    else
    {
        
        
        
        
    }
    
    
    if ([race_selectedid isEqualToString:@""]||[race_selectedid isEqualToString:@"(null)"]||race_selectedid == nil||race_selectedid==NULL)
        
    {
        
        race_selectedid=[[NSString alloc]initWithFormat:@"0"];
        
        
    }
    else
    {
        
        
        
        
    }
    
    
    if ([edu_selectedid isEqualToString:@""]||[edu_selectedid isEqualToString:@"(null)"]||edu_selectedid == nil||edu_selectedid==NULL)
        
    {
        
        edu_selectedid=[[NSString alloc]initWithFormat:@"0"];
        
        
    }
    else
    {
        
        
        
        
    }
    
    
    
    
    if ([bike_string isEqualToString:@""]||[bike_string isEqualToString:@"(null)"]||bike_string == nil||bike_string==NULL)
        
    {
        
        bike_string=[[NSString alloc]initWithFormat:@"0"];
        
        
    }
    else
    {
        
        
        
        
    }
//
    
    [self searching];
    
}


-(IBAction)search
{
    view_profile_bool = TRUE;
    [self check_others];
}
-(void)searching
{

    global_country_selectedid=[[NSString alloc]initWithFormat:@"%@",country_selectedid];
    global_genderString=[[NSString alloc]initWithFormat:@"%@",genderString];

    global_age_from_string=[[NSString alloc]initWithFormat:@"%@",age_from_string];

    global_age_to_string=[[NSString alloc]initWithFormat:@"%@",age_to_string];

    global_drinker__selectedid=[[NSString alloc]initWithFormat:@"%@",drinker__selectedid];

    global_edu_selectedid=[[NSString alloc]initWithFormat:@"%@",edu_selectedid];

    global_height_from_string=[[NSString alloc]initWithFormat:@"%@",height_from_string];

    global_height_to_string=[[NSString alloc]initWithFormat:@"%@",height_to_string];

    global_smoker_selectedid=[[NSString alloc]initWithFormat:@"%@",smoker_selectedid];

    global_interest_Business=[[NSString alloc]initWithFormat:@"%@",interest_Business];

    global_interest_chatting=[[NSString alloc]initWithFormat:@"%@",interest_chatting];

    global_interest_dating=[[NSString alloc]initWithFormat:@"%@",interest_dating];
    
    global_interest_flirting=[[NSString alloc]initWithFormat:@"%@",interest_flirting];
    
    global_interest_friendship=[[NSString alloc]initWithFormat:@"%@",interest_friendship];
    
    global_interest_other_activity=[[NSString alloc]initWithFormat:@"%@",interest_other_activity];
    
    global_interest_relationship=[[NSString alloc]initWithFormat:@"%@",interest_relationship];
    
    global_weight_from_string=[[NSString alloc]initWithFormat:@"%@",weight_from_string];
    
    global_weight_to_string=[[NSString alloc]initWithFormat:@"%@",weight_to_string];
    
    global_race_selectedid=[[NSString alloc]initWithFormat:@"%@",race_selectedid];
    global_keyword_string=[[NSString alloc]initWithFormat:@"%@",keyword_string];
    global_haircolor_selectedid=[[NSString alloc]initWithFormat:@"%@",haircolor_selectedid];
    
    global_eyecolor_selectedid=[[NSString alloc]initWithFormat:@"%@",eyecolor_selectedid];
    
    global_car_string=[[NSString alloc]initWithFormat:@"%@",car_string];
    
     global_bike_string=[[NSString alloc]initWithFormat:@"%@",bike_string];
    /*
        NSURL *url = [NSURL URLWithString:@"http://192.168.0.111/DatingService/getDetails.svc/getSearchResults/"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
       
    
    NSString *str_url=[[NSString alloc]initWithFormat:@"{\"Gender\":\"%@\",\"userCountryID\":\"%@\",\"userHeightFrom\":\"%@\",\"userHeightTo\":\"%@\",\"userWeightFrom\":\"%@\",\"userWeightTo\":\"%@\",\"userAgeFrom\":\"%@\",\"userAgeTo\":\"%@\",\"userRaceID\":\"%@\",\"userHairColorID\":\"%@\",\"userEyesColorID\":\"%@\",\"userEducationLevelID\":\"%@\",\"drinkerTypeID\":\"%@\",\"smokerTypeID\":\"%@\",\"isDriveCar\":\"%@\",\"isDriveBike\":\"%@\",\"isInterestedInBusinessNetworking\":\"%@\",\"isInterestedInChatting\":\"%@\",\"isInterestedInDating\":\"%@\",\"isInterestedInFlirting\":\"%@\",\"isInterestedInFriendships\":\"%@\",\"isInterestedInOtherActivities\":\"%@\",\"isInterestedInRelationships\":\"%@\",\"userKeywords\":\"%@\"}",genderString,country_selectedid,height_from_string,height_to_string,weight_from_string,weight_to_string,age_from_string,age_to_string,race_selectedid,haircolor_selectedid,eyecolor_selectedid,edu_selectedid,drinker__selectedid,smoker_selectedid,car_string,bike_string,interest_Business,interest_chatting,interest_dating,interest_flirting,interest_friendship,interest_other_activity,interest_relationship,keyword_string];
     
     
    
    NSLog(@"str_url:%@",str_url);
    [request appendPostData:[str_url dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    //[request addRequestHeader:@"Accept" value:@"application/json"];
    [request setRequestMethod:@"POST"];
    [request setDelegate:self];
    [request startAsynchronous];
    */
    // Start hud
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading...";
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    Search_list *search_list=[[Search_list alloc]initWithNibName:@"Search_list" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:search_list animated:NO];
    



}
- (void)viewDidUnload
{
    [global_msg_btn release];
    global_msg_btn = nil;
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


- (void)dealloc {
    [global_msg_btn release];
    [super dealloc];
}
@end
