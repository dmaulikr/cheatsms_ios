    //
//  NewMessage.m
//  cheatSMS
//
//  Created by whats on 07/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NewMessageController.h"


@implementation NewMessageController

@synthesize txtFrom;
@synthesize txtTo;


-(id)init
{
	self = [super init];
	if(self){
		[[NSNotificationCenter defaultCenter] addObserver:self 
												 selector:@selector(keyboardWillShow:) 
													 name:UIKeyboardWillShowNotification 
												   object:nil];
		
		[[NSNotificationCenter defaultCenter] addObserver:self 
												 selector:@selector(keyboardWillHide:) 
													 name:UIKeyboardWillHideNotification 
												   object:nil];		
	}
	
	return self;
}


// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
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
    [super viewDidLoad];
	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(keyboardWillShow:) 
												 name:UIKeyboardWillShowNotification 
											   object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(keyboardWillHide:) 
												 name:UIKeyboardWillHideNotification 
											   object:nil];	

//	textView = (HPGrowingTextView*)[self.view viewWithTag:1];
//TODO: Canviar tamanys estatics per dinamics
	textView = [[HPGrowingTextView alloc] initWithFrame:CGRectMake(0, 425, 320, 100)];
	textView.minNumberOfLines = 1;
	textView.maxNumberOfLines = 4;
	textView.returnKeyType = UIReturnKeyGo; //just as an example
	textView.font = [UIFont boldSystemFontOfSize:15.0f];

	textView.delegate = self;
	[self.view addSubview:textView];
	[textView sizeToFit];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)doneEditing {
    // Send the sms
	MFMessageComposeViewController *controller = [[[MFMessageComposeViewController alloc] init] autorelease];
	if ([MFMessageComposeViewController canSendText]) {
		controller.body = @"Hello from albert";
		controller.recipients = [NSArray arrayWithObjects:@"677541957", nil];
		controller.messageComposeDelegate = self;
		[self presentModalViewController:controller animated:YES];
	
	}
	// Record it into database
	//[self dismissModalViewControllerAnimated:YES];

}


- (void)dealloc {
    [super dealloc];
	[textView release];
	[txtFrom release];
	[txtTo release];
}

- (IBAction)btnCancel {	
	[self dismissModalViewControllerAnimated:YES];
}


- (IBAction)selectTo {	
	ABPeoplePickerNavigationController * picker = [[ABPeoplePickerNavigationController alloc] init];
	picker.displayedProperties = [NSArray arrayWithObject:[NSNumber numberWithInt:kABPersonPhoneProperty]];
	picker.peoplePickerDelegate = self;
	[self presentModalViewController:picker animated:YES];
	[picker release];
	
}

-(void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker {
	[self dismissModalViewControllerAnimated:YES];
}

-(BOOL)peoplePickerNavigationController:
		(ABPeoplePickerNavigationController *)peoplePicker
	 shouldContinueAfterSelectingPerson:(ABRecordRef)person {
	return YES;
}

-(BOOL)peoplePickerNavigationController:
		(ABPeoplePickerNavigationController *)peoplePicker
	 shouldContinueAfterSelectingPerson:(ABRecordRef)person
							   property:(ABPropertyID)property
							 identifier:(ABMultiValueIdentifier)identifier{
	ABMultiValueRef multiPhones = ABRecordCopyValue(person, property);
	NSString *phone = (NSString *)ABMultiValueCopyValueAtIndex(multiPhones, identifier);
	
	NSMutableString *strippedPhone = [NSMutableString stringWithCapacity:phone.length];
	
	NSScanner *scanner = [NSScanner scannerWithString:phone];
	NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
	
	while ([scanner isAtEnd] == NO) {
		NSString *buffer;
		if ([scanner scanCharactersFromSet:numbers intoString:&buffer]){
			[strippedPhone appendString:buffer];
		} else {
			[scanner setScanLocation:([scanner scanLocation]+1)];
		}
	}
	self.txtTo.text = strippedPhone;
	
	[phone release];
	
	[self dismissModalViewControllerAnimated:YES];
	return NO;
}


-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
	UIAlertView *alert;

	switch (result) {
		case MessageComposeResultCancelled:
			NSLog(@"Cancelled");
			break;
		case MessageComposeResultSent:
			break;
		case MessageComposeResultFailed:
			alert = [[UIAlertView alloc] 
								  initWithTitle:@"cheatSMS" 
								  message:@"Error desconocido" 
								  delegate:self 
								  cancelButtonTitle:@"Aceptar" 
								  otherButtonTitles:nil];
			[alert show];
			[alert release];
			break;			
		default:
			break;
	}
	[self dismissModalViewControllerAnimated:YES];
}
/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {

	
	self.view = [[[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]] autorelease];
	self.view.backgroundColor = [UIColor grayColor];
	
	textView = [[HPGrowingTextView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
	textView.minNumberOfLines = 1;
	textView.maxNumberOfLines = 4;
	textView.returnKeyType = UIReturnKeyGo; //just as an example
	textView.font = [UIFont boldSystemFontOfSize:15.0f];
	textView.delegate = self;
	//textView.animateHeightChange = NO; //turns off animation
	
	[self.view addSubview:textView];
	[textView sizeToFit];
	
	UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	doneBtn.frame = CGRectMake(30, 30, 260, 80);
	[doneBtn setTitle:@"Done" forState:UIControlStateNormal];
	[doneBtn addTarget:self action:@selector(resignTextView) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:doneBtn];
	
	CGRect r = textView.frame;
	r.origin.y = self.view.frame.size.height - r.size.height;
	textView.frame = r;	
	
}*/

-(void)resignTextView
{
	NSLog(@"???");
	[textView resignFirstResponder];
}

//Code from Brett Schumann
-(void) keyboardWillShow:(NSNotification *)note{
    // get keyboard size and loctaion
	CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardBoundsUserInfoKey] getValue: &keyboardBounds];
	
	// get the height since this is the main value that we need.
	NSInteger kbSizeH = keyboardBounds.size.height;
	
	// get a rect for the textView frame
	CGRect textViewFrame = textView.frame;
	textViewFrame.origin.y -= kbSizeH;
	
	// animations settings
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.3f];
	
	// set views with new info
	textView.frame = textViewFrame;
	
	// commit animations
	[UIView commitAnimations];
}

-(void) keyboardWillHide:(NSNotification *)note{
    // get keyboard size and location
	CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardBoundsUserInfoKey] getValue: &keyboardBounds];
	
	// get the height since this is the main value that we need.
	NSInteger kbSizeH = keyboardBounds.size.height;
	
	// get a rect for the textView frame
	CGRect textViewFrame = textView.frame;
	textViewFrame.origin.y += kbSizeH;
	
	// animations settings
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.3f];
	
	// set views with new info
	textView.frame = textViewFrame;
	
	// commit animations
	[UIView commitAnimations];
}

- (void)growingTextView:(HPGrowingTextView *)growingTextView willChangeHeight:(float)height
{
	float diff = (textView.frame.size.height - height);
	
	CGRect r = textView.frame;
	r.origin.y += diff;
	textView.frame = r;
}

@end
