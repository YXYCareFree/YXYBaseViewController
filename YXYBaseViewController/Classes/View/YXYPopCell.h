//
//  YXYPopCell.h
//  YouTo
//
//  Created by apple on 2018/11/27.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YXYBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface YXYPopCell : YXYBaseTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIView *vSplit;

@end

NS_ASSUME_NONNULL_END
