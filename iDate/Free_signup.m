//
//  Free_signup.m
//  iDate
//
//  Created by D M R on 08/08/12.
//  Copyright (c) 2012 iHubTechnologies. All rights reserved.
//

#import "Free_signup.h"
#import "JSON1.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "JSON.h"
#import "MBProgressHUD.h"
#import "Terms_View.h"
#import "RootViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "UIViewController+MJPopupViewController.h"
#import "Vital_stats_view.h"
#import "Login.h"
#import "AppDelegate.h"


@interface Free_signup ()<Terms_ViewDelegate,Vital_sate_delegate>
{
    Terms_View *terms_service;
    Vital_stats_view *vital_view;
}


@end

@implementation Free_signup
@synthesize editButton,cancelButton,deleteButton,editLangButton,doneLangButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{

    if (check_bool==TRUE)
    {
        name_txt.text=fname;
        email_txt.text=femail;
        realname_txt.text=fname;
        
        if ([fgender isEqualToString:@"male"])
        {
            genderString=[[NSString alloc]initWithFormat:@"1"];  
            
            [male_btn setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
            [female_btn setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
        }
        
        else  if ([fgender isEqualToString:@"female"])
        {
             genderString=[[NSString alloc]initWithFormat:@"0"];  
            [female_btn setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
            [male_btn setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
        }
    
    }
    else
    {
        
    }

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    lang_tabel_view.allowsMultipleSelectionDuringEditing = YES;
    lang_tblcontain_view.frame = CGRectMake(641,0, 320, 300);
    tab_btns_tbl.frame = CGRectMake(0, 0, 320, 44);
    [lang_tblcontain_view addSubview:tab_btns_tbl];
    
    
    lbl_partnerwebsitename.text = global_partner_websitename;

    
    if (check_bool==TRUE)
    {
        string_contact=[[NSString alloc]init];
        language_select_new=[[NSString alloc]init];
        final_str=[[NSString alloc]init];
        check_lang_ids = [[NSString alloc]init];
        editparanthese = [[NSString alloc]init];
        //selectedRows = [[NSMutableArray alloc]init];
        lang_name_edit_arr = [[NSMutableArray alloc]init];
        terms_string = [[NSString alloc]initWithFormat:@"0"];
        lang_store_ids = [[NSArray alloc]init];
        lang_edit_arr = [[NSMutableArray alloc]init];
        interest_Business = [[NSString alloc]initWithFormat:@"0"];
        interest_chatting = [[NSString alloc]initWithFormat:@"0"];
        interest_flirting = [[NSString alloc]initWithFormat:@"0"];
        interest_relationship = [[NSString alloc]initWithFormat:@"0"];
        interest_friendship = [[NSString alloc]initWithFormat:@"0"];
        interest_dating = [[NSString alloc]initWithFormat:@"0"];
        interest_other_activity = [[NSString alloc]initWithFormat:@"0"];
    }
    else
    {
        string_contact=[[NSString alloc]init];
        language_select_new=[[NSString alloc]init];
        check_lang_ids = [[NSString alloc]init];
        final_str=[[NSString alloc]init];
        lang_store_ids = [[NSArray alloc]init];
        //selectedRows = [[NSMutableArray alloc]init];
        lang_edit_arr = [[NSMutableArray alloc]init];
        lang_name_edit_arr = [[NSMutableArray alloc]init];
        terms_string = [[NSString alloc]initWithFormat:@"0"];
        genderString = [[NSString alloc]initWithFormat:@"1"];
        interest_Business = [[NSString alloc]initWithFormat:@"0"];
        interest_chatting = [[NSString alloc]initWithFormat:@"0"];
        interest_flirting = [[NSString alloc]initWithFormat:@"0"];
        interest_relationship = [[NSString alloc]initWithFormat:@"0"];
        interest_friendship = [[NSString alloc]initWithFormat:@"0"];
        interest_dating = [[NSString alloc]initWithFormat:@"0"];
        interest_other_activity = [[NSString alloc]initWithFormat:@"0"];
    }
    
    
    
    [self adding_view];
        

          /*
    
    country_arr=[[NSArray alloc]initWithObjects:@"Afghanistan",@"Albania",@"Algeria",@"American Samoa",@"Andorra",@"Angola",@"Anguilla",@"Antractica",@"Antigua And Barbuda",@"Argentina",@"Armenia",@"Aruba",@"Australia",@"Austria",@"Azerbaijan",@"Bahamas",@"Bahrain",@"Bangladesh",@"Barbados",@"Belarus",@"Belgium",@"Belize",@"Benin",@"Bermuda",@"Bhutan",@"Bolivia",@"Bosnia And Herzegovina",@"Botswana",@"Bouvet Island",@"Brazil",@"British Indian Ocean Territory",@"Brunei",@"Bulgaria",@"Burkina Faso",@"Burundi",@"Cambodia",@"Cameroon",@"Canada",@"Cape Verde",@"Cayman Islands",@"Central African Republic",@"Chad",@"Chile",@"China",@"Christmas Island",@"Cocos (Keeling) Islands",@"Colombia",@"Comoros",@"Congo",@"Congo (DRC)",@"Cook Islands",@"Costa Rica",@"Cote Dlvoire",@"Croatia (Hrvatska)",@"Cuba",@"Cyprus",@"Czech Republic",@"Denmark",@"Djibouti",@"Dominica",@"Dominican Republic",@"East Timor",@"Ecuador",@"Egypt",@"El Salvador",@"Equatorial Guinea",@"Eritrea",@"Estonia",@"Ethiopia",@"Falkland Islands ( Islas Malvinas)",@"Faroe Islands",@"Fiji Islands",@"Finland",@"France",@"French Guiana",@"French Polynesia",@"French Southern And Antarctic Lands",@"Gabon",@"Gambia",@"Georgia",@"Germany",@"Ghana",@"Gibraltar",@"Greece",@"Greenland",@"Grenada",@"Guadeloupe",@"Guam",@"Guatemala",@"Guinea",@"GuineaBissau",@"Guyana",@"Haiti",@"Heard Island And McDonald Islands",@"Honduras",@"Hong Kong SAR",@"Hungary",@"Iceland",@"India",@"Indonesia",@"Iran",@"Iraq",@"Ireland",@"Israel",@"Italy",@"Jamaica",@"Japan",@"Jordan",@"Kazakhstan",@"Kenya",@"Kiribati",@"Kuwait",@"Kyrgyzstan",@"Laos",@"Latvia",@"Lebanon",@"Lesotho",@"Liberia",@"Libya",@"Liechtenstein",@"Lithuania",@"Luxembourg",@"Macau SAR",@"Macedonia",@"Madagascar",@"Malawi",@"Malaysia",@"Maldives",@"mali",@"Malta",@"Marshall Islands",@"Martinique",@"Mauritania",@"Mauritius",@"Mayotte",@"Mexico",@"Micronesia",@"Moldova",@"Monaco",@"Mongolia",@"Montserrat",@"Morocco",@"Mozambique",@"Myanmar",@"Namibia",@"Nauru",@"Nepal",@"Netherlands",@"Netherlands Antilles",@"New Caledonia",@"New zealand",@"Nicaragua",@"Niger",@"Nigeria",@"Niue",@"Norfolk Island",@"North Korea",@"Northern Mariana Island", nil];
    
    
    
    country_arr_number=[[NSArray alloc]initWithObjects:@"1",@"2",@"" ,nil];
    */
    
    /*
    city_arr=[[NSArray alloc]initWithObjects:@"Shanghai",@"Istanbul",@"Karachi",@"Mumbai",@"Moscow",@"Beijing",@"Tianjin",@"Delhi",@"Seoul",@"Tokyo",@"Mexico City", nil];
    
    city_arr_number=[[NSArray alloc]initWithObjects:@"", nil];
    
    
    state_arr=[[NSArray alloc]initWithObjects:@"Afghanistan",@"Albania",@"Algeria",@"Angola",@"Bahamas",@"Bahrain",@"Bangladesh",@"Brazil",@"Burma",@"Burundi",nil];
    
    state_arr_number=[[NSArray alloc]initWithObjects:@"", nil];

    lang_arr=[[NSArray alloc]initWithObjects:@"Mandarin",@"English",@"Spanish",@"Hindi",@"Russian",@"Arabic",@"Portuguses",@"Bengali",@"French",@"Malay",@"German",@"Japanese",@"Farsi",@"Urdu",@"Punjabi",@"Vietnamese",@"Javanese",@"Tamil",@"Korean",@"Turkish",@"Telugu",@"Marathi",@"Italian",@"Thai",@"Burmese",@"Cantonese",@"Tagalog",@"Dutch", nil];
    
    lang_arr_number=[[NSArray alloc]initWithObjects:@"", nil];
    
    
    haircolor_arr=[[NSArray alloc]initWithObjects:@"Black",@"Brown",@"Blond",@"Red",@"Gray/White",@"Others", nil];
    
    haircolor_arr_number=[[NSArray alloc]initWithObjects:@"", nil];
    
    
    eyecolor_arr=[[NSArray alloc]initWithObjects:@"Black",@"Brown",@"Hazel",@"Gray",@"Blue",@"Amber",@"Green",@"Violet",@"Red",@"others",nil];
    
    eyecolor_arr_number=[[NSArray alloc]initWithObjects:@"", nil];
    
    education_arr=[[NSArray alloc]initWithObjects:@"School Dropout",@"High School",@"College",@"Bachelors Degree",@"Masters Degree",@"Doctoral Degree",@"Others",nil];
    
    education_arr_number=[[NSArray alloc]initWithObjects:@"", nil];
    
   
    
    interest_arr_number=[[NSArray alloc]initWithObjects:@"", nil];
    
    drinker_arr=[[NSArray alloc]initWithObjects:@"Non Drinker",@"Social Drinker",@"Regular Drinker",@"Heavy Drinker",@"Others", nil];
    drinker_arr_number=[[NSArray alloc]initWithObjects:@"", nil];
    
    smoker_arr=[[NSArray alloc]initWithObjects:@"Non Smoker",@"Social Smoker",@"Regular Smoker",@"Heavy Drinker",@"others", nil]; 
    smoker_arr_number=[[NSArray alloc]initWithObjects:@"", nil];
    
    race_arr=[[NSArray alloc]initWithObjects:@"Singaporean Chinese",@"Singaporean Malay",@"Singaporean Indian",@"Singaporean others",@"American (North/South)",@"European",@"Middle Eastern",@"Australian",@"African",@"Indonesian",@"Vietnamese",@"Thai",@"Chinese",@"Malay",@"Indian",@"others", nil];
    
    race_arr_number=[[NSArray alloc]initWithObjects:@"", nil];
    
    
    /////////////////numbre/////////////////////////
    
  */
    
    
   /* 
    NSString *str=[[NSString alloc]initWithFormat:@"http://192.168.0.111/DatingService/signUp.svc/createAccount/isMale=male&userName=rinku&userPassword=rinku123&serEmail=rinku@handsintechnology.com&userRealName=rink&userMobileNumber=3665664654564&userDOBDay=2&userDOBMonth=9&userDOBYear=2012&userCountryID=india&userCountrystateID=maharashtra&userCountrystateCityID=mumbai&languageID=hindi&userHeight=1&userWeight=50&userVitalStatsWaist=30&userVitalStatsHips=5&userVitalStatsBust=10&userCupSize=4&userRaceID=hindu&userHairColorID=red&userEyesColorID=brown&userEducationLevelID=deg&drinkerTypeID=whisky&smokerTypeID=smoke&isDrivecar=yes&isDriveBike=0&isInterestedInMale=0&isInterestedInFemale=0&isInterestedInBusinessNetworking=0&isInterestedInChatting=0&isInterestedInDating=0&isInterestedInFlirting=0&isInterestedInFriendships=0&isInterestedInOtherActivities=0&isInterestedInRelationships=0&userTagline=0&userShortDescription=0&userLongDescription=0&userKeywords=0&userMinimumBookingFee=0&userminimBookinghour=0&userServicesDescription=0&userAddress=0"
    */
    
    
    
     interest_arr=[[NSMutableArray alloc]initWithObjects:@"Business Networking",@"Chatting",@"Dating",@"Flirting",@"Friendships",@"Relationships",@"Other Activities",nil];
    
    
    
      

    
//    country_picker.frame = CGRectMake(0, 480, 320, 260);
//	country_picker.hidden = TRUE;
//    //  datepick.datePickerMode = UIDatePickerModeDate;
//	[self.view addSubview:country_picker];
    
//    state_picker.frame = CGRectMake(0, 480, 320, 260);
//	state_picker.hidden = TRUE;
//    //  datepick.datePickerMode = UIDatePickerModeDate;
//	[self.view addSubview:state_picker];
    
   /* 
    lang_picker.frame = CGRectMake(0, 480, 320, 260);
	lang_picker.hidden = TRUE;
    //  datepick.datePickerMode = UIDatePickerModeDate;
	[self.view addSubview:lang_picker];
    
    haircolor_picker.frame = CGRectMake(0, 480, 320, 260);
	haircolor_picker.hidden = TRUE;
    //  datepick.datePickerMode = UIDatePickerModeDate;
	[self.view addSubview:haircolor_picker];
    
    
    
    eyescolor_picker.frame = CGRectMake(0, 480, 320, 260);
	eyescolor_picker.hidden = TRUE;
    //  datepick.datePickerMode = UIDatePickerModeDate;
	[self.view addSubview:eyescolor_picker];
    
    
    education_picker.frame = CGRectMake(0, 480, 320, 260);
	education_picker.hidden = TRUE;
    //  datepick.datePickerMode = UIDatePickerModeDate;
	[self.view addSubview:education_picker];
    
    interest_picker.frame = CGRectMake(0, 480, 320, 260);
	interest_picker.hidden = TRUE;
    //  datepick.datePickerMode = UIDatePickerModeDate;
	[self.view addSubview:interest_picker];
    
    drinker_picker.frame = CGRectMake(0, 480, 320, 260);
	drinker_picker.hidden = TRUE;
    //  datepick.datePickerMode = UIDatePickerModeDate;
	[self.view addSubview:drinker_picker];
    
    
    
    smoker_picker.frame = CGRectMake(0, 480, 320, 260);
	smoker_picker.hidden = TRUE;
    //  datepick.datePickerMode = UIDatePickerModeDate;
	[self.view addSubview:smoker_picker];
    

*/    
    
    // Do any additional setup after loading the view from its nib.
}

-(void)adding_view
{

    [pageControl removeFromSuperview];
    if ([genderString isEqualToString:@"1"]) 
    {
        pageControl = [[DDPageControl alloc] init] ;
        [pageControl setCenter:CGPointMake(160, 380)];
        
        [pageControl addTarget: self action: @selector(pageControlClicked:) forControlEvents: UIControlEventValueChanged] ;
        [pageControl setDefersCurrentPageDisplay: YES] ;
        [pageControl setType: DDPageControlTypeOnFullOffFull] ;
        [pageControl setOnColor: [UIColor cyanColor]] ;
        [pageControl setOffColor: [UIColor darkGrayColor]] ;
        [pageControl setIndicatorDiameter: 10.0f] ;
        [pageControl setIndicatorSpace: 10.0f] ;
        [self.view addSubview: pageControl] ;
        [pageControl release];
        
        [pageControl setNumberOfPages:8] ;
        
        
        
        scroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0,110, 320, 256)];
        //scroll.backgroundColor=[UIColor redColor];
        scroll.scrollEnabled=YES;
        scroll.userInteractionEnabled=YES;
        scroll.pagingEnabled = YES;
        scroll.showsHorizontalScrollIndicator = NO;
        scroll.showsVerticalScrollIndicator = NO;
        scroll.scrollsToTop = NO;
        scroll.delegate = self;
        [self.view addSubview:scroll];
        
        [scroll setContentSize:CGSizeMake(320*8, 256)];
        
        
        
        View_1.frame=CGRectMake(0, 0, 320, 256);
        [scroll addSubview:View_1];
        
        
        View_2.frame=CGRectMake(321, 0, 320, 256);
        [scroll addSubview:View_2];
        
        
        View_3.frame=CGRectMake(641, 0, 320, 256);
        [scroll addSubview:View_3];
        
        View_4.frame=CGRectMake(961, 0, 320, 256);
        [scroll addSubview:View_4];
        
        
        View_5.frame=CGRectMake(1281, 0, 320, 256);
        [scroll addSubview:View_5];
        
        
        View_6.frame=CGRectMake(1601, 0, 320, 256);
        [scroll addSubview:View_6];
        
        
        View_7.frame=CGRectMake(1921, 0, 320, 256);
        [scroll addSubview:View_7];
        
        
        //        View_8.frame=CGRectMake(2241, 0, 320, 256);
        //        [scroll addSubview:View_8];
        
        
        
        upload_view.frame=CGRectMake(2241, 0, 320, 256);
        [scroll addSubview:upload_view];
        
        
        dobview.frame = CGRectMake(0, 480, 320, 260);
        dobview.hidden = TRUE;
        dob_picker.datePickerMode = UIDatePickerModeDate;
        [self.view addSubview:dobview];
        // [dobview bringSubviewToFront:self.view];
        [country_btn setTitle:@"Singapore" forState:UIControlStateNormal];
        country_selectedid= @"188";
        
        // country_id_str=[[NSString alloc]initWithFormat:@"188"];
        country_view.frame = CGRectMake(0, 480, 320, 260);
        country_view.hidden = TRUE;
        [self.view addSubview:country_view];
        
        state_view.frame = CGRectMake(0, 480, 320, 260);
        state_view.hidden = TRUE;
        [self.view addSubview:state_view];
        
        city_view.frame = CGRectMake(0, 480, 320, 260);
        city_view.hidden = TRUE;
        [self.view addSubview:city_view];
        
        
       // lang_view.frame = CGRectMake(0, 480, 320, 260);
        //lang_view.hidden = TRUE;
        //[self.view addSubview:lang_view];
        
        //lang_tabel_view.frame = CGRectMake(0, 480, 320, 260);
        //lang_tabel_view.hidden = TRUE;
        //[self.view addSubview:lang_tabel_view];
    
        
        lang_tblcontain_view.frame = CGRectMake(0, 480, 320, 300);
        //lang_tblcontain_view.hidden = TRUE;
        [self.view addSubview:lang_tblcontain_view];
        lang_tblcontain_view.hidden = TRUE;
        
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
    }
    
    else 
    {
        pageControl = [[DDPageControl alloc] init] ;
        [pageControl setCenter:CGPointMake(160, 380)];
        
        [pageControl addTarget: self action: @selector(pageControlClicked:) forControlEvents: UIControlEventValueChanged] ;
        [pageControl setDefersCurrentPageDisplay: YES] ;
        [pageControl setType: DDPageControlTypeOnFullOffFull] ;
        [pageControl setOnColor: [UIColor cyanColor]] ;
        [pageControl setOffColor: [UIColor darkGrayColor]] ;
        [pageControl setIndicatorDiameter: 10.0f] ;
        [pageControl setIndicatorSpace: 10.0f] ;
        [self.view addSubview: pageControl] ;
        [pageControl release];
        
        [pageControl setNumberOfPages:9] ;
        
        
        
        scroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0,110, 320, 256)];
        //scroll.backgroundColor=[UIColor redColor];
        scroll.scrollEnabled=YES;
        scroll.userInteractionEnabled=YES;
        scroll.pagingEnabled = YES;
        scroll.showsHorizontalScrollIndicator = NO;
        scroll.showsVerticalScrollIndicator = NO;
        scroll.scrollsToTop = NO;
        scroll.delegate = self;
        [self.view addSubview:scroll];
        
        [scroll setContentSize:CGSizeMake(320*9, 256)];
        
        
        
        View_1.frame=CGRectMake(0, 0, 320, 256);
        [scroll addSubview:View_1];
        
        
        View_2.frame=CGRectMake(321, 0, 320, 256);
        [scroll addSubview:View_2];
        
        
        View_3.frame=CGRectMake(641, 0, 320, 256);
        [scroll addSubview:View_3];
        
        View_4.frame=CGRectMake(961, 0, 320, 256);
        [scroll addSubview:View_4];
        
        
        View_5.frame=CGRectMake(1281, 0, 320, 256);
        [scroll addSubview:View_5];
        
        
        View_6.frame=CGRectMake(1601, 0, 320, 256);
        [scroll addSubview:View_6];
        
        
        View_7.frame=CGRectMake(1921, 0, 320, 256);
        [scroll addSubview:View_7];
        
        
        View_8.frame=CGRectMake(2241, 0, 320, 256);
        [scroll addSubview:View_8];
        
        
        
        upload_view.frame=CGRectMake(2561, 0, 320, 256);
        [scroll addSubview:upload_view];
        
        
        dobview.frame = CGRectMake(0, 480, 320, 260);
        dobview.hidden = TRUE;
        dob_picker.datePickerMode = UIDatePickerModeDate;
        [self.view addSubview:dobview];
        // [dobview bringSubviewToFront:self.view];
        [country_btn setTitle:@"Singapore" forState:UIControlStateNormal];
        country_selectedid= @"188";
        
        // country_id_str=[[NSString alloc]initWithFormat:@"188"];
        country_view.frame = CGRectMake(0, 480, 320, 260);
        country_view.hidden = TRUE;
        [self.view addSubview:country_view];
        
        state_view.frame = CGRectMake(0, 480, 320, 260);
        state_view.hidden = TRUE;
        [self.view addSubview:state_view];
        
        city_view.frame = CGRectMake(0, 480, 320, 260);
        city_view.hidden = TRUE;
        [self.view addSubview:city_view];
        
        
        //lang_view.frame = CGRectMake(0, 480, 320, 260);
        //lang_view.hidden = TRUE;
        //[self.view addSubview:lang_view];
        
        //lang_tabel_view.frame = CGRectMake(0, 480, 320, 260);
        //lang_tabel_view.hidden = TRUE;
        //[self.view addSubview:lang_tabel_view];
        
        lang_tblcontain_view.frame = CGRectMake(0, 480, 320, 300);
        
        [self.view addSubview:lang_tblcontain_view];
        lang_tblcontain_view.hidden = TRUE;
        
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
        
    }


    [self lang_json_call];
    [lang_tabel_view reloadData];
    
}



