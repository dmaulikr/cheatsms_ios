//
//  cheatSMSViewController.h
//  cheatSMS
//
//  Created by whats on 07/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewMessageController.h"

@interface cheatSMSViewController : UIViewController <UITableViewDelegate,UITableViewDataSource> {
	IBOutlet NewMessageController *newMessageController;
	NSArray *messagesList;

}


-(IBAction)btnCompose;
-(IBAction)btnEdit;

@property (nonatomic, retain) NSArray *messagesList;

@end

