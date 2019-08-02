//
//  WebComposeController.m
//  YYTextKitDemo
//
//  Created by zkf on 2017/6/21.
//  Copyright © 2017年 zkf. All rights reserved.
//

#import "WebComposeController.h"
#import "YYKit.h"
#import "WebStatesLayout.h"
#import "WebEmotionView.h"
#import "TZImagePickerController.h"

#define kToolbarHeight (35 + 46)

@interface WebComposeController ()<YYTextKeyboardObserver , YYTextViewDelegate , WebEmotionViewDelegate , TZImagePickerControllerDelegate>

@property (nonatomic , strong) YYTextView *textView;
@property (nonatomic , strong) UIView *toolBar;
@property (nonatomic , strong) UIView *toolbarBackground;

@property (nonatomic , strong) WebEmotionView *emotionView;
@property (nonatomic , strong) UIView *inputView2;
@property (nonatomic , strong) UIView *inputView3;

@property (nonatomic , strong) UIButton *locationBtn;
@property (nonatomic , strong) UIButton *publicBtn;

@property (nonatomic , strong) UIButton *picBtn;
@property (nonatomic , strong) UIButton *atBtn;
@property (nonatomic , strong) UIButton *topicBtn;
@property (nonatomic , strong) UIButton *emotionBtn;
@property (nonatomic , strong) UIButton *moreBtn;

@end

@implementation WebComposeController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[YYTextKeyboardManager defaultManager] addObserver:self];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _inputView2 = [UIView new];
    _inputView2.backgroundColor = [UIColor yellowColor];
    _inputView2.size = CGSizeMake(self.view.width, 200);
    
    _inputView3 = [UIView new];
    _inputView3.backgroundColor = [UIColor purpleColor];
    _inputView3.size = CGSizeMake(self.view.width, 300);
    
    [self _initNav];
    [self _initTextView];
    [self _initToolBar];
    
}


