//
//  Vital_stats_view.m
//  iDate
//
//  Created by D M R on 11/09/12.
//  Copyright (c) 2012 iHubTechnologies. All rights reserved.
//

#import "Vital_stats_view.h"
@protocol Vital_sate_delegate;
@interface Vital_stats_view ()

@end

@implementation Vital_stats_view
@synthesize bust_txt,hips_txt,waist_txt,cup_txt,delegate;
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
   
 
    
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)doneClick:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(doneButtonClicked1)]) 
    {
        [self.delegate doneButtonClicked1:self];
    }
}

- (IBAction)cancelClick:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelButtonClickedForEmail1::)]) 
    {
        [self.delegate cancelButtonClickedForEmail1:self];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    
    if (textField==cup_txt)
    {
        CGRect frame3 = self.view.frame;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        frame3.origin.x =30;
        frame3.origin.y =100;
        self.view.frame = frame3;
        
        [UIView commitAnimations];
        
    }

    
    
    
    
	[textField resignFirstResponder]; 
    
    
	
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	NSLog(@"textFieldShouldBeginEditing");
    
    if (textField==cup_txt)
    {
        CGRect frame3 = self.view.frame;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        frame3.origin.x =30;
        frame3.origin.y =50;
        self.view.frame = frame3;
        
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

-(IBAction)back
{
    
    
//    Free_signup* B2 = [[Free_signup alloc] init];
//    UINavigationController *B2Nav = [[UINavigationController alloc] initWithRootViewController:B2];  
//    [B2Nav setNavigationBarHidden:YES];
//    B2Nav.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//    [self presentModalViewController:B2Nav animated:YES];
//    [B2 release];
//    [B2Nav release];
    
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

@end
