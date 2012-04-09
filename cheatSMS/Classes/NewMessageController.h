//
//  NewMessage.h
//  cheatSMS
//
//  Created by whats on 07/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved. < >
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import <MessageUI/MessageUI.h>
#import "HPGrowingTextView.h"

@interface NewMessageController : UIViewController <HPGrowingTextViewDelegate,ABPeoplePickerNavigationControllerDelegate,MFMessageComposeViewControllerDelegate>{
	HPGrowingTextView *textView;
	IBOutlet UITextField *txtFrom;
	IBOutlet UITextField *txtTo;
}

-(IBAction)selectTo;
-(IBAction)btnCancel;
-(IBAction)doneEditing;
-(void)resignTextView;

@property (nonatomic, retain) IBOutlet UITextField *txtFrom;
@property (nonatomic, retain) IBOutlet UITextField *txtTo;

@end
