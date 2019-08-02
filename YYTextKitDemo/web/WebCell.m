//
//  WebCell.m
//  YYTextKitDemo
//
//  Created by zkf on 2017/6/13.
//  Copyright © 2017年 zkf. All rights reserved.
//

#import "WebCell.h"
#import "YYPhotoGroupView.h"

@implementation webTitleView

- (instancetype)initWithFrame:(CGRect)frame
{
    
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size.width = kScreenWidth;
        frame.size.height = kWBCellTitleView_H;
    }
    
    self = [super initWithFrame:frame];
    if (self) {
        
        _titleLB = [YYLabel new];
        _titleLB.size = CGSizeMake(kScreenWidth - 100, self.height);
        _titleLB.left = kWBCellPadding;
//        _titleLB.displaysAsynchronously = YES;
        _titleLB.ignoreCommonProperties = YES;
        _titleLB.fadeOnHighlight = NO;
        _titleLB.fadeOnAsynchronouslyDisplay = NO;
        [self addSubview:_titleLB];
        
        CALayer *line = [CALayer layer];
        line.size = CGSizeMake(self.width, CGFloatFromPixel(1));
        line.bottom = self.height;
        line.backgroundColor = kWBCellLineColor.CGColor;
        [self.layer addSublayer:line];
        
        self.exclusiveTouch = YES;
    }
    return self;
}
@end

@implementation webProfileVIew

- (instancetype)initWithFrame:(CGRect)frame
{
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size.width = kScreenWidth;
        frame.size.height = kWBCellProfileHeight;
    }
    self = [super initWithFrame:frame];
    if (self) {
        
        _avatarView = [UIImageView new];
        _avatarView.size = CGSizeMake(40, 40);
        _avatarView.origin = CGPointMake(kWBCellPadding, kWBCellPadding + 3);
        _avatarView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_avatarView];
        
        _avatarBadgeView = [UIImageView new];
        _avatarBadgeView.size = CGSizeMake(14, 14);
        _avatarBadgeView.bottom = _avatarView.bottom;
        _avatarBadgeView.right = _avatarView.right;
        _avatarBadgeView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_avatarBadgeView];
        
        _nameLabel = [YYLabel new];
        _nameLabel.size = CGSizeMake(kWBCellNameWidth, 24);
        _nameLabel.left = _avatarView.right + kWBCellNamePaddingLeft;
       
        _nameLabel.centerY = 27;
//        _nameLabel.displaysAsynchronously = YES;
        _nameLabel.ignoreCommonProperties = YES;
        _nameLabel.fadeOnHighlight = NO;
        _nameLabel.fadeOnAsynchronouslyDisplay = NO;
        _nameLabel.lineBreakMode = NSLineBreakByClipping;
        [self addSubview:_nameLabel];
        
        _sourceLabel = [YYLabel new];
        _sourceLabel.frame = _nameLabel.frame;
        _sourceLabel.centerY = 47;
//        _sourceLabel.displaysAsynchronously = YES;
        _sourceLabel.ignoreCommonProperties = YES;
        _sourceLabel.fadeOnAsynchronouslyDisplay = NO;
        _sourceLabel.fadeOnHighlight = NO;
        [self addSubview:_sourceLabel];
        
        _sourceLabel.highlightTapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
            NSLog(@"点击了来源");
        };
        
        self.exclusiveTouch = YES;
        
    }
    return self;
}

-(void)setVerifyType:(WBUserVerifyType)verifyType
{
    _verifyType = verifyType;
    
    switch (verifyType) {
        case WBUserVerifyTypeStandard: {
            _avatarBadgeView.hidden = NO;
            _avatarBadgeView.image = [WBStatusHelper imageNamed:@"avatar_vip"];
        } break;
        case WBUserVerifyTypeClub: {
            _avatarBadgeView.hidden = NO;
            _avatarBadgeView.image = [WBStatusHelper imageNamed:@"avatar_grassroot"];
        } break;
        default: {
            _avatarBadgeView.hidden = YES;
        } break;
    }
    
    
    
}

