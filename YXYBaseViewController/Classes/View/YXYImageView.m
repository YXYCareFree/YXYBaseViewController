//
//  YXYImageView.m
//  AFNetworking
//
//  Created by apple on 2018/11/30.
//

#import "YXYImageView.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"

#define kScreenWidth       [UIScreen mainScreen].bounds.size.width

@interface YXYImageView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIImageView *imgV;
@property (nonatomic, strong) UIView *vBg;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation YXYImageView

- (void)awakeFromNib{
    [super awakeFromNib];
    [self addGesture];
}

- (instancetype)init{
    if (self = [super init]) {
        [self addGesture];
    }
    return self;
}

- (void)addGesture{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(look)];
    [self addGestureRecognizer:tap];
}

- (void)look{

    [[UIApplication sharedApplication].delegate.window addSubview:self.vBg];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap)];
    tap.numberOfTapsRequired = 2;
    [self.imgV addGestureRecognizer:tap];
    
    [self.vBg addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(view);
//        make.width.equalTo(@(kScreenWidth));
//        make.height.equalTo(@(kScreenWidth * 3 / 4));
        make.edges.equalTo(self.vBg);
    }];
    

    [self.scrollView addSubview:self.imgV];
    
    [self.imgV mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(scroll);
        make.center.equalTo(self.vBg);
        make.width.equalTo(@(kScreenWidth));
        make.height.equalTo(@(kScreenWidth * 3 / 4));
    }];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imgV;
}

- (void)doubleTap{
    if (self.scrollView.zoomScale == 1) {
        self.scrollView.zoomScale = 2;
    }else{
        self.scrollView.zoomScale = 1;
    }
}

- (void)dismiss:(UITapGestureRecognizer *)tap{
    UIView *view = tap.view;
    [view removeFromSuperview];
}

- (UIView *)vBg{
    if (!_vBg) {
        UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        view.backgroundColor = UIColor.blackColor;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss:)];
        [view addGestureRecognizer:tap];
        _vBg = view;
    }
    return _vBg;
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        UIScrollView *scroll = [[UIScrollView alloc] init];
        scroll.maximumZoomScale = 2;
        scroll.minimumZoomScale = 1;
        scroll.delegate = self;
        _scrollView = scroll;
    }
    return _scrollView;
}

- (UIImageView *)imgV{
    if (!_imgV) {
        _imgV = [[UIImageView alloc] init];
        _imgV.contentMode = UIViewContentModeScaleAspectFill;
        _imgV.userInteractionEnabled = YES;
        [_imgV sd_setImageWithURL:[NSURL URLWithString:self.urlStr]];
//        [_imgV sd_setImageWithURL:[NSURL URLWithString:self.urlStr] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//            [self.scrollView setContentSize:image.size];
//
//        }];
    }
    return _imgV;
}
@end