/*
- (void)deleteButton:(id)sender
{
    NSString *actionTitle = ([[lang_tabel_view indexPathsForSelectedRows] count] == 1) ?
    @"Are you sure you want to remove this item?" : @"Are you sure you want to remove these items?";
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:actionTitle delegate:self cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:@"OK" otherButtonTitles:nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actionSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"buttonIndex1:%i",buttonIndex);
    if(buttonIndex==0){
        NSLog(@"buttonIndex2:%i",buttonIndex);
        final_str =@"";
        check_lang_ids=@"";
        language_select_new=@"";
        lang_select_str=@"";
        lang_selectedid = @"";
        [lang_edit_arr removeAllObjects];
        lang_textview.text=@"";
        editparanthese =@"";
        [lang_name_edit_arr removeAllObjects];
    
        
       
        
        [lang_tabel_view reloadData];
        
        
        
        
        
    }
    
    
}

*/
-(NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return [lang_arr count];
}


-(UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *cellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil){
        
        cell =[[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier]autorelease];
        
    }
    //[lang_tabel_view selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
    
    NSString *cellValue = [lang_arr objectAtIndex:indexPath.row];
    
    cell.textLabel.text = cellValue;
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    

    
 // [selectedRows addObject:[lang_tabel_view indexPathForSelectedRow]];

    
    
    select = indexPath.row;
    NSLog(@"Entered in didselect:%i",select);
    lang_selectedid=[[NSString alloc]initWithFormat:@"%@",[lang_arr_number objectAtIndex:select]];
    lang_select_str=[[NSString alloc]initWithFormat:@"%@",[lang_arr objectAtIndex:select]];
    
    
    
    
    NSLog(@"Entered in didselect:%@",lang_select_str);
    NSLog(@"Entered in lang_selectedid:%@",lang_selectedid);
    
    lang_selectedid=[lang_selectedid stringByAppendingFormat:@","];
    
    NSLog(@"Entered in lang_selectedidafter:%@",lang_selectedid);
    lang_select_str=[lang_select_str stringByAppendingFormat:@","];
    //language_select_new=[[NSString alloc]initWithFormat:@"%@",[language_select_new stringByAppendingString:lang_selectedid]];
    
    NSLog(@"final_str:%@",final_str);
    NSLog(@"lang_select_str:%@",lang_select_str);
    if([final_str rangeOfString:lang_select_str].location == NSNotFound)
    {
        
        
        final_str=[[NSString alloc]initWithFormat:@"%@",[final_str stringByAppendingString:lang_select_str]];
        NSLog(@"check condition3:%@",check_lang_ids);
                
          check_lang_ids = [[NSString alloc]initWithFormat:@"%@",[check_lang_ids stringByAppendingString:lang_selectedid]];
            NSLog(@"check condition2:%@",check_lang_ids);
        
            
        if ([final_str isEqualToString:@"(null)"]||[final_str isEqualToString:@"(null)"]||final_str==nil||final_str==NULL)
        {
            
        }
        
        else
        {
            [lang_name_edit_arr addObject:[lang_arr objectAtIndex:select]];
            lang_textview.text=final_str;
            
            
            
            //final_str = [[NSString alloc]initWithFormat:@"%@",lang_name_edit_arr];
            
            //final_str = [final_str substringWithRange:NSMakeRange(1, final_str.length-2)];
            
            
            //lang_textview.textAlignment= UITextLayoutDirectionLeft;
            
            
        }

        if ([check_lang_ids isEqualToString:@"(null)"]||[check_lang_ids isEqualToString:@"(null)"]||check_lang_ids==nil||check_lang_ids==NULL)
        {
            NSLog(@"Check lang ID null: %@",check_lang_ids);
        }
        else
        {
            NSLog(@"checkIds:%@",check_lang_ids);
        
            
                        
            [lang_edit_arr addObject:lang_selectedid];
            
            NSLog(@"Entered arry1:%@",lang_edit_arr);
            
            language_select_new = [[NSString alloc]initWithFormat:@"%@",check_lang_ids];
            NSLog(@"Language Selected check:%@",language_select_new);
            
        }
        


    }else
    {
        NSLog(@"Lang Name Already Exists");
    }
    
    
   /*
    if([check_lang_ids rangeOfString:lang_selectedid].location == NSNotFound)
    {
        
        
              
                
    }else
    {
        NSLog(@"Lang ID Already Exists");
    }
*/


}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSLog(@"delete1");
    //NSString *lang_ids_values = [lang_arr_number objectAtIndex:indexPath.row];
    NSString *lang_editvalue = [lang_arr objectAtIndex:indexPath.row];
    NSLog(@"delete2");
    NSString *lang_textviewvalue = [[NSString alloc]initWithFormat:@"%@",final_str];
    final_str=@"";
    check_lang_ids=@"";
    // Remove the row from data model
    //[tableData removeObjectAtIndex:indexPath.row];
    
        NSLog(@"delete3");
        if([lang_textviewvalue rangeOfString:lang_editvalue ].location == NSNotFound){
            NSLog(@"delete4");
            
            NSLog(@"delete notfound");
            
        }else{
            NSLog(@"delete8");
            
            for(int i=0;i<lang_name_edit_arr.count;i++){
                NSLog(@"delete9");
                NSLog(@"value1:%@",lang_editvalue);
                NSLog(@"value2:%@",[lang_name_edit_arr objectAtIndex:i]);
                if([lang_editvalue isEqualToString:[lang_name_edit_arr objectAtIndex:i]]==1){
                    
                    NSLog(@"delete5:%@",[lang_name_edit_arr objectAtIndex:i]);
                    
                    [lang_name_edit_arr removeObjectAtIndex:i];
                    [lang_edit_arr removeObjectAtIndex:i];
                    
                    NSLog(@"delete6:%@",lang_name_edit_arr);
                    
                    if(lang_name_edit_arr.count!=0){
                    for(int k=0;k<lang_name_edit_arr.count;k++){
                        NSLog(@"delete13:%@",[lang_name_edit_arr objectAtIndex:k]);
                        
                    editparanthese = [[ NSString alloc]initWithFormat:@"%@",[lang_name_edit_arr objectAtIndex:k]];
                        editparanthese = [editparanthese stringByAppendingString:@","];
                        NSLog(@"delete14:%@",editparanthese);
                        
                        final_str = [[NSString alloc]initWithFormat:@"%@",[final_str stringByAppendingString:editparanthese]];
                        NSLog(@"delete15:%@",final_str);
                        
                        deselectLangids = [[NSString alloc]initWithFormat:@"%@",[lang_edit_arr objectAtIndex:k]];
                        NSLog(@"editparanthese str:%@",editparanthese);
                        check_lang_ids = [[NSString alloc]initWithFormat:@"%@",[check_lang_ids stringByAppendingString:deselectLangids]];
                        
                    }
                    }else{
                        
                        
                        editparanthese=@"";
                    deselectLangids=@"";
                        
                    }
                    NSLog(@"delete10:%@",editparanthese);
                    NSLog(@"delete10:%@",final_str);
                    NSLog(@"delete10:%@",final_str);
                    
                    lang_textview.text = final_str;
                    
                    NSLog(@"length:%i",editparanthese.length);
                    NSLog(@"lang_edit_arr values:%@",lang_edit_arr);
                    
                    language_select_new = check_lang_ids;
                    
                    NSLog(@"lang_edit_arr values1:%@",lang_edit_arr);
                   // language_select_new = [[NSMutableString alloc]initWithFormat:@"%@",lang_edit_arr];
                    NSLog(@"language_select_new:%@",language_select_new);
                    
                    
                    if(editparanthese.length==1){
                        NSLog(@"delete12");
                        final_str =@"";
                        check_lang_ids=@"";
                        language_select_new=@"0";
                        lang_select_str=@"";
                        lang_selectedid = @"";
                        [lang_edit_arr removeAllObjects];
                        editparanthese =@"";
                        deselectLangids=@"";
                    }
                    
                    
                }
                
            }
            
        }
        
    if (lang_edit_arr.count==0 || ([check_lang_ids isEqualToString:@""]==1)) {
        language_select_new=@"0";
    }
    
    
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return UITableViewCellEditingStyleDelete;

}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
     NSLog(@"delete1");
    //NSString *lang_ids_values = [lang_arr_number objectAtIndex:indexPath.row];
    NSString *lang_editvalue = [lang_arr objectAtIndex:indexPath.row];
    NSString *lang_textviewvalue = [[NSString alloc]initWithFormat:@"%@",final_str];
    NSString *editparanthese;
    NSLog(@"delete2");
    // Remove the row from data model
    //[tableData removeObjectAtIndex:indexPath.row];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
      NSLog(@"delete3");
        if([lang_textviewvalue rangeOfString:lang_editvalue ].location == NSNotFound){
        NSLog(@"delete4");
            
             NSLog(@"delete notfound");
        
        }else{
            NSLog(@"delete8");
            
            for(int i=0;i<lang_name_edit_arr.count;i++){
                NSLog(@"delete9");
                NSLog(@"value1:%@",lang_editvalue);
                NSLog(@"value2:%@",[lang_name_edit_arr objectAtIndex:i]);
                if([lang_editvalue isEqualToString:[lang_name_edit_arr objectAtIndex:i]]==1){
                    
                    NSLog(@"delete5:%@",[lang_name_edit_arr objectAtIndex:i]);
                    //lang_textview.text = [[NSString alloc]initWithFormat:@"%@",[lang_name_edit_arr r];
                    [lang_name_edit_arr removeObjectAtIndex:i];
                    //[lang_name_edit_arr componentsJoinedByString:@","];
                    NSLog(@"delete6:%@",lang_name_edit_arr);
                    editparanthese = [[ NSString alloc]initWithFormat:@"%@",lang_name_edit_arr];
                    NSLog(@"delete10:%@",editparanthese);
             editparanthese = [editparanthese substringWithRange:NSMakeRange(1,editparanthese.length-2)];
                    NSLog(@"delete10:%@",editparanthese);
                    lang_textview.text = editparanthese;
                    //NSLog(@"bool value:%i",[editparanthese isEqualToString:@""]);
                    NSLog(@"length:%i",editparanthese.length);
                    [lang_edit_arr removeObjectAtIndex:i];
                    language_select_new = [[NSMutableString alloc]initWithFormat:@"%@",lang_edit_arr];
                    NSLog(@"language_select_new:%@",language_select_new);
                    
                    
                    if(editparanthese.length==1){
                        NSLog(@"delete12");
                        final_str =@"";
                        check_lang_ids=@"";
                        language_select_new=@"";
                        lang_select_str=@"";
                        lang_selectedid = @"";
                        [lang_edit_arr removeAllObjects];
                    }
                    
                    
                }
                
            }
            
        }
    //[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
     */
    // Request table view to reload
    [tableView reloadData];
}


-(IBAction)vitalclick
{
    if ([genderString isEqualToString:@"1"])
    {
        
         vital_btn.hidden=NO;
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"You are male can't fill this information" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alert show];
		[alert release];

    }
    else 
    {
        vital_btn.hidden=YES;
    }




}
-(IBAction)select_image
{

    UIImagePickerControllerSourceType sourceType = 	UIImagePickerControllerSourceTypePhotoLibrary; 
    UIImagePickerController *picker = [[UIImagePickerController alloc] init]; 
    picker.delegate = self;
    //picker.allowsImageEditing = YES;
	picker.allowsEditing = YES;
    picker.sourceType = sourceType; 
    [self presentModalViewController:picker animated:YES]; 
    [picker release]; 



}
-(IBAction)take_image
{
    BOOL isCamera = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
	if (isCamera==YES)
	{
        UIImagePickerControllerSourceType sourceType = 	UIImagePickerControllerSourceTypeCamera; 
        UIImagePickerController *picker = [[UIImagePickerController alloc] init]; 
        picker.delegate = self;
        //picker.allowsImageEditing = YES;
        picker.allowsEditing = YES;
        picker.sourceType = sourceType; 
        [self presentModalViewController:picker animated:YES]; 
        [picker release]; 
        
        
        
        
        
        
	}
	else 
	{
        
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"No Camera Available" message:@"Sorry, It seems you dont have camera on this device. Please select a picture from your album. " delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}




}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo 
{ 
	//selectImage = YES;
	globImg = [[UIImage alloc]init];
	[globImg retain];
	globImg = image;
	[globImg retain];	
	NSLog(@"globImg:%@",globImg);
	[globImg retain];
	[picker dismissModalViewControllerAnimated:YES];
    profile_image.image= globImg;
}
-(IBAction)notify_tap:(id)sender
{
    UIButton *tappedButton = (UIButton*)sender;
	
	if([tappedButton.currentImage isEqual:[UIImage imageNamed:@"off.png"]])
        // {
	{
        
		[notification_btn setImage:[UIImage imageNamed:@"on.png"] forState:UIControlStateNormal];
		notifystring = [[NSString alloc]initWithFormat:@"1"];
		NSLog(@"notifystring:%@",notifystring);
	}
	
	else 
	{
		[notification_btn setImage:[UIImage imageNamed:@"off.png"] forState:UIControlStateNormal];
		notifystring = [[NSString alloc]initWithFormat:@"0"];
		NSLog(@"notifystring:%@",notifystring);
        
	}


}
-(void)callPopupForUserEntry
{
    terms_service = nil;
    terms_service = [[Terms_View alloc] initWithNibName:@"Terms_View" bundle:nil];
    terms_service.delegate = self;
    [self presentPopupViewController:terms_service animationType:MJPopupViewAnimationFade];
}

-(void)call_vital_stats
{
    vital_view = nil;
    vital_view = [[Vital_stats_view alloc] initWithNibName:@"Vital_stats_view" bundle:nil];
    vital_view.delegate = self;
    [self presentPopupViewController:vital_view animationType:MJPopupViewAnimationFade];

}
-(void)doneButtonClicked:(Terms_View *)SMSUser
{
    
          
        [self cancelButtonClickedForEmail:terms_service];
    
    
    
}

-(void)cancelButtonClickedForEmail:(Terms_View *)SMSUser
{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    terms_service = nil;
}

