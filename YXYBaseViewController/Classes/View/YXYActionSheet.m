//
//  YXYActionSheet.m
//  AFNetworking
//
//  Created by apple on 2019/1/5.
//

#import "YXYActionSheet.h"
#import "YXYDefine.h"

@interface YXYActionSheet ()<UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>

@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, copy) void (^ActionSheetBlock)(NSInteger idx);

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) CGFloat rowH;

@end

@implementation YXYActionSheet

+ (instancetype)actionSheetWithDataSource:(NSArray *)dataSource rowHeigh:(CGFloat)heigh completion:(void (^)(NSInteger))completion{
    YXYActionSheet *sheet = [[YXYActionSheet alloc] initWithDataSource:dataSource delegate:nil rowHeigh:heigh completion:completion];
    return sheet;
}

+ (instancetype)actionSheetWithDataSource:(NSArray *)dataSource delegate:(id)delegate rowHeigh:(CGFloat)heigh completion:(void (^)(NSInteger))completion{
    YXYActionSheet *sheet = [[YXYActionSheet alloc] initWithDataSource:dataSource delegate:delegate rowHeigh:heigh completion:completion];
    return sheet;
}

- (instancetype)initWithDataSource:(NSArray *)dataSource delegate:(id)delegate rowHeigh:(CGFloat)heigh completion:(void (^)(NSInteger))completion{
    if (self = [super init]) {
        self.dataSource = dataSource;
        self.ActionSheetBlock = completion;
        self.delegate = delegate;
        self.rowH = heigh > 0 ? heigh : 46;
        [self setUI];
    }
    return self;
}

- (void)setUI{
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.3];
    [KEY_WINDOW addSubview:self];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
    
    CGFloat esH = self.dataSource.count * self.rowH;
    CGFloat maxH = kScreenHeight - NAVIGATION_BAR_HEIGHT - 17 - 44 - HOME_INDICATOR_HEIGHT;
    CGFloat h = esH > maxH ? maxH : esH;
    
    [self addSubview:self.btnBottom];
    [self addSubview:self.tableView];
    
    [UIView animateWithDuration:.25 animations:^{
        self.btnBottom.frame = CGRectMake(15, kScreenHeight - 44 - 17 - HOME_INDICATOR_HEIGHT, kScreenWidth - 30, 44);
        self.tableView.frame = CGRectMake(15, kScreenHeight - 44 - 17 - HOME_INDICATOR_HEIGHT - h - 15, kScreenWidth - 30, h);
    }];
}

- (void)btnCancelClicked{
    [self dismiss];
}

- (void)dismiss{
    [UIView animateWithDuration:.25 animations:^{
        self.btnBottom.frame = CGRectMake(15, kScreenHeight - (- 44 - 17 - HOME_INDICATOR_HEIGHT - 15 - self.rowH * self.dataSource.count), kScreenWidth - 30, 44);
        self.tableView.frame = CGRectMake(15, kScreenHeight, kScreenWidth - 30, self.dataSource.count * self.rowH);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return  YES;
}

#pragma mark--UITableViewDelegate UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.delegate && [self.delegate respondsToSelector:@selector(YXYActionSheetCellForRowAtIndexPath:tableView:)]) {
        return [self.delegate YXYActionSheetCellForRowAtIndexPath:indexPath tableView:tableView];
    }
    YXYActionSheetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YXYActionSheetID" forIndexPath:indexPath];
    cell.lblTitle.text = self.dataSource[indexPath.row];
    cell.lblTitle.font = self.font;
    cell.lblTitle.textColor = self.color;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.ActionSheetBlock(indexPath.row);
    [self dismiss];
}

- (UITableView *)tableView{
    if (!_tableView) {
        CGFloat esH = self.dataSource.count * self.rowH;
        CGFloat maxH = kScreenHeight - NAVIGATION_BAR_HEIGHT - 17 - 44 - HOME_INDICATOR_HEIGHT;
        CGFloat h = esH > maxH ? maxH : esH;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(15, kScreenHeight, kScreenWidth - 30, h) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.rowHeight = self.rowH;
        _tableView.bounces = NO;
        _tableView.separatorColor = ColorFromHex(0xeeeeee);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.clipsToBounds = YES;
        _tableView.layer.cornerRadius = 5;
        _tableView.showsVerticalScrollIndicator = NO;
        if (self.delegate && [self.delegate respondsToSelector:@selector(YXYActionSheetRegisterCell:)]) {
            [self.delegate YXYActionSheetRegisterCell:_tableView];
        }else{
            [_tableView registerClass:[YXYActionSheetCell class] forCellReuseIdentifier:@"YXYActionSheetID"];
        }
    }
    return _tableView;
}

- (UIButton *)btnBottom{
    if (!_btnBottom) {
        _btnBottom = [[UIButton alloc] initWithFrame:CGRectMake(15, kScreenHeight, kScreenWidth - 30, self.rowH)];
        _btnBottom.layer.cornerRadius = 5;
        _btnBottom.backgroundColor = UIColor.whiteColor;
        [_btnBottom setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0] forState:UIControlStateNormal];
        _btnBottom.clipsToBounds = YES;
        [_btnBottom setTitle:@"取消" forState:UIControlStateNormal];
        [_btnBottom addTarget:self action:@selector(btnCancelClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnBottom;
}

@end


@implementation YXYActionSheetCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setUI{
    [self.contentView addSubview:self.lblTitle];
    [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
    }];
}

- (UILabel *)lblTitle{
    if (!_lblTitle) {
        _lblTitle = [[UILabel alloc] init];
    }
    return _lblTitle;
}
@end