@end

@implementation webToolView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size.width = kScreenWidth;
        frame.size.height = kWBCellToolbarHeight;
    }
    
    @weakify(self);
    
    self = [super initWithFrame:frame];
    self.exclusiveTouch = YES;
    self.backgroundColor = [UIColor whiteColor];
    
    _repostButton = [[UIButton alloc] init];
    _repostButton.exclusiveTouch = YES;
    _repostButton.size = CGSizeMake(self.width / 3.0, self.height);
    [_repostButton setBackgroundImage:[UIImage imageWithColor:kWBCellHighlightColor] forState:UIControlStateHighlighted];
    
    _commentButton = [[UIButton alloc] init];
    _commentButton.exclusiveTouch = YES;
    _commentButton.size = CGSizeMake(self.width / 3.0, self.height);
    _commentButton.left = self.width / 3.0;
    [_commentButton setBackgroundImage:[UIImage imageWithColor:kWBCellHighlightColor] forState:UIControlStateHighlighted];
    
    _likeButton = [[UIButton alloc] init];
    _likeButton.exclusiveTouch = YES;
    _likeButton.size = CGSizeMake(self.width / 3.0, self.height);
    _likeButton.left = self.width / 3.0 * 2;
    [_likeButton setBackgroundImage:[UIImage imageWithColor:kWBCellHighlightColor] forState:UIControlStateHighlighted];
    
    _repostImageV = [[UIImageView alloc] initWithImage:[WBStatusHelper imageNamed:@"timeline_icon_retweet"]];
    _repostImageV.centerY = self.height * 0.5;
    [_repostButton addSubview:_repostImageV];
    
    _commentImageV = [[UIImageView alloc] initWithImage:[WBStatusHelper imageNamed:@"timeline_icon_comment"]];
    _commentImageV.centerY = self.height * 0.5;
    [_commentButton addSubview:_commentImageV];
    
    _likeImageV = [[UIImageView alloc] initWithImage:[WBStatusHelper imageNamed:@"timeline_icon_unlike"]];
    _likeImageV.centerY = self.height * 0.5;
    [_likeButton addSubview:_likeImageV];
    
    _repostLabel = [YYLabel new];
    _repostLabel.userInteractionEnabled = NO;
    _repostLabel.height = self.height;
    _repostLabel.textVerticalAlignment = YYTextVerticalAlignmentCenter;
//    _repostLabel.displaysAsynchronously = YES;
    _repostLabel.ignoreCommonProperties = YES;
    _repostLabel.fadeOnHighlight = NO;
    _repostLabel.fadeOnAsynchronouslyDisplay = NO;
    [_repostButton addSubview:_repostLabel];
    
    _commentLabel = [YYLabel new];
    _commentLabel.userInteractionEnabled = NO;
    _commentLabel.height = self.height;
    _commentLabel.textVerticalAlignment = YYTextVerticalAlignmentCenter;
//    _commentLabel.displaysAsynchronously = YES;
    _commentLabel.ignoreCommonProperties = YES;
    _commentLabel.fadeOnHighlight = NO;
    _commentLabel.fadeOnAsynchronouslyDisplay = NO;
    [_commentButton addSubview:_commentLabel];
    
    [_commentButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        if ([weak_self.cell.delegate respondsToSelector:@selector(CellDidClickComment:)]) {
            [weak_self.cell.delegate CellDidClickComment:weak_self.cell];
        }
    }];
    
    _likeLabel = [YYLabel new];
    _likeLabel.userInteractionEnabled = NO;
    _likeLabel.height = self.height;
    _likeLabel.textVerticalAlignment = YYTextVerticalAlignmentCenter;
