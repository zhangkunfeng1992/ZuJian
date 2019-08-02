//
//  WebEmotionView.h
//  YYTextKitDemo
//
//  Created by zkf on 2017/6/22.
//  Copyright © 2017年 zkf. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol WebEmotionViewDelegate <NSObject>

- (void)emoticonInputDidTapText:(NSString *)text;
- (void)emoticonInputDidTapBackspace;

@end

@interface WebEmotionView : UIView
+(WebEmotionView *)sharedView;
@property (nonatomic , assign) id<WebEmotionViewDelegate> delegate;
@end