-(void)_initNav{
    
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    btn.frame = CGRectMake(0, 0, 60, 40);
    [btn addTarget:self action:@selector(dissMiss) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = item;
    
}


-(void)_initTextView{
    
    _textView = [YYTextView new];
    
    _textView.size = CGSizeMake(self.view.width, self.view.height);
    _textView.textContainerInset = UIEdgeInsetsMake(12, 16, 12, 16);
    _textView.contentInset = UIEdgeInsetsMake(0, 0, kToolbarHeight, 0);
    _textView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _textView.extraAccessoryViewHeight = kToolbarHeight;
    _textView.showsVerticalScrollIndicator = NO;
    _textView.alwaysBounceVertical = YES;
    _textView.allowsCopyAttributedString = NO;
    _textView.font = [UIFont systemFontOfSize:17];
//    _textView.textParser = [WBStatusComposeTextParser new];
    _textView.delegate = self;
    _textView.inputAccessoryView = [UIView new];
    _textView.backgroundColor = [UIColor whiteColor];
    
    WBTextLinePositionModifier *modifier = [WBTextLinePositionModifier new];
    modifier.font = [UIFont fontWithName:@"Heiti SC" size:17];
    modifier.lineTop = 12;
    modifier.lineBottom = 12;
    modifier.lineHeightMultiple = 1.5;
    _textView.linePositionModifier = modifier;
    [self.view addSubview:_textView];
}


-(void)_initToolBar{
    
    _toolBar = [UIView new];
    _toolBar.backgroundColor = [UIColor whiteColor];
    _toolBar.size = CGSizeMake(kScreenWidth, kToolbarHeight);
    _toolBar.bottom = self.view.height;
    [self.view addSubview:_toolBar];
    
    _toolbarBackground = [[UIView alloc] init];
    _toolbarBackground.size =CGSizeMake(_textView.width, 46);
    _toolbarBackground.backgroundColor = kWBCellBackgroundColor;
    _toolbarBackground.bottom = _toolBar.height;
    [_toolBar addSubview:_toolbarBackground];
    
    _locationBtn = [UIButton new];
    _locationBtn.size =CGSizeMake(88, 26);
    _locationBtn.left = 4;
    _locationBtn.centerY = 36 * 0.5;
    _locationBtn.clipsToBounds = YES;
    _locationBtn.layer.cornerRadius = _locationBtn.height * 0.5;
    _locationBtn.layer.borderColor = UIColorHex(e4e4e4).CGColor;
    _locationBtn.layer.borderWidth = CGFloatFromPixel(1);
    [_locationBtn setTitle:@"显示位置 " forState:UIControlStateNormal];
    _locationBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    _locationBtn.adjustsImageWhenHighlighted = NO;
    [_locationBtn setTitleColor:UIColorHex(939393) forState:UIControlStateNormal];
    [_locationBtn setBackgroundImage:[UIImage imageWithColor:UIColorHex(f8f8f8)] forState:UIControlStateNormal];
    [_locationBtn setBackgroundImage:[UIImage imageWithColor:UIColorHex(e0e0e0)] forState:UIControlStateHighlighted];
    [_locationBtn setImage:[WBStatusHelper imageNamed:@"compose_locatebutton_ready"] forState:UIControlStateNormal];
    [_locationBtn setImage:[WBStatusHelper imageNamed:@"compose_locatebutton_ready"] forState:UIControlStateNormal];
    [_toolBar addSubview:_locationBtn];
    
    _publicBtn = [UIButton new];
    _publicBtn.size =CGSizeMake(62, 26);
    _publicBtn.right = _toolBar.width - 4;
    _publicBtn.centerY = 36 * 0.5;
    _publicBtn.clipsToBounds = YES;
    _publicBtn.layer.cornerRadius = _locationBtn.height * 0.5;
    _publicBtn.layer.borderColor = UIColorHex(e4e4e4).CGColor;
    _publicBtn.layer.borderWidth = CGFloatFromPixel(1);
    [_publicBtn setTitle:@"公开 " forState:UIControlStateNormal];
    _publicBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [_publicBtn setTitleColor:UIColorHex(527ead) forState:UIControlStateNormal];
    
    [_publicBtn setBackgroundImage:[UIImage imageWithColor:UIColorHex(f8f8f8)] forState:UIControlStateNormal];
    [_publicBtn setBackgroundImage:[UIImage imageWithColor:UIColorHex(e0e0e0)] forState:UIControlStateHighlighted];
    [_publicBtn setImage:[WBStatusHelper imageNamed:@"compose_publicbutton"] forState:UIControlStateNormal];
    [_publicBtn setImage:[WBStatusHelper imageNamed:@"compose_publicbutton"] forState:UIControlStateNormal];
    [_toolBar addSubview:_publicBtn];
    
    _picBtn = [self creatBtnWithimageName:@"compose_toolbar_picture" hlightImageName:@"compose_toolbar_picture_highlighted"];
    
    _atBtn = [self creatBtnWithimageName:@"compose_mentionbutton_background" hlightImageName:@"compose_mentionbutton_background_highlighted"];
    
    _topicBtn = [self creatBtnWithimageName:@"compose_trendbutton_background" hlightImageName:@"compose_trendbutton_background_highlighted"];
    
    _emotionBtn = [self creatBtnWithimageName:@"compose_emoticonbutton_background" hlightImageName:@"compose_emoticonbutton_background_highlighted"];
    
    _moreBtn = [self creatBtnWithimageName:@"message_add_background" hlightImageName:@"message_add_background_highlighted"];
    
    CGFloat btn_W = _toolBar.width / 5;
    _picBtn.centerX = btn_W * 0.5;
    _atBtn.centerX = btn_W * 1.5;
    _topicBtn.centerX = btn_W * 2.5;
    _emotionBtn.centerX = btn_W * 3.5;
    _moreBtn.centerX = btn_W * 4.5;

}
-(UIButton *)creatBtnWithimageName:(NSString *)imageName hlightImageName:(NSString *)hlightImageName{
    
    UIButton *btn = [[UIButton alloc] init];
    btn.size = CGSizeMake(46, 46);
    btn.centerY = 46 / 2;
    btn.adjustsImageWhenHighlighted = NO;
    [btn setImage:[WBStatusHelper imageNamed:imageName] forState:UIControlStateNormal];
    [btn setImage:[WBStatusHelper imageNamed:hlightImageName] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_toolbarBackground addSubview:btn];
    return btn;
    
}

-(void)btnClick:(UIButton *)button
{
//    [self setBtnStatusWithBtn:button];
    if (button == _picBtn) {
        TZImagePickerController *imagePC=[[TZImagePickerController alloc]initWithMaxImagesCount:9 delegate:self];//设置多选最多支持的最大数量，设置代理
        
        [imagePC setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
            
            //点击确
            
        }];
        
        [self presentViewController:imagePC animated:YES completion:nil];//跳转
//        [self setBtnStatusWithBtn:button inputView:_inputView1];
        
    } else if (button == _atBtn) {
        
        [self setBtnStatusWithBtn:button inputView:_inputView2];
        
    } else if (button == _topicBtn) {
        
        [self setBtnStatusWithBtn:button inputView:_inputView3];
    } else if (button == _emotionBtn) {
        WebEmotionView *v = [WebEmotionView sharedView];
        v.delegate = self;
        [self setBtnStatusWithBtn:button inputView:v];
        
    } else if (button == _moreBtn) {
//        [self setBtnStatusWithBtn:button inputView:_inputView1];
    }
    
}