//    _likeLabel.displaysAsynchronously = YES;
    _likeLabel.ignoreCommonProperties = YES;
    _likeLabel.fadeOnHighlight = NO;
    _likeLabel.fadeOnAsynchronouslyDisplay = NO;
    [_likeButton addSubview:_likeLabel];
    
    [_likeButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        if ([weak_self.cell.delegate respondsToSelector:@selector(CellDidClickLike:)]) {
            [weak_self.cell.delegate CellDidClickLike:weak_self.cell];
        }
    }];
    
    _line1 = [CAGradientLayer layer];
    UIColor *color1 = [UIColor colorWithWhite:0 alpha:.2];
    UIColor *color2 = [UIColor clearColor];
    NSArray *colors = @[(id)color2.CGColor ,(id)color1.CGColor ,(id)color2.CGColor  ];
    NSArray *locations =@[@(0.2),@(0.5),@(0.8)];
    _line1.colors = colors;
    _line1.locations = locations;
    _line1.startPoint = CGPointMake(0, 0);
    _line1.endPoint = CGPointMake(0, 1);
    _line1.size = CGSizeMake(CGFloatFromPixel(1), self.height);
    _line1.left = _repostButton.right;
    
    _line2 = [CAGradientLayer layer];
    _line2.colors = colors;
    _line2.locations = locations;
    _line2.startPoint = CGPointMake(0, 0);
    _line2.endPoint = CGPointMake(0, 1);
    _line2.size = CGSizeMake(CGFloatFromPixel(1), self.height);
    _line2.left = _commentButton.right;
    
    _topLine = [CALayer layer];
    _topLine.size = CGSizeMake(self.width, CGFloatFromPixel(1));
    _topLine.backgroundColor = kWBCellLineColor.CGColor;
    _bottomLine = [CALayer layer];
    _bottomLine.size = _topLine.size;
    _bottomLine.bottom = self.height;
    _bottomLine.backgroundColor = UIColorHex(e8e8e8).CGColor;
    
    [self addSubview:_repostButton];
    [self addSubview:_commentButton];
    [self addSubview:_likeButton];
    [self.layer addSublayer:_line1];
    [self.layer addSublayer:_line2];
    [self.layer addSublayer:_topLine];
    [self.layer addSublayer:_bottomLine];
    
    return self;
}


-(void)setLayoutWith:(WebStatesLayout *)layout{
    
    _repostLabel.textLayout = layout.respostTextLayout;
    _commentLabel.textLayout = layout.commentTextLayout;
    _likeLabel.textLayout = layout.likeTextLayout;
    
    _repostLabel.width = layout.respostTextLayout.textBoundingSize.width;
    _repostLabel.left = _repostImageV.right;
    
    _commentLabel.width = layout.commentTextLayout.textBoundingSize.width;
    _commentLabel.left = _commentImageV.right;
    
    _likeLabel.width = layout.likeTextLayout.textBoundingSize.width;
    _likeLabel.left = _likeImageV.right;
    
    [self setToolBarContentWith:_repostLabel imageView:_repostImageV button:_repostButton];
    
    [self setToolBarContentWith:_commentLabel imageView:_commentImageV button:_commentButton];
    
    [self setToolBarContentWith:_likeLabel imageView:_likeImageV button:_likeButton];
}
-(void)setToolBarContentWith:(YYLabel *)label imageView:(UIImageView *)imageView button:(UIButton *)button
{
    CGFloat label_W = label.width;
    CGFloat image_W = imageView.image.size.width;
    CGFloat paddingMid = 5;
    
    CGFloat aaa = (button.width - label_W - image_W - paddingMid) * 0.5;
    imageView.centerX = aaa + image_W * 0.5;
    label.left = imageView.right + paddingMid;
}
@end

