//
//  ViewController.m
//  YYTextKitDemo
//
//  Created by zkf on 2016/11/8.
//  Copyright © 2016年 zkf. All rights reserved.
//

#import "ViewController.h"
#import "NEPFlowLayout.h"
#import "PubuViewController.h"
#import "AAA.h"
@interface ViewController ()<UICollectionViewDelegate , UICollectionViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NEPFlowLayout *Layout =[[NEPFlowLayout alloc] init];
    //Layout.cusDelegate = self;
    Layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//    Layout.itemSize = CGSizeMake(30, 30);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 250) collectionViewLayout:Layout];
    [self.view addSubview:collectionView];
    //collectionView.pagingEnabled = YES;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor redColor];
    
    return cell;
}

@end
