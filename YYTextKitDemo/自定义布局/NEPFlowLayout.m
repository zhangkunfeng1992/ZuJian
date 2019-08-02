//
//  NEPFlowLayout.m
//  YYTextKitDemo
//
//  Created by zkf on 2017/4/10.
//  Copyright © 2017年 zkf. All rights reserved.
//

#import "NEPFlowLayout.h"

@implementation NEPFlowLayout

-(void)prepareLayout
{
    [super prepareLayout];
    
   // self.itemSize = CGSizeMake(200, 200);
    
    self.itemSize = CGSizeMake(self.collectionView.frame.size.width - 40, 200);
    //设置内边距
    CGFloat insert =(self.collectionView.frame.size.width-self.itemSize.width)/2;
    self.sectionInset =UIEdgeInsetsMake(0, insert, 0, insert);
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    CGFloat center_X = self.collectionView.contentOffset.x + self.collectionView.bounds.size.width * 0.5;

    for (UICollectionViewLayoutAttributes *attribute in array) {
        CGFloat aaa = ABS(center_X - attribute.center.x);
        CGFloat scale = 1 - aaa / self.collectionView.bounds.size.width;
        
        attribute.transform = CGAffineTransformMakeScale(scale, scale);
    }
    return array;
}

-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    CGRect rect;
    rect.size = self.collectionView.bounds.size;
    rect.origin.x = proposedContentOffset.x;
    rect.origin.y = 0;
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    CGFloat centerX = proposedContentOffset.x + self.collectionView.bounds.size.width * 0.5;
    
    CGFloat minDelta = MAXFLOAT;
    for (UICollectionViewLayoutAttributes * attrs in array) {
        if (ABS(minDelta)>ABS(attrs.center.x-centerX)) {
            minDelta=attrs.center.x-centerX;
        }
    }
    proposedContentOffset.x += minDelta;
    
    return proposedContentOffset;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes * attributes = [[super layoutAttributesForItemAtIndexPath:indexPath] copy];
    attributes.transform = CGAffineTransformMakeScale(0.5, 0.5);
    return attributes;
}


-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}


@end
