//
//  cheatSMSAppDelegate.h
//  cheatSMS
//
//  Created by whats on 07/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class cheatSMSViewController;

@interface cheatSMSAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    cheatSMSViewController *viewController;
	//NSManagedObjectContext *managedObjectContext;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet cheatSMSViewController *viewController;
//@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end

