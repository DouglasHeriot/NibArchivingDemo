//
//  DHDViewController.m
//  NibArchiving
//
//  Created by Douglas Heriot on 16/04/12.
//  Copyright (c) 2012 Douglas Heriot Design. All rights reserved.
//

#import "DHDViewController.h"

@interface DHDViewController ()

@end

@implementation DHDViewController
@synthesize stuff;
@synthesize last;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	self.last = self.stuff;
	
	NSURL *url = [[NSBundle mainBundle] URLForResource:@"SomeNib" withExtension:@"nib"];
	NSData *data = [NSData dataWithContentsOfURL:url];
	//id object = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
	//NSLog(@"%@ of class %@", object, [object class]);
}

- (void)viewDidUnload
{
	[self setStuff:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)moreStuff:(id)sender
{
	NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.last];
	// Couldn’t be easier to save this to some file:
	//[data writeToURL:<#(NSURL *)#> atomically:<#(BOOL)#>];
	UIView *newView = [NSKeyedUnarchiver unarchiveObjectWithData:data];
	
	CGRect randomFrame = newView.frame;
	randomFrame.origin.x = arc4random() % (int)(self.view.bounds.size.width-randomFrame.size.width);
	randomFrame.origin.y = arc4random() % (int)(self.view.bounds.size.height-randomFrame.size.height);
	
	[newView setFrame:randomFrame];
	
	self.last = newView;
	
	[self.view insertSubview:newView belowSubview:sender];
}

@end