- (void)doneButtonClicked1:(Vital_stats_view*)femaleuser
{
    
[self cancelButtonClickedForEmail1:vital_view];
}
- (void)cancelButtonClickedForEmail1:(Vital_stats_view*)femaleuser
{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    vital_view = nil;

}
-(IBAction)back
{

    [self.navigationController popViewControllerAnimated:NO];

}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath*)indexPath
{
    // Return YES
    return YES;
}

- (IBAction)toggelEdit:(id)sender {
    
    NSLog(@"Entered in toggelEdit");
    
    
    final_str =@"";
    check_lang_ids=@"";
    language_select_new=@"";
    lang_select_str=@"";
    lang_selectedid = @"";
    [lang_edit_arr removeAllObjects];
    lang_textview.text=@"";
    editparanthese =@"";
    [lang_name_edit_arr removeAllObjects];
    
    
    
    
    [lang_tabel_view reloadData];
    
    
    /*
    if (lang_tabel_view.editing) {
       
        [lang_tabel_view setEditing:NO animated:YES];
    } else {
        
       // self.editLangButton = [[UIBarButtonItem alloc] initWithTitle:@"Delete" style:UIBarButtonItemStyleBordered target:self action:@selector(deleteButton:)];
        
        [editLangButton initWithTitle:@"Delete" style:UIBarButtonItemStyleBordered target:self action:@selector(deleteButton:)];
        
        self.editLangButton.tintColor = [UIColor redColor];
        
        [lang_tabel_view setEditing:YES animated:YES];
        
    }
     */
    
    [self languageViewScrollDown];
    [self clickDone:nil];
}


-(void)languageViewScrollDown{
    
    CGRect frame1 = View_3.frame;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    frame1.origin.x = 641;
    frame1.origin.y = 00;
    View_3.frame = frame1;
    
    [UIView commitAnimations];

    
    
}
- (IBAction)clickDone:(id)sender {
    
    
    CGRect frame = lang_tblcontain_view.frame;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.5];
    frame.origin.y = 300;
    //lang_view.frame = frame;
    lang_tblcontain_view.frame = frame;
    [UIView commitAnimations];
    [self languageViewScrollDown];
    lang_tblcontain_view.hidden = TRUE;
    
    
    
    
}

-(IBAction)DOBPressed
{
    
   // [nametxt resignFirstResponder];
   // [quatxt resignFirstResponder];
    
    [self hide_city_picker ];
    [self hide_country_picker];
    [self hide_drinker_picker];
    [self hide_edu_picker];
    [self hide_eyecolor_picker];
    [self hide_haircolor_picker];
    [self hide_interest_picker];
    [self hide_lang_picker];
    [self hide_smoker_picker];
    [self hide_state_picker];
    
    
    
	dobview.hidden = FALSE;
	CGRect frame = dobview.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.5];
	frame.origin.y = 300;
	dobview.frame = frame;
	[UIView commitAnimations];
    
    
    
	[dob_picker addTarget:self
                 action:@selector(LabelChange:)
       forControlEvents:UIControlEventValueChanged];
	//[self.view addSubview:datePicker];
    
    // [datePicker release];
    
    
}

- (void)LabelChange:(id)sender
{
    
    
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    [format setDateStyle:NSDateFormatterLongStyle];
    
    date1 = dob_picker.date;
    

  
    
           
        NSLog(@"date1:%@",date1);
        str = [format stringFromDate:date1];
        NSLog( @"str:%@",str);
        
        
        [format setDateFormat:@"dd/MM/yyyy"];
        str = [format stringFromDate:date1];
        date1= [format dateFromString:str];
        NSLog(@"Picker row selected:%@",str);
        
        NSLog( @"str:%@",str);
        
        
        [dob_btn setTitle:str forState:UIControlStateNormal];
        
        NSLog( @"str:%@",str);
        
        
        dateselect1 =[[NSString alloc]initWithFormat:@"%@",str];
        
        
        
        NSLog(@"dateselect:%@",dateselect1);
        
        
        
        NSArray *arr = [dateselect1 componentsSeparatedByString:@"/"];
        
        day_string =[[NSString alloc]initWithFormat:@"%@",[arr objectAtIndex:0]];
        month_string =[[NSString alloc]initWithFormat:@"%@",[arr objectAtIndex:1]];
        year_string = [[NSString alloc]initWithFormat:@"%@",[arr objectAtIndex:2]];

        
        

        
     
    
    
      
}
-(IBAction)clickPickerCanel:(id)sender
{
   [dob_btn setTitle:@"" forState:UIControlStateNormal];
    CGRect frame = dobview.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.5];
	frame.origin.y = 880;
	dobview.frame = frame;
	[UIView commitAnimations];
    

}
-(IBAction)clickPickerDone:(id)sender
{
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    [format setDateStyle:NSDateFormatterLongStyle];

    
  
        
//        [dob_btn setTitle:@"" forState:UIControlStateNormal];
//        
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Date selected id future date" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//        [alert release];
//        
        
    
//        
//        str = [format stringFromDate:date1];
//        NSLog( @"str:%@",str);
//        
//        
//        [format setDateStyle:NSDateFormatterShortStyle];
//        str = [format stringFromDate:date1];
//        date1= [format dateFromString:str];
//        NSLog(@"Picker row selected:%@",str);
//        
//        NSLog( @"str:%@",str);
//        
//        
//        [dob_btn setTitle:str forState:UIControlStateNormal];
//        
//        NSLog( @"str:%@",str);
//        
//        
//        dateselect1 =[[NSString alloc]initWithFormat:@"%@",str];
//        
//        
//        
//        NSLog(@"dateselect:%@",dateselect1);
//        
//        
//        
//        NSArray *arr = [dateselect1 componentsSeparatedByString:@"/"];
//        
//        day_string =[[NSString alloc]initWithFormat:@"%@",[arr objectAtIndex:0]];
//        month_string =[[NSString alloc]initWithFormat:@"%@",[arr objectAtIndex:1]];
//        year_string = [[NSString alloc]initWithFormat:@"%@",[arr objectAtIndex:2]];
//        
        
        CGRect frame = dobview.frame;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:.5];
        frame.origin.y = 880;
        dobview.frame = frame;
        [UIView commitAnimations];

        
         
    
  
}
-(IBAction)clickPickerCanel1:(id)sender
{
    
    [country_btn setTitle:@"" forState:UIControlStateNormal];
    CGRect frame = country_view.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.5];
	frame.origin.y = 880;
	country_view.frame = frame;
	[UIView commitAnimations];

}
-(IBAction)clickPickerDone1:(id)sender
{
    country_selectedid=[[NSString alloc]initWithFormat:@"%@",[country_arr_number objectAtIndex:select]];
    
    country_select_str=[[NSString alloc]initWithFormat:@"%@",[country_arr objectAtIndex:select]];
    [country_btn setTitle:country_select_str forState:UIControlStateNormal];

    
    CGRect frame = country_view.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.5];
	frame.origin.y = 880;
	country_view.frame = frame;
	[UIView commitAnimations];

}

-(IBAction)clickPickerCane2:(id)sender
{
    [state_btn setTitle:@"" forState:UIControlStateNormal];
    CGRect frame = state_view.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.5];
	frame.origin.y = 880;
	state_view.frame = frame;
	[UIView commitAnimations];


}
-(IBAction)clickPickerDone2:(id)sender
{
   // [country_btn setTitle:@"" forState:UIControlStateNormal];
     state_selectedid=[[NSString alloc]initWithFormat:@"%@",[state_arr_number objectAtIndex:select]];
    
    state_select_str=[[NSString alloc]initWithFormat:@"%@",[state_arr objectAtIndex:select]];
    [state_btn setTitle:state_select_str forState:UIControlStateNormal];
    
    CGRect frame = state_view.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.5];
	frame.origin.y = 880;
	state_view.frame = frame;
	[UIView commitAnimations];

}

-(IBAction)clickPickerCanel3:(id)sender
{

    [city_btn setTitle:@"" forState:UIControlStateNormal];
    CGRect frame = city_view.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.5];
	frame.origin.y = 880;
	city_view.frame = frame;
	[UIView commitAnimations];


}
-(IBAction)clickPickerDone3:(id)sender
{
   city_selectedid=[[NSString alloc]initWithFormat:@"%@",[city_arr_number objectAtIndex:select]];
    city_select_str=[[NSString alloc]initWithFormat:@"%@",[city_arr objectAtIndex:select]];
    [city_btn setTitle:city_select_str forState:UIControlStateNormal];
    
    CGRect frame = city_view.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.5];
	frame.origin.y = 880;
	city_view.frame = frame;
	[UIView commitAnimations];

}

-(IBAction)clickPickerCanel4:(id)sender
{
    [self langScrollViewUpDown];
    [lang_btn setTitle:@"" forState:UIControlStateNormal];
    CGRect frame = lang_view.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.5];
	frame.origin.y = 880;
	lang_view.frame = frame;
	[UIView commitAnimations];

}

-(void)langScrollViewUpDown{
    
    CGRect frame = View_3.frame;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    frame.origin.x = 641;
    frame.origin.y = 00;
    View_3.frame = frame;
    
    [UIView commitAnimations];
    
    
}
-(IBAction)clickPickerDone4:(id)sender
{
    [self langScrollViewUpDown];
    /*
    if([language_select_new isEqualToString:@""]){
        
        language_select_new=@"0";
        
        
    }
     */
    
    
    
    lang_selectedid=[[NSString alloc]initWithFormat:@"%@",[lang_arr_number objectAtIndex:select]];
    lang_select_str=[[NSString alloc]initWithFormat:@"%@",[lang_arr objectAtIndex:select]];
    
    
    
    lang_selectedid=[lang_selectedid stringByAppendingFormat:@","];
    
    
    lang_select_str=[lang_select_str stringByAppendingFormat:@","];
    language_select_new=[[NSString alloc]initWithFormat:@"%@",[language_select_new stringByAppendingString:lang_selectedid]];
    
    
    if([final_str rangeOfString:lang_select_str].location == NSNotFound)
    {
        
    
    final_str=[[NSString alloc]initWithFormat:@"%@",[final_str stringByAppendingString:lang_select_str]];
    
    
    
    if ([language_select_new isEqualToString:@"(null)"]||[language_select_new isEqualToString:@"(null)"]||language_select_new==nil||language_select_new==NULL)
    {
        
    }
    
    else 
    {
        
    }
    
    
    if ([final_str isEqualToString:@"(null)"]||[final_str isEqualToString:@"(null)"]||final_str==nil||final_str==NULL)
    {
        
    }
    
    else 
    {
        lang_textview.text=final_str;
    }
    }else
    {
        NSLog(@"Already Exists");
    }
    
    
   // [lang_btn setTitle:lang_select_str forState:UIControlStateNormal];
      // lang_textview.text=string_contact;
    
    CGRect frame = lang_view.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.5];
	frame.origin.y = 880;
	lang_view.frame = frame;
	[UIView commitAnimations];



}

- (IBAction)clickPickerReset3:(id)sender {
    
    language_select_new =@"0";
    lang_textview.text=@"";
    final_str =@"";
}

-(IBAction)clickPickerCanel5:(id)sender
{
        
    [race_btn setTitle:@"" forState:UIControlStateNormal];
    CGRect frame = race_view.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.5];
	frame.origin.y = 880;
	race_view.frame = frame;
	[UIView commitAnimations];
    
    CGRect frame1 = View_3.frame;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    frame1.origin.x = 641;
    frame1.origin.y = 0;
    View_3.frame = frame1;
    
    [UIView commitAnimations];
    
   
}
-(IBAction)clickPickerDone5:(id)sender
{
      race_selectedid=[[NSString alloc]initWithFormat:@"%@",[race_arr_number objectAtIndex:select]];
    
    race_select_str=[[NSString alloc]initWithFormat:@"%@",[race_arr objectAtIndex:select]];
    [race_btn setTitle:race_select_str forState:UIControlStateNormal];
    
    CGRect frame = race_view.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.5];
	frame.origin.y = 880;
	race_view.frame = frame;
	[UIView commitAnimations];
    
    CGRect frame1 = View_3.frame;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    frame1.origin.x = 641;
    frame1.origin.y = 0;
    View_3.frame = frame1;
    [UIView commitAnimations];

}

-(IBAction)clickPickerCanel6:(id)sender
{
    [haircolor_btn setTitle:@"" forState:UIControlStateNormal];
    CGRect frame = haircolor_view.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.5];
	frame.origin.y = 880;
	haircolor_view.frame = frame;
	[UIView commitAnimations];


}
-(IBAction)clickPickerDone6:(id)sender
{
 //   [race_btn setTitle:@"" forState:UIControlStateNormal];
    
    haircolor_selectedid=[[NSString alloc]initWithFormat:@"%@",[haircolor_arr_number objectAtIndex:select]];
    hair_select_str=[[NSString alloc]initWithFormat:@"%@",[haircolor_arr objectAtIndex:select]];
    [haircolor_btn setTitle:hair_select_str forState:UIControlStateNormal];
    CGRect frame = haircolor_view.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.5];
	frame.origin.y = 880;
	haircolor_view.frame = frame;
	[UIView commitAnimations];



}

-(IBAction)clickPickerCanel7:(id)sender
{
    [eyescolor_btn setTitle:@"" forState:UIControlStateNormal];
    CGRect frame = eyescolor_view.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.5];
	frame.origin.y = 880;
	eyescolor_view.frame = frame;
	[UIView commitAnimations];


}
-(IBAction)clickPickerDone7:(id)sender
{
   // [race_btn setTitle:@"" forState:UIControlStateNormal];
    
    eyecolor_selectedid=[[NSString alloc]initWithFormat:@"%@",[eyecolor_arr_number objectAtIndex:select]];
    eye_select_str=[[NSString alloc]initWithFormat:@"%@",[eyecolor_arr objectAtIndex:select]];
    [eyescolor_btn setTitle:eye_select_str forState:UIControlStateNormal];
    CGRect frame = eyescolor_view.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.5];
	frame.origin.y = 880;
	eyescolor_view.frame = frame;
	[UIView commitAnimations];



}


-(IBAction)clickPickerCanel8:(id)sender
{
    [edulevel_btn setTitle:@"" forState:UIControlStateNormal];
    CGRect frame = education_view.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.5];
	frame.origin.y = 880;
	education_view.frame = frame;
	[UIView commitAnimations];

}

-(IBAction)clickPickerDone8:(id)sender
{
 edu_selectedid=[[NSString alloc]initWithFormat:@"%@",[education_arr_number objectAtIndex:select]];
    edu_select_str=[[NSString alloc]initWithFormat:@"%@",[education_arr objectAtIndex:select]];
    [edulevel_btn setTitle:edu_select_str forState:UIControlStateNormal];
    CGRect frame = education_view.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.5];
	frame.origin.y = 880;
	education_view.frame = frame;
	[UIView commitAnimations];
}

-(void)SmkDrnkCancelorDoneScrollup{
  
    CGRect frame = View_4.frame;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    frame.origin.x = 961;
    frame.origin.y = -00;
    View_4.frame = frame;
    
    [UIView commitAnimations];
    
}

-(IBAction)clickPickerCanel9:(id)sender
{
    [self SmkDrnkCancelorDoneScrollup];
    
    [drinker_btn setTitle:@"" forState:UIControlStateNormal];
    CGRect frame = drinker_view.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.5];
	frame.origin.y = 880;
	drinker_view.frame = frame;
	[UIView commitAnimations];

    

}
-(IBAction)clickPickerDone9:(id)sender
{
    [self SmkDrnkCancelorDoneScrollup];
    drinker__selectedid=[[NSString alloc]initWithFormat:@"%@",[drinker_arr_number objectAtIndex:select]];
    drinker_select_str=[[NSString alloc]initWithFormat:@"%@",[drinker_arr objectAtIndex:select]];
    [drinker_btn setTitle:drinker_select_str forState:UIControlStateNormal];
    CGRect frame = drinker_view.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.5];
	frame.origin.y = 880;
	drinker_view.frame = frame;
	[UIView commitAnimations];


}
-(IBAction)clickPickerCanel10:(id)sender
{
    [interest_btn setTitle:@"" forState:UIControlStateNormal];
    interest_Business=[[NSString alloc]initWithFormat:@"0"];
    interest_chatting=[[NSString alloc]initWithFormat:@"0"];
    interest_dating=[[NSString alloc]initWithFormat:@"0"];
    interest_flirting=[[NSString alloc]initWithFormat:@"0"];
    interest_friendship=[[NSString alloc]initWithFormat:@"0"];
    interest_relationship=[[NSString alloc]initWithFormat:@"0"];interest_other_activity=[[NSString alloc]initWithFormat:@"0"];

    
    CGRect frame = interest_view.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.5];
	frame.origin.y = 880;
	interest_view.frame = frame;
	[UIView commitAnimations];
    

}
-(IBAction)clickPickerDone10:(id)sender
{
    
    interest_string=[interest_arr objectAtIndex:select];
    
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
	frame.origin.y = 880;
	interest_view.frame = frame;
	[UIView commitAnimations];

}


