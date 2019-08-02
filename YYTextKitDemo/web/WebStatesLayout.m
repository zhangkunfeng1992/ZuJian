//
//  WebStatesLayout.m
//  YYTextKitDemo
//
//  Created by zkf on 2017/6/13.
//  Copyright © 2017年 zkf. All rights reserved.
//

#import "WebStatesLayout.h"

/**
 微博的文本中，某些嵌入的图片需要从网上下载，这里简单做个封装
 */
@interface WBTextImageViewAttachment : YYTextAttachment
@property (nonatomic, strong) NSURL *imageURL;
@property (nonatomic, assign) CGSize size;
@end

@implementation WBTextImageViewAttachment {
    UIImageView *_imageView;
}
- (void)setContent:(id)content {
    _imageView = content;
}
- (id)content {
    /// UIImageView 只能在主线程访问
    if (pthread_main_np() == 0) return nil;
    if (_imageView) return _imageView;
    
    /// 第一次获取时 (应该是在文本渲染完成，需要添加附件视图时)，初始化图片视图，并下载图片
    /// 这里改成 YYAnimatedImageView 就能支持 GIF/APNG/WebP 动画了
    _imageView = [UIImageView new];
    _imageView.size = _size;
    [_imageView setImageWithURL:_imageURL placeholder:nil];
    return _imageView;
}
@end

@implementation WebStatesLayout

-(instancetype)initWithStatus:(WebStatus *)status
{
    if (!status.user.name.length || !status) return nil;
    self = [super init];
    _status = status;
    [self layout];
    return self;
}

-(void)layout{
    [self _layout];
    
}
-(void)_layout
{
    _marginTop = kWBCellTopMargin;
    _titleView_H = 0;
    _profileView_H = kWBCellProfileHeight;
    _text_H = 0;
    _retweetHeight = 0;
    _retweetPicSize = CGSizeZero;
    _picSize = CGSizeZero;
    _retweetPicHeight = 0;
    _picHeight = 0;
    _toolBar_H = kWBCellToolbarHeight;
    
    
    [self layoutTitleView];
    [self layoutProfileView];
    [self layoutRetweetView];
    if (_retweetPicHeight == 0) {
        [self layoutPic];
    }
    [self layoutText];
    
    [self layoutToolBarView];
    
    
    // 计算高度
    _height = 0;
    _height += _marginTop;
//    _height += _titleHeight;
    _height += _profileView_H;
    _height += _text_H;
    
    if (_retweetHeight > 0) {
        _height += _retweetHeight;
        if (_retweetPicHeight > 0) {
            _height += _retweetPicHeight + kWBCellPadding;
        }
    } else {
        if (_picHeight > 0) {
            _height += _picHeight + kWBCellPadding;
        }
    }
    
    _height += _toolBar_H;
}

-(void)layoutTitleView
{
    
}

-(void)layoutProfileView
{
    [self _layoutName];
    [self _layoutSource];
    _profileView_H = kWBCellProfileHeight;
}

-(void)_layoutName{
    
    WebUser *user = _status.user;
    NSString *nameStr = nil;
    
    if (user.screen_name.length) {
        nameStr = user.screen_name;
    } else {
        nameStr = user.name;
    }
    
    if (nameStr.length==0) {
        _nameTextLayout = nil;
        return;
    }
    
    NSMutableAttributedString *nameText = [[NSMutableAttributedString alloc] initWithString:nameStr];
    
    if (user.mbrank > 0) {
        
        UIImage *image = [WBStatusHelper imageNamed:[NSString stringWithFormat:@"common_icon_membership_level%ld" , user.mbrank]];
        NSAttributedString *str = [self _attachmentWithFontSize:kWBCellNameFontSize image:image shrink:NO];
        [nameText appendString:@" "];
        [nameText appendAttributedString:str];
        
    }
    
    nameText.font = [UIFont systemFontOfSize:kWBCellNameFontSize];
    nameText.color = user.mbrank > 0 ? kWBCellNameOrangeColor : kWBCellNameNormalColor;
    
    YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(kWBCellNameWidth, 9999)];
    container.maximumNumberOfRows = 1;
    YYTextLayout *textLayou = [YYTextLayout layoutWithContainer:container text:nameText];
    _nameTextLayout = textLayou;
    
}

