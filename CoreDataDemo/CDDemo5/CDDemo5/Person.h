//
//  Person.h
//  CDDemo5
//
//  Created by cora1n on 14-4-21.
//  Copyright (c) 2014年 devwu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Person : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSString * gender;

@end
