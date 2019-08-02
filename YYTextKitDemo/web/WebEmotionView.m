//
//  WebEmotionView.m
//  YYTextKitDemo
//
//  Created by zkf on 2017/6/22.
//  Copyright © 2017年 zkf. All rights reserved.
//

#import "WebEmotionView.h"
#import "YYKit.h"
#import "WBStatusHelper.h"
#define kViewHeight 216
#define kcellHeight 50
#define kOnePageCount 20
@interface WebEmotionCollecationCell : UICollectionViewCell
@property (nonatomic , strong) WBEmoticon *emotion;
@property (nonatomic , strong) UIImageView *imageView;
@property (nonatomic , assign) BOOL isDelete;
@end

@implementation WebEmotionCollecationCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _imageView = [UIImageView new];
        _imageView.size = CGSizeMake(32, 32);
        _imageView.image = [UIImage imageNamed:@"d_beishang@2x"];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_imageView];
    }
    return self;
}

-(void)setEmotion:(WBEmoticon *)emotion
{
    if (_emotion == emotion) return;
    _emotion = emotion;
    [self upDateContent];
}

-(void)setIsDelete:(BOOL)isDelete{
    if (_isDelete == isDelete) return;
    _isDelete = isDelete;
    [self upDateContent];
}

-(void)upDateContent{
    _imageView.image = nil;
    if (_isDelete) {
        _imageView.image = [WBStatusHelper imageNamed:@"compose_emotion_delete"];
    } else if (_emotion) {
        _imageView.image = nil;
        if (_emotion.type == WBEmoticonTypeEmoji) {
            NSNumber *num = [NSNumber numberWithString:_emotion.code];
            NSString *str = [NSString stringWithUTF32Char:num.unsignedIntValue];
            if (str) {
                UIImage *img = [UIImage imageWithEmoji:str size:_imageView.width];
                _imageView.image = img;
            }
        } else if (_emotion.group.groupID && _emotion.png){
            NSString *pngPath = [[WBStatusHelper emoticonBundle] pathForScaledResource:_emotion.png ofType:nil inDirectory:_emotion.group.groupID];
            if (!pngPath) {
                NSString *addBundlePath = [[WBStatusHelper emoticonBundle].bundlePath stringByAppendingPathComponent:@"additional"];
                NSBundle *addBundle = [NSBundle bundleWithPath:addBundlePath];
                pngPath = [addBundle pathForScaledResource:_emotion.png ofType:nil inDirectory:_emotion.group.groupID];
            }
            if (pngPath) {
                [_imageView setImageWithURL:[NSURL fileURLWithPath:pngPath] options:YYWebImageOptionIgnoreDiskCache];
            }
        }
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    _imageView.center = CGPointMake(self.width * 0.5, self.height * 0.5);
}

@end

@protocol WebEmotionCollecationCellDelegate <UICollectionViewDelegate>
- (void)emoticonScrollViewDidTapCell:(WebEmotionCollecationCell *)cell;
@end




@interface WebEmotionCollectionView : UICollectionView
//@property (nonatomic , assign)id<WebEmotionCollecationCellDelegate>delegate;
@end

@implementation WebEmotionCollectionView {
    
    UIImageView *_magnifier;
    UIImageView *_magnifierContent;
    BOOL _touchMove;
    WebEmotionCollecationCell *_currentCell;
    
}

-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
   self = [super initWithFrame:frame collectionViewLayout:layout];
    
    self.backgroundColor = [UIColor clearColor];
    self.backgroundView = [UIView new];
    self.pagingEnabled = YES;
    self.showsHorizontalScrollIndicator = NO;
    self.clipsToBounds = NO;
    self.canCancelContentTouches = NO;
    self.multipleTouchEnabled = NO;
    UIImage *image = [WBStatusHelper imageNamed:@"emoticon_keyboard_magnifier"];
    _magnifier = [[UIImageView alloc] initWithImage:image];
    
    _magnifierContent = [[UIImageView alloc] init];
    _magnifierContent.size = CGSizeMake(40, 40);
    _magnifierContent.centerX = _magnifier.width * 0.5;
    
    [_magnifier addSubview:_magnifierContent];
    
    [self addSubview:_magnifier];
    _magnifier.size = CGSizeMake(image.size.width, image.size.height);
    _magnifier.hidden = YES;
    return self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    _touchMove = NO;
    
    WebEmotionCollecationCell *cell = [self _getCellWith:touches];
    
    if (!cell.imageView.image && !cell.isDelete) {
        _currentCell = cell;
    }
    
    [self showMagnifierForCell:cell];
    
    if (cell.isDelete) {
        NSLog(@"咯咯咯");
    }
    
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _touchMove = YES;
    
    if (_currentCell && _currentCell.isDelete) return;
    
    WebEmotionCollecationCell *cell = [self _getCellWith:touches];
    if (cell != _currentCell) {
        if (!_currentCell.isDelete && !cell.isDelete) {
            _currentCell = cell;
        }
        [self showMagnifierForCell:cell];
    }
    
    if (cell.isDelete) {
        NSLog(@"阿萨德");
    }
    
}