@implementation webStatusView{
    BOOL _touchRetweetView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size.width = kScreenWidth;
        frame.size.height = 1;
    }
    self = [super initWithFrame:frame];
    
    self.backgroundColor = kWBCellBackgroundColor;
    self.exclusiveTouch = YES;
    
    
    _contentView = [UIView new];
    _contentView.width = kScreenWidth;
    _contentView.height = 1;
    _contentView.backgroundColor = [UIColor whiteColor];
    static UIImage *topLineBG, *bottomLineBG;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        topLineBG = [UIImage imageWithSize:CGSizeMake(1, 3) drawBlock:^(CGContextRef context) {
            CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
            CGContextSetShadowWithColor(context, CGSizeMake(0, 0), 0.8, [UIColor colorWithWhite:0 alpha:0.08].CGColor);
            CGContextAddRect(context, CGRectMake(-2, 3, 4, 4));
            CGContextFillPath(context);
        }];
        bottomLineBG = [UIImage imageWithSize:CGSizeMake(1, 3) drawBlock:^(CGContextRef context) {
            CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
            CGContextSetShadowWithColor(context, CGSizeMake(0, 0.4), 2, [UIColor colorWithWhite:0 alpha:0.08].CGColor);
            CGContextAddRect(context, CGRectMake(-2, -2, 4, 2));
            CGContextFillPath(context);
        }];
    });
    
    UIImageView *topLine = [[UIImageView alloc] initWithImage:topLineBG];
    topLine.width = _contentView.width;
    topLine.bottom = 0;
    topLine.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    [_contentView addSubview:topLine];
    
    UIImageView *bottomLine = [[UIImageView alloc] initWithImage:bottomLineBG];
    bottomLine.width = _contentView.width;
    bottomLine.top = _contentView.height;
    bottomLine.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [_contentView addSubview:bottomLine];
    [self addSubview:_contentView];
    
    _titleView = [webTitleView new];
    _titleView.hidden = YES;
    [_contentView addSubview:_titleView];
    
    _profileView = [webProfileVIew new];
    [_contentView addSubview:_profileView];
    
    _vipBackgroundView = [UIImageView new];
    _vipBackgroundView.size = CGSizeMake(kScreenWidth, 14.0);
    _vipBackgroundView.top = -2;
    _vipBackgroundView.contentMode = UIViewContentModeRight | UIViewContentModeScaleAspectFill;
    [_contentView addSubview:_vipBackgroundView];
    
    _menuButton = [[UIButton alloc] init];
    _menuButton.size = CGSizeMake(30, 30);
    [_menuButton setImage:[WBStatusHelper imageNamed:@"timeline_icon_more"] forState:UIControlStateNormal];
    [_menuButton setImage:[WBStatusHelper imageNamed:@"timeline_icon_more_highlighted"] forState:UIControlStateHighlighted];
    _menuButton.centerX = self.width - 20;
    _menuButton.centerY = 18;
    
    [_menuButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        NSLog(@"点击了菜单按钮");
    }];
    [_contentView addSubview:_menuButton];
    
    _retweetBackgroundView = [UIView new];
    _retweetBackgroundView.backgroundColor = kWBCellInnerViewColor;
    _retweetBackgroundView.width = kScreenWidth;
    [_contentView addSubview:_retweetBackgroundView];
    
    _textLB = [YYLabel new];
    _textLB.width = kWBCellContentWidth;
    _textLB.left = kWBCellPadding;
    _textLB.textVerticalAlignment = YYTextVerticalAlignmentTop;
//    _textLB.displaysAsynchronously = YES;
    _textLB.ignoreCommonProperties = YES;
    _textLB.fadeOnHighlight = NO;
    _textLB.fadeOnAsynchronouslyDisplay = NO;
    _textLB.highlightTapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
        NSLog(@"%@" , text.string);
    };
    [_contentView addSubview:_textLB];
    
    
    _retweetBackgroundView = [UIView new];
    _retweetBackgroundView.backgroundColor = kWBCellInnerViewColor;
    _retweetBackgroundView.width = kScreenWidth;
    [_contentView addSubview:_retweetBackgroundView];
    
    
    _retweetTextLB = [YYLabel new];
    _retweetTextLB.left = kWBCellPadding;
    _retweetTextLB.width = kWBCellContentWidth;
    _retweetTextLB.textVerticalAlignment = YYTextVerticalAlignmentTop;
