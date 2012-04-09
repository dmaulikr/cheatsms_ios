//
//  Message.h
//  cheatSMS
//
//  Created by whats on 31/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface Messages : NSManagedObject {
	
}

@property (nonatomic, retain) NSDate *mDate;
@property (nonatomic, retain) NSString *mContent; 
@property (nonatomic, retain) NSString *mFrom;
@property (nonatomic, retain) NSString *mTo;

@end
