//
//  AAA.h
//  YYTextKitDemo
//
//  Created by zkf on 2017/9/8.
//  Copyright © 2017年 zkf. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CustomViewFlowLayoutDelegate <UICollectionViewDelegateFlowLayout>
- (void)AcollectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout cellCenteredAtIndexPath:(NSIndexPath *)indexPath page:(int)page;
@end


@interface AAA : UICollectionViewFlowLayout

@property (nonatomic, weak) id<CustomViewFlowLayoutDelegate> cusDelegate;

@end
