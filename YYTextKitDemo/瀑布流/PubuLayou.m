//
//  PubuLayou.m
//  YYTextKitDemo
//
//  Created by zkf on 2017/4/11.
//  Copyright © 2017年 zkf. All rights reserved.
//

#import "PubuLayou.h"

@interface PubuLayou ()
/** 数组 */
@property (nonatomic , strong) NSMutableArray *array;
/** 数组 */
@property (nonatomic , strong) NSMutableArray *minHeightArray;

//-(CGFloat)maxColumn;

@end

static const CGFloat columnMargin = 10;
static const CGFloat rowMargin = 10;
static const CGFloat defaultMaxColumn = 3;
static const UIEdgeInsets defaultEdgeInsets = {10, 10, 10, 10};

@implementation PubuLayou

//-(CGFloat)maxColumn
//{
//    if (self.delegate) {
//        <#statements#>
//    } else {
//        return rowMargin;
//    }
//}

-(NSMutableArray *)array
{
    if (!_array) {
        _array = [NSMutableArray array];
    }
    return _array;
}

-(NSMutableArray *)minHeightArray
{
    if (!_minHeightArray) {
        _minHeightArray = [NSMutableArray array];
    }
    return _minHeightArray;
}


-(void)prepareLayout
{
    [super prepareLayout];
    
    NSInteger number = [self.collectionView numberOfItemsInSection:0];
    
    
    for (int i = 0; i < defaultMaxColumn; i++) {
        [self.minHeightArray addObject:@(0)];
    }
    
    for (int i = 0; i < number; i++) {
        UICollectionViewLayoutAttributes *attribute = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        [self.array addObject:attribute];
    }
    
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.array;
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes * attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGFloat w = (self.collectionView.bounds.size.width - defaultEdgeInsets.left - defaultEdgeInsets.right - columnMargin * (defaultMaxColumn - 1)) / defaultMaxColumn;
    
    
    CGFloat h = [self.delegate pubuLayou:self heightForItemWithIndexPath:indexPath andWidth:w];
    
    NSInteger column = 0;
    CGFloat aaa = [self.minHeightArray[0] floatValue];
    
    for (int i = 1; i < defaultMaxColumn; i++) {
        CGFloat height = [self.minHeightArray[i] floatValue];
        if (height < aaa) {
            height = aaa;
            column = i;
        }
    }
    
    CGFloat x = defaultEdgeInsets.left + column * (w + columnMargin);
    CGFloat y = [self.minHeightArray[column] floatValue] + rowMargin;
    attribute.frame = CGRectMake(x, y, w, h);
    
    self.minHeightArray[column] = @(CGRectGetMaxY(attribute.frame)) ;
    
    return attribute;
}

-(CGSize)collectionViewContentSize
{
    CGFloat aaa = [self.minHeightArray[0] floatValue];
    for (int i = 1; i < defaultMaxColumn; i++) {
        CGFloat height = [self.minHeightArray[i] floatValue];
        if (height > aaa) {
           aaa = height;
        }
    }
    return CGSizeMake(0, aaa + defaultEdgeInsets.bottom);
}





@end