-(IBAction)clickPickerCanel11:(id)sender
{
    [self SmkDrnkCancelorDoneScrollup];
    
    [smoker_btn setTitle:@"" forState:UIControlStateNormal];
    CGRect frame = smoker_view.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.5];
	frame.origin.y = 880;
	smoker_view.frame = frame;
	[UIView commitAnimations];

}
-(IBAction)clickPickerDone11:(id)sender
{
    [self SmkDrnkCancelorDoneScrollup];
    smoker_selectedid=[[NSString alloc]initWithFormat:@"%@",[smoker_arr_number objectAtIndex:select]];

    smoker_select_str=[[NSString alloc]initWithFormat:@"%@",[smoker_arr objectAtIndex:select]];
    [smoker_btn setTitle:smoker_select_str forState:UIControlStateNormal];
    
    CGRect frame = smoker_view.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.5];
	frame.origin.y = 880;
	smoker_view.frame = frame;
	[UIView commitAnimations];

}
-(IBAction)terms_condition
{
//    Terms_View* B2 = [[Terms_View alloc] init];
//    UINavigationController *B2Nav = [[UINavigationController alloc] initWithRootViewController:B2];  
//    [B2Nav setNavigationBarHidden:YES];
//    B2Nav.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//    [self presentModalViewController:B2Nav animated:YES];
//    [B2 release];
//    [B2Nav release];
 
    [self callPopupForUserEntry];

}
#pragma mark UIPickerView Delegate and datasource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
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
        NSLog(@"Country_picke:%@",country_str);
        //[country_btn setTitle:country_str forState:UIControlStateNormal];
        
               
    }
    else  if (pickerView== state_picker) 
    {
        NSString *state_str=[state_arr objectAtIndex:row];
         NSLog(@"state_str_picke:%@",state_str);
        //[state_btn setTitle:state_str forState:UIControlStateNormal];

    }
    else  if (pickerView== city_picker) 
    {
        NSString *city_str=[city_arr objectAtIndex:row];
        NSLog(@"city_str_picke:%@",city_str);
        //[city_btn setTitle:country_str forState:UIControlStateNormal];
        
    }

    
    else  if (pickerView== lang_picker) 
    {
//        NSString *country_str=[[NSString alloc]initWithFormat:@"%@",[lang_arr objectAtIndex:row]];
//        NSString *country_id=[[NSString alloc]initWithFormat:@"%@",[lang_arr_number objectAtIndex:row]];
//        
//        
//             country_id=[country_id stringByAppendingFormat:@","];
//        
//        
//         country_str=[country_str stringByAppendingFormat:@","];
//        language_select_new=[[NSString alloc]initWithFormat:@"%@",[language_select_new stringByAppendingFormat:country_id]];
//        
//        
//        final_str=[[NSString alloc]initWithFormat:@"%@",[final_str stringByAppendingFormat:country_str]];
//        
//        if ([language_select_new isEqualToString:@"(null)"]||[language_select_new isEqualToString:@"(null)"]||language_select_new==nil||language_select_new==NULL)
//        {
//            
//        }
//        
//        else 
//        {
//           
//        }
//        
//        
//        if ([final_str isEqualToString:@"(null)"]||[final_str isEqualToString:@"(null)"]||final_str==nil||final_str==NULL)
//        {
//            
//        }
//        
//        else 
//        {
//            lang_textview.text=final_str;
//        }

          }
    else  if (pickerView== race_picker) 
    {
       race_str=[race_arr objectAtIndex:row];
        NSLog(@"race_str:%@",race_str);
       // [race_btn setTitle:race_str forState:UIControlStateNormal];
        
    }


    
    else  if (pickerView== haircolor_picker) 
    {
        NSString *haircolor_str=[haircolor_arr objectAtIndex:row];
         NSLog(@"haircolor_str:%@",haircolor_str);
       // [haircolor_btn setTitle:country_str forState:UIControlStateNormal];
        
    }

    
    else  if (pickerView== eyescolor_picker) 
    {
        NSString *eyecolor_str=[eyecolor_arr objectAtIndex:row];
        NSLog(@"eyecolor_str:%@",eyecolor_str);
        [eyescolor_btn setTitle:eyecolor_str forState:UIControlStateNormal];
        
    }

    
    else  if (pickerView== interest_picker) 
    {
        NSString *country_str=[interest_arr objectAtIndex:row];
        
        int_textview.text=country_str;
       // [interest_btn setTitle:country_str forState:UIControlStateNormal];
        
    }

    else  if (pickerView== education_picker) 
    {
        NSString *education_str=[education_arr objectAtIndex:row];
        NSLog(@"education_str:%@",education_str);
        
        //[edulevel_btn setTitle:country_str forState:UIControlStateNormal];
        
    }
    else  if (pickerView== drinker_picker) 
    {
        NSString *drinker_str=[drinker_arr objectAtIndex:row];
        NSLog(@"drinker_str:%@",drinker_str);
        //[drinker_btn setTitle:country_str forState:UIControlStateNormal];
        
    }

    else  if (pickerView== smoker_picker) 
    {
        NSString *smoker_str=[smoker_arr objectAtIndex:row];
        NSLog(@"Smoker_str:%@",smoker_str);
        
        //[smoker_btn setTitle:country_str forState:UIControlStateNormal];
        
    }
  



}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
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


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
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
		[male_btn setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
		[female_btn setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
		genderString = [[NSString alloc]initWithFormat:@"1"];
		NSLog(@"genderStringMale1:%@",genderString);
          cup_string=[[NSString alloc]initWithFormat:@"null"];
          hips_string=[[NSString alloc]initWithFormat:@"null"];
          bust_string=[[NSString alloc]initWithFormat:@"null"];
          waist_string=[[NSString alloc]initWithFormat:@"null"];
        [self adding_view];

	}
	
	else 
	{
		[female_btn setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
		[male_btn setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
		genderString = [[NSString alloc]initWithFormat:@"0"];
		NSLog(@"genderStringFemale:%@",genderString);
        
        [self adding_view];
        
//        [self call_vital_stats];
	}
}


-(IBAction)car_tap:(id)sender
{
	UIButton *tappedButton = (UIButton*)sender;
    
  	if([tappedButton.currentImage isEqual:[UIImage imageNamed:@"unclick_new.png"]])
    {
        [tappedButton setImage:[UIImage imageNamed:@"click_new.png"] forState:UIControlStateNormal];
		car_string = [[NSString alloc]initWithFormat:@"1"];

    }
    
		
	else 
	{
		[tappedButton setImage:[UIImage imageNamed:@"unclick_new.png"] forState:UIControlStateNormal];
		car_string = [[NSString alloc]initWithFormat:@"0"];
		
      		

	}

}
-(IBAction)bike_tap:(id)sender
{

    UIButton *tappedButton = (UIButton*)sender;
	
    if([tappedButton.currentImage isEqual:[UIImage imageNamed:@"unclick_new.png"]])
    {	
        
		[tappedButton setImage:[UIImage imageNamed:@"click_new.png"] forState:UIControlStateNormal];
		bike_string = [[NSString alloc]initWithFormat:@"1"];
		
	}
	
	else 
	{
		[tappedButton setImage:[UIImage imageNamed:@"unclick_new.png"] forState:UIControlStateNormal];
		bike_string = [[NSString alloc]initWithFormat:@"0"];
		
        
	}

    

}
-(IBAction)guy_tap:(id)sender
{


	UIButton *tappedButton = (UIButton*)sender;
	
    if([tappedButton.currentImage isEqual:[UIImage imageNamed:@"unclick_new.png"]])
    
        // {
	{
        
		[tappedButton setImage:[UIImage imageNamed:@"click_new.png"] forState:UIControlStateNormal];
		guys_string = [[NSString alloc]initWithFormat:@"1"];
		NSLog(@"genderStringMale2:%@",genderString);
        
       

	}
	
	else 
	{
		[tappedButton setImage:[UIImage imageNamed:@"unclick_new.png"] forState:UIControlStateNormal];
		guys_string = [[NSString alloc]initWithFormat:@"0"];
		NSLog(@"genderStringMale3:%@",genderString);
        
        
      
        
	}

}
-(IBAction)ladies_tap:(id)sender
{


    UIButton *tappedButton = (UIButton*)sender;
	
    if([tappedButton.currentImage isEqual:[UIImage imageNamed:@"unclick_new.png"]])
        // {
	{
        
		[ladies_btn setImage:[UIImage imageNamed:@"click_new.png"] forState:UIControlStateNormal];
		ladies_string = [[NSString alloc]initWithFormat:@"1"];
		NSLog(@"genderStringMale4:%@",genderString);
	}
	
	else 
	{
		[ladies_btn setImage:[UIImage imageNamed:@"unclick_new.png"] forState:UIControlStateNormal];
		ladies_string = [[NSString alloc]initWithFormat:@"0"];
		NSLog(@"genderStringMale5:%@",genderString);
        
	}

}

-(IBAction)int_business:(id)sender
{
    
    UIButton *tappedButton = (UIButton*)sender;
	
	if([tappedButton.currentImage isEqual:[UIImage imageNamed:@"unclick_new.png"]])
        // {
	{
        
		[int_business_btn setImage:[UIImage imageNamed:@"click_new.png"] forState:UIControlStateNormal];
		interest_Business = [[NSString alloc]initWithFormat:@"1"];
		NSLog(@"interest_Business:%@",interest_Business);
	}
	
	else 
	{
		[int_business_btn setImage:[UIImage imageNamed:@"unclick_new.png"] forState:UIControlStateNormal];
		interest_Business = [[NSString alloc]initWithFormat:@"0"];
		NSLog(@"interest_Business:%@",interest_Business);
        
	}

}
-(IBAction)int_chatting:(id)sender
{
    
    UIButton *tappedButton = (UIButton*)sender;
	
	if([tappedButton.currentImage isEqual:[UIImage imageNamed:@"unclick_new.png"]])
        // {
	{
        
		[int_chatting_btn setImage:[UIImage imageNamed:@"click_new.png"] forState:UIControlStateNormal];
		interest_chatting = [[NSString alloc]initWithFormat:@"1"];
		NSLog(@"interest_chatting:%@",interest_chatting);
	}
	
	else 
	{
		[int_chatting_btn setImage:[UIImage imageNamed:@"unclick_new.png"] forState:UIControlStateNormal];
		interest_chatting = [[NSString alloc]initWithFormat:@"0"];
		NSLog(@"interest_Business:%@",interest_chatting);
        
	}

}
-(IBAction)int_flirting:(id)sender
{
    UIButton *tappedButton = (UIButton*)sender;
	
	if([tappedButton.currentImage isEqual:[UIImage imageNamed:@"unclick_new.png"]])
        // {
	{
        
		[int_flirting_btn setImage:[UIImage imageNamed:@"click_new.png"] forState:UIControlStateNormal];
		interest_flirting = [[NSString alloc]initWithFormat:@"1"];
		NSLog(@"interest_Business:%@",interest_Business);
	}
	
	else 
	{
		[int_flirting_btn setImage:[UIImage imageNamed:@"unclick_new.png"] forState:UIControlStateNormal];
		interest_flirting = [[NSString alloc]initWithFormat:@"0"];
		NSLog(@"interest_Business:%@",interest_Business);
        
	}

}
-(IBAction)int_relation:(id)sender
{
    UIButton *tappedButton = (UIButton*)sender;
	
	if([tappedButton.currentImage isEqual:[UIImage imageNamed:@"unclick_new.png"]])
        // {
	{
        
		[int_relation_btn setImage:[UIImage imageNamed:@"click_new.png"] forState:UIControlStateNormal];
		interest_relationship = [[NSString alloc]initWithFormat:@"1"];
		NSLog(@"interest_relationship:%@",interest_relationship);
	}
	
	else 
	{
		[int_relation_btn setImage:[UIImage imageNamed:@"unclick_new.png"] forState:UIControlStateNormal];
		interest_relationship = [[NSString alloc]initWithFormat:@"0"];
		NSLog(@"interest_relationship:%@",interest_relationship);
        
	}

}
-(IBAction)int_frd:(id)sender
{
    UIButton *tappedButton = (UIButton*)sender;
	
	if([tappedButton.currentImage isEqual:[UIImage imageNamed:@"unclick_new.png"]])
        // {
	{
        
		[int_frd_btn setImage:[UIImage imageNamed:@"click_new.png"] forState:UIControlStateNormal];
		interest_friendship = [[NSString alloc]initWithFormat:@"1"];
		NSLog(@"interest_friendship:%@",interest_friendship);
	}
	
	else 
	{
		[int_frd_btn setImage:[UIImage imageNamed:@"unclick_new.png"] forState:UIControlStateNormal];
		interest_friendship = [[NSString alloc]initWithFormat:@"0"];
		NSLog(@"interest_friendship:%@",interest_friendship);
        
	}

}
-(IBAction)int_dating:(id)sender
{
    UIButton *tappedButton = (UIButton*)sender;
	
	if([tappedButton.currentImage isEqual:[UIImage imageNamed:@"unclick_new.png"]])
        // {
	{
        
		[int_dating_btn setImage:[UIImage imageNamed:@"click_new.png"] forState:UIControlStateNormal];
		interest_dating = [[NSString alloc]initWithFormat:@"1"];
		NSLog(@"interest_dating:%@",interest_dating);
	}
	
	else 
	{
		[int_dating_btn setImage:[UIImage imageNamed:@"unclick_new.png"] forState:UIControlStateNormal];
		interest_dating = [[NSString alloc]initWithFormat:@"0"];
		NSLog(@"interest_dating:%@",interest_dating);
        
	}

}
-(IBAction)int_others:(id)sender
{
    UIButton *tappedButton = (UIButton*)sender;
	
	if([tappedButton.currentImage isEqual:[UIImage imageNamed:@"unclick_new.png"]])
        // {
	{
        
		[int_other_btn setImage:[UIImage imageNamed:@"click_new.png"] forState:UIControlStateNormal];
		interest_other_activity = [[NSString alloc]initWithFormat:@"1"];
		NSLog(@"interest_other_activity:%@",interest_other_activity);
	}
	
	else 
	{
		[int_other_btn setImage:[UIImage imageNamed:@"unclick_new.png"] forState:UIControlStateNormal];
		interest_other_activity = [[NSString alloc]initWithFormat:@"0"];
		NSLog(@"interest_other_activity:%@",interest_other_activity);
        
	}

}
#pragma mark -
#pragma mark DDPageControl triggered actions

- (void)pageControlClicked:(id)sender
{
    
    
	DDPageControl *thePageControl = (DDPageControl *)sender ;
	
	// we need to scroll to the new index
	[scroll setContentOffset: CGPointMake(scroll.bounds.size.width * thePageControl.currentPage, scroll.contentOffset.y) animated: YES] ;
}


#pragma mark -
#pragma mark UIScrollView delegate methods

- (void)scrollViewDidScroll:(UIScrollView *)aScrollView
{
	CGFloat pageWidth = scroll.bounds.size.width ;
    float fractionalPage = scroll.contentOffset.x / pageWidth ;
	NSInteger nearestNumber = lround(fractionalPage) ;
	
	if (pageControl.currentPage != nearestNumber)
	{
		pageControl.currentPage = nearestNumber ;
		
		// if we are dragging, we want to update the page control directly during the drag
		if (scroll.dragging)
			[pageControl updateCurrentPageDisplay] ;
	}
    int i =pageControl.currentPage;
    NSLog(@"i:%d",i);
    pageview=pageControl.currentPage;
   
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)aScrollView
{
	// if we are animating (triggered by clicking on the page control), we update the page control
	[pageControl updateCurrentPageDisplay] ;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    
    if (pageview == 0)
        
    {
        CGRect frame = View_1.frame;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        frame.origin.x = 0;
        frame.origin.y = 0;
        View_1.frame = frame;
        
        [UIView commitAnimations];
    }
    
    else if (pageview == 1)
    {
        
        CGRect frame1 = View_2.frame;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        frame1.origin.x = 321;
        frame1.origin.y = 0;
        View_2.frame = frame1;
        
        [UIView commitAnimations];
        
        
        
    }
    else if (pageview == 2)
        
    {
        
        //    
        
        
        CGRect frame2 = View_3.frame;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        frame2.origin.x = 641;
        frame2.origin.y = 0;
        View_3.frame = frame2;
        
        [UIView commitAnimations];
        //    
        
        //     CGRect frame2 = comview1.frame;
        //    [UIView beginAnimations:nil context:NULL];
        //    [UIView setAnimationDuration:0.5];
        //    frame2.origin.x = 641;
        //    frame2.origin.y = -40;
        //    comview1.frame = frame2;
        //    
        //    [UIView commitAnimations];
        
    }  
    
    else if (pageview == 3) 
    {
        CGRect frame3 = View_4.frame;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        frame3.origin.x = 961;
        frame3.origin.y =0;
        View_4.frame = frame3;
        
        [UIView commitAnimations];
    }
    
    else if(pageview == 4)
        
    {
        CGRect frame3 = View_5.frame;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        frame3.origin.x = 1281;
        frame3.origin.y = 0;
        View_5.frame = frame3;
        
        [UIView commitAnimations];
    }
    
    else if(pageview == 5)
    {
        CGRect frame3 = View_6.frame;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        frame3.origin.x = 1601;
        frame3.origin.y = 0;
        View_6.frame = frame3;
        
        [UIView commitAnimations];
        
    }
    else if(pageview == 6)
    {
        CGRect frame3 = View_7.frame;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        frame3.origin.x = 1921;
        frame3.origin.y = 0;
        View_7.frame = frame3;
        
        [UIView commitAnimations];
        
    }

    
    
    
       
    
	[textField resignFirstResponder]; 
    
    
	
    return YES;
}
/*
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    
    if(pageview == 4){
        if (textView==long_desc)
        {
            CGRect frame = View_5.frame;
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.5];
            frame.origin.x = 1281;
            frame.origin.y = -100;
            View_5.frame = frame;
            
            [UIView commitAnimations];
            
        }else if (textView == short_desc){
            
            CGRect frame = View_5.frame;
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.5];
            frame.origin.x = 1281;
            frame.origin.y = -100;
            View_5.frame = frame;
            
        }
        
        
    }
    
    [textView resignFirstResponder];
    
    return YES;
}
*/
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	NSLog(@"textFieldShouldBeginEditing");
    
    
    if (pageview == 0)
        
    {
        
        
        if (textField==name_txt)
        {
            CGRect frame = View_1.frame;
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.5];
            frame.origin.x = 0;
            frame.origin.y = -40;
            View_1.frame = frame;
            
            [UIView commitAnimations];

        }
        
        
       else if (textField==mob_txt)
        {
            CGRect frame = View_1.frame;
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.5];
            frame.origin.x = 0;
            frame.origin.y = -100;
            View_1.frame = frame;
            
            [UIView commitAnimations];
            
        }
       else {
           CGRect frame = View_1.frame;
           [UIView beginAnimations:nil context:NULL];
           [UIView setAnimationDuration:0.5];
           frame.origin.x = 0;
           frame.origin.y = -60;
           View_1.frame = frame;
           
           [UIView commitAnimations];

       }

        
        
        
           }
    
    else if (pageview == 1)
    {
        
        if (textField==height_txt)
        {
            CGRect frame1 = View_2.frame;
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.5];
            frame1.origin.x = 321;
            frame1.origin.y =-60;
            View_2.frame = frame1;
            
            [UIView commitAnimations];
        }else if (textField == weight_txt){
            
            CGRect frame1 = View_2.frame;
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.5];
            frame1.origin.x = 321;
            frame1.origin.y =-100;
            View_2.frame = frame1;
            
            [UIView commitAnimations];
            
        }
        else
        {
            CGRect frame1 = View_2.frame;
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.5];
            frame1.origin.x = 321;
            frame1.origin.y =-60;
            View_2.frame = frame1;
            
            [UIView commitAnimations];
        }
       
        
        
        
    }
    else if (pageview == 2)
        
    {
        
        //    
        
        
        CGRect frame2 = View_3.frame;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        frame2.origin.x = 641;
        frame2.origin.y = -60;
        View_3.frame = frame2;
        
        [UIView commitAnimations];
        //    
        
        //     CGRect frame2 = comview1.frame;
        //    [UIView beginAnimations:nil context:NULL];
        //    [UIView setAnimationDuration:0.5];
        //    frame2.origin.x = 641;
        //    frame2.origin.y = -40;
        //    comview1.frame = frame2;
        //    
        //    [UIView commitAnimations];
        
    }  
    
    else if (pageview == 3) 
    {
        CGRect frame3 = View_4.frame;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        frame3.origin.x = 961;
        frame3.origin.y =-60;
        View_4.frame = frame3;
        
        [UIView commitAnimations];
    }
    
    else if(pageview == 4)
        
    {
        CGRect frame3 = View_5.frame;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        frame3.origin.x = 1281;
        frame3.origin.y = -90;
        View_5.frame = frame3;
        
        [UIView commitAnimations];
    }
    
    else if(pageview == 5)
    {
        if(textField == tagline_txt){
          
            CGRect frame3 = View_6.frame;
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.5];
            frame3.origin.x = 1601;
            frame3.origin.y = -00;
            View_6.frame = frame3;
            
            [UIView commitAnimations];
            
            
            
        }else if(textField == bookinghr_txt ){
        
            CGRect frame3 = View_6.frame;
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.5];
            frame3.origin.x = 1601;
            frame3.origin.y = -100;
            View_6.frame = frame3;
            
            [UIView commitAnimations];
            
        
        
        }else if(textField == bookingfee_txt){
        
            CGRect frame3 = View_6.frame;
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.5];
            frame3.origin.x = 1601;
            frame3.origin.y = -60;
            View_6.frame = frame3;
            
            [UIView commitAnimations];
        
        
        }else if(textField == bookinghr_txt){
            
            CGRect frame3 = View_6.frame;
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.5];
            frame3.origin.x = 1601;
            frame3.origin.y = -100;
            View_6.frame = frame3;
            
            [UIView commitAnimations];
            
            
        } else{
            
        CGRect frame3 = View_6.frame;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        frame3.origin.x = 1601;
        frame3.origin.y = -60;
        View_6.frame = frame3;
        
        [UIView commitAnimations];
        
        }}
    else if(pageview == 6)
    {
        
        CGRect frame3 = View_7.frame;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        frame3.origin.x = 1921;
        frame3.origin.y = -60;
        View_7.frame = frame3;
        
        [UIView commitAnimations];
        
    }
    
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
- (BOOL)textViewShouldReturn:(UITextView *)textView