-(void)_layoutSource{
    
    NSMutableAttributedString *sourceText = [NSMutableAttributedString new];
    
    NSString *creatTime = [WBStatusHelper stringWithTimelineDate:_status.created_at];
    
    if (creatTime.length) {
        [sourceText appendString:creatTime];
    }
    sourceText.font = [UIFont systemFontOfSize:kWBCellSourceFontSize];
    sourceText.color = kWBCellTimeNormalColor;
    
    YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(kWBCellNameWidth, 9999)];
    YYTextLayout *layout = [YYTextLayout layoutWithContainer:container text:sourceText];
    _sourceTextLayout = layout;
    
}


-(void)layoutRetweetView
{
    [self layoutRetweetText];
    [self layoutRetweetedPic];
    
    
}
-(void)layoutRetweetText{
    
    _retweetHeight = 0;
    _retweetTextHeight = 0;
    _retweetTextLayout = nil;
    
    NSMutableAttributedString *text = [self _textWithStatus:_status.retweeted_status isRetweet:YES fontSize:kWBCellTextFontSize textColor:kWBCellTextNormalColor];
    
    WBTextLinePositionModifier *modifier = [WBTextLinePositionModifier new];
    modifier.lineTop = 10;
    modifier.lineBottom = 10;
    modifier.font = [UIFont fontWithName:@"Heiti SC" size:kWBCellTextFontSize];
    
    YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(kWBCellContentWidth, 9999)];
    container.linePositionModifier = modifier;
    
    YYTextLayout *layout = [YYTextLayout layoutWithContainer:container text:text];
    _retweetTextLayout = layout;
    _retweetTextHeight = [modifier heightForLineCount:layout.rowCount];
    _retweetHeight = _retweetTextHeight;
}

-(void)layoutPic{
    [self layoutPicWith:_status isResopst:NO];
}
-(void)layoutRetweetedPic{
    [self layoutPicWith:_status.retweeted_status isResopst:YES];
    
}


-(void)layoutPicWith:(WebStatus *)status isResopst:(BOOL)isResopst{
    
    
    if (isResopst) {
        _retweetPicSize = CGSizeZero;
        _retweetPicHeight = 0;
    } else {
        _picSize = CGSizeZero;
        _picHeight = 0;
    }
    
    if (status.pic_urls.count) {
        CGSize picSize = CGSizeZero;
        CGFloat pic_H = 0;
        CGFloat picW_H = (kWBCellContentWidth - kWBCellPaddingPic * 2) / 3;
        
        NSInteger count = status.pic_urls.count;
        if (count == 0) return;
        switch (count) {
            case 1:
                picSize = CGSizeMake(picW_H, picW_H);
                pic_H = picW_H;
                break;
            case 2: case 3:
                picSize = CGSizeMake(picW_H, picW_H);
                pic_H = picW_H;
                break;
            case 4: case 5: case 6:
                picSize = CGSizeMake(picW_H, picW_H);
                pic_H = picW_H * 2 + kWBCellPaddingPic;
                break;
            default:
                picSize = CGSizeMake(picW_H, picW_H);
                pic_H = picW_H * 3 + kWBCellPaddingPic * 2;
                break;
        }
        
        if (isResopst) {
            _retweetPicSize = picSize;
            _retweetPicHeight = pic_H;
        } else {
            _picSize = picSize;
            _picHeight = pic_H;
        }
        
    }
}


