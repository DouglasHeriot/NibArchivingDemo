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
	self.last = self.stuff;
	
	
	// Demonstration of the long way of instantiating obejcts from a nib at a given URL
	// (could just skip down to:
	// NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"GMOSettingsPhoneCellView" owner:self options:nil];
	// …if it’s already in the bundle)
	
	
	NSURL *url = [[NSBundle mainBundle] URLForResource:@"SomeNib" withExtension:@"nib"];
	NSData *data = [NSData dataWithContentsOfURL:url];
	
	// This doesn’t work: apparently nibs contain a little more than just the usual archive data:
	//id object = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
	// Have to use the proper Nib classes instead:
	
	UINib *nib = [UINib nibWithData:data bundle:nil];
	NSArray *topLevelObjects = [nib instantiateWithOwner:nil options:nil];
	
	// I’m lazy, so let’s assume for this demo the nib just contains views
	for(UIView *view in topLevelObjects)
		[self.view insertSubview:view atIndex:0];
}

- (IBAction)moreStuff:(id)sender
{
	// Demonstrates how to archive/unarchive objects to data (as long as they conform to NSCoding)
	// Can trivially save/load this data to a file with NSDate writeToURL:atomically: and friends or something if you wanted
	
	NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.last];
	UIView *newView = [NSKeyedUnarchiver unarchiveObjectWithData:data];
	
	// Too easy! New view is a copy of the last view, loaded from our archive data
	
	// Let’s make this a little more fun
	CGRect randomFrame = newView.frame;
	randomFrame.origin.x = arc4random() % (int)(self.view.bounds.size.width-randomFrame.size.width);
	randomFrame.origin.y = arc4random() % (int)(self.view.bounds.size.height-randomFrame.size.height);
	[newView setFrame:randomFrame];
	
	[self.view insertSubview:newView belowSubview:sender];
	self.last = newView;
}

@end
