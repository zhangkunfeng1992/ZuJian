//
//  PubuViewController.m
//  YYTextKitDemo
//
//  Created by zkf on 2017/4/11.
//  Copyright © 2017年 zkf. All rights reserved.
//

#import "PubuViewController.h"
#import "PubuLayou.h"
#import "XMGShopCell.h"
#import "XMGShop.h"
#import "MJExtension.h"
@interface PubuViewController ()<UICollectionViewDelegate , UICollectionViewDataSource , PubuLayouDelegate>
@property (nonatomic , weak) UICollectionView *collectionView;
@property (nonatomic , strong) NSMutableArray *dataArray;
@end

@implementation PubuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.dataArray = [NSMutableArray array];
    
    PubuLayou *Layout =[[PubuLayou alloc] init];
    Layout.delegate = self;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:Layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:collectionView];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([XMGShopCell class]) bundle:nil] forCellWithReuseIdentifier:@"shop"];
    
    self.collectionView = collectionView;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSArray *shops = [XMGShop objectArrayWithFilename:@"1.plist"];
        [self.dataArray addObjectsFromArray:shops];
        [self.collectionView reloadData];
    });
    
    
}


-(CGFloat)pubuLayou:(PubuLayou *)pubuLayou heightForItemWithIndexPath:(NSIndexPath *)indexPath andWidth:(CGFloat)width
{
    XMGShop *shop = self.dataArray[indexPath.item];
    
    return width * shop.h /shop.w ;
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XMGShopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"shop" forIndexPath:indexPath];
    cell.shop = self.dataArray[indexPath.item];
    return cell;
}


@end
