//
//  ChatToolBar.h
//  YYTextKitDemo
//
//  Created by zkf on 2017/4/19.
//  Copyright © 2017年 zkf. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChatToolBarDelegate <NSObject>

@optional

/*
 *  文字输入框开始编辑
 *
 *  @param inputTextView 输入框对象
 */
//- (void)inputTextViewDidBeginEditing:(EaseTextView *)inputTextView;

/*
 *  文字输入框将要开始编辑
 *
 *  @param inputTextView 输入框对象
 */
//- (void)inputTextViewWillBeginEditing:(EaseTextView *)inputTextView;

/*
 *  发送文字消息，可能包含系统自带表情
 *
 *  @param text 文字消息
 */
- (void)didSendText:(NSString *)text;

/*
 *  发送文字消息，可能包含系统自带表情
 *
 *  @param text 文字消息
 *  @param ext 扩展消息
 */
- (void)didSendText:(NSString *)text withExt:(NSDictionary*)ext;

/*
 *  在光标location位置处是否插入字符@
 *
 *  @param location 光标位置
 */
- (BOOL)didInputAtInLocation:(NSUInteger)location;

/*
 *  在光标location位置处是否删除字符@
 *
 *  @param location 光标位置
 */
- (BOOL)didDeleteCharacterFromLocation:(NSUInteger)location;

/*
 *  发送第三方表情，不会添加到文字输入框中
 *
 *  @param faceLocalPath 选中的表情的本地路径
 */
- (void)didSendFace:(NSString *)faceLocalPath;

/*
 *  按下录音按钮开始录音
 */
- (void)didStartRecordingVoiceAction:(UIView *)recordView;

/*
 *  手指向上滑动取消录音
 */
- (void)didCancelRecordingVoiceAction:(UIView *)recordView;

/*
 *  松开手指完成录音
 */
- (void)didFinishRecoingVoiceAction:(UIView *)recordView;

/*
 *  当手指离开按钮的范围内时，主要为了通知外部的HUD
 */
- (void)didDragOutsideAction:(UIView *)recordView;

/*
 *  当手指再次进入按钮的范围内时，主要也是为了通知外部的HUD
 */
- (void)didDragInsideAction:(UIView *)recordView;

@required

/*
 *  高度变到toHeight
 */
- (void)chatToolbarDidChangeFrameToHeight:(CGFloat)toHeight andDuration:(CGFloat)duration;

@end

@interface ChatToolBar : UIView

@property (weak, nonatomic) id<ChatToolBarDelegate> delegate;
@property (nonatomic , weak) UITextView *textView;

@end