//    _retweetTextLB.displaysAsynchronously = YES;
    _retweetTextLB.ignoreCommonProperties = YES;
    _retweetTextLB.fadeOnAsynchronouslyDisplay = NO;
    _retweetTextLB.fadeOnHighlight = NO;
    _retweetTextLB.highlightTapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
        NSLog(@"%@" , text.string);
    };
    [_contentView addSubview:_retweetTextLB];
    
    NSMutableArray *picViews = [NSMutableArray array];
    
    for (int i = 0; i < 9; i++) {
        UIImageView *imageView = [UIImageView new];
        imageView.hidden = YES;
        imageView.clipsToBounds = YES;
        imageView.backgroundColor = kWBCellHighlightColor;
        imageView.exclusiveTouch = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageAction:)];
        imageView.tag = 100 + i;
        [imageView addGestureRecognizer:tap];
        
        
        UIView *badge = [UIImageView new];
        badge.userInteractionEnabled = NO;
        badge.contentMode = UIViewContentModeScaleAspectFit;
        badge.size = CGSizeMake(56 / 2, 36 / 2);
        badge.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
        badge.right = imageView.width;
        badge.bottom = imageView.height;
        badge.hidden = YES;
        [imageView addSubview:badge];
        [picViews addObject:imageView];
        [_contentView addSubview:imageView];
    }
    _picViews = picViews;
    
    _toolView = [webToolView new];
    [_contentView addSubview:_toolView];
    
    return self;
}


-(void)imageAction:(UITapGestureRecognizer *)tap
{
    NSMutableArray *items = [NSMutableArray array];
    UIImageView *imageView = (UIImageView *)tap.view;
    NSInteger index = imageView.tag - 100;
    
    WebStatus *status = _layout.status;
    
    NSArray *picModelArray =  status.retweeted_status ? status.retweeted_status.pic_urls : status.pic_urls;
    for (int i = 0; i <picModelArray.count ; i++) {
        
        UIImageView *image_V = _picViews[i];
        
        WebPicModel *model = picModelArray[i];
        NSString *str = model.thumbnail_pic;
        YYPhotoGroupItem *item = [YYPhotoGroupItem new];
        item.thumbView = image_V;
        item.largeImageURL = [NSURL URLWithString:[str stringByReplacingOccurrencesOfString:@"bmiddle" withString:@"large"]];
        [items addObject:item];
        
        if (i == index) {
            imageView = image_V;
        }
        
    }
    
    YYPhotoGroupView *v = [[YYPhotoGroupView alloc] initWithGroupItems:items];
    [v presentFromImageView:nil toContainer:[UIApplication sharedApplication].keyWindow animated:YES completion:nil];
    
}


