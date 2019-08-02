//
//  Entity+CoreDataProperties.m
//  YYTextKitDemo
//
//  Created by zkf on 2018/12/4.
//  Copyright © 2018 zkf. All rights reserved.
//
//

#import "Entity+CoreDataProperties.h"

@implementation Entity (CoreDataProperties)

+ (NSFetchRequest<Entity *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Entity"];
}

@dynamic name;
@dynamic age;
@dynamic sex;

@end