-(void)layoutText
{
    _text_H = 0;
    _textLayout = nil;
    
    if (_status.text.length) {
        NSMutableAttributedString *text = [self _textWithStatus:_status isRetweet:NO fontSize:kWBCellTextFontSize textColor:kWBCellTextNormalColor];
        WBTextLinePositionModifier *modifier = [WBTextLinePositionModifier new];
        modifier.lineTop = 10;
        modifier.lineBottom = 10;
//        modifier.font = [UIFont fontWithName:@"Heiti SC" size:kWBCellTextFontSize];
        modifier.font = [UIFont boldSystemFontOfSize:kWBCellTextFontSize];
        
        YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(kWBCellContentWidth, 9999)];
        container.linePositionModifier = modifier;
        
        YYTextLayout *layout = [YYTextLayout layoutWithContainer:container text:text];
        _textLayout = layout;
        _text_H = [modifier heightForLineCount:layout.rowCount];
        
    } else {
        _textLayout = nil;
    }
}

-(void)layoutToolBarView{
    _respostTextLayout = nil;
    _commentTextLayout = nil;
    _likeTextLayout = nil;
    
    YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(MAXFLOAT, kWBCellToolbarHeight)];
    container.maximumNumberOfRows = 1;
    
    NSMutableAttributedString *repostText = [[NSMutableAttributedString alloc] initWithString: _status.reposts_count <= 0 ? @"转发" : [WBStatusHelper shortedNumberDesc:_status.reposts_count]];
    repostText.font = [UIFont systemFontOfSize:kWBCellToolbarFontSize];
    repostText.color = kWBCellToolbarTitleColor;
    YYTextLayout *respostLayout = [YYTextLayout layoutWithContainer:container text:repostText];
    _respostTextLayout = respostLayout;
    
    
    
    NSMutableAttributedString *commentText = [[NSMutableAttributedString alloc] initWithString:_status.comments_count <= 0 ? @"评论" : [WBStatusHelper shortedNumberDesc:_status.comments_count]];
    commentText.font = [UIFont systemFontOfSize:kWBCellToolbarFontSize];
    commentText.color = kWBCellToolbarTitleColor;
    YYTextLayout *commentLayout = [YYTextLayout layoutWithContainer:container text:commentText];
    _commentTextLayout = commentLayout;
    
    NSMutableAttributedString *likeText = [[NSMutableAttributedString alloc] initWithString:_status.attitudes_count <= 0 ? @"赞" : [WBStatusHelper shortedNumberDesc:_status.attitudes_count]];
    likeText.font = [UIFont systemFontOfSize:kWBCellToolbarFontSize];
    likeText.color = kWBCellToolbarTitleColor;
    
    YYTextLayout *likeLayout = [YYTextLayout layoutWithContainer:container text:likeText];
    _likeTextLayout = likeLayout;
    
    
}


- (NSAttributedString *)_attachmentWithFontSize:(CGFloat)fontSize image:(UIImage *)image shrink:(BOOL)shrink {
    
    // Heiti SC 字体。。
    CGFloat ascent = fontSize * 0.86;
    CGFloat descent = fontSize * 0.14;
    CGRect bounding = CGRectMake(0, -0.14 * fontSize, fontSize, fontSize);
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(ascent - (bounding.size.height + bounding.origin.y), 0, descent + bounding.origin.y, 0);
    
    YYTextRunDelegate *delegate = [YYTextRunDelegate new];
    delegate.ascent = ascent;
    delegate.descent = descent;
    delegate.width = bounding.size.width;
    
    YYTextAttachment *attachment = [YYTextAttachment new];
    attachment.contentMode = UIViewContentModeScaleAspectFit;
    attachment.contentInsets = contentInsets;
    attachment.content = image;
    
    if (shrink) {
        // 缩小~
        CGFloat scale = 1 / 10.0;
        contentInsets.top += fontSize * scale;
        contentInsets.bottom += fontSize * scale;
        contentInsets.left += fontSize * scale;
        contentInsets.right += fontSize * scale;
        contentInsets = UIEdgeInsetPixelFloor(contentInsets);
        attachment.contentInsets = contentInsets;
    }
    
    NSMutableAttributedString *atr = [[NSMutableAttributedString alloc] initWithString:YYTextAttachmentToken];
    [atr setTextAttachment:attachment range:NSMakeRange(0, atr.length)];
    CTRunDelegateRef ctDelegate = delegate.CTRunDelegate;
    [atr setRunDelegate:ctDelegate range:NSMakeRange(0, atr.length)];
    if (ctDelegate) CFRelease(ctDelegate);
    
    return atr;
}