{   
	NSLog(@"textViewShouldReturn");
    
    if (pageview == 0)
        
    {
        CGRect frame = View_1.frame;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        frame.origin.x = 0;
        frame.origin.y = 0;
        View_1.frame = frame;
        
        [UIView commitAnimations];
    }
    
    else if (pageview == 1)
    {
        
        CGRect frame1 = View_2.frame;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        frame1.origin.x = 321;
        frame1.origin.y = 0;
        View_2.frame = frame1;
        
        [UIView commitAnimations];
        
        
        
    }
    else if (pageview == 2)
        
    {
        
        //    
        
        
        CGRect frame2 = View_3.frame;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        frame2.origin.x = 641;
        frame2.origin.y = 0;
        View_3.frame = frame2;
        
        [UIView commitAnimations];
        //    
        
        //     CGRect frame2 = comview1.frame;
        //    [UIView beginAnimations:nil context:NULL];
        //    [UIView setAnimationDuration:0.5];
        //    frame2.origin.x = 641;
        //    frame2.origin.y = -40;
        //    comview1.frame = frame2;
        //    
        //    [UIView commitAnimations];
        
    }  
    
    else if (pageview == 3) 
    {
        CGRect frame3 = View_4.frame;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        frame3.origin.x = 961;
        frame3.origin.y =0;
        View_4.frame = frame3;
        
        [UIView commitAnimations];
    }
    
    else if(pageview == 4)
        
    {
        CGRect frame3 = View_5.frame;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        frame3.origin.x = 1281;
        frame3.origin.y = 0;
        View_5.frame = frame3;
        
        [UIView commitAnimations];
    }
    
    else if(pageview == 5)
    {
        CGRect frame3 = View_6.frame;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        frame3.origin.x = 1601;
        frame3.origin.y = 0;
        View_6.frame = frame3;
        
        [UIView commitAnimations];
        
    }
    else if(pageview == 6)
    {
        CGRect frame3 = View_7.frame;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        frame3.origin.x = 1921;
        frame3.origin.y = 0;
        View_7.frame = frame3;
        
        [UIView commitAnimations];
        
    }
    
    
    
    [textView resignFirstResponder];
	return YES;
    
}


- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    NSLog(@"textViewShouldEndEditing");
    
    if (pageview == 0)
        
    {
        CGRect frame = View_1.frame;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        frame.origin.x = 0;
        frame.origin.y = 0;
        View_1.frame = frame;
        
        [UIView commitAnimations];
    }
    
    else if (pageview == 1)
    {
        
        CGRect frame1 = View_2.frame;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        frame1.origin.x = 321;
        frame1.origin.y = 0;
        View_2.frame = frame1;
        
        [UIView commitAnimations];
        
        
        
    }
    else if (pageview == 2)
        
    {
        
        //    
        
        
        CGRect frame2 = View_3.frame;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        frame2.origin.x = 641;
        frame2.origin.y = 0;
        View_3.frame = frame2;
        
        [UIView commitAnimations];
        //    
       }  
    
    else if (pageview == 3) 
    {
        CGRect frame3 = View_4.frame;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        frame3.origin.x = 961;
        frame3.origin.y =0;
        View_4.frame = frame3;
        
        [UIView commitAnimations];
    }
    
    else if(pageview == 4)
        
    {
        CGRect frame3 = View_5.frame;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        frame3.origin.x = 1281;
        frame3.origin.y = 0;
        View_5.frame = frame3;
        
        [UIView commitAnimations];
    }
    
    else if(pageview == 5)
    {
        CGRect frame3 = View_6.frame;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        frame3.origin.x = 1601;
        frame3.origin.y = 0;
        View_6.frame = frame3;
        
        [UIView commitAnimations];
        
    }
    else if(pageview == 6)
    {
        CGRect frame3 = View_7.frame;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        frame3.origin.x = 1921;
        frame3.origin.y = 0;
        View_7.frame = frame3;
        
        [UIView commitAnimations];
        
    }
    
    
    
   	[textView resignFirstResponder];
	return YES;
    
    
}
- (void)textViewDidBeginEditing:(UITextView *)textView 
{          // became first responder'
    
    //    CGRect frame = profileview.frame;
    //    [UIView beginAnimations:nil context:NULL];
    //    [UIView setAnimationDuration:0.5];
    //    frame.origin.x = 0;
    //    frame.origin.y = -35;
    //    profileview.frame = frame;
    //    
    //    [UIView commitAnimations];
    
    
    //    CGRect frame1 = contactview.frame;
    //    [UIView beginAnimations:nil context:NULL];
    //    [UIView setAnimationDuration:0.5];
    //    frame1.origin.x = 0;
    //    frame1.origin.y = -35;
    //    contactview.frame = frame1;
    //    
    //    [UIView commitAnimations];
    //    
    //    
    //    CGRect frame2 = comview1.frame;
    //    [UIView beginAnimations:nil context:NULL];
    //    [UIView setAnimationDuration:0.5];
    //    frame2.origin.x = 0;
    //    frame2.origin.y = -35;
    //    comview1.frame = frame2;
    //    
    //    [UIView commitAnimations];
    //    
    //    CGRect frame3 = comview2.frame;
    //    [UIView beginAnimations:nil context:NULL];
    //    [UIView setAnimationDuration:0.5];
    //    frame3.origin.x = 0;
    //    frame3.origin.y = -35;
    //    comview2.frame = frame3;
    //    
    //    [UIView commitAnimations];
    
    
    
    if (pageview == 0)
        
    {
        CGRect frame = View_1.frame;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        frame.origin.x = 0;
        frame.origin.y = -60;
        View_1.frame = frame;
        
        [UIView commitAnimations];
    }
    
    else if (pageview == 1)
    {
        
        CGRect frame1 = View_2.frame;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        frame1.origin.x = 321;
        frame1.origin.y =-60;
        View_2.frame = frame1;
        
        [UIView commitAnimations];
        
        
        
    }
    else if (pageview == 2)
        
    {
        
        //    
        
        
        CGRect frame2 = View_3.frame;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        frame2.origin.x = 641;
        frame2.origin.y = -60;
        View_3.frame = frame2;
        
        [UIView commitAnimations];
        //    
        
        //     CGRect frame2 = comview1.frame;
        //    [UIView beginAnimations:nil context:NULL];
        //    [UIView setAnimationDuration:0.5];
        //    frame2.origin.x = 641;
        //    frame2.origin.y = -40;
        //    comview1.frame = frame2;
        //    
        //    [UIView commitAnimations];
        
       // textFieldShouldBeginEditing
       // 2012-09-10 14:07:54.278 iDate[1666:f803] textViewShouldEndEditing
       // 2012-09-10 14:07:54.281 iDate[1666:f803] textFieldDidBeginEditing

    }  
    
    
    else if (pageview == 3) 
    {
        CGRect frame3 = View_4.frame;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        frame3.origin.x = 961;
        frame3.origin.y =-60;
        View_4.frame = frame3;
        
        [UIView commitAnimations];
    }
    
    else if(pageview == 4)
        
    {
        CGRect frame3 = View_5.frame;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        frame3.origin.x = 1281;
        frame3.origin.y = -90;
        View_5.frame = frame3;
        
        [UIView commitAnimations];
    }
    
    else if(pageview == 5)
    {
        CGRect frame3 = View_6.frame;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        frame3.origin.x = 1601;
        frame3.origin.y = -40;
        View_6.frame = frame3;
        
        [UIView commitAnimations];
        
    }
    else if(pageview == 6)
    {
        if(textView == userdesc_txt){
        
            CGRect frame3 = View_7.frame;
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.5];
            frame3.origin.x = 1921;
            frame3.origin.y = -00;
            View_7.frame = frame3;
            
            [UIView commitAnimations];
            
        }else{
        CGRect frame3 = View_7.frame;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        frame3.origin.x = 1921;
        frame3.origin.y = -60;
        View_7.frame = frame3;
        
        [UIView commitAnimations];
        }
    }    
    
    
	NSLog(@"textFieldDidBeginEditing");
    
}

- (void)textViewDidEndEditing:(UITextView *)textView { 
    [textView resignFirstResponder];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range 
 replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        // Return FALSE so that the final '\n' character doesn't get added
        return NO;
    }
    // For any other character return TRUE so that the text gets added to the view
    
    
    
    //    if (pageview == 0) {
    //        CGRect frame = profileview.frame;
    //        [UIView beginAnimations:nil context:NULL];
    //        [UIView setAnimationDuration:0.5];
    //        frame.origin.x = 0;
    //        frame.origin.y = -35;
    //        profileview.frame = frame;
    //        
    //        [UIView commitAnimations];
    //    }
    //    
    //    else if (pageview == 1)
    //    {
    //        
    //        CGRect frame1 = contactview.frame;
    //        [UIView beginAnimations:nil context:NULL];
    //        [UIView setAnimationDuration:0.5];
    //        frame1.origin.x = 5;
    //        frame1.origin.y = -20;
    //        contactview.frame = frame1;
    //        
    //        [UIView commitAnimations];
    //        
    //        
    //        
    //    }
    //    else if (pageview == 2)
    //        
    //    {
    //        
    //        //    
    //        //    
    //        CGRect frame2 = comview1.frame;
    //        [UIView beginAnimations:nil context:NULL];
    //        [UIView setAnimationDuration:0.5];
    //        frame2.origin.x = 0;
    //        frame2.origin.y = -35;
    //        comview1.frame = frame2;
    //        
    //        [UIView commitAnimations];
    //    }  
    //    
    //    else if (pageview == 3) 
    //    {
    //        CGRect frame3 = comview2.frame;
    //        [UIView beginAnimations:nil context:NULL];
    //        [UIView setAnimationDuration:0.5];
    //        frame3.origin.x = 0;
    //        frame3.origin.y = -35;
    //        comview2.frame = frame3;
    //        
    //        [UIView commitAnimations];
    //    }
    return YES;
}
-(IBAction)country_pressed
{ 
    
    [name_txt resignFirstResponder];
    [passwd_txt resignFirstResponder];
    [email_txt resignFirstResponder];
    [realname_txt resignFirstResponder];
    [mob_txt resignFirstResponder];
    [height_txt resignFirstResponder];
    [weight_txt resignFirstResponder];
    [waist_txt resignFirstResponder];
    [hips_txt resignFirstResponder];
    [bust_txt resignFirstResponder];
    [cupsize_txt resignFirstResponder];
    [vital_txt resignFirstResponder];
    [tagline_txt resignFirstResponder];
    [short_desc resignFirstResponder];
    [long_desc resignFirstResponder];
    [keyword_txt resignFirstResponder];
    [bookingfee_txt resignFirstResponder];
    [bookinghr_txt resignFirstResponder];
    [userdesc_txt resignFirstResponder];
    [useradd_txt resignFirstResponder];
    
    
    
    [self hide_dob_picker];
    [self hide_city_picker ];
    [self hide_drinker_picker];
    [self hide_edu_picker];
    [self hide_eyecolor_picker];
    [self hide_haircolor_picker];
    [self hide_interest_picker];
    [self hide_lang_picker];
    [self hide_smoker_picker];
    [self hide_state_picker];
    [self hide_race_picker];

    
    [self country_json_call];
    
	
}
-(IBAction)state_pressed
{
    [name_txt resignFirstResponder];
    [passwd_txt resignFirstResponder];
    [email_txt resignFirstResponder];
    [realname_txt resignFirstResponder];
    [mob_txt resignFirstResponder];
    [height_txt resignFirstResponder];
    [weight_txt resignFirstResponder];
    [waist_txt resignFirstResponder];
    [hips_txt resignFirstResponder];
    [bust_txt resignFirstResponder];
    [cupsize_txt resignFirstResponder];
    [vital_txt resignFirstResponder];
    [tagline_txt resignFirstResponder];
    [short_desc resignFirstResponder];
    [long_desc resignFirstResponder];
    [keyword_txt resignFirstResponder];
    [bookingfee_txt resignFirstResponder];
    [bookinghr_txt resignFirstResponder];
    [userdesc_txt resignFirstResponder];
    [useradd_txt resignFirstResponder];

    
    [self hide_dob_picker];
    [self hide_city_picker ];
    [self hide_drinker_picker];
    [self hide_edu_picker];
    [self hide_eyecolor_picker];
    [self hide_haircolor_picker];
    [self hide_interest_picker];
    [self hide_lang_picker];
    [self hide_smoker_picker];
    [self hide_country_picker];
     [self hide_race_picker];
    [self state_json_call];
 }
-(IBAction)city_pressed
{
    [name_txt resignFirstResponder];
    [passwd_txt resignFirstResponder];
    [email_txt resignFirstResponder];
    [realname_txt resignFirstResponder];
    [mob_txt resignFirstResponder];
    [height_txt resignFirstResponder];
    [weight_txt resignFirstResponder];
    [waist_txt resignFirstResponder];
    [hips_txt resignFirstResponder];
    [bust_txt resignFirstResponder];
    [cupsize_txt resignFirstResponder];
    [vital_txt resignFirstResponder];
    [tagline_txt resignFirstResponder];
    [short_desc resignFirstResponder];
    [long_desc resignFirstResponder];
    [keyword_txt resignFirstResponder];
    [bookingfee_txt resignFirstResponder];
    [bookinghr_txt resignFirstResponder];
    [userdesc_txt resignFirstResponder];
    [useradd_txt resignFirstResponder];

    [self hide_dob_picker];
    [self hide_state_picker];
    [self hide_drinker_picker];
    [self hide_edu_picker];
    [self hide_eyecolor_picker];
    [self hide_haircolor_picker];
    [self hide_interest_picker];
    [self hide_lang_picker];
    [self hide_smoker_picker];
    [self hide_country_picker];
     [self hide_race_picker];
      [self city_json_call];
}
-(IBAction)lang_pressed
{
    
    
    
    CGRect frame = View_3.frame;
    //CGRect frame = lang_tabel_view.frame;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    frame.origin.x = 641;
    frame.origin.y = -100;
    View_3.frame = frame;
    //lang_tabel_view.frame = frame;
    [UIView commitAnimations];
    
    /*
    [editLangButton initWithTitle:@"Delete" style:UIBarButtonItemStyleBordered target:self action:@selector(deleteButton:)];
    
    self.editLangButton.tintColor = [UIColor redColor];
     
     */
    
    [lang_tabel_view setEditing:YES animated:YES];
    lang_tblcontain_view.hidden = FALSE;
    
    
    /*
    self.editButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStyleBordered target:self action:@selector(editButton:)];
    self.cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelButton:)];
    self.deleteButton = [[UIBarButtonItem alloc] initWithTitle:@"Delete" style:UIBarButtonItemStyleBordered target:self action:@selector(deleteButton:)];
    
    self.deleteButton.tintColor = [UIColor redColor];
    [self.navigationItem setRightBarButtonItem:self.editButton];
    */

    
    
    /*
    
    string_contact=lang_textview.text;
    
    
       
    if ([string_contact isEqualToString:@""])
    {
        
    }
    else 
    {
        
        
        int count=[string_contact length]; 
        NSLog(@"count:%d",count);
        
        int strint=(int)[string_contact characterAtIndex:count-1];
        NSString *temp=[NSString stringWithFormat:@"%C",strint];
        NSLog(@"temp:%@",temp);
        
        
        if ([temp isEqualToString:@","])
        {
            lang_textview.text=string_contact;
        }
        else 
        {
            
            string_contact= [string_contact stringByAppendingString:@","];
            lang_textview.text=string_contact;
        }
    }
    */
    
    [name_txt resignFirstResponder];
    [passwd_txt resignFirstResponder];
    [email_txt resignFirstResponder];
    [realname_txt resignFirstResponder];
    [mob_txt resignFirstResponder];
    [height_txt resignFirstResponder];
    [weight_txt resignFirstResponder];
    [waist_txt resignFirstResponder];
    [hips_txt resignFirstResponder];
    [bust_txt resignFirstResponder];
    [cupsize_txt resignFirstResponder];
    [vital_txt resignFirstResponder];
    [tagline_txt resignFirstResponder];
    [short_desc resignFirstResponder];
    [long_desc resignFirstResponder];
    [keyword_txt resignFirstResponder];
    [bookingfee_txt resignFirstResponder];
    [bookinghr_txt resignFirstResponder];
    [userdesc_txt resignFirstResponder];
    [useradd_txt resignFirstResponder];

    
    [self hide_dob_picker];
    [self hide_state_picker];
    [self hide_drinker_picker];
    [self hide_edu_picker];
    [self hide_eyecolor_picker];
    [self hide_haircolor_picker];
    [self hide_interest_picker];
    [self hide_city_picker];
    [self hide_smoker_picker];
    [self hide_country_picker];
    [self hide_race_picker];
    //[self lang_json_call];

}

