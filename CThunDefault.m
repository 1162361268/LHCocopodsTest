//
//  CThunDefault.m
//  CThunTabBar
//
//  Created by apple on 2022/1/11.
//

#import "CThunDefault.h"

#define Default_Title_Color   [UIColor colorWithRed:195.0/255.0 green:197.0/255.0 blue:199.0/255.0 alpha:1.0]   //浅灰（全局缺省页的文字颜色）
#define Default_Button_Color               [UIColor colorWithRed:77/255.0 green:190/255.0 blue:152/255.0 alpha:1.0] //主题色

@interface CThunDefault()
@property (nonatomic, copy) dispatch_block_t finishHandler;

@end

@implementation CThunDefault

+(instancetype)showBDAddedTo:(UIView *)view type:(DefaultMode)type finishHandler:(dispatch_block_t _Nullable)handler{
    [self hideBDForView:view];
    CThunDefault *bd = [[self alloc]initWithView:view type:type finishHandler:handler];
    bd.removeFromSuperViewOnHide = YES;
    [view addSubview:bd];
    
    return bd;
}


+(BOOL)hideBDForView:(UIView *)view{
    CThunDefault *bd = [self BDForView:view];
    if (bd != nil) {
        bd.removeFromSuperViewOnHide = YES;
        [bd done];
        return YES;
    }
    return NO;
}

+(CThunDefault *)BDForView:(UIView *)view{
    NSEnumerator *subviewsEnum = [view.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:self]) {
            return (CThunDefault *)subview;
        }
    }
    return nil;
}

-(void)done{
    self.alpha = 0.0f;
    if (self.removeFromSuperViewOnHide) {
        [self removeFromSuperview];
    }
}



- (instancetype)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self commonInit];
    }
    return self;
}

- (id)initWithView:(UIView *)view type:(DefaultMode)type finishHandler:(dispatch_block_t _Nullable)handler{
    NSAssert(view, @"View must not be nil.");
    _animationType = type;
    self.finishHandler = handler;
    return [self initWithFrame:view.bounds];
}

-(void)commonInit{
    
    [self setupViews];
}

-(void)setupViews{
    CGFloat width    = WIDTH /2;
    CGFloat height   = WIDTH /2;
    
    
    UIView *backGround = [[UIView alloc]initWithFrame:self.bounds];
    backGround.backgroundColor = [UIColor clearColor];
    [self addSubview:backGround];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0.25*WIDTH , 150, width, height)];
    [backGround addSubview:imageView];

    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame), WIDTH, 30)];
    [backGround addSubview:title];
    title.textColor = Default_Title_Color;
    title.font = [UIFont systemFontOfSize:13];
    title.textAlignment = NSTextAlignmentCenter;
    
    UIButton *btn = [UIButton buttonWithType:0];
    btn.frame = CGRectMake(100, CGRectGetMaxY(title.frame) +50, WIDTH - 200, 40);
    [backGround addSubview:btn];
    [btn setTitle:@"去添加" forState:0];
    [btn setTitleColor:Default_Button_Color forState:0];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    btn.layer.cornerRadius = 10.0;//2.0是圆角的弧度，根据需求自己更改
    btn.layer.borderColor = Default_Button_Color.CGColor;//设置边框颜色
    btn.layer.borderWidth = 1.0f;//设置边框颜色
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    if (_animationType == Default) {
        imageView.image = [UIImage imageNamed:@"typeB"];
        title.text = @"还没有数据哦，快去添加吧";
    }else if (_animationType == NoSearchList){
        imageView.image = [UIImage imageNamed:@"typeC"];
        title.text = @"搜索无结果，换个词试试吧";
    }else if (_animationType == NoNetwork){
        imageView.image = [UIImage imageNamed:@"typeF"];
        title.text = @"当前无网络，请检查后重试";
    }else if (_animationType == NoMessageList){
        imageView.image = [UIImage imageNamed:@"typeD"];
        title.text = @"还没有消息哦，快去逛逛吧";
    }else if(_animationType == NoCollectionList){
        imageView.image = [UIImage imageNamed:@"typeA"];
        title.text = @"还没有收藏哦，快去添加吧";
    }else if(_animationType == NoShopCarList){
        imageView.image = [UIImage imageNamed:@"typeE"];
        title.text = @"购物车还是空的，快去看看吧";
    }else{
        imageView.image = [UIImage imageNamed:@"typeB"];
        title.text = @"还没有数据哦，快去添加吧";
    }
    
}

-(void)btnClick:(UIButton *)btn{
    self.finishHandler();
}

@end
