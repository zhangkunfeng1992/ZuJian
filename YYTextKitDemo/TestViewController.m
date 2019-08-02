//
//  TestViewController.m
//  YYTextKitDemo
//
//  Created by zkf on 2017/4/26.
//  Copyright © 2017年 zkf. All rights reserved.
//

#import "TestViewController.h"
#import "UIView+Extension.h"
#import "sssView.h"
#import "UIImageView+WebCache.h"
#import "TableViewCell.h"
@interface TestViewController ()<UITextViewDelegate,UITextFieldDelegate ,  UITableViewDelegate , UITableViewDataSource>
//@property (nonatomic , strong) UIView *testTextView;
//@property (nonatomic , weak) UITextField *textTF;

@property (nonatomic , strong) UIView *keyboardView;
@property (nonatomic , strong) UIView *windowView;
@property (nonatomic , strong) UIButton *bgBtn;

@property (nonatomic , copy) NSString *localLastModified;
@property (nonatomic , weak) UIImageView *imageV;
@property (nonatomic , weak) UITableView *tableView;
@property (nonatomic , weak) sssView *sview;
@end

@implementation TestViewController
{
    CGFloat _inputY;
}

-(UIView *)windowView
{
    if (!_windowView) {
        _windowView = [[UIView alloc] initWithFrame:self.view.window.bounds];
        _windowView.backgroundColor = [UIColor clearColor];
    }
    return _windowView;
}

-(UIView *)keyboardView
{
    if (!_keyboardView) {
        _keyboardView = [self getKeyBoard];
    }
    return _keyboardView;
}

-(UIButton *)bgBtn
{
    if (!_bgBtn) {
        _bgBtn = [[UIButton alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
        _bgBtn.backgroundColor = [UIColor colorWithWhite:0 alpha:.5];
        [_bgBtn addTarget:self action:@selector(bgBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bgBtn;
}

//  点击上半部分
- (void)bgBtnClick:(UIButton *)btn
{
    [btn removeFromSuperview];
    [self.sview.textTF resignFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
//    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
//    _imageV = imageV;
//    [self.view addSubview:imageV];
    [self setUpTableView];
    
}
-(void)setUpTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 40;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
}

#pragma mark - tabbleView source
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 200;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"s"];
    if (!cell) {
        cell = (TableViewCell *)[[[NSBundle mainBundle] loadNibNamed:@"TableViewCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.name = @"http://mobile.dev.idaqi.com/images_head/5/424355.jpg";
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [_imageV sd_setImageWithURL:[NSURL URLWithString:@"http://mobile.dev.idaqi.com/images_head/5/424355.jpg"] placeholderImage:nil];
}

//键盘弹出时触发
-(void)kbWillShow:(NSNotification *)noti{
    //获取键盘高度
    CGRect kbEndFrm = [noti.userInfo[UIKeyboardFrameEndUserInfoKey]CGRectValue];
    CGFloat kbHeight = kbEndFrm.size.height;
    
    [self.keyboardView addSubview:_windowView];
    
    _sview.transform = CGAffineTransformMakeTranslation(0, -kbHeight);
}
//键盘隐藏时触发
- (void)kbWillHide:(NSNotification *)noti{
    
    _sview.transform = CGAffineTransformIdentity;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    [self.sview.textTF resignFirstResponder];
    
    [_imageV sd_setImageWithURL:[NSURL URLWithString:@"http://mobile.dev.idaqi.com/images_head/5/424355.jpg"] placeholderImage:nil options:SDWebImageRefreshCached];
    
//    NSURL *url = [NSURL URLWithString:@"http://mobile.dev.idaqi.com/iext/resource/imgs/head/2017/3/320-320-2858.jpg"];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:15.0];
//    
//    // 发送 LastModified
//    if (self.localLastModified.length > 0) {
//        [request setValue:self.localLastModified forHTTPHeaderField:@"If-Modified-Since"];
//    }
//    
//    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        
//        // NSLog(@"%@ %tu", response, data.length);
//        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
//        NSLog(@"statusCode == %@", @(httpResponse.statusCode));
//        // 判断响应的状态码是否是 304 Not Modified （更多状态码含义解释： https://github.com/ChenYilong/iOSDevelopmentTips）
//        if (httpResponse.statusCode == 304) {
//            NSLog(@"加载本地缓存图片");
//            // 如果是，使用本地缓存
//            // 根据请求获取到`被缓存的响应`！
//            NSCachedURLResponse *cacheResponse =  [[NSURLCache sharedURLCache] cachedResponseForRequest:request];
//            // 拿到缓存的数据
//            data = cacheResponse.data;
//        }
//        
//        // 获取并且纪录 LastModified
//        self.localLastModified = httpResponse.allHeaderFields[@"Last-Modified"];
//        //        NSLog(@"%@", self.etag);
//        NSLog(@"%@", self.localLastModified);
//        dispatch_async(dispatch_get_main_queue(), ^{
////            !completion ?: completion(data);
//            NSLog(@"存缓存");
//        });
//    }] resume];
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [self.windowView addSubview:self.bgBtn];
    [self.windowView addSubview:(sssView *)[_sview copy]];
    _sview.frame = CGRectMake(0, self.windowView.height - _sview.height, self.windowView.width, _sview.height);
//    [_sview.textTF becomeFirstResponder];
    return YES;
}

//-(void)textViewDidBeginEditing:(UITextView *)textView
//{
//    [self.windowView addSubview:self.bgBtn];
//    [self.windowView addSubview:self.inputView];
//    self.inputView.frame = CGRectMake(0, self.windowView.height - self.inputView.height, self.windowView.width, self.inputView.height);
//}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    [self.windowView removeFromSuperview];
    [self.view addSubview:_sview];
    _sview.frame = CGRectMake(0, self.view.height - _sview.height, self.view.width, _sview.height);
}

//-(void)textFieldDidBeginEditing:(UITextField *)textField
//{
//    [self.windowView addSubview:self.bgBtn];
//    [self.windowView addSubview:self.inputView];
//    self.inputView.frame = CGRectMake(0, self.windowView.height - self.inputView.height, self.windowView.width, self.inputView.height);
//}
//
//-(void)textFieldDidEndEditing:(UITextField *)textField
//{
//    [self.windowView removeFromSuperview];
//    [self.view addSubview:self.inputView];
//    self.inputView.frame = CGRectMake(0, self.view.height - self.inputView.height, self.view.width, self.inputView.height);
//}

- (UIView *)getKeyBoard
{
    UIView *result = nil;
    NSArray *windowsArray = [UIApplication sharedApplication].windows;
    for (UIView *tmpWindow in windowsArray) {
        NSArray *viewArray = [tmpWindow subviews];
        for (UIView *tmpView  in viewArray) {
            if ([[NSString stringWithUTF8String:object_getClassName(tmpView)] isEqualToString:@"UIInputSetContainerView"]) {
                result = tmpView;
                break;
            }
        }
        if (result != nil) {
            break;
        }
    }
    return result;
}
@end