- (NSAttributedString *)_attachmentWithFontSize:(CGFloat)fontSize imageURL:(NSString *)imageURL shrink:(BOOL)shrink {
    /*
     微博 URL 嵌入的图片，比临近的字体要小一圈。。
     这里模拟一下 Heiti SC 字体，然后把图片缩小一下。
     */
    CGFloat ascent = fontSize * 0.86;
    CGFloat descent = fontSize * 0.14;
    CGRect bounding = CGRectMake(0, -0.14 * fontSize, fontSize, fontSize);
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(ascent - (bounding.size.height + bounding.origin.y), 0, descent + bounding.origin.y, 0);
    CGSize size = CGSizeMake(fontSize, fontSize);
    
    if (shrink) {
        // 缩小~
        CGFloat scale = 1 / 10.0;
        contentInsets.top += fontSize * scale;
        contentInsets.bottom += fontSize * scale;
        contentInsets.left += fontSize * scale;
        contentInsets.right += fontSize * scale;
        contentInsets = UIEdgeInsetPixelFloor(contentInsets);
        size = CGSizeMake(fontSize - fontSize * scale * 2, fontSize - fontSize * scale * 2);
        size = CGSizePixelRound(size);
    }
    
    YYTextRunDelegate *delegate = [YYTextRunDelegate new];
    delegate.ascent = ascent;
    delegate.descent = descent;
    delegate.width = bounding.size.width;
    
    WBTextImageViewAttachment *attachment = [WBTextImageViewAttachment new];
    attachment.contentMode = UIViewContentModeScaleAspectFit;
    attachment.contentInsets = contentInsets;
    attachment.size = size;
    attachment.imageURL = [WBStatusHelper defaultURLForImageURL:imageURL];
    
    NSMutableAttributedString *atr = [[NSMutableAttributedString alloc] initWithString:YYTextAttachmentToken];
    [atr setTextAttachment:attachment range:NSMakeRange(0, atr.length)];
    CTRunDelegateRef ctDelegate = delegate.CTRunDelegate;
    [atr setRunDelegate:ctDelegate range:NSMakeRange(0, atr.length)];
    if (ctDelegate) CFRelease(ctDelegate);
    
    return atr;
}

