//
//  cheatSMSViewController.m
//  cheatSMS
//
//  Created by whats on 07/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "cheatSMSViewController.h"
#import "Messages.h"

@implementation cheatSMSViewController

@synthesize messagesList;





/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    NSArray *array = [[NSArray alloc] initWithObjects:@"", @"", @"", nil];
	self.messagesList = array;
	[array release];
	
	[super viewDidLoad];
	/*UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Cada SMS tiene un coste de 1,2€+IVA"
													message:@"Recuerda que tu eres el único responsable de los mensajes que tu envies."
												   delegate:self
										  cancelButtonTitle: @"OK"
										  otherButtonTitles: nil];
	[alert show];
	[alert release];*/
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[messagesList dealloc];
    [super dealloc];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.messagesList count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"Cell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
	}
	// Configure the cell
	
	NSUInteger row = [indexPath row];
	cell.textLabel.text = [messagesList objectAtIndex:row];
	return cell;
}

- (IBAction)btnCompose {
	
	[self presentModalViewController:newMessageController animated:YES];
}
- (IBAction)btnEdit {}

@end
