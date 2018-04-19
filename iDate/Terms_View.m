//
//  Terms_View.m
//  iDate
//
//  Created by D M R on 17/08/12.
//  Copyright (c) 2012 iHubTechnologies. All rights reserved.
//

#import "Terms_View.h"
#import "Free_signup.h"
#import  "AppDelegate.h"
@interface Terms_View ()

@end

@implementation Terms_View
@synthesize delegate;

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
    
    lbl_partnerwebsitename.text = global_partner_websitename;
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [lbl_partnerwebsitename release];
    lbl_partnerwebsitename = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (IBAction)doneClick:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(doneButtonClicked:)]) 
    {
        [self.delegate doneButtonClicked:self];
    }
}

- (IBAction)cancelClick:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelButtonClickedForEmail::)]) 
    {
        [self.delegate cancelButtonClickedForEmail:self];
    }
}


-(IBAction)back
{


    Free_signup* B2 = [[Free_signup alloc] init];
    UINavigationController *B2Nav = [[UINavigationController alloc] initWithRootViewController:B2];  
    [B2Nav setNavigationBarHidden:YES];
    B2Nav.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentModalViewController:B2Nav animated:YES];
    [B2 release];
    [B2Nav release];



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
    [super dealloc];
}
@end
