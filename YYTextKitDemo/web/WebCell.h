//
//  WebCell.h
//  YYTextKitDemo
//
//  Created by zkf on 2017/6/13.
//  Copyright © 2017年 zkf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYKit.h"
#import "ZKFCell.h"
#import "WebStatesLayout.h"
@class WebCell;
@interface webTitleView : UIView

@property (nonatomic , strong) YYLabel *titleLB;
@property (nonatomic , strong) UIButton *arrowButton;
@property (nonatomic , weak) WebCell *cell;

@end

@interface webProfileVIew : UIView

@property (nonatomic, strong) UIImageView *avatarView; ///< 头像
@property (nonatomic, strong) UIImageView *avatarBadgeView; ///< 徽章
@property (nonatomic, strong) YYLabel *nameLabel;
@property (nonatomic, strong) YYLabel *sourceLabel;
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIButton *arrowButton;
@property (nonatomic, strong) UIButton *followButton;
@property (nonatomic, assign) WBUserVerifyType verifyType;
@property (nonatomic, weak) WebCell *cell;

@end


@interface webToolView : UIView

@property (nonatomic , strong) UIButton *repostButton;
@property (nonatomic , strong) UIButton *commentButton;
@property (nonatomic , strong) UIButton *likeButton;

@property (nonatomic , strong) UIImageView *repostImageV;
@property (nonatomic , strong) UIImageView *commentImageV;
@property (nonatomic , strong) UIImageView *likeImageV;

@property (nonatomic , strong) YYLabel *repostLabel;
@property (nonatomic , strong) YYLabel *commentLabel;
@property (nonatomic , strong) YYLabel *likeLabel;

@property (nonatomic, strong) CAGradientLayer *line1;
@property (nonatomic, strong) CAGradientLayer *line2;
@property (nonatomic, strong) CALayer *topLine;
@property (nonatomic, strong) CALayer *bottomLine;
@property (nonatomic, weak) WebCell *cell;

-(void)setLayoutWith:(WebStatesLayout *)layout;

@end

@interface webStatusView : UIView

@property (nonatomic , strong) UIView *contentView;
@property (nonatomic , strong) webTitleView *titleView;
@property (nonatomic , strong) webProfileVIew *profileView;
@property (nonatomic , strong) webToolView *toolView;
@property (nonatomic , strong) YYLabel *textLB;
@property (nonatomic , strong) NSArray *picViews;
@property (nonatomic , strong) UIView *retweetBackgroundView;
@property (nonatomic , strong) YYLabel *retweetTextLB;

@property (nonatomic , strong) UIImageView *vipBackgroundView;
@property (nonatomic , strong) UIButton *menuButton;
@property (nonatomic , strong) UIButton *followButton;


@property (nonatomic , strong) WebStatesLayout *layout;
@property (nonatomic , weak) WebCell *cell;

@end


@protocol WebCellDelegate;
@interface WebCell : ZKFCell

@property (nonatomic , strong) webStatusView *statusView;

-(void)setLayout:(WebStatesLayout *)layout;

@property (nonatomic , assign) id<WebCellDelegate> delegate;

@end

@protocol WebCellDelegate <NSObject>

-(void)CellDidClickLike:(WebCell *)cell;
-(void)CellDidClickComment:(WebCell *)cell;

@end
