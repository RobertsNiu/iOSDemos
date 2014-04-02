//
//  Person.h
//  MagicalRecordDemo
//
//  Created by Ronan on 14-2-18.
//  Copyright (c) 2014年 Ronan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Person : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * age;

@end