-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    _magnifier.hidden = YES;
    
    WebEmotionCollecationCell *cell = [self _getCellWith:touches];
    
    if ([self.delegate respondsToSelector:@selector(emoticonScrollViewDidTapCell:)]) {
        [((id<WebEmotionCollecationCellDelegate>) self.delegate) emoticonScrollViewDidTapCell:cell];
    }
    
}

-(WebEmotionCollecationCell *)_getCellWith:(NSSet<UITouch *> *)touches{
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:self];
    NSIndexPath *indexPath = [self indexPathForItemAtPoint:point];
    return (WebEmotionCollecationCell *)[self cellForItemAtIndexPath:indexPath];
}

- (void)showMagnifierForCell:(WebEmotionCollecationCell *)cell {
    if (cell.isDelete || !cell.imageView.image) {
        _magnifier.hidden = YES;
        return;
    }
    _magnifier.hidden = NO;
    
    CGRect rect = [cell convertRect:cell.bounds toView:self];
    _magnifierContent.image = cell.imageView.image;
    _magnifier.centerX = rect.origin.x + rect.size.width * 0.5;
    _magnifier.bottom = rect.origin.y + rect.size.height - 9;
    
    [_magnifierContent.layer removeAllAnimations];
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        _magnifierContent.top = 3;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            _magnifierContent.top = 6;
        } completion:^(BOOL finished) {
            _magnifierContent.top = 5;
        }];
    }];
}


@end



@interface WebEmotionView ()<UICollectionViewDelegate , UICollectionViewDataSource>

@property (nonatomic , strong) UICollectionView *collectionView;
@property (nonatomic , strong) UIView *pageControl;

@property (nonatomic, strong) NSArray* emoticonGroups;
@property (nonatomic , strong) NSArray *pageIndexArray;
@property (nonatomic , strong) NSArray *pagecountsArray;
@property (nonatomic , assign) NSInteger emoticonGroupTotalPageCount;
@property (nonatomic , assign) NSInteger currentPageIndex;

@property (nonatomic , strong) NSArray *btnArrays;

@end

@implementation WebEmotionView
+(WebEmotionView *)sharedView
{
    static WebEmotionView *v;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        v = [self new];
    });
    return v;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, kScreenWidth, kViewHeight);
        self.backgroundColor = UIColorHex(f9f9f9);
        [self _initGroupArray];
        [self _initTopLine];
        [self _initCollectionView];
        [self _initToolBar];
        _currentPageIndex = NSNotFound;
        [self _toolbarBtnDidTapped:_btnArrays.firstObject];
    }
    return self;
}

-(void)_initGroupArray
{
    _emoticonGroups = [WBStatusHelper emoticonGroups];
    
    CGFloat index = 0;
    NSMutableArray *pageIndex = [NSMutableArray array];
    for (WBEmoticonGroup *group in _emoticonGroups) {
        [pageIndex addObject:@(index)];
        NSInteger count = ceil(group.emoticons.count / (CGFloat)kOnePageCount);
        if (count == 0) count = 1;
        index += count;
    }
    _pageIndexArray = pageIndex;
    
    NSMutableArray *pageCount = [NSMutableArray array];
    _emoticonGroupTotalPageCount = 0;
    for (WBEmoticonGroup *group in _emoticonGroups) {
        NSInteger count = ceil(group.emoticons.count / (CGFloat)kOnePageCount);
        if (count == 0) count = 1;
        [pageCount addObject:@(count)];
        _emoticonGroupTotalPageCount += count;
    }
    _pagecountsArray = pageCount;
}