-(NSMutableAttributedString *)_textWithStatus:(WebStatus *)status isRetweet:(BOOL)isRetweet fontSize:(CGFloat)fontSize textColor:(UIColor *)textColor{
    
    if (!status) return nil;
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    // 高亮状态的背景
    YYTextBorder *highlightBorder = [YYTextBorder new];
    highlightBorder.insets = UIEdgeInsetsMake(-2, 0, -2, 0);
    highlightBorder.cornerRadius = 3;
    highlightBorder.fillColor = kWBCellTextHighlightBackgroundColor;
    
    NSMutableString *string = status.text.mutableCopy;
    if (string.length == 0) return nil;
    if (isRetweet) {
        NSString *name = status.user.name;
        if (name.length == 0) {
            name = status.user.screen_name;
        }
        if (name) {
            NSString *insert = [NSString stringWithFormat:@"@%@:",name];
            [string insertString:insert atIndex:0];
        }
    }
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:string];
    text.font = font;
    text.color = textColor;
    text.maximumLineHeight = 0;
    
    NSArray *atResults = [[WBStatusHelper regexAt] matchesInString:text.string options:kNilOptions range:text.rangeOfAll];
    for (NSTextCheckingResult *at in atResults) {
        if (at.range.location == NSNotFound && at.range.length <= 1) continue;
        if ([text attribute:YYTextHighlightAttributeName atIndex:at.range.location] == nil) {
            [text setColor:kWBCellTextHighlightColor range:at.range];
            
            // 高亮状态
            YYTextHighlight *highlight = [YYTextHighlight new];
            [highlight setBackgroundBorder:highlightBorder];
            // 数据信息，用于稍后用户点击
            highlight.userInfo = @{kWBLinkAtName : [text.string substringWithRange:NSMakeRange(at.range.location + 1, at.range.length - 1)]};
            [text setTextHighlight:highlight range:at.range];
        }
    }
    
    
    NSArray *topicResults = [[WBStatusHelper regexTopic] matchesInString:text.string options:kNilOptions range:text.rangeOfAll];
    for (NSTextCheckingResult *topicResult in topicResults) {
        
        if (topicResult.range.location == NSNotFound || topicResult.range.length <= 2) continue;
        
        if ([text attribute:YYTextHighlightAttributeName atIndex:topicResult.range.location] == nil) {
            
            [text setColor:kWBCellTextHighlightColor range:topicResult.range];
            
            YYTextHighlight *hight = [YYTextHighlight new];
            [hight setBackgroundBorder:highlightBorder];
            hight.userInfo = @{kWBLinkAtName : [text.string substringWithRange:NSMakeRange(topicResult.range.location + 1, topicResult.range.length - 1)]};
            [text setTextHighlight:hight range:topicResult.range];
        }
    }
    
    
    // 匹配 [表情]
    NSArray<NSTextCheckingResult *> *emoticonResults = [[WBStatusHelper regexEmoticon] matchesInString:text.string options:kNilOptions range:text.rangeOfAll];
    NSUInteger emoClipLength = 0;
    for (NSTextCheckingResult *emo in emoticonResults) {
        if (emo.range.location == NSNotFound && emo.range.length <= 1) continue;
        NSRange range = emo.range;
        range.location -= emoClipLength;
        if ([text attribute:YYTextHighlightAttributeName atIndex:range.location]) continue;
        if ([text attribute:YYTextAttachmentAttributeName atIndex:range.location]) continue;
        NSString *emoString = [text.string substringWithRange:range];
        NSString *imagePath = [WBStatusHelper emoticonDic][emoString];
        UIImage *image = [WBStatusHelper imageWithPath:imagePath];
        if (!image) continue;
        
        NSAttributedString *emoText = [NSAttributedString attachmentStringWithEmojiImage:image fontSize:fontSize];
        [text replaceCharactersInRange:range withAttributedString:emoText];
        emoClipLength += range.length - 1;
    }
    return text;
}



@end


@implementation WBTextLinePositionModifier

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        if (kiOS9Later) {
            _lineHeightMultiple = 1.34;   // for PingFang SC
        } else {
            _lineHeightMultiple = 1.3125; // for Heiti SC
        }
    }
    return self;
}

-(id)copyWithZone:(NSZone *)zone
{
    WBTextLinePositionModifier *Modifier = [self.class new];
    Modifier->_font = _font;
    Modifier->_lineTop = _lineTop;
    Modifier->_lineBottom = _lineBottom;
    Modifier->_lineHeightMultiple = _lineHeightMultiple;
    return Modifier;
}

-(void)modifyLines:(NSArray<YYTextLine *> *)lines fromText:(NSAttributedString *)text inContainer:(YYTextContainer *)container
{
    CGFloat ascender = _font.pointSize * 0.86;
//    CGFloat ascender = _font.ascender;
    CGFloat lineHeight = _font.pointSize * _lineHeightMultiple;
    
    for (YYTextLine *line in lines) {
        
        CGPoint point = line.position;
        point.y = _lineTop + ascender + line.row * lineHeight;
        line.position = point;
        
    }
}
-(CGFloat)heightForLineCount:(NSUInteger)lineCount{
    
    if (lineCount == 0) return 0;
    
    CGFloat ascender = _font.pointSize * 0.86;
    CGFloat descender = _font.pointSize * 0.14;
    CGFloat lineHeight = _font.pointSize * _lineHeightMultiple;
    
    return _lineTop + _lineBottom + ascender + descender + (lineCount - 1) * lineHeight;
    
}

@end
