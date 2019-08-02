//
//  WebStatesLayout.h
//  YYTextKitDemo
//
//  Created by zkf on 2017/6/13.
//  Copyright © 2017年 zkf. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "WBModel.h"
#import "WebModel.h"
#import "WBStatusHelper.h"

#define kWBCellTitleView_H 36
#define kWBCellTopMargin 8
#define kWBCellPadding 10

#define kWBCellNameFontSize 16      // 名字字体大小
#define kWBCellSourceFontSize 12    // 来源字体大小
#define kWBCellTextFontSize 16      // 文本字体大小
#define kWBCellTextFontRetweetSize 16 // 转发字体大小
#define kWBCellCardTitleFontSize 16 // 卡片标题文本字体大小
#define kWBCellCardDescFontSize 12 // 卡片描述文本字体大小
#define kWBCellTitlebarFontSize 14 // 标题栏字体大小
#define kWBCellToolbarFontSize 14 // 工具栏字体大小

#define kWBCellLineColor [UIColor colorWithWhite:0.000 alpha:0.09] //线条颜色

#define kWBCellProfileHeight 56 // cell 名片高度
#define kWBCellNameWidth (kScreenWidth - 110) // cell 名字最宽限制
#define kWBCellNamePaddingLeft 14 // cell 名字和 avatar 之间留白

#define kWBCellToolbarHeight 35     // cell 下方工具栏高度
#define kWBCellPaddingPic 4     // cell 多张图片中间留白

#define kWBCellInnerViewColor UIColorHex(f7f7f7)   // Cell内部卡片灰色

#define kWBCellContentWidth (kScreenWidth - 2 * kWBCellPadding) // cell 内容宽度


// 颜色
#define kWBCellNameNormalColor UIColorHex(333333) // 名字颜色
#define kWBCellNameOrangeColor UIColorHex(f26220) // 橙名颜色 (VIP)
#define kWBCellTimeNormalColor UIColorHex(828282) // 时间颜色
#define kWBCellTimeOrangeColor UIColorHex(f28824) // 橙色时间 (最新刷出)

#define kWBCellTextNormalColor UIColorHex(333333) // 一般文本色
#define kWBCellTextSubTitleColor UIColorHex(5d5d5d) // 次要文本色
#define kWBCellTextHighlightColor UIColorHex(527ead) // Link 文本色
#define kWBCellTextHighlightBackgroundColor UIColorHex(bfdffe) // Link 点击背景色
#define kWBCellToolbarTitleColor UIColorHex(929292) // 工具栏文本色
#define kWBCellToolbarTitleHighlightColor UIColorHex(df422d) // 工具栏文本高亮色

#define kWBCellBackgroundColor UIColorHex(f2f2f2)    // Cell背景灰色
#define kWBCellHighlightColor UIColorHex(f0f0f0)     // Cell高亮时灰色
#define kWBCellInnerViewColor UIColorHex(f7f7f7)   // Cell内部卡片灰色
#define kWBCellInnerViewHighlightColor  UIColorHex(f0f0f0) // Cell内部卡片高亮时灰色
#define kWBCellLineColor [UIColor colorWithWhite:0.000 alpha:0.09] //线条颜色


#define kWBLinkHrefName @"href" //NSString
#define kWBLinkURLName @"url" //WBURL
#define kWBLinkTagName @"tag" //WBTag
#define kWBLinkTopicName @"topic" //WBTopic
#define kWBLinkAtName @"at" //NSString

@interface WBTextLinePositionModifier : NSObject<YYTextLinePositionModifier>
@property (nonatomic , strong) UIFont *font;
@property (nonatomic , assign) CGFloat lineTop;
@property (nonatomic , assign) CGFloat lineBottom;
@property (nonatomic , assign) CGFloat lineHeightMultiple;

-(CGFloat)heightForLineCount:(NSUInteger)lineCount;

@end

@interface WebStatesLayout : NSObject

-(instancetype)initWithStatus:(WebStatus *)status;

@property (nonatomic , strong) WebStatus *status;

@property (nonatomic , assign) CGFloat marginTop;
@property (nonatomic , assign) CGFloat titleView_H;
@property (nonatomic , strong) YYTextLayout *titleTextLayout;

@property (nonatomic , assign) CGFloat profileView_H;
@property (nonatomic , strong) YYTextLayout *nameTextLayout;
@property (nonatomic , strong) YYTextLayout *sourceTextLayout;


@property (nonatomic , assign) CGFloat text_H;
@property (nonatomic , strong) YYTextLayout *textLayout;
@property (nonatomic, assign) CGFloat picHeight; //图片高度，0为没图片
@property (nonatomic, assign) CGSize picSize;

@property (nonatomic , assign) CGFloat retweetHeight;
@property (nonatomic , assign) CGFloat retweetTextHeight;
@property (nonatomic , strong) YYTextLayout *retweetTextLayout;
@property (nonatomic, assign) CGFloat retweetPicHeight;
@property (nonatomic, assign) CGSize retweetPicSize;


@property (nonatomic , strong) YYTextLayout *respostTextLayout;
@property (nonatomic , strong) YYTextLayout *commentTextLayout;
@property (nonatomic , strong) YYTextLayout *likeTextLayout;
@property (nonatomic , assign) CGFloat toolBar_H;

@property (nonatomic , assign) CGFloat height;
@end