-(void)_initTopLine
{
    UIView *line = [UIView new];
    line.backgroundColor = UIColorHex(bfbfbf);
    line.size = CGSizeMake(self.width, CGFloatFromPixel(1));
    [self addSubview:line];
}

-(void)_initCollectionView
{
    CGFloat item_W = (self.width - 2 * 10) / 7.0;
    item_W = CGFloatPixelRound(item_W);
    CGFloat padding = (self.width - 7 * item_W) / 2.0;
    CGFloat paddingLeft = CGFloatPixelRound(padding);
    CGFloat paddingRight = self.width - item_W * 7 - paddingLeft;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0.0f;
    layout.minimumInteritemSpacing = 0.0f;
    layout.sectionInset = UIEdgeInsetsMake(0, paddingLeft, 0, paddingRight);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(item_W, kcellHeight);
    _collectionView = [[WebEmotionCollectionView alloc] initWithFrame:CGRectMake(0, 0, self.width, kcellHeight * 3) collectionViewLayout:layout];
    _collectionView.top = 10;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[WebEmotionCollecationCell class] forCellWithReuseIdentifier:@"emotionCell"];
    [self addSubview:_collectionView];
    
    _pageControl = [[UIView alloc] init];
    _pageControl.size = CGSizeMake(self.width, 20);
    _pageControl.top = _collectionView.bottom;
    [self addSubview:_pageControl];
}

-(void)_initToolBar{
    
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = [UIColor whiteColor];
    bottomView.size = CGSizeMake(self.width, 37);
    bottomView.bottom = self.height;
    [self addSubview:bottomView];
    
    UIImageView *bg = [[UIImageView alloc] initWithImage:[WBStatusHelper imageNamed:@"compose_emotion_table_right_normal"]];
    bg.size = bottomView.size;
    [bottomView addSubview:bg];

    
    UIScrollView *bottomScrollView = [UIScrollView new];
    bottomScrollView.frame = bottomView.bounds;
    bottomScrollView.showsVerticalScrollIndicator = NO;
    bottomScrollView.showsHorizontalScrollIndicator = NO;
    bottomScrollView.contentSize = CGSizeMake(self.width / 3.0 * _emoticonGroups.count, 0);
    [bottomView addSubview:bottomScrollView];
    
    NSMutableArray *btns = [NSMutableArray new];
    UIButton *btn;
    for (int i = 0;  i < _emoticonGroups.count; i++) {
        WBEmoticonGroup *group = _emoticonGroups[i];
        btn = [self _createToolbarButton];
        [btn setTitle:group.nameCN forState:UIControlStateNormal];
        btn.left = kScreenWidth / (float)_emoticonGroups.count * i;
        btn.tag = i;
        [bottomScrollView addSubview:btn];
        [btns addObject:btn];
    }
    
    _btnArrays = btns;

}