-(IBAction)race_pressed
{
    
    [name_txt resignFirstResponder];
    [passwd_txt resignFirstResponder];
    [email_txt resignFirstResponder];
    [realname_txt resignFirstResponder];
    [mob_txt resignFirstResponder];
    [height_txt resignFirstResponder];
    [weight_txt resignFirstResponder];
    [waist_txt resignFirstResponder];
    [hips_txt resignFirstResponder];
    [bust_txt resignFirstResponder];
    [cupsize_txt resignFirstResponder];
    [vital_txt resignFirstResponder];
    [tagline_txt resignFirstResponder];
    [short_desc resignFirstResponder];
    [long_desc resignFirstResponder];
    [keyword_txt resignFirstResponder];
    [bookingfee_txt resignFirstResponder];
    [bookinghr_txt resignFirstResponder];
    [userdesc_txt resignFirstResponder];
    [useradd_txt resignFirstResponder];

    [self hide_dob_picker];
    [self hide_state_picker];
    [self hide_drinker_picker];
    [self hide_edu_picker];
    [self hide_eyecolor_picker];
    [self hide_haircolor_picker];
    [self hide_interest_picker];
    [self hide_lang_picker];
    [self hide_smoker_picker];
    [self hide_country_picker];
    [self hide_city_picker];
    
    
    [self race_json_call];
}
-(IBAction)haircolor_pressed
{
    
    [name_txt resignFirstResponder];
    [passwd_txt resignFirstResponder];
    [email_txt resignFirstResponder];
    [realname_txt resignFirstResponder];
    [mob_txt resignFirstResponder];
    [height_txt resignFirstResponder];
    [weight_txt resignFirstResponder];
    [waist_txt resignFirstResponder];
    [hips_txt resignFirstResponder];
    [bust_txt resignFirstResponder];
    [cupsize_txt resignFirstResponder];
    [vital_txt resignFirstResponder];
    [tagline_txt resignFirstResponder];
    [short_desc resignFirstResponder];
    [long_desc resignFirstResponder];
    [keyword_txt resignFirstResponder];
    [bookingfee_txt resignFirstResponder];
    [bookinghr_txt resignFirstResponder];
    [userdesc_txt resignFirstResponder];
    [useradd_txt resignFirstResponder];

    [self hide_dob_picker];
    [self hide_state_picker];
    [self hide_drinker_picker];
    [self hide_edu_picker];
    [self hide_eyecolor_picker];
    [self hide_city_picker];
    [self hide_interest_picker];
    [self hide_lang_picker];
    [self hide_smoker_picker];
    [self hide_country_picker];
     [self hide_race_picker];
    [self hair_json_call];
    
   }

-(IBAction)eyecolor_pressed
{
    
    [name_txt resignFirstResponder];
    [passwd_txt resignFirstResponder];
    [email_txt resignFirstResponder];
    [realname_txt resignFirstResponder];
    [mob_txt resignFirstResponder];
    [height_txt resignFirstResponder];
    [weight_txt resignFirstResponder];
    [waist_txt resignFirstResponder];
    [hips_txt resignFirstResponder];
    [bust_txt resignFirstResponder];
    [cupsize_txt resignFirstResponder];
    [vital_txt resignFirstResponder];
    [tagline_txt resignFirstResponder];
    [short_desc resignFirstResponder];
    [long_desc resignFirstResponder];
    [keyword_txt resignFirstResponder];
    [bookingfee_txt resignFirstResponder];
    [bookinghr_txt resignFirstResponder];
    [userdesc_txt resignFirstResponder];
    [useradd_txt resignFirstResponder];

    [self hide_dob_picker];
    [self hide_state_picker];
    [self hide_drinker_picker];
    [self hide_edu_picker];
    [self hide_city_picker];
    [self hide_haircolor_picker];
    [self hide_interest_picker];
    [self hide_lang_picker];
    [self hide_smoker_picker];
    [self hide_country_picker];
     [self hide_race_picker];
    [self eye_json_call];
   
}
-(IBAction)edu_pressed
{   
    
    [name_txt resignFirstResponder];
    [passwd_txt resignFirstResponder];
    [email_txt resignFirstResponder];
    [realname_txt resignFirstResponder];
    [mob_txt resignFirstResponder];
    [height_txt resignFirstResponder];
    [weight_txt resignFirstResponder];
    [waist_txt resignFirstResponder];
    [hips_txt resignFirstResponder];
    [bust_txt resignFirstResponder];
    [cupsize_txt resignFirstResponder];
    [vital_txt resignFirstResponder];
    [tagline_txt resignFirstResponder];
    [short_desc resignFirstResponder];
    [long_desc resignFirstResponder];
    [keyword_txt resignFirstResponder];
    [bookingfee_txt resignFirstResponder];
    [bookinghr_txt resignFirstResponder];
    [userdesc_txt resignFirstResponder];
    [useradd_txt resignFirstResponder];

    [self hide_dob_picker];
    [self hide_state_picker];
    [self hide_drinker_picker];
    [self hide_city_picker];
    [self hide_eyecolor_picker];
    [self hide_haircolor_picker];
    [self hide_interest_picker];
    [self hide_lang_picker];
    [self hide_smoker_picker];
    [self hide_country_picker];
     [self hide_race_picker];
    
    [self edu_json_call];
}

-(IBAction)int_pressed
{
    
    interest_view.hidden = FALSE;
	CGRect frame1 = interest_view.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.5];
	frame1.origin.y = 300;
	interest_view.frame = frame1;
	[UIView commitAnimations];


}

-(IBAction)drink_pressed
{
    CGRect frame = View_4.frame;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    frame.origin.x = 961;
    frame.origin.y = -40;
    View_4.frame = frame;
    
    [UIView commitAnimations];
    
    [name_txt resignFirstResponder];
    [passwd_txt resignFirstResponder];
    [email_txt resignFirstResponder];
    [realname_txt resignFirstResponder];
    [mob_txt resignFirstResponder];
    [height_txt resignFirstResponder];
    [weight_txt resignFirstResponder];
    [waist_txt resignFirstResponder];
    [hips_txt resignFirstResponder];
    [bust_txt resignFirstResponder];
    [cupsize_txt resignFirstResponder];
    [vital_txt resignFirstResponder];
    [tagline_txt resignFirstResponder];
    [short_desc resignFirstResponder];
    [long_desc resignFirstResponder];
    [keyword_txt resignFirstResponder];
    [bookingfee_txt resignFirstResponder];
    [bookinghr_txt resignFirstResponder];
    [userdesc_txt resignFirstResponder];
    [useradd_txt resignFirstResponder];

    [self hide_dob_picker];
    [self hide_state_picker];
    [self hide_city_picker];
    [self hide_edu_picker];
    [self hide_eyecolor_picker];
    [self hide_haircolor_picker];
    [self hide_interest_picker];
    [self hide_lang_picker];
    [self hide_smoker_picker];
    [self hide_country_picker];
     [self hide_race_picker];
    [self drink_json_call];
}
-(IBAction)smoke_pressed
{
    
    CGRect frame = View_4.frame;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    frame.origin.x = 961;
    frame.origin.y = -80;
    View_4.frame = frame;
    
    [UIView commitAnimations];
    
    [name_txt resignFirstResponder];
    [passwd_txt resignFirstResponder];
    [email_txt resignFirstResponder];
    [realname_txt resignFirstResponder];
    [mob_txt resignFirstResponder];
    [height_txt resignFirstResponder];
    [weight_txt resignFirstResponder];
    [waist_txt resignFirstResponder];
    [hips_txt resignFirstResponder];
    [bust_txt resignFirstResponder];
    [cupsize_txt resignFirstResponder];
    [vital_txt resignFirstResponder];
    [tagline_txt resignFirstResponder];
    [short_desc resignFirstResponder];
    [long_desc resignFirstResponder];
    [keyword_txt resignFirstResponder];
    [bookingfee_txt resignFirstResponder];
    [bookinghr_txt resignFirstResponder];
    [userdesc_txt resignFirstResponder];
    [useradd_txt resignFirstResponder];

    [self hide_dob_picker];
    [self hide_state_picker];
    [self hide_drinker_picker];
    [self hide_edu_picker];
    [self hide_eyecolor_picker];
    [self hide_haircolor_picker];
    [self hide_interest_picker];
    [self hide_lang_picker];
    [self hide_city_picker];
    [self hide_country_picker];
     [self hide_race_picker];
    [self smoke_json_call];

}


-(IBAction)Register
{
   	NSLog(@"globImg:%@",globImg);
   
       
    if ([terms_string isEqualToString:@"0"])
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please Check The Terms And Conditions Acceptance Box." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    else
    {
    [self check_compulsory_field];
//
//    
//    [self othercheck_field];
//       [self check_user];
        
      }
    
    //return TRUE;

}
- (void)requestFinished:(ASIHTTPRequest *)request
{    
    
    if (request.responseStatusCode == 400) {
        [MBProgressHUD hideHUDForView:upload_view animated:YES];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Sign up failed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
      
    } else if (request.responseStatusCode == 403) {
        [MBProgressHUD hideHUDForView:upload_view animated:YES];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Sign up failed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    } else if (request.responseStatusCode == 200) 
    {
        
        
      
        if (check_user_bool==TRUE)
        {
            @try{
           responseString = [request responseString];
            NSLog(@"responseString1:%@",responseString);
            
            responseString = [responseString stringByReplacingOccurrencesOfString:@"\""
                                                                       withString:@""];
            
            if ([responseString isEqualToString:@"Username Taken, Please Try Another One."]||[responseString isEqualToString:@"An Account With This Email Already Exists In The System."]) 
            {
                [MBProgressHUD hideHUDForView:upload_view animated:YES];

                name_txt.text=@"";
                email_txt.text=@"";
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Username Taken" message:@"Please Try Another One.An Account With This Email Already Exists In The System" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                [alert release];
            }
           
         
            else
            {
                NSLog(@"check crash1");
            
                [self othercheck_field];
            
            
            }
            NSLog(@"fetch_uid:%@",fetch_uid);   
            NSDictionary *responseDict = [responseString JSONValue];
            NSLog(@"responseDict:%@",responseDict);
            NSString *unlockCode = [responseDict objectForKey:@"unlock_code"];
                NSLog(@"unlockCode:%@",unlockCode);
            check_user_bool=FALSE;
            }@catch (NSException *ex) {
                NSLog(@"Exception2:%@",ex);
            }
       
            }
        

        
        
            else 
            {

        responseString = [request responseString];
        NSLog(@"responseString2:%@",responseString);
        
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\""
                                             withString:@""];

        fetch_uid=[[NSString alloc]initWithFormat:@"%@",responseString];
        NSLog(@"fetch_uid:%@",fetch_uid);   
        NSDictionary *responseDict = [responseString JSONValue];
             NSLog(@"responseDict:%@",responseDict);
        NSString *unlockCode = [responseDict objectForKey:@"unlock_code"];
        
        if ([unlockCode compare:@"com.razeware.test.unlock.cake"] == NSOrderedSame)
        {  [MBProgressHUD hideHUDForView:upload_view animated:YES];
            
              [MBProgressHUD hideHUDForView:upload_view animated:YES];
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Thank you signing up" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
            
            //[self insertlogin];
            
            
            if (globImg==nil||globImg==NULL)
            {
                Login *preview=[[Login alloc]initWithNibName:@"Login" bundle:[NSBundle mainBundle]];
                [self.navigationController pushViewController:preview animated:NO];
               
            }

            else 
            {
                MBProgressHUD *hud1 = [MBProgressHUD showHUDAddedTo:upload_view animated:YES];
                hud1.labelText = @"Uploading image...";            
                
                
                
                [self performSelector:@selector(postimages) withObject:nil afterDelay:3.0];
                //[self performSelector:@selector(postimages_2) withObject:nil afterDelay:3.0];
                
            }
            
          
            
            

        } 
        else 
        {    
            [MBProgressHUD hideHUDForView:upload_view animated:YES];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Sign up failed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];

        }
        
    }
        
    }     
}
-(void)insertlogin
{
    sqlite3_stmt *stmt3;
    char *errorMsg4;
    char *update4 = "insert into login values (?,?,?);";
    
    int x1 = sqlite3_prepare_v2(database, update4, -1, &stmt3, nil);
    
    if (x1 == SQLITE_OK) 
    {
        sqlite3_bind_text(stmt3, 1, NULL,-1, NULL);
        sqlite3_bind_text(stmt3, 2, [responseString UTF8String],-1, NULL);
        sqlite3_bind_text(stmt3, 3, [passwd_txt.text UTF8String],-1, NULL);
        
    }
    if (sqlite3_step(stmt3) != SQLITE_DONE)
        NSLog(@"Error: %s",errorMsg4);
    sqlite3_finalize(stmt3); 
}
- (void)requestFailed:(ASIHTTPRequest *)request
{    
    [MBProgressHUD hideHUDForView:upload_view animated:YES];
    NSError *error = [request error];
    NSLog(@"error:%@",error);
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Sign up failed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [alert release];
}

-(void)postimages
{
    NSLog(@"posting images method");

    int int_value1=[fetch_uid intValue];
   
    NSLog(@"int_value1:%d",int_value1);
    imageData = UIImageJPEGRepresentation(profile_image.image, 90);
    NSLog(@"imageData:%@",imageData);
    NSString *urlString1 =[[NSString alloc]initWithFormat:@"http://192.168.0.111/DatingService/Photos.svc/uploadPhoto?fname=profile_pic.jpg&uid=%d&type=0",int_value1];
    NSLog(@"urlString1:%@",urlString1);
    
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString1]] autorelease];
    [request setValue:@"text/plain" forHTTPHeaderField:@"content-type"];
    [request setHTTPMethod:@"POST"];
    
    [request setValue:[NSString stringWithFormat:@"%d", [imageData length]] forHTTPHeaderField:@"content-length"];
    [request setHTTPBody:imageData];
    
    [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSLog(@"returnData:%@",returnData);
    
    if (returnData==nil)
    { [MBProgressHUD hideHUDForView:upload_view animated:YES];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Image upload failed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];

    }
    else
    {
        // [MBProgressHUD hideHUDForView:upload_view animated:YES];
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Image uploaded" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//        [alert release];
//        
        
        [self postimages_2];
//        Login *preview=[[Login alloc]initWithNibName:@"Login" bundle:[NSBundle mainBundle]];
//        [self.navigationController pushViewController:preview animated:NO];        
    }
   

}

-(void)postimages_2
{

    NSLog(@"enter into postimages_2");

    int int_value1=[fetch_uid intValue];
    
    NSLog(@"int_value1:%d",int_value1);
    imageData = UIImageJPEGRepresentation(profile_image.image, 90);
    NSLog(@"imageData:%@",imageData);
    NSString *urlString1 =[[NSString alloc]initWithFormat:@"http://192.168.0.111/DatingService/Photos.svc/uploadPhoto?fname=profile_pic.jpg&uid=%d&type=1",int_value1];
    NSLog(@"urlString1:%@",urlString1);
    
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString1]] autorelease];
    [request setValue:@"text/plain" forHTTPHeaderField:@"content-type"];
    [request setHTTPMethod:@"POST"];
    
    [request setValue:[NSString stringWithFormat:@"%d", [imageData length]] forHTTPHeaderField:@"content-length"];
    [request setHTTPBody:imageData];
    
    [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSLog(@"returnData:%@",returnData);
    
    if (returnData==nil)
    { [MBProgressHUD hideHUDForView:upload_view animated:YES];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Image upload failed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
    }
    else
    {
        [MBProgressHUD hideHUDForView:upload_view animated:YES];

        [self performSelector:@selector(showing_alert) withObject:nil afterDelay:2.0];
         
    }
    
    
}



-(void)showing_alert
{
    
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Image uploaded" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
           [alert show];
            [alert release];
     [self performSelector:@selector(go_to_login) withObject:nil afterDelay:3.0];
    
    
    
  }
