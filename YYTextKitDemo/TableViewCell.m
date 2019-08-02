//
//  TableViewCell.m
//  YYTextKitDemo
//
//  Created by zkf on 2017/5/25.
//  Copyright © 2017年 zkf. All rights reserved.
//

#import "TableViewCell.h"
#import "UIImage+WebP.h"
#import "UIImageView+WebCache.h"
@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setName:(NSString *)name
{
    _name = [name copy];
    [_imageView1 sd_setImageWithURL:[NSURL URLWithString:_name] placeholderImage:nil options:SDWebImageRefreshCached];
    [_imageView2 sd_setImageWithURL:[NSURL URLWithString:_name] placeholderImage:nil options:SDWebImageRefreshCached];
    [_imageView3 sd_setImageWithURL:[NSURL URLWithString:_name] placeholderImage:nil options:SDWebImageRefreshCached];
    
}

@end
