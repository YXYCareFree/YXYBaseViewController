//
//  YXYActionSheet.h
//  AFNetworking
//
//  Created by apple on 2019/1/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YXYActionSheet : UIView

+ (instancetype)actionSheetWithDataSource:(NSArray *)dataSource completion:(void(^)(NSInteger idx))completion;

@property (nonatomic, strong) UIButton *btnBottom;
@property (nonatomic, strong) UIFont *font;//选项lbl的font
@property (nonatomic, strong) UIColor *color;//选项lbl的Color

@end


@interface YXYActionSheetCell : UITableViewCell

@property (nonatomic, strong) UILabel *lblTitle;

@end
NS_ASSUME_NONNULL_END
