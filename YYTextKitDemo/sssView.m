//
//  sssView.m
//  YYTextKitDemo
//
//  Created by zkf on 2017/4/27.
//  Copyright © 2017年 zkf. All rights reserved.
//

#import "sssView.h"

@implementation sssView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubviewsTV];
//        [self addSubviewsTF];
    }
    return self;
}
-(void)addSubviewsTF
{
    UITextField *textTF = [[UITextField alloc] init];
    textTF.backgroundColor = [UIColor purpleColor];
    textTF.frame = CGRectMake(0, 0, 370, 40);
    [self addSubview:textTF];
    
    _textTF = textTF;
}


-(void)addSubviewsTV
{
    UITextView *textTF = [[UITextView alloc] init];
    textTF.backgroundColor = [UIColor purpleColor];
    textTF.frame = CGRectMake(0, 0, 370, 40);
    [self addSubview:textTF];
    
    _textTF = textTF;
}
@end
