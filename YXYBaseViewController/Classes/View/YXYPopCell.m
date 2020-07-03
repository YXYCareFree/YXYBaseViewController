//
//  YXYPopCell.m
//  YouTo
//
//  Created by apple on 2018/11/27.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YXYPopCell.h"
#import "Masonry.h"

@implementation YXYPopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUI];
    }
    return self;
}

- (void)setUI{
    [self.contentView addSubview:self.lblTitle];
    [self.contentView addSubview:self.vSplit];
    
    [self.vSplit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@1);
        make.left.equalTo(@(10));
        make.right.equalTo(@(-10));
        make.bottom.equalTo(@0);
    }];
    [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(@(5));
        make.bottom.equalTo(self.vSplit.mas_top).offset(-5);
    }];
}

- (UILabel *)lblTitle{
    if (!_lblTitle) {
        _lblTitle = [UILabel new];
        _lblTitle.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
        _lblTitle.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    }
    return _lblTitle;
}

- (UIView *)vSplit{
    if (!_vSplit) {
        _vSplit = UIView.new;
        _vSplit.backgroundColor = [UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1.0];
    }
    return _vSplit;
}

@end