-(void)go_to_login
{

    Login *preview=[[Login alloc]initWithNibName:@"Login" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:preview animated:NO];      
    

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
    
    NSLog(@"returnString:*%@*",returnString);
    
    
    NSDictionary *dict=[returnString JSONValue];

    if (dict==nil||dict==NULL)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"No Response From Server" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    
    
    else {
        
        NSDictionary *str123 = [dict objectForKey:@"getCountriesResult"];
        NSLog(@"str123:%@",str123);
    
       for (NSDictionary *info in str123)
        {
    
            
            NSLog(@"info:%@",info);
        
           country_id_str=[info objectForKey:@"id"];
            [country_arr_number addObject:country_id_str];
              NSLog(@"id_str:*%@*",country_id_str);
       
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
            [country_picker selectRow:0 inComponent:0 animated:YES];
            select=0;
            
       }
        
    }

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
        [state_picker selectRow:0 inComponent:0 animated:NO];
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
        [city_picker selectRow:0 inComponent:0 animated:NO];
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
        
        
        //lang_tblcontain_view.hidden = FALSE;
        
        CGRect frame = lang_tblcontain_view.frame;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:.5];
        frame.origin.y = 300;
        lang_tblcontain_view.frame = frame;
        [UIView commitAnimations];
        
       
       
        //    [lang_tabel_view reloadData];
        
        
        //[lang_tabel_view reloadData];
        [lang_tabel_view selectRowAtIndexPath:0 animated:NO scrollPosition:0];
        //[lang_picker reloadAllComponents];
        //[lang_picker selectRow:0 inComponent:0 animated:NO];
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
        
        CGRect frame = View_3.frame;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        frame.origin.x = 641;
        frame.origin.y = -80;
        View_3.frame = frame;
        
        [UIView commitAnimations];
        
        race_view.hidden = FALSE;
        CGRect frame1 = race_view.frame;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:.5];
        frame1.origin.y = 300;
        race_view.frame = frame1;
        [UIView commitAnimations];
        

        [race_picker reloadAllComponents];
        [race_picker selectRow:0 inComponent:0 animated:NO];
        
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
        [haircolor_picker selectRow:0 inComponent:0 animated:NO];
        
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
        [eyescolor_picker selectRow:0 inComponent:0 animated:NO];
        
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
        [education_picker selectRow:0 inComponent:0 animated:NO];
        
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
        [drinker_picker selectRow:0 inComponent:0 animated:NO];
        
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
        [smoker_picker selectRow:0 inComponent:0 animated:NO];
        
        select=0;

        
        
    }

    }
}
-(void)check_compulsory_field
{

    if ([name_txt.text isEqualToString:@""]||[passwd_txt.text isEqualToString:@""]||[email_txt.text isEqualToString:@""]||[realname_txt.text isEqualToString:@""]) 
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Field of Name,Password,Email and Real name is mandatory" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];

    
    
    }
    else 
    {
        
        [self name_validation];
        
               
           }
        

}


-(void)name_validation
{
    
    NSString *string = name_txt.text;
     NSString *appendS =[string stringByAppendingString:@""];
    NSCharacterSet *alphanumericSet = [NSCharacterSet alphanumericCharacterSet];
    NSCharacterSet *numberSet = [NSCharacterSet decimalDigitCharacterSet];
    
     NSCharacterSet * set = [[NSCharacterSet characterSetWithCharactersInString:@"_"] invertedSet];
    BOOL isAplhaNumericOnly;
    if ([appendS rangeOfCharacterFromSet:set].location != NSNotFound) {
        NSLog(@"This string contains illegal characters");
        isAplhaNumericOnly =1;
        //isAplhaNumericOnly= [[appendS stringByTrimmingCharactersInSet:alphanumericSet] isEqualToString:@""] || [[appendS stringByTrimmingCharactersInSet:numberSet] isEqualToString:@""];
        
    }else{

        
        isAplhaNumericOnly= [[appendS stringByTrimmingCharactersInSet:alphanumericSet] isEqualToString:@""] || [[appendS stringByTrimmingCharactersInSet:numberSet] isEqualToString:@""];
        
        NSLog(@"isAplhaNumericOnly: %d",isAplhaNumericOnly);
    }

    
    //isAplhaNumericOnly= [[string stringByTrimmingCharactersInSet:alphanumericSet] isEqualToString:@" "] || [[string stringByTrimmingCharactersInSet:numberSet] isEqualToString:@""];
    
    
    NSLog(@"isAplhaNumericOnly1: %d",isAplhaNumericOnly);
    
    
    if(isAplhaNumericOnly)
        
    {
        [self password_validation];
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please use alphanumeric for name" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
    }

}
-(void)email_validation
{
    if ([self validateEmail:email_txt.text])
    {
        
        [self check_user];
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please use valid email address" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    

}
-(void)real_name_validation
{
    
    NSString *string2 = realname_txt.text;
    NSCharacterSet *alphanumericSet2 = [NSCharacterSet alphanumericCharacterSet];
    NSCharacterSet *numberSet2 = [NSCharacterSet decimalDigitCharacterSet];
    BOOL isAplhaNumericOnly2;
    //[[string2 stringByTrimmingCharactersInSet:alphanumericSet2] isEqualToString:@" "] || [[string2 stringByTrimmingCharactersInSet:numberSet2] isEqualToString:@""];
    NSCharacterSet * setSpe = [[NSCharacterSet characterSetWithCharactersInString:@"_"] invertedSet];
    
    if ([string2 rangeOfCharacterFromSet:setSpe].location != NSNotFound) {
        
        NSLog(@"This string contains illegal characters");
        isAplhaNumericOnly2 =1;
        //isAplhaNumericOnly= [[appendS stringByTrimmingCharactersInSet:alphanumericSet] isEqualToString:@""] || [[appendS stringByTrimmingCharactersInSet:numberSet] isEqualToString:@""];
        
    }else
    {
        isAplhaNumericOnly2= [[string2 stringByTrimmingCharactersInSet:alphanumericSet2] isEqualToString:@""] || [[string2 stringByTrimmingCharactersInSet:numberSet2] isEqualToString:@""];
    }
    
    
    
    if(isAplhaNumericOnly2)
        
    {
        [self email_validation];
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please use alphanumeric for realname" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
    }
    

}
-(void)password_validation
{
    
    NSString *string1 = passwd_txt.text;
    NSCharacterSet *alphanumericSet1 = [NSCharacterSet alphanumericCharacterSet];
    NSCharacterSet *numberSet1 = [NSCharacterSet decimalDigitCharacterSet];
    //BOOL isAplhaNumericOnly1= [[string1 stringByTrimmingCharactersInSet:alphanumericSet1] isEqualToString:@""] && ![[string1 stringByTrimmingCharactersInSet:numberSet1] isEqualToString:@""];
    BOOL isAplhaNumericOnly1= [[string1 stringByTrimmingCharactersInSet:alphanumericSet1] isEqualToString:@""] || ![[string1 stringByTrimmingCharactersInSet:numberSet1] isEqualToString:@""];
    
    
    
    
    if(isAplhaNumericOnly1)
        
    {
        
        [self real_name_validation];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please use alphanumeric for password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
    }
    

}
-(IBAction)terms_tap:(id)sender
{
    UIButton *tappedButton = (UIButton*)sender;
	
	if([tappedButton.currentImage isEqual:[UIImage imageNamed:@"unclick_new.png"]])
        // {
	{
        
		[terms_btn setImage:[UIImage imageNamed:@"click_new.png"] forState:UIControlStateNormal];
		terms_string = [[NSString alloc]initWithFormat:@"1"];
		NSLog(@"terms_string:%@",terms_string);
	}
	
	else 
	{
		[terms_btn setImage:[UIImage imageNamed:@"unclick_new.png"] forState:UIControlStateNormal];
		terms_string = [[NSString alloc]initWithFormat:@"0"];
		NSLog(@"terms_string:%@",terms_string);
        
	}

}
- (BOOL)validateEmail:(NSString *)candidate 
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"; 
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex]; 
    return [emailTest evaluateWithObject:candidate];
}

-(void)othercheck_field
{
    if ([dateselect1 isEqualToString:@""]||[dateselect1 isEqualToString:@"(null)"]||dateselect1 == nil||dateselect1==NULL)
    {
        day_string=[[NSString alloc]initWithFormat:@"0"];
        month_string=[[NSString alloc]initWithFormat:@"0"];
        year_string =[[NSString alloc]initWithFormat:@"0"];
        [self height_validation];
    }
    else 
    {
        [self height_validation];
    }
    

 
    


}


-(void)country_validation
{
    
    if ([country_selectedid isEqualToString:@""]||[country_selectedid isEqualToString:@"(null)"]||country_selectedid == nil||country_selectedid==NULL)
        
    {
        
        country_selectedid=[[NSString alloc]initWithFormat:@"0"];
        [self state_validation];
        
        
    }
    else
    {
        
        [self state_validation];
        
        
    }
    
  
}
-(void)state_validation
{
    if ([state_selectedid isEqualToString:@""]||[state_selectedid isEqualToString:@"(null)"]||state_selectedid == nil||state_selectedid==NULL)
        
    {
        
        state_selectedid=[[NSString alloc]initWithFormat:@"0"];
        [self city_validation];
        
        
    }
    else
    {
        [self city_validation];

        
        
        
    }
    

}
-(void)city_validation
{
    if ([city_selectedid isEqualToString:@""]||[city_selectedid isEqualToString:@"(null)"]||city_selectedid == nil||city_selectedid==NULL)
        
    {
        
        city_selectedid=[[NSString alloc]initWithFormat:@"0"];
        [self signing_in];
        
    }
    else
    {
        [self signing_in];
        
        
        
    }
    

    
}
-(void)height_validation
{
    if ([height_txt.text isEqualToString:@""]||[height_txt.text isEqualToString:@"(null)"]||height_txt.text == nil||height_txt.text==NULL)
        
    {
        
        height_string=[[NSString alloc]initWithFormat:@"0"];
        
        [self weight_validation];
        
    }
    else
    {
        BOOL valid;
        NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
        NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:height_txt.text];
        valid = [alphaNums isSupersetOfSet:inStringSet];    
        if (!valid) //
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please enter numeric for height" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
            
            
            
        }
        else 
        {
            NSString *height_str=height_txt.text;
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
                height_string=[[NSString alloc]initWithFormat:@"%@",height_txt.text];
                  [self weight_validation];
                
            }
            
        }
        
    }
    

}

-(void)weight_validation

{
    
    if ([weight_txt.text isEqualToString:@""]||[weight_txt.text isEqualToString:@"(null)"]||weight_txt.text == nil||weight_txt.text==NULL)
        
    {
        
        weight_string=[[NSString alloc]initWithFormat:@"0"];   
        [self cup_validation];
    }
    else
    {
        BOOL valid;
        NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
        NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:weight_txt.text];
        valid = [alphaNums isSupersetOfSet:inStringSet];    
        if (!valid) //
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please enter numeric for weight" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
            
            
            
        }
        else 
        {
            NSString *height_str=weight_txt.text;
            NSInteger height_integer=[height_str integerValue];
            
            if (height_integer>250)
            {
                weight_txt.text=@"";
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Weight should not exceed 250 characters" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                [alert release];
                
            }
            else 
            {
                weight_string=[[NSString alloc]initWithFormat:@"%@",weight_txt.text];
                [self cup_validation];
            }
            
        }
        
    }

    
}
-(void)lang_validation
{
    NSLog(@"lang valiadte");
    
    @try {
        
    
        NSLog(@"Language Exception Cache%@:",language_select_new);
    if ([language_select_new isEqualToString:@""]||[language_select_new isEqualToString:@"(null)"]||language_select_new == nil||language_select_new==NULL)
        
    {
        NSLog(@"lang valiadte1");
        language_select_new=[[NSString alloc]initWithFormat:@"0"];
        [self hair_validation];
        
        NSLog(@"lang valiadte2");
    }
    else
    {
        NSLog(@"lang valiadte3");
        
        if ( [language_select_new length]> 0 )
        {
            NSLog(@"lang valiadte4");
            language_select_new = [language_select_new substringToIndex:[language_select_new length] - 1];
             [self hair_validation];
            NSLog(@"lang valiadte5");
        }
        
        else 
        {
            
        }
        
        
    }
    }
    @catch (NSException *exception) {
        NSLog(@"Exception:%@",exception);
    }
}
-(void)hair_validation
{
    if ([haircolor_selectedid isEqualToString:@""]||[haircolor_selectedid isEqualToString:@"(null)"]||haircolor_selectedid == nil||haircolor_selectedid==NULL)
        
    {
        
        haircolor_selectedid=[[NSString alloc]initWithFormat:@"0"];
        [self eye_validation];
        
        
    }
    else
    {
        
         [self eye_validation];
        
        
    }

}
-(void)eye_validation
{
    if ([eyecolor_selectedid isEqualToString:@""]||[eyecolor_selectedid isEqualToString:@"(null)"]||eyecolor_selectedid == nil||eyecolor_selectedid==NULL)
        
    {
        
        eyecolor_selectedid=[[NSString alloc]initWithFormat:@"0"];
        [self edu_validation];
        
        
    }
    else
    {
        
         [self edu_validation];
        
        
    }

}
-(void)edu_validation
{
    
    if ([edu_selectedid isEqualToString:@""]||[edu_selectedid isEqualToString:@"(null)"]||edu_selectedid == nil||edu_selectedid==NULL)
        
    {
        
        edu_selectedid=[[NSString alloc]initWithFormat:@"0"];
        [self drinker_validation];
        
        
    }
    else
    {
        [self drinker_validation];

        
        
        
    }
    

}
-(void)drinker_validation
{
    if ([drinker__selectedid isEqualToString:@""]||[drinker__selectedid isEqualToString:@"(null)"]||drinker__selectedid == nil||drinker__selectedid==NULL)
        
    {
        
        drinker__selectedid=[[NSString alloc]initWithFormat:@"0"];
        [self smoker_validation];
        
        
    }
    else
    {
        [self smoker_validation];

        
        
        
    }

}
-(void)smoker_validation
{
    if ([smoker_selectedid isEqualToString:@""]||[smoker_selectedid isEqualToString:@"(null)"]||smoker_selectedid == nil||smoker_selectedid==NULL)
        
    {
        
        smoker_selectedid=[[NSString alloc]initWithFormat:@"0"];
        [self race_validation];
        
        
    }
    else
    {
        
         [self race_validation];
        
        
    }
}
-(void)race_validation
{
    if ([race_selectedid isEqualToString:@""]||[race_selectedid isEqualToString:@"(null)"]||race_selectedid == nil||race_selectedid==NULL)
        
    {
        
        race_selectedid=[[NSString alloc]initWithFormat:@"0"];
        [self drive_car_validation];
        
        
    }
    else
    {
        [self drive_car_validation];

        
        
        
    }
    

}
-(void)drive_car_validation
{
    if ([car_string isEqualToString:@""]||[car_string isEqualToString:@"(null)"]||car_string == nil||car_string==NULL)
        
    {
        
        car_string=[[NSString alloc]initWithFormat:@"0"];
        [self drive_bike_validation];

        
    }
    else
    {
        
          [self drive_bike_validation];
        
        
    }

}
-(void)drive_bike_validation
{
    if ([bike_string isEqualToString:@""]||[bike_string isEqualToString:@"(null)"]||bike_string == nil||bike_string==NULL)
        
    {
        
        bike_string=[[NSString alloc]initWithFormat:@"0"];
        [self guys_validation];
        
        
    }
    else
    {
        
         [self guys_validation];
        
        
    }
    

}
-(void)guys_validation
{
    if ([guys_string isEqualToString:@""]||[guys_string isEqualToString:@"(null)"]||guys_string == nil||guys_string==NULL)
        
    {
        
        guys_string=[[NSString alloc]initWithFormat:@"0"];
         [self ladies_validation];
        
        
    }
    else
    {
         [self ladies_validation];
    }
    

}
-(void)ladies_validation
{
    if ([ladies_string isEqualToString:@""]||[ladies_string isEqualToString:@"(null)"]||ladies_string == nil||ladies_string==NULL)
        
    {
        
        ladies_string=[[NSString alloc]initWithFormat:@"0"];
        [self tagline_validation];
        
        
    }
    else
    {
        
         [self tagline_validation];
        
        
    }
    

}
-(void)booking_fee_validation
{
    if ([bookingfee_txt.text isEqualToString:@""]||[bookingfee_txt.text isEqualToString:@"(null)"]||bookingfee_txt.text == nil||bookingfee_txt.text==NULL)
        
    {
        
        booking_string=[[NSString alloc]initWithFormat:@"0"]; 
        [self booking_hr_validation];
    }
    else
    {
        BOOL valid;
        NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
        NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:bookingfee_txt.text];
        valid = [alphaNums isSupersetOfSet:inStringSet];    
        if (!valid) //
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please Enter Numeric For Booking Fee" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
            
            
            
        }
        else 
        {
            NSString *height_str=bookingfee_txt.text;
            NSInteger height_integer=[height_str integerValue];
            NSLog(@"height_integer1:%i",height_integer);
            booking_string=[[NSString alloc]initWithFormat:@"%@",bookingfee_txt.text];
            [self booking_hr_validation];
            
        }
        
    }

}
-(void)booking_hr_validation
{
    if ([bookinghr_txt.text isEqualToString:@""]||[bookinghr_txt.text isEqualToString:@"(null)"]||bookinghr_txt.text == nil||bookinghr_txt.text==NULL)
        
    {
        
        booking_hr=[[NSString alloc]initWithFormat:@"0"];
        [self lang_validation];
        
    }
    else
    {
        BOOL valid;
        NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
        NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:bookinghr_txt.text];
        valid = [alphaNums isSupersetOfSet:inStringSet];    
        if (!valid) //
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please enter numeric for Booking" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
            
            
            
        }
        else 
        {
            NSString *height_str=bookinghr_txt.text;
            NSLog(@"height_str:%@",height_str);
            
            booking_hr=[[NSString alloc]initWithFormat:@"%@",bookinghr_txt.text];
            NSLog(@"booking_hr:%@",booking_hr);
            [self lang_validation];
        
            
        }
        
    }
    
    

}

