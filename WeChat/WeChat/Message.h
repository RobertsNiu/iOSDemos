//
//  Message.h
//  WeChat
//
//  Created by Ronan on 14-2-13.
//  Copyright (c) 2014年 iBokan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Message : NSManagedObject

@property (nonatomic, retain) NSString * sender;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * person;

@end
