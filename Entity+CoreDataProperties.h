//
//  Entity+CoreDataProperties.h
//  YYTextKitDemo
//
//  Created by zkf on 2018/12/4.
//  Copyright © 2018 zkf. All rights reserved.
//
//

#import "Entity+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Entity (CoreDataProperties)

+ (NSFetchRequest<Entity *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) int16_t age;
@property (nonatomic) int16_t sex;

@end

NS_ASSUME_NONNULL_END