-(void)setLayout:(WebStatesLayout *)layout
{
    _layout = layout;
    
    self.height = layout.height;
    
    _contentView.top = layout.marginTop;
    _contentView.height = layout.height - layout.marginTop;
    
    CGFloat top = 0;
    
    [_profileView.avatarView setImageWithURL:layout.status.user.avatar_large placeholder:nil options:kNilOptions manager:[WBStatusHelper avatarImageManager] progress:nil transform:nil completion:nil];
    
    NSString *urlStr = [NSString stringWithFormat:@"http://img.t.sinajs.cn/t6/skin/public/feed_cover/star_%d%d%d_os7.png?version=2015080302" , arc4random()%9 , arc4random()%9 , arc4random()%9];
    
    [_vipBackgroundView setImageWithURL:[NSURL URLWithString:urlStr] options:kNilOptions];
    
    _profileView.nameLabel.textLayout = layout.nameTextLayout;
    _profileView.sourceLabel.textLayout = layout.sourceTextLayout;
    _profileView.verifyType = layout.status.user.verified_type;
    _profileView.height = layout.profileView_H;
    _profileView.top = top;
    top += layout.profileView_H;
    
    _textLB.top = top;
    _textLB.height = layout.text_H;
    _textLB.textLayout = layout.textLayout;
    top += layout.text_H;
    
    _retweetBackgroundView.hidden = YES;
    _retweetTextLB.hidden = YES;
    
    if (layout.retweetHeight > 0) {
        
        _retweetTextLB.top = top;
        _retweetBackgroundView.top = top;
        
        _retweetTextLB.textLayout = layout.retweetTextLayout;
        _retweetTextLB.height = layout.retweetTextHeight;
        _retweetBackgroundView.height = layout.retweetHeight;
        
        _retweetTextLB.hidden = NO;
        _retweetBackgroundView.hidden = NO;
        
        top += layout.retweetHeight;
        
        if (layout.retweetPicHeight > 0) {
            [self layoutPicsWithTop:_retweetTextLB.bottom isRespost:YES];
            _retweetBackgroundView.height += layout.retweetPicHeight + kWBCellPadding;
            top += layout.retweetPicHeight + kWBCellPadding;
        } else {
            [self _hideImageViews];
        }
    } else {
        if (layout.picHeight > 0) {
            [self layoutPicsWithTop:_textLB.bottom isRespost:NO];
            top += layout.picHeight + kWBCellPadding;
        } else {
            [self _hideImageViews];
        }
        
    }
    _toolView.height = layout.toolBar_H;
    _toolView.top = top;
    [_toolView setLayoutWith:layout];
}


- (void)_hideImageViews {
    for (UIImageView *imageView in _picViews) {
        imageView.hidden = YES;
    }
}

-(void)layoutPicsWithTop:(CGFloat)top isRespost:(BOOL)isRespost
{
    NSInteger count = isRespost ?  _layout.status.retweeted_status.pic_urls.count : _layout.status.pic_urls.count;
    CGSize picSize = isRespost ? _layout.retweetPicSize : _layout.picSize;
    for (int i = 0; i < 9; i++) {
        UIImageView *imageView = _picViews[i];
        
        if (i >= count) {
            [imageView.layer cancelCurrentImageRequest];
            imageView.hidden = YES;
        } else {
            CGPoint point = {0};
            switch (count) {
                case 1:
                    point = CGPointMake(kWBCellPadding, top);
                    break;
                case 4:
                    point = CGPointMake(kWBCellPadding + (picSize.width + kWBCellPaddingPic) * (i % 2),top + (picSize.width + kWBCellPaddingPic) * (i /2));
                    break;
                default:
                    point = CGPointMake(kWBCellPadding + (picSize.width + kWBCellPaddingPic) * (i % 3),top + (picSize.width + kWBCellPaddingPic) * (i /3));
                    break;
            }
            
            imageView.left = point.x;
            imageView.top = point.y;
            imageView.size = picSize;
            
            WebPicModel *picUrl = isRespost ?  _layout.status.retweeted_status.pic_urls[i] : _layout.status.pic_urls[i];
            [imageView.layer setImageWithURL:[NSURL URLWithString:picUrl.thumbnail_pic] placeholder:nil options:kNilOptions completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
                
            }];
            imageView.hidden = NO;
        }
        
    }
    
    
}

@end

@implementation WebCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    NSLog(@"%@", NSStringFromClass([self class])); // Son
    NSLog(@"%@", NSStringFromClass([super class])); // Son

    _statusView = [webStatusView new];
    _statusView.cell = self;
    _statusView.titleView.cell = self;
    _statusView.profileView.cell = self;
    _statusView.toolView.cell = self;
    
    [self.contentView addSubview:_statusView];
    
    return self;
}


-(void)setLayout:(WebStatesLayout *)layout{
    
    self.height = layout.height;
    self.contentView.height = layout.height;
    _statusView.layout = layout;
    
}


@end