- (UIButton *)_createToolbarButton {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.exclusiveTouch = YES;
    btn.size = CGSizeMake(kScreenWidth / _emoticonGroups.count, 37);
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:UIColorHex(5D5C5A) forState:UIControlStateSelected];
    
    UIImage *img;
    img = [WBStatusHelper imageNamed:@"compose_emotion_table_left_normal"];
    img = [img resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, img.size.width - 1) resizingMode:UIImageResizingModeStretch];
    [btn setBackgroundImage:img forState:UIControlStateNormal];
    
    img = [WBStatusHelper imageNamed:@"compose_emotion_table_left_selected"];
    img = [img resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, img.size.width - 1) resizingMode:UIImageResizingModeStretch];
    [btn setBackgroundImage:img forState:UIControlStateSelected];
    
    [btn addTarget:self action:@selector(_toolbarBtnDidTapped:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

-(void)_toolbarBtnDidTapped:(UIButton *)button{
    
    NSInteger i = button.tag;
    NSInteger index = [_pageIndexArray[i] integerValue];
    [_collectionView setContentOffset:CGPointMake(index * self.width, 0)];
    [self scrollViewDidScroll:_collectionView];
    
}

- (WBEmoticon *)_emoticonForIndexPath:(NSIndexPath *)indexPath {
    NSUInteger section = indexPath.section;
    for (NSInteger i = _pageIndexArray.count - 1; i >= 0; i--) {
        NSNumber *pageIndex = _pageIndexArray[i];
        if (section >= pageIndex.unsignedIntegerValue) {
            WBEmoticonGroup *group = _emoticonGroups[i];
            NSUInteger page = section - pageIndex.unsignedIntegerValue;
            NSUInteger index = page * kOnePageCount + indexPath.row;
        
            // transpose line/row
            NSUInteger ip = index / kOnePageCount;
            NSUInteger ii = index % kOnePageCount;
            NSUInteger reIndex = (ii % 3) * 7 + (ii / 3);
            index = reIndex + ip * kOnePageCount;
            
            if (index < group.emoticons.count) {              return group.emoticons[index];
            } else {
                return nil;
            }
        }
    }
    return nil;
}


#pragma mark WBEmoticonScrollViewDelegate

- (void)emoticonScrollViewDidTapCell:(WebEmotionCollecationCell *)cell {
    if (!cell) return;
    if (cell.isDelete) {
        if ([self.delegate respondsToSelector:@selector(emoticonInputDidTapBackspace)]) {
            [[UIDevice currentDevice] playInputClick];
            [self.delegate emoticonInputDidTapBackspace];
        }
    } else if (cell.emotion) {
        NSString *text = nil;
        switch (cell.emotion.type) {
            case WBEmoticonTypeImage: {
                text = cell.emotion.chs;
            } break;
            case WBEmoticonTypeEmoji: {
                NSNumber *num = [NSNumber numberWithString:cell.emotion.code];
                text = [NSString stringWithUTF32Char:num.unsignedIntValue];
            } break;
            default:break;
        }
        if (text && [self.delegate respondsToSelector:@selector(emoticonInputDidTapText:)]) {
            [self.delegate emoticonInputDidTapText:text];
        }
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger index = roundf(scrollView.contentOffset.x / _collectionView.width);
    if (index < 0) index = 0;
    else if (index >= _emoticonGroupTotalPageCount) index = _emoticonGroupTotalPageCount - 1;
    if (index == _currentPageIndex) return;
    _currentPageIndex = index;
    NSInteger curGroupIndex = 0;
    NSInteger curGroupPageIndex = 0;
    NSInteger curGroupPageCount = 0;
    for (NSInteger i = _pageIndexArray.count - 1; i >= 0; i--) {
        NSNumber *aaa = _pageIndexArray[i];
        if (index >= aaa.integerValue) {
            curGroupIndex = i;
            curGroupPageIndex = [_pageIndexArray[i] integerValue];
            curGroupPageCount = [_pagecountsArray[i] integerValue];
            break;
        }
    }
    
    CGFloat page_W = 6;
    CGFloat page_Padding = 5;
    CGFloat pageControl_W = (page_W + page_Padding) * curGroupPageCount - page_Padding;
    
    [_pageControl.layer removeAllSublayers];
    
    for (int i = 0; i < curGroupPageCount; i++) {
        CALayer *layer = [CALayer layer];
        layer.size = CGSizeMake(page_W, 3);
        [_pageControl.layer addSublayer:layer];
        layer.centerY = _pageControl.height * 0.5;
        layer.left = (_pageControl.width - pageControl_W) * 0.5 + i * (page_W + page_Padding);
        if (index - curGroupPageIndex == i) {
            layer.backgroundColor = UIColorHex(fd8225).CGColor;
        } else {
            layer.backgroundColor = UIColorHex(dedede).CGColor;
        }
    }
    
    
    [_btnArrays enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL *stop) {
        btn.selected = (idx == curGroupIndex);
    }];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return _emoticonGroupTotalPageCount;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return kOnePageCount + 1;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WebEmotionCollecationCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"emotionCell" forIndexPath:indexPath];
    
    if (indexPath.item == kOnePageCount) {
        cell.isDelete = YES;
        cell.emotion = nil;
    } else {
        cell.isDelete = NO;
        cell.emotion = [self _emoticonForIndexPath:indexPath];
    }
    
    return cell;
}
@end
