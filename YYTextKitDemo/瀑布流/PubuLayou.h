//
//  PubuLayou.h
//  YYTextKitDemo
//
//  Created by zkf on 2017/4/11.
//  Copyright © 2017年 zkf. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PubuLayou;


@protocol PubuLayouDelegate <NSObject>

@required

- (CGFloat)pubuLayou:(PubuLayou *)pubuLayou heightForItemWithIndexPath:(NSIndexPath *)indexPath andWidth:(CGFloat)width;

@optional

- (NSInteger)maxCloumnInPubuLayou:(PubuLayou *)PubuLayou;
@end

@interface PubuLayou : UICollectionViewLayout

@property (nonatomic , weak) id<PubuLayouDelegate>delegate;

@end
