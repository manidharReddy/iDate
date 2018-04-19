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

#import "FriendsRequestResult.h"
#import "AppDelegate.h"
#import "RootViewController.h"
#import "JSON.h"

@implementation FriendsRequestResult

- (id) initializeWithDelegate:(id<FriendsRequestDelegate>)delegate {
    self = [super init];
    _friendsRequestDelegate = [delegate retain];
    return self;
}

/**
 * FBRequestDelegate
 */
- (void)request:(FBRequest*)request didLoad:(id)result{
    NSLog(@"result1234:%@",result);
    
    /*
    
    NSMutableArray *friendsInfo = [[[NSMutableArray alloc] init] autorelease];
    for (NSDictionary *info in result)
    {
        NSString *friend_id = [NSString stringWithString:[[info objectForKey:@"uid"] stringValue]];
        NSString *friend_name = nil;
        if ([info objectForKey:@"name"] != [NSNull null]) {
            friend_name = [NSString stringWithString:[info objectForKey:@"name"]];
        }
        NSString *friend_pic = [info objectForKey:@"pic_square"];
        // NSString *friend_status = [info objectForKey:@"status"];
        NSMutableDictionary *friend_info = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                            friend_id,@"uid",
                                            friend_name, @"name",
                                            friend_pic, @"pic_square",
                                            
                                            nil];
        [friendsInfo addObject:friend_info];
		
    }
    arrdata= [[NSMutableArray alloc]init];
    arrdata1=[[NSMutableArray alloc]init];
    arrid=[[NSMutableArray alloc]init];
    
    
    for (int t =0; t<[friendsInfo count]; t++)
	{
		//NSString *temp= [friendsInfo objectAtIndex:t];
		NSDictionary *dic = [friendsInfo objectAtIndex:t];
        
        
		NSString *strid=[dic objectForKey:@"uid"];
		NSString *strtemp = [dic objectForKey:@"name"];
		NSString *strtemp1 =[dic objectForKey:@"pic_square"];
        
        
        
        NSLog(@"strid:%@",strid);
        //        NSLog(@"strtemp:%@",strtemp);
        //        NSLog(@"strtemp1:%@",strtemp1);
        
		[arrdata addObject:strtemp];
		[arrdata1 addObject:strtemp1];
		[arrid addObject:strid];
        
        
		NSLog(@"arrdata:%@",arrdata);
		
		
	}
    //[self databaseinsert];
    */
    
    
    //    for (int t =0; t<[friendsInfo count]; t++)
    //	{
    //		//NSString *temp= [friendsInfo objectAtIndex:t];
    //		NSDictionary *dic = [friendsInfo objectAtIndex:t];
    //
    //
    //		NSString *strid=[dic objectForKey:@"uid"];
    //		NSString *strtemp = [dic objectForKey:@"name"];
    //		NSString *strtemp1 =[dic objectForKey:@"pic_square"];
    //
    //
    //
    //        NSString *str2 = [NSString stringWithFormat:@"http://www.handsintechnology.com/guess_song/facebookfriendlist_json.php?user_id=%@&friend_id=%@&friend_name=%@&friend_image=%@",fbid,strid,strtemp,strtemp1];
    //
    //
    //        str2 =[str2 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //
    //
    //
    //        NSMutableURLRequest *request =[[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:str2]];
    //
    //
    //
    //
    //
    //        NSData *returnData = [ NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil ];
    //
    //        NSString *returnString = [[NSString alloc]initWithData:returnData encoding:NSUTF8StringEncoding];
    //
    //
    //
    //
    //
    //
    //	}
    
    // [self playdata];
    //[self insertplay];
    
    
    
    
    
    
    //[fbLogin readdatabase];
    //[_friendsRequestDelegate FriendsRequestCompleteWithFriendsInfo:friendsInfo];
    
    
    
    
    
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    //[responseData setLength:0];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // [responseData appendData:data];
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"%@", error);
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
}




-(void)databaseinsert
{
    
    
    
    sqlite3_stmt *stmt;
	for (int i=0; i<[arrdata count]; i++)
	{
		char *errorMsg;
        
		int x;
		char *update = "insert into freinds_profile values (?,?,?);";
		x = sqlite3_prepare_v2(database, update, -1, &stmt, nil);
		//int returnValue =-1;
		
		if (x == SQLITE_OK)
		{
			sqlite3_bind_text(stmt, 1, [[arrid objectAtIndex:i] UTF8String],-1, NULL);
            sqlite3_bind_text(stmt, 2, [[arrdata1 objectAtIndex:i] UTF8String],-1, NULL);
			sqlite3_bind_text(stmt, 3, [[arrdata objectAtIndex:i] UTF8String],-1, NULL);
			
        }
		if (sqlite3_step(stmt) != SQLITE_DONE)
			NSLog(@"Error: %s",errorMsg);
		
		
	}
    
    sqlite3_finalize(stmt);
    
    
}


@end