-(void)setBtnStatusWithBtn:(UIButton *)button inputView:(UIView *)inputView{
    
    if (_textView.inputView == inputView) {
        _textView.inputView = nil;
        [_textView reloadInputViews];
        [_textView becomeFirstResponder];
        
        if (button == _emotionBtn) {
            [button setImage:[WBStatusHelper imageNamed:@"compose_emoticonbutton_background"] forState:UIControlStateNormal];
            [button setImage:[WBStatusHelper imageNamed:@"compose_emoticonbutton_background_highlighted"] forState:UIControlStateHighlighted];
        }
        
    } else {
        _textView.inputView = nil;
        _textView.inputView = inputView;
        [_textView reloadInputViews];
        [_textView becomeFirstResponder];
        
        if (button == _emotionBtn) {
            [button setImage:[WBStatusHelper imageNamed:@"compose_keyboardbutton_background"] forState:UIControlStateNormal];
            [button setImage:[WBStatusHelper imageNamed:@"compose_keyboardbutton_background_highlighted"] forState:UIControlStateHighlighted];
        }
    }
}
-(void)keyboardChangedWithTransition:(YYTextKeyboardTransition)transition
{
    CGRect toFrame = [[YYTextKeyboardManager defaultManager] convertRect:transition.toFrame toView:self.view];
    if (transition.animationDuration == 0) {
        _toolBar.bottom = CGRectGetMinY(toFrame);
    } else {
        [UIView animateWithDuration:transition.animationDuration delay:0 options:transition.animationOption | UIViewAnimationOptionBeginFromCurrentState animations:^{
            _toolBar.bottom = CGRectGetMinY(toFrame);
        } completion:NULL];
    }
}

-(void)emoticonInputDidTapBackspace
{
    [_textView deleteBackward];
}

-(void)emoticonInputDidTapText:(NSString *)text
{
    if (text.length) {
        [_textView replaceRange:_textView.selectedTextRange withText:text];
    }
}


-(void)dealloc
{
    [[YYTextKeyboardManager defaultManager] removeObserver:self];
}
-(void)dissMiss
{
    [self.view endEditing:YES];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
@end
