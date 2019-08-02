//
//  OAuthViewController.m
//  新浪微博(终结版)
//
//  Created by lanouhn on 15/12/31.
//  Copyright (c) 2015年 zmh. All rights reserved.
//

#import "OAuthViewController.h"
#import "AFNetworking.h"
#import "AccsonModel.h"
#import "ACcountTool.h"
//#import "MBProgressHUD+MJ.h"
@interface OAuthViewController ()<UIWebViewDelegate>

@end

@implementation OAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    webView.delegate = self;
    [self.view addSubview:webView];
    
    /*client_id	true	string	申请应用时分配的AppKey。
     redirect_uri	true	string	授权回调地址，站外应用需与设置的回调地址一致，站内应用需填写canvas page的地址。*/
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=2582516319&redirect_uri=http://www.baidu.com"]];
    
    [webView loadRequest:request];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    NSLog(@"wwwwwww%@" , request.URL.absoluteString);
    NSString *url = request.URL.absoluteString;
    NSRange range = [url rangeOfString:@"code="];
    
    if (range.length != 0) {
        NSInteger fromIndex = range.location + range.length;
        
        NSString *code = [url substringFromIndex:fromIndex];
        [self accessTokenWithCode:code];
        
        return NO;
    }
    
    
    return YES;
}

-(void)accessTokenWithCode:(NSString *)code
{
    /*
     
     https://api.weibo.com/oauth2/access_token
     
     必选	类型及范围	说明
     client_id	true	string	申请应用时分配的AppKey。
     client_secret	true	string	申请应用时分配的AppSecret。
     grant_type	true	string	请求的类型，填写authorization_code
     
     grant_type为authorization_code时
     必选	类型及范围	说明
     code	true	string	调用authorize获得的code值。
     redirect_uri	true	string	回调地址，需需与注册应用里的回调地址一致。*/

    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = @"2582516319";
    params[@"client_secret"] = @"fb68660ca26fb7bfd56a3b047d7067c0";
    params[@"grant_type"] = @"authorization_code";
    params[@"code"] = code;
    params[@"redirect_uri"] = @"http://www.baidu.com";
    
    [manger POST:@"https://api.weibo.com/oauth2/access_token" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
//        NSLog(@"请求成功%@" , responseObject);

        AccsonModel *model = [AccsonModel accsonWithDict:responseObject];
        
        [ACcountTool saveAccount:model];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
//        [MBProgressHUD hideHUD];
//        NSLog(@"失败原因%@" , error);
    }];
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
//    [MBProgressHUD hideHUD];
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
//    [MBProgressHUD showMessage:@"正在登录中..."];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
//    [MBProgressHUD hideHUD];
}

@end
