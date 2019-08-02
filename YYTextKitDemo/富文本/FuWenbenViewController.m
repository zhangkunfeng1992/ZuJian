//
//  FuWenbenViewController.m
//  YYTextKitDemo
//
//  Created by zkf on 2017/6/14.
//  Copyright © 2017年 zkf. All rights reserved.
//

#import "FuWenbenViewController.h"
#import "YYKit.h"
@interface FuWenbenViewController ()

@end

@implementation FuWenbenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    YYLabel *label = [[YYLabel alloc] init];
    label.backgroundColor = [UIColor whiteColor];
    UIFont *font = [UIFont systemFontOfSize:18];
    CGFloat width = kScreenWidth - 20;
    NSMutableAttributedString *text = [NSMutableAttributedString new];
    
    
    
    NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:@"开始"];
    one.font = font;
//    one.color = [UIColor redColor];
    
    [one setTextHighlightRange:one.rangeOfAll color:[UIColor yellowColor] backgroundColor:[UIColor greenColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        
    }];
    
//    YYTextBorder *border = [YYTextBorder new];
////    border.cornerRadius = 50;
//    border.insets = UIEdgeInsetsMake(0, -3, 0, -3);
//    border.strokeWidth = 0.5;
//    border.strokeColor = one.color;
//    border.lineStyle = YYTextLineStyleSingle;
//    one.textBackgroundBorder = border;
    
//    YYTextBorder *highlightBorder = [YYTextBorder new];
//    highlightBorder.strokeWidth = 0;
//    highlightBorder.strokeColor = one.color;
//    highlightBorder.fillColor = one.color;
//    highlightBorder.insets = UIEdgeInsetsMake(0, -3, 0, -3);
////    border.lineStyle = YYTextLineStyleSingle;
//    one.textBackgroundBorder = highlightBorder;
//    
//    YYTextHighlight *highlight = [YYTextHighlight new];
//    [highlight setColor:[UIColor whiteColor]];
//    [highlight setBackgroundBorder:highlightBorder];
//    highlight.tapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
//        [_self showMessage:[NSString stringWithFormat:@"Tap: %@",[text.string substringWithRange:range]]];
//    };
    
    
//    [one setTextHighlight:highlight range:one.rangeOfAll];
    
    
    
//    NSMutableAttributedString *title11 = [[NSMutableAttributedString alloc] initWithString:@"开始 "];
//    YYTextBorder *border = [YYTextBorder new];
//    border.fillColor = [UIColor colorWithRed:0.5 green:0.7 blue:0 alpha:1];
//    border.insets = UIEdgeInsetsMake(-10, 0, -10, 0);
////    border.cornerRadius = 2;
//    YYTextHighlight *textHight = [YYTextHighlight new];
//    [textHight setBackgroundBorder:border];
//    textHight.tapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
//        NSLog(@"SF");
//    };
//    
//    [title11 setTextHighlight:textHight range:title11.rangeOfAll];
    [text appendAttributedString:one];
//    [text setTextHighlightRange:title11.rangeOfAll color:[UIColor redColor] backgroundColor:[UIColor blackColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
//        NSLog(@"%@" ,title11 );
//    }];
    
    
    
    NSArray *names = @[@"001", @"022", @"019",@"056",@"085",@"001", @"022", @"019",@"056",@"085",@"001", @"022", @"019",@"056",@"085",@"001", @"022", @"019",@"056",@"085",@"001", @"022",@"001",@"001",@"022",@"022",@"022",@"022",@"022",@"022",@"022",@"001",@"001",@"001",@"001",@"001",@"001",@"001",@"001",@"001",@"001",@"001",@"001",@"001",@"001",@"001",@"001",@"001",@"001",@"001",@"001",@"001",@"001",@"022",@"022",@"022",@"022",@"001", @"022", @"019",@"056",@"085",@"001", @"022", @"019",@"056",@"085",@"001", @"022", @"019",@"056",@"085",@"001", @"022", @"019",@"056",@"085",@"001", @"022",@"001",@"001",@"022",@"022",@"022",@"022",@"022",@"022",@"022",@"001",@"001",@"001",@"001",@"001",@"001",@"001",@"001",@"001",@"001",@"001",@"001",@"001",@"001",@"001",@"001",@"001",@"001",@"001",@"001",@"001",@"001",@"022",@"022",@"022",@"022"];
    NSInteger aaa = arc4random()%141;
    for (int j = 0; j< aaa ;j++)
    {
        NSString *name  = names[j];
        NSString *path = [[NSBundle mainBundle] pathForScaledResource:name ofType:@"gif" inDirectory:@"EmoticonQQ.bundle"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        YYImage *image = [YYImage imageWithData:data scale:2];//修改表情大小
        image.preloadAllAnimatedImageFrames = YES;
        YYAnimatedImageView *imageView = [[YYAnimatedImageView alloc] initWithImage:image];
        NSMutableAttributedString *attachText = [NSMutableAttributedString attachmentStringWithContent:imageView contentMode:UIViewContentModeCenter attachmentSize:imageView.size alignToFont:font alignment:YYTextVerticalAlignmentCenter];
        [text appendAttributedString:attachText];
//        if(arc4random()%5==0)
//        {
//            [text appendAttributedString:[[NSAttributedString alloc] initWithString:@"这是乱七八糟的文字" attributes:@{NSFontAttributeName:font}]];
//        }
    }
    
    [text appendAttributedString:[[NSAttributedString alloc] initWithString:@"结束" attributes:@{NSFontAttributeName:font}]];
    YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(width, MAXFLOAT)];
    YYTextLayout *textLayout = [YYTextLayout layoutWithContainer:container text:text];
    
    CGFloat height = textLayout.textBoundingSize.height;
    
    label.frame = CGRectMake(10, 80, width, height);
    
    label.textLayout = textLayout;
    
    [self.view addSubview:label];
}


@end
