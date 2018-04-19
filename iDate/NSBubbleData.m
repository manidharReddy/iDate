//
//  NSBubbleData.m
//
//  Created by Alex Barinov
//  StexGroup, LLC
//  http://www.stexgroup.com
//
//  Project home page: http://alexbarinov.github.com/UIBubbleTableView/
//
//  This work is licensed under the Creative Commons Attribution-ShareAlike 3.0 Unported License.
//  To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/3.0/
//

#import "NSBubbleData.h"

@implementation NSBubbleData

@synthesize date = _date;
@synthesize type = _type;
@synthesize text = _text;

+ (id)dataWithText:(NSString *)text andType:(NSBubbleType)type
{
#ifndef ARC_ENABLED
    return [[[NSBubbleData alloc] initWithText:text  andType:type] autorelease];
#else
    return [[NSBubbleData alloc] initWithText:text  andType:type];
#endif    
}

- (id)initWithText:(NSString *)initText  andType:(NSBubbleType)initType
{
    self = [super init];
    if (self)
    {
#ifndef ARC_ENABLED
        _text = [initText retain];
       
#else
        _text = initText;
       
#endif

        if (!_text || [_text isEqualToString:@""]) _text = @" ";
        
        _type = initType;
    }
    return self;
}

#ifndef ARC_ENABLED
- (void)dealloc
{
    [_date release];
	[_text release];
	_date = nil;
	_text = nil;
    [super dealloc];
}
#endif

@end
