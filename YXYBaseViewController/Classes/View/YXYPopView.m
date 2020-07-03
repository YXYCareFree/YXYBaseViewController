//
//  YXYPopView.m
//  YouTo
//
//  Created by apple on 2018/11/27.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YXYPopView.h"
#import "YXYPopCell.h"
#import "YXYDefine.h"

@interface YXYPopView ()<UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>

@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *vBase;

@property (nonatomic, assign) CGFloat tableViewWidth;
@property (nonatomic, assign) CGFloat rowHeight;
@property (nonatomic, assign) CGFloat constraint;

@end

@implementation YXYPopView

+ (YXYPopView *)popWithBaseView:(UIView *)baseView constraint:(CGFloat)constraint delegate:(nullable id)delegate rowH:(CGFloat)h tableViewWidth:(CGFloat)width dataSource:(NSArray *)dataSource{
    YXYPopView *view = YXYPopView.new;
    view.delegate = delegate;
    view.vBase = baseView;
    view.rowHeight = h;
    view.tableViewWidth = width;
    view.dataSource = dataSource;
    view.tableView.rowHeight = h;
    view.constraint = constraint;
    [view setUI];
    [KEY_WINDOW addSubview:view];
    return view;
}

- (void)setUI{
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    self.frame = [UIScreen mainScreen].bounds;
    [KEY_WINDOW addSubview:self];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
    
    CGRect frame = [self.vBase convertRect:self.vBase.bounds toView:KEY_WINDOW];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
//    [self.tableView registerNib:[UINib nibWithNibName:@"YXYPopCell" bundle:[NSBundle getBundle]] forCellReuseIdentifier:@"YXYPopCellID"];
    [self.tableView registerClass:YXYPopCell.class forCellReuseIdentifier:@"YXYPopCellID"];
    [self addSubview:self.tableView];

    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(frame.origin.x - self.constraint));
        make.top.equalTo(@(frame.size.height + frame.origin.y + 5));
        make.width.equalTo(@(self.tableViewWidth));
        make.height.equalTo(@(self.rowHeight * self.dataSource.count));
    }];
}

- (void)registReuseCellNib:(UINib *)nib reuseId:(nonnull NSString *)reuseId{
    [self.tableView registerNib:nib forCellReuseIdentifier:reuseId];
}

- (void)registReuseCellClass:(Class)cellClass reuseId:(nonnull NSString *)reuseId{
    [self.tableView registerClass:cellClass forCellReuseIdentifier:reuseId];
}

- (void)dismiss{
    [self removeFromSuperview];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.delegate && [self.delegate respondsToSelector:@selector(yxyPopView:cellForRowAtIndexPath:)]) {
        return [self.delegate yxyPopView:tableView cellForRowAtIndexPath:indexPath];
    }
    YXYPopCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YXYPopCellID" forIndexPath:indexPath];
    cell.lblTitle.text = self.dataSource[indexPath.row];
    if (self.selectedIdx == indexPath.row) {
        if (self.selectedTextColor) {
            cell.lblTitle.textColor = self.selectedTextColor;
        }
    }
    if (indexPath.row == self.dataSource.count - 1) {
        cell.vSplit.hidden = YES;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.delegate && [self.delegate respondsToSelector:@selector(yxyPopView:didSelectRowAtIndexPath:)]) {
        [self.delegate yxyPopView:tableView didSelectRowAtIndexPath:indexPath];
        [self dismiss];
        return ;
    }
    if (self.YXYPopViewSelectBlock) {
        self.YXYPopViewSelectBlock(indexPath.row);
        [self dismiss];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {//判断如果点击的是tableView的cell，就把手势给关闭了
        return NO;
    }
    return YES;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView.backgroundColor = UIColor.whiteColor;
        _tableView.rowHeight = UITableViewRowAnimationAutomatic;
        _tableView.clipsToBounds = YES;
        _tableView.layer.cornerRadius = 5;
        _tableView.scrollEnabled = NO;
    }
    return _tableView;
}
@end
