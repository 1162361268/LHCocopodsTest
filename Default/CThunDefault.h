//
//  CThunDefault.h
//  CThunTabBar
//
//  Created by apple on 2022/1/11.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DefaultMode) {
    ///无数据
    Default,
    ///无网络
    NoNetwork,
    ///搜索无结果
    NoSearchList,
    ///无收藏
    NoCollectionList,
    ///无信息
    NoMessageList,
    ///购物车无商品
    NoShopCarList
};

NS_ASSUME_NONNULL_BEGIN

@interface CThunDefault : UIView

@property (assign, nonatomic) DefaultMode animationType UI_APPEARANCE_SELECTOR;

/// 隐藏时从其父视图删除，默认是no
@property (assign, nonatomic) BOOL removeFromSuperViewOnHide;


/// 显示缺省页
/// @param view 父view
/// @param type 样式
/// @param handler 回调
+(instancetype)showBDAddedTo:(UIView *)view type:(DefaultMode)type finishHandler:(dispatch_block_t _Nullable)handler;

/// 隐藏缺省页
/// @param view 父view
+(BOOL)hideBDForView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
