//
//  YXYPopView.h
//  YouTo
//
//  Created by apple on 2018/11/27.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol YXYPopViewDelegate <NSObject>

- (UITableViewCell *)yxyPopView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)yxyPopView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end


@interface YXYPopView : UIView

@property (nonatomic, weak) id<YXYPopViewDelegate> delegate;

@property (nonatomic, copy) void(^YXYPopViewSelectBlock)(NSInteger idx);

@property (nonatomic, assign) NSInteger selectedIdx;
@property (nonatomic, strong) UIColor *selectedTextColor;

/// popView
/// @param baseView 基准View
/// @param constraint popView最右侧距离BsaseView最右侧的距离
/// @param delegate delegate
/// @param h rowH
/// @param width tableView的width
/// @param dataSource dataSource
+ (YXYPopView *)popWithBaseView:(UIView *)baseView constraint:(CGFloat)constraint delegate:(nullable id)delegate rowH:(CGFloat)h tableViewWidth:(CGFloat)width dataSource:(NSArray *)dataSource;

- (void)registReuseCellNib:(UINib *)nib reuseId:(NSString *)reuseId;

- (void)registReuseCellClass:(Class)cellClass reuseId:(NSString *)reuseId;

@end

NS_ASSUME_NONNULL_END
