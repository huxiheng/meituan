//
//  DHPageController.h
//  Copyright (c) 2013年 Lessu. All rights reserved.
//
//
//  DHPageController 是将dh 服务器的分页格式转化为数据控制的控制器。
//  DHPageController 的一般使用：
//      1.设置回调Block
//      2.调用
//      3.在视图消失时取消访问，清理回调Block
//  注意：在调用(refreash loadNext)时，会生成一个APIConnection，
//  DHPageController 与该 APIConnection有强引用，即网络没有访问
//  完，DHPageController 不会被释放。
//  所以如果外部视图控制器被释放了，一定要将连接取消，或者将DHPageController
//  的回调清理掉，否则可能出现网络连接回来时，引用到BAD MEMORY。
//
//  其次数据合并暂时不完善
//  v 1.01
//  新增了 返回分页信息的标准格式
//  v 1.01.1
//  refreash 接口默认page = 1
//  v 1.1
//  新增 pageinfoAdapter

// v1.2
// 新增带apiconnection缓存支持

// v1.3 更新 缓存支持，加上cache block

#import <Foundation/Foundation.h>
#import "APIConnection.h"

extern NSString *kLSPageControllerPageName;
extern NSString *kLSPageControllerStepName;
extern int       kLSPageControllerStep;
extern NSString *kLSPageControllerListKey;
extern NSString *kLSPageControllerPageInfoKey;
extern NSString *kLSPageControllerPageInfoTotalKey;
typedef enum  {
    DHPageControllerMergeDirectionFront,
    DHPageControllerMergeDirectionTail
} DHPageControllerMergeDirection;

@interface LSPageController : NSObject
{
@protected
    NSString            * _stepName;
    NSString            * _pageName;
    NSMutableArray      *_list;
    BOOL                _hasMore;
    int                 _count;
    int                 _totalPage;
    int                 _totalCount;
    int                 _currentPage;
    APIConnection       *_nextPageConnection;
    APIConnection       *_refreashConnection;
}
@property(nonatomic,retain) NSString *apiClass;

@property(copy,nonatomic) NSString * stepName;
@property(copy,nonatomic) NSString * pageName;
//数据主键名
@property(copy,nonatomic) NSString * keyName;
@property(nonatomic,readwrite,retain) NSMutableArray *list;
@property(nonatomic,readonly)   BOOL   hasMore;
@property(nonatomic,readonly)   int count;
@property(nonatomic,readonly)   int totalPage;
@property(nonatomic,readonly)   int totalCount;

@property(nonatomic,readonly)   int currentPage;
@property(nonatomic,assign)     int step;
//@property(nonatomic,readonly)   APIConnection *nextPageConnection;
//@property(nonatomic,readonly)   APIConnection *refreashConnection;

@property(nonatomic,copy)       void(^onNextSuccessBlock)(NSArray *mergedList,NSDictionary *result);
@property(nonatomic,copy)       void(^onNextFailedBlock)(NSError *error);
@property(nonatomic,copy)       void(^onRefreashSuccessBlock)(NSArray *mergedList,NSDictionary *result);
@property(nonatomic,copy)       void(^onRefreashFailedBlock)(NSError *error);
@property(nonatomic,copy)       BOOL(^beforeNextPageRequestBlock)(APIConnection *nextConnection);
@property(nonatomic,copy)       BOOL(^beforeRefreashRequestBlock)(APIConnection *refreashConnection);

@property(nonatomic,copy)       void(^onCacheRefreashBlock)(NSArray *mergedList,NSDictionary *result);
@property(nonatomic,copy)       void(^onCacheNextBlock)(NSArray *mergedList,NSDictionary *result);

@property(nonatomic,copy)       void(^pageinfoAdapter)(NSDictionary *inputdata,BOOL *success,NSArray **outputList,int *totalCount,NSString **errorMessage);

@property(nonatomic,readonly)   BOOL isLoading;
@property(nonatomic,readonly)   BOOL isRefreashing;
@property(nonatomic,readonly)   BOOL isBusy;

@property(nonatomic,copy)       NSString *apiName;
@property(nonatomic,copy)       NSDictionary *apiParams;
@property(nonatomic,assign)     BOOL isOnlyTenDataShow;
- (id)initWithApiName:(NSString *)apiName;
- (id)initWithApiName:(NSString *)apiName andParams:(NSDictionary *)apiParams;

//load and refresh
- (void)nextPage:(UIScrollView *)dataScroll;
- (void)nextPage;
- (void)refresh:(BOOL)shoudMerge;
- (void)refresh;
- (void)refreshNoMerge;

- (void)clearList;
- (void)releaseBlocks;
- (void)cancelLoading;
- (void)cancelRefreashing;

//#ifdef TESTS
//极限测试，边界测试
//- (void)_mergeArray:(NSMutableArray *)destination with:(NSMutableArray *)src at:(DHPageControllerMergeDirection)direction;
- (void)_mergeArray:(NSMutableArray *)destination with:(NSMutableArray *)src withKeyName:(NSString *)keyname at:(DHPageControllerMergeDirection)direction;
//极限测试，边界测试
- (int)_indexOfObject:(NSDictionary *)object ByKey:(NSString *)key inArray:(NSArray *)src;
//#endif
-(void)UpPage;
@end




@interface LSPageController (DefaultSetting)
+ (void)setDefaultStepName:(NSString *)stepName;
+ (void)setDefaultPageName:(NSString *)pageName;

+ (void)setDefaultListKey:(NSString *)listKey;
+ (void)setDefaultPageInfoKey:(NSString *)pageinfokey;
+ (void)setDefaultPageInfoTotalKey:(NSString *)totalkey;
@end

@interface LSPageController (PageTests)

+ (void)test;

@end
