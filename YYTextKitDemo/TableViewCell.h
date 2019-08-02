//
//  TableViewCell.h
//  YYTextKitDemo
//
//  Created by zkf on 2017/5/25.
//  Copyright © 2017年 zkf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
@property (nonatomic , copy) NSString *name;
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;

@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;

@end