-(void)keyword_validation
{
    if ([keyword_txt.text isEqualToString:@""]||[keyword_txt.text isEqualToString:@"(null)"]||keyword_txt.text == nil||keyword_txt.text==NULL)
        
    {
        keyword_string=@"null";
        [self country_validation];
        
        
    }
    else
    {
        @try{
        NSString *string = keyword_txt.text;
        NSCharacterSet *alphanumericSet = [NSCharacterSet alphanumericCharacterSet];
        NSCharacterSet *numberSet = [NSCharacterSet decimalDigitCharacterSet];
        BOOL isAplhaNumericOnly= [[string stringByTrimmingCharactersInSet:alphanumericSet] isEqualToString:@""] || [[string stringByTrimmingCharactersInSet:numberSet] isEqualToString:@""];
        
        NSLog(@"isAplhaNumericOnly2: %d",isAplhaNumericOnly);
        
        
        if(isAplhaNumericOnly == 1)
            
        {
            NSInteger keylength=[string length];
            NSLog(@"enter keywordmani");
            
            if (keylength>500)
            {
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Keyword cannot exceed 500" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                [alert release];
                
            }
            else
            {
                keyword_string=[[NSString alloc]initWithFormat:@"%@",keyword_txt.text];
                 [self country_validation];
                
            }
            
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please use alphanumeric for keyword" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
            
        }
        }@catch (NSException *e) {
            NSLog(@"Exception1:%@",e);
        }
        
        
    }


}
-(void)cup_validation
{
    if ([cupsize_txt.text isEqualToString:@""]||[cupsize_txt.text isEqualToString:@"(null)"]||cupsize_txt.text == nil||cupsize_txt.text==NULL)
        
    {
        
        cup_string=@"null"; 
        [self waist_validation];
    }
    else
    {
        
        
        NSString *regex = @"[A-Z]+"; 
        NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex]; 
        BOOL result = [test evaluateWithObject:cupsize_txt.text];
        
        NSLog(@"result:%d",result);   
        if (!result) //
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please enter one letter alphabet for cup size field" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
            
            
            
        }
        else 
        {
            NSString *cupsize_str=cupsize_txt.text;
            NSInteger cupsize_integer=[cupsize_str length];
            
            if (cupsize_integer>1)
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please enter one letter alphabet for cup size field" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                [alert release];
                
                
            }
            else 
            {
                cup_string=[[NSString alloc]initWithFormat:@"%@",cupsize_txt.text];
                [self waist_validation];
            }
            
        }
        
    }
    


}

-(void)waist_validation
{
    if ([waist_txt.text isEqualToString:@""]||[waist_txt.text isEqualToString:@"(null)"]||waist_txt.text == nil||waist_txt.text==NULL)
        
    {
        
        waist_string=[[NSString alloc]initWithFormat:@"0"];
        [self bust_validation];
        
    }
    else
    {
        
        
        
        BOOL valid;
        NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
        NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:waist_txt.text];
        valid = [alphaNums isSupersetOfSet:inStringSet];    
        if (!valid) //
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please enter numeric for vitalstate" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
            
            
            
        }
        else 
        {
            waist_string=[[NSString alloc]initWithFormat:@"%@",waist_txt.text];  
            [self bust_validation];
        }
        
        
        
    }

}

-(void)hip_validation
{
    if ([hips_txt.text isEqualToString:@""]||[hips_txt.text isEqualToString:@"(null)"]||hips_txt.text == nil||hips_txt.text==NULL)
        
    {
        
        hips_string=[[NSString alloc]initWithFormat:@"0"];
        [self mobile_validation];
        
    }
    else
    {
        
        
        
        BOOL valid;
        NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
        NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:hips_txt.text];
        valid = [alphaNums isSupersetOfSet:inStringSet];    
        if (!valid) //
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please enter numeric for vitalstate" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
            
            
            
        }
        else 
        {
            hips_string=[[NSString alloc]initWithFormat:@"%@",hips_txt.text];
             [self mobile_validation];
        }
        
        
        
    }

}
-(void)bust_validation
{
    if ([bust_txt.text isEqualToString:@""]||[bust_txt.text isEqualToString:@"(null)"]||bust_txt.text == nil||bust_txt.text==NULL)
        
    {
        
        bust_string=[[NSString alloc]initWithFormat:@"0"];
        [self hip_validation];
        
    }
    else
    {
        
        
        
        BOOL valid;
        NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
        NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:bust_txt.text];
        valid = [alphaNums isSupersetOfSet:inStringSet];    
        if (!valid) //
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please enter numeric for vitalstate" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
            
            
            
        }
        else 
        {
            bust_string=[[NSString alloc]initWithFormat:@"%@",bust_txt.text]; 
             [self hip_validation];
        }
        
        
        
    }
    


}

-(void)long_desc_validation
{
    
    if ([long_desc.text isEqualToString:@""]||[long_desc.text isEqualToString:@"(null)"]||long_desc.text == nil||long_desc.text==NULL)
        
    {
        
        long_desc_string=@"null";
        [self user_add_validation];
        
    }
    else
    {
        NSString *string2 = long_desc.text;
        NSInteger keylength=[string2 length];
        
        if (keylength>5000)
        {
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Longdescription cannot exceed 5000" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
            
        }
        else
        {
            long_desc_string=[[NSString alloc]initWithFormat:@"%@",long_desc.text];
            [self user_add_validation];

            
        }
        
    }
}
-(void)short_desc_validation
{
    
    if ([short_desc.text isEqualToString:@""]||[short_desc.text isEqualToString:@"(null)"]||short_desc.text == nil||short_desc.text==NULL)
        
    {
        
        short_desc_string=@"null";
         [self long_desc_validation];
        
    }
    else
    {
        NSString *string3 = short_desc.text;
        NSInteger keylength=[string3 length];
        
        if (keylength>250)
        {
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Shortdescription cannot exceed 250" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
            
        }
        else
        {
            short_desc_string=[[NSString alloc]initWithFormat:@"%@",short_desc.text];
             [self long_desc_validation];
            
            
            
        }
        
    }
    

}
-(void)user_add_validation
{
    if ([useradd_txt.text isEqualToString:@""]||[useradd_txt.text isEqualToString:@"(null)"]||useradd_txt.text == nil||useradd_txt.text==NULL)
        
    {
        user_add_string=@"null";
        [self user_desc_validation];
        
    }
    else
    {
        NSString *string = useradd_txt.text;
        NSInteger keylength=[string length];
        
        if (keylength>500)
        {
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Address cannot exceed 500" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
            
        }
        else
        {
            user_add_string=[[NSString alloc]initWithFormat:@"%@",useradd_txt.text];
             [self user_desc_validation];
        }
        
    }
    
    

}
-(void)user_desc_validation
{
    
    if ([userdesc_txt.text isEqualToString:@""]||[userdesc_txt.text isEqualToString:@"(null)"]||userdesc_txt.text == nil||userdesc_txt.text==NULL)
        
    {
        user_desc_string=@"null";
        [self keyword_validation];
        
        
        
    }
    else
    {
        NSString *string1 = userdesc_txt.text;
        NSInteger keylength=[string1 length];
        
        if (keylength>500)
        {
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Description cannot exceed 500" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
            
        }
        else
        {
            user_desc_string=[[NSString alloc]initWithFormat:@"%@",userdesc_txt.text];
             [self keyword_validation];
        }
        
        
    }

    
}
-(void)mobile_validation
{

    if ([mob_txt.text isEqualToString:@""]||[mob_txt.text isEqualToString:@"(null)"]||mob_txt.text == nil||mob_txt.text==NULL)
        
    {
        
        mobile_string=@"null";
        [self booking_fee_validation];
        
    }
    else
    {
        BOOL valid;
        NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
        NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:mob_txt.text];
        valid = [alphaNums isSupersetOfSet:inStringSet];    
        if (!valid) //
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please enter numeric for mobilenumber" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
            
            
            
        }
        else 
        {
            NSString *height_str=mob_txt.text;
            NSInteger height_integer=[height_str integerValue];
            NSLog(@"height_integer:%i",height_integer);
            mobile_string=[[NSString alloc]initWithFormat:@"%@",mob_txt.text];
             [self booking_fee_validation];
            
        }
        
    }
    
    
    
    


}

-(void)tagline_validation
{
    if ([tagline_txt.text isEqualToString:@""]||[tagline_txt.text isEqualToString:@"(null)"]||tagline_txt.text == nil||tagline_txt.text==NULL)
        
    {
        
        tagline_string=@"null";
        [self short_desc_validation];
        
    }
    else
    {
        NSString *string2 = tagline_txt.text;
        NSInteger keylength=[string2 length];
        
        if (keylength>5000)
        {
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Longdescription cannot exceed 5000" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
            
        }
        else
        {
            tagline_string=[[NSString alloc]initWithFormat:@"%@",tagline_txt.text];
             [self short_desc_validation];
            
        }
        
    }
    

}
-(void)jsoncall
{
    
    
    
    NSString *str_link = [NSString stringWithFormat:@"http://192.168.0.111/DatingService/getDetails.svc/getPartnerContents/1/2"];
    
    NSLog(@"str:%@",str_link);
    
    NSMutableURLRequest *request =[[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:str_link]];
    
    NSData *returnData = [ NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil ];
    
    NSString *returnString = [[NSString alloc]initWithData:returnData encoding:NSUTF8StringEncoding];
    
    NSLog(@"returnString:*%@*",returnString);
    
    
//    NSDictionary *dict=[returnString JSONValue];
//    for (NSDictionary *info in dict)
//    {
//        NSLog(@"info:%@",info);
//        NSString *str123 = [info objectForKey:@"partnerContent"];
//        NSLog(@"str123:%@",str123);
//        
//        if ([str123 isEqualToString:@"(null)"]||[str123 isEqualToString:@""]||str123==nil||str123==NULL)
//        {
//            txtview.text=@"Server problem";
//        }
//        else
//        {
//            
//            txtview.text=str123;
//        }
//        
//    }
    
    
    // NSLog(@"dict1:%@",dict);
    //NSString *str=[dict objectFor]
    
    //   
}

-(void)signing_in
{
    NSLog(@"enter in signing_in");
  
    NSURL *url = [NSURL URLWithString:@"http://192.168.0.111/DatingService/signUp.svc/createAccount/"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    /*
     NSString *str_url=[[NSString alloc]initWithFormat:@"{\"isMale\":\"%@\",\"userName\":\"%@\",\"userPassword\":\"%@\",\"userEmail\":\"%@\",\"userRealName\":\"%@\"}",genderString,name_txt.text,passwd_txt.text,email_txt.text,realname_txt.text];
     
     */
    
    
    
      if (globImg==nil||globImg==NULL)
      {
      
          userfile_string=[[NSString alloc]initWithFormat:@"null"];
          screenshot_string=[[NSString alloc]initWithFormat:@"null"];
      
      }
      else 
      {
          userfile_string=[[NSString alloc]initWithFormat:@"profile_pic.png"];
          screenshot_string=[[NSString alloc]initWithFormat:@"profile_pic.png"];

      }
    
    if([language_select_new isEqualToString:@""]){
        
        language_select_new=@"0";
    }
    NSString *strUsername = name_txt.text;
    //NSString * realNameChng = realname_txt.text;
    NSString *replaUsername = [ strUsername stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    //NSString *replaRealname = [ realNameChng stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    
    NSString *str_url=[[NSString alloc]initWithFormat:@"{\"isMale\":\"%@\",\"userName\":\"%@\",\"userPassword\":\"%@\",\"userEmail\":\"%@\",\"userRealName\":\"%@\",\"userMobileNumber\":\"%@\",\"userDOBDay\":\"%@\",\"userDOBMonth\":\"%@\",\"userDOBYear\":\"%@\",\"userCountryID\":\"%@\",\"userCountrystateID\":\"%@\",\"userCountrystateCityID\":\"%@\",\"languageID\":\"%@\",\"userHeight\":\"%@\",\"userWeight\":\"%@\",\"userVitalStatsWaist\":\"%@\",\"userVitalStatsHips\":\"%@\",\"userVitalStatsBust\":\"%@\",\"userCupSize\":\"%@\",\"userRaceID\":\"%@\",\"userHairColorID\":\"%@\",\"userEyesColorID\":\"%@\",\"userEducationLevelID\":\"%@\",\"drinkerTypeID\":\"%@\",\"smokerTypeID\":\"%@\",\"isDriveCar\":\"%@\",\"isDriveBike\":\"%@\",\"isInterestedInMale\":\"%@\",\"isInterestedInFemale\":\"%@\",\"isInterestedInBusinessNetworking\":\"%@\",\"isInterestedInChatting\":\"%@\",\"isInterestedInDating\":\"%@\",\"isInterestedInFlirting\":\"%@\",\"isInterestedInFriendships\":\"%@\",\"isInterestedInOtherActivities\":\"%@\",\"isInterestedInRelationships\":\"%@\",\"userTagline\":\"%@\",\"userShortDescription\":\"%@\",\"userLongDescription\":\"%@\",\"userKeywords\":\"%@\",\"userMinimumBookingFee\":\"%@\",\"userMinimumBookingHours\":\"%@\",\"userServicesDescription\":\"%@\",\"userAddress\":\"%@\",\"partnerID\":\"%@\",\"bonusCode\":\"Bonus Code\",\"partnerRemarks\":\"Partner Remarks\",\"referredByUserid\":\"0\",\"userFileDescription\":\"null\",\"userFileURL\":\"%@\",\"userFileScreenshotURL\":\"%@\"}",genderString,replaUsername,passwd_txt.text,email_txt.text,realname_txt.text,mobile_string,day_string,month_string,year_string,country_selectedid,state_selectedid,city_selectedid,language_select_new,height_string,weight_string,waist_string,hips_string,bust_string,cup_string,race_selectedid,haircolor_selectedid,eyecolor_selectedid,edu_selectedid,drinker__selectedid,smoker_selectedid,car_string,bike_string,guys_string,ladies_string,interest_Business,interest_chatting,interest_dating,interest_flirting,interest_friendship,interest_other_activity,interest_relationship,tagline_string,short_desc_string,long_desc_string,keyword_string,booking_string,booking_hr,user_desc_string,user_add_string,global_partnerID_str,userfile_string,screenshot_string];
    
    NSLog(@"str_urlfree:%@",str_url);
    [request appendPostData:[str_url dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    //[request addRequestHeader:@"Accept" value:@"application/json"];
    [request setRequestMethod:@"POST"];
    [request setDelegate:self];
    [request startAsynchronous];
    // Start hud
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:upload_view animated:YES];
    hud.labelText = @"Loading...";
    




}
-(void)check_user
{
    @try{
    check_user_bool=TRUE;
    
    
    NSURL *url = [NSURL URLWithString:@"http://192.168.0.111/DatingService/signUp.svc/checkUserNameEmail/"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
      
    
    NSString *str_url=[[NSString alloc]initWithFormat:@"{\"userName\":\"%@\",\"userEmail\":\"%@\"}",name_txt.text,email_txt.text];
    
    NSLog(@"str_urlem:%@",str_url);
    [request appendPostData:[str_url dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    //[request addRequestHeader:@"Accept" value:@"application/json"];
    [request setRequestMethod:@"POST"];
    [request setDelegate:self];
    [request startAsynchronous];
    // Start hud
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:upload_view animated:YES];
//    hud.labelText = @"Loading...";
        
    }@catch (NSException *e) {
        NSLog(@"Exception%@",e);
    }

}
-(void)hide_dob_picker
{

    CGRect frame = dobview.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.5];
	frame.origin.y = 880;
	dobview.frame = frame;
	[UIView commitAnimations];
}
-(void)hide_country_picker
{

    CGRect frame = country_view.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.5];
	frame.origin.y = 880;
	country_view.frame = frame;
	[UIView commitAnimations];
}
-(void)hide_city_picker
{
    CGRect frame = city_view.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.5];
	frame.origin.y = 880;
	city_view.frame = frame;
	[UIView commitAnimations];


}
-(void)hide_lang_picker
{
    CGRect frame = lang_view.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.5];
	frame.origin.y = 880;
	lang_view.frame = frame;
	[UIView commitAnimations];


}
-(void)hide_haircolor_picker
{
    CGRect frame = haircolor_view.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.5];
	frame.origin.y = 880;
	haircolor_view.frame = frame;
	[UIView commitAnimations];


}
-(void)hide_eyecolor_picker
{  
    CGRect frame = eyescolor_view.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.5];
	frame.origin.y = 880;
	eyescolor_view.frame = frame;
	[UIView commitAnimations];


}
-(void)hide_edu_picker
{
    CGRect frame = education_view.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.5];
	frame.origin.y = 880;
	education_view.frame = frame;
	[UIView commitAnimations];
}
-(void)hide_interest_picker
{
    CGRect frame = country_view.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.5];
	frame.origin.y = 880;
	country_view.frame = frame;
	[UIView commitAnimations];

}
-(void)hide_drinker_picker
{
    CGRect frame = drinker_view.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.5];
	frame.origin.y = 880;
	drinker_view.frame = frame;
	[UIView commitAnimations];

}
-(void)hide_smoker_picker
{
    CGRect frame = smoker_view.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.5];
	frame.origin.y = 880;
	smoker_view.frame = frame;
	[UIView commitAnimations];
}
-(void)hide_race_picker
{
    CGRect frame = race_view.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.5];
	frame.origin.y = 880;
	race_view.frame = frame;
	[UIView commitAnimations];
}
-(void)hide_state_picker
{

    CGRect frame = state_view.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.5];
	frame.origin.y = 880;
	state_view.frame = frame;
	[UIView commitAnimations];

}
- (void)viewDidUnload
{
    [lbl_partnerwebsitename release];
    lbl_partnerwebsitename = nil;
    [lang_tabel_view release];
    lang_tabel_view = nil;
    [lang_tblcontain_view release];
    lang_tblcontain_view = nil;
    [tab_btns_tbl release];
    tab_btns_tbl = nil;
    [self setEditLangButton:nil];
    [self setDoneLangButton:nil];
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
    [lbl_partnerwebsitename release];
    [lang_tabel_view release];
    [lang_tblcontain_view release];
    [tab_btns_tbl release];
   // [_editLangButton release];
    //[_doneLangButton release];
    [super dealloc];
}
@end
