//
//  YXYBaseTableViewCell.m
//  AFNetworking
//
//  Created by apple on 2018/11/20.
//

#import "YXYBaseTableViewCell.h"

@implementation YXYBaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Configure the view for the selected state
}

@end
