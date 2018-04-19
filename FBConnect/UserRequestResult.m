/*
 * Copyright 2010 Facebook
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *    http://www.apache.org/licenses/LICENSE-2.0
 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "UserRequestResult.h"
#import "AppDelegate.h"
#import "JSON1.h"
#import "JSON.h"
@implementation UserRequestResult



- (id) initializeWithDelegate:(id<UserRequestDelegate>)delegate 
{
  self = [super init];
  _userRequestDelegate = [delegate retain];
  return self;  
}


/**
 * FBRequestDelegate
 */


- (void)request:(FBRequest*)request didLoad:(id)result
{
    
global_SocialCheck =[[NSString alloc]initWithFormat:@"%@",@"fbPic"];
  NSString *uid = [result objectForKey:@"id"];
    
    global_socialLogID = [[NSString alloc]initWithFormat:@"%@",uid];
    NSLog(@"fbuserid:%@",uid);
    
    
  facebkImgUrl=[[NSString alloc]initWithFormat:@"http://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1",global_socialLogID];
    
    NSLog(@"facebkImg:%@",facebkImgUrl);
    
    
    
    
  NSLog(@"result:%@",result);
    fid=[[NSString alloc]initWithFormat:@"%@",uid];
    
    NSString *username=[result objectForKey:@"name"];
    
    NSLog(@"uesrname:%@",username);
    
    NSString *replacUsername = [ username stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    
    facebkName = [[NSString alloc]initWithFormat:@"%@",replacUsername];
    
    NSString *realname=[result objectForKey:@"name"];
     fname=[[NSString alloc]initWithFormat:@"%@_facebook",realname];
    NSString *email=[result objectForKey:@"email"];
    NSLog(@"email:%@",email);
     femail=[[NSString alloc]initWithFormat:@"%@",email];
    
    NSString *gender_str=[result objectForKey:@"gender"];
    NSLog(@"gender_str:%@",gender_str);
     fgender=[[NSString alloc]initWithFormat:@"%@",gender_str];

    
    NSString *birthday=[result objectForKey:@"birthday"];
    if ([birthday isEqualToString:@""] || [birthday isEqualToString:NULL])
        
    {
    
        
        birthday=[[NSString alloc]initWithFormat:@"Not known"];
        
        dayFacebook = @"0";
        monthFacebook =@"0";
        yearFacebook = @"0";
    
    }
    
    else
    {
       // NSLog(@"birthday In Else:%@",birthday);
        NSArray *splitFBirthday =[[NSArray alloc]init];
        splitFBirthday = [birthday componentsSeparatedByString:@"/"];
       // NSLog(@"splitbirthday:%@",splitFBirthday);
        dayFacebook = [[NSString alloc]initWithFormat:@"%@",[splitFBirthday objectAtIndex:1]];
        monthFacebook = [[NSString alloc]initWithFormat:@"%@",[splitFBirthday objectAtIndex:0]];
        yearFacebook = [[NSString alloc]initWithFormat:@"%@",[splitFBirthday objectAtIndex:2]];
        
    }
    NSLog(@"birthday:%@",birthday);
    
    
    
    
    
    
    
    
    
    

  /*

    
    NSDictionary *dictLoc = [result objectForKey:@"location"];
   // NSLog(@"dictLoc:%@",dictLoc);
    if (dictLoc == (id)[NSNull null] )
    {
        
        //NSLog(@"locationfacebook is empty");
        locationFacebook=@"";
        
        
        
    }
    
    NSString *locationDict = [NSString stringWithFormat:@"%@",[dictLoc objectForKey:@"name"]];
    if ([locationDict isEqualToString:@""] )
    {
    
        //NSLog(@"locationfacebook is empty");
        locationFacebook=@"";
        
    
    
    }else{
    
        locationFacebook = [[NSString alloc]initWithFormat:@"%@",locationDict] ;
        //NSLog(@"locationDic:%@",locationFacebook);
    
    
    }
    
    //NSLog(@"locationDict:%@",locationDict);
    
   // NSLog(@"educationface:%@",[result objectForKey:@"education"]);
    
    
    
    /////////Get Facebook User Education/////////////////////////
    
    NSMutableArray *educFaceArray = [[NSMutableArray alloc]init] ;
    NSLog(@"langKey:%@",[result objectForKey:@"education"]);
    
   // NSString *strcheckEduc = [result objectForKey:@"education"];
    
    if([result objectForKey:@"education"] ==NULL){
        
        EducationFacebook =@"0";
    }else{
    NSDictionary *dictEduc = [result objectForKey:@"education"];
    if (dictEduc ==(id)[NSNull null])
    {
        //NSLog(@"educationfacebook is empty");
        EducationFacebook = @"0";
        
        
    }else{
    
    //NSLog(@"dictLoc:%@",dictEduc);
    NSString *educDict;
    for (NSDictionary *educInfo in dictEduc) {
        // NSLog(@"educattionDict:%@",educDict);
       // NSLog(@"educInfo:%@",educInfo);
    
    educDict = [NSString stringWithFormat:@"%@",[educInfo objectForKey:@"type"]];
    if ([educDict isEqualToString:@"" ])
    {
         //NSLog(@"educationfacebook is empty");
        EducationFacebook = @"0";
        
        
    }else{
        
        //NSLog(@"typeSchool:%@",educDict);
        
        [educFaceArray addObject:educDict];
        
        
    }
    
    }
    //NSLog(@"lastObject:%@",[educFaceArray lastObject]);
    
    
    
    NSString *educationString = [[NSString alloc]initWithFormat:@"%@",[educFaceArray lastObject]];
    
    if([educFaceArray count]!=0){
        
        
        
     if([educationString isEqualToString:@"College"]==1){
        
        EducationFacebook = @"3";
        
        
    }else if([educationString isEqualToString:@"High School"]==1 ){
        
        EducationFacebook = @"2";
        
    }else if ([educationString isEqualToString:@"Bachelors Degree"]==1){
        
        
        EducationFacebook = @"4";
        
    }else if ([educationString isEqualToString:@"Masters Degree"]==1) {
        
        
        EducationFacebook = @"5";
        
    }else if ([educationString isEqualToString:@"Doctoral Degree"]==1){
        
        
        EducationFacebook = @"6";
    }else if ([educationString isEqualToString:@"Others"]==1 ){
        
        
        EducationFacebook = @"7";
    }
        
    
    }
    }
    }
   //////////Get Facebook User Languages////////////////
    NSString * langNamesFacebk =@"";//= [[NSMutableArray alloc]init];
    NSString *langAppendFacebk;
   
    NSArray *langNames = [NSArray arrayWithObjects:@"Mandarin",@"English",@"Spanish",@"Hindi",@"Russian",@"Arabic",@"Portuguese",@"Bengali",@"French",@"Malay",@"German",@"Japanese",@"Farsi",@"Urdu",@"Punjabi",@"Vietnamese",@"Javanese",@"Tamil",@"Korean",@"Turkish",@"Telugu",@"Marathi",@"Italian",@"Thai",@"Burmese",@"Cantonese",@"Tagalog",@"Dutch", nil];
   
    NSArray * langID = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28", nil];
   // NSString *strcheckLang = [result objectForKey:@"languages"];
    
    if([result objectForKey:@"languages"] ==NULL ){
        NSLog(@"langNotNull");
        languagesFacebook =@"0";
    }else{
    if ([result objectForKey:@"languages"]) {
        
        NSArray *languages = [result objectForKey:@"languages"];
        
        if (languages ==(id)[NSNull null])
        {
            //NSLog(@"educationfacebook is empty");
            EducationFacebook = @"0";
            
            
        }else{
        NSMutableArray *languageNamesFace = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < [languages count]; i++) {
            [languageNamesFace addObject:[[languages
                                       objectAtIndex:i]
                                      objectForKey:@"name"]];
        }
        
        
        
        for(int f=0;f<[langNames count];f++){
            
            
            NSString * langFindF = [langNames objectAtIndex:f] ;
             ;
            
            
            
            
            for(int h=0;h<[languageNamesFace count];h++){
                NSString * langFindL = [languageNamesFace objectAtIndex:h];
                
            
            if([langFindL isEqualToString:langFindF]!=0){
                                
          langNamesFacebk = [langNamesFacebk
                                    stringByAppendingString:
                                    [NSString stringWithFormat:@"%@,",
                                     [langID objectAtIndex:f]]];
                
                
                               
                
            }
            }
        }
            
        }
       if([langAppendFacebk isEqualToString:@""]){
           NSLog(@"maniLan");
           languagesFacebook=@"0";
     
       }else{
           
           NSString *string = [NSString stringWithString:langNamesFacebk];
           NSString *newString = [string substringToIndex:[string length]-1];
           
           
           
           languagesFacebook = [[NSString alloc ]initWithString:newString];
                      
       }
            }
    
    
    }
    */
    
    
    
  // [_userRequestDelegate userRequestCompleteWithUid:uid];
    
   
    
   // [self UpdateFacebookLoginTable:email USername:username];

                          
}

-(void)UpdateFacebookLoginTable:(NSString*)email USername:(NSString *)username 
{
//    sqlite3_stmt *stmt2;
//    NSString *update2=[NSString stringWithFormat:@"update facebookLogin set email ='%@'",email];
//    int x2 = sqlite3_prepare_v2(database, [update2 UTF8String], -1, &stmt2, nil);
//    if (sqlite3_step(stmt2) == SQLITE_DONE)
//        NSLog(@"update done %d",x2); 
//    sqlite3_finalize(stmt2);
//    
//    sqlite3_stmt *stmt3;
//    NSString *update3=[NSString stringWithFormat:@"update facebookLogin set name ='%@'",username];
//    int x3 = sqlite3_prepare_v2(database, [update3 UTF8String], -1, &stmt3, nil);
//    if (sqlite3_step(stmt3) == SQLITE_DONE)
//        NSLog(@"update done %d",x3); 
//    sqlite3_finalize(stmt3);


}

/*

- (void)request:(FBRequest*)request didFailWithError:(NSError*)error {
  NSLog(@"%@",[error localizedDescription]);
  [_userRequestDelegate userRequestFailed];
}
 
 */

@end
