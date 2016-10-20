//
//  DHPageController.m
//  Youxian100
//
//  Created by Lessu on 13-4-15.
//  Copyright (c) 2013年 Lessu. All rights reserved.
//

#import "LSPageController.h"
#import "API.h"
NSString *kLSPageControllerPageName           = @"page";
NSString *kLSPageControllerStepName           = @"step";
int       kLSPageControllerStep               = 10;
NSString *kLSPageControllerListKey            = @"list";
NSString *kLSPageControllerPageInfoKey        = @"pageinfo";
NSString *kLSPageControllerPageInfoTotalKey   = @"total_page";

NSString *PageControllerErrorDomain = @"PageControllerErrorDomain";
@interface LSPageController ()

//@property(nonatomic,copy) void (^pageControllerRefreshSuccessBlock)(id result);
//@property(nonatomic,copy) void (^pageControllerNextSuccessBlock)(id result);
@property(nonatomic,assign) BOOL shouldMerge;

@end
@implementation LSPageController

- (id)init
{
    self = [super init];
    if (self) {
        _apiClass = @"API";
        _pageName   = [kLSPageControllerPageName copy];
        _stepName   = [kLSPageControllerStepName copy];
        _step       = kLSPageControllerStep;
        _currentPage = 1;
        _keyName    = @"id";
        
//        self.pageControllerNextSuccessBlock = ^(NSDictionary *result) {
//            NSArray *listData = NULL;
//            BOOL isSuccess= false;
//            NSString *errorMessage;
//            if (_pageinfoAdapter) {
//                _pageinfoAdapter(result,&isSuccess,&listData,&_totalPage,&errorMessage);
//            }else if (IS_CLASS_OF(result[kLSPageControllerPageInfoKey], NSDictionary)&&IS_CLASS_OF(result[kLSPageControllerListKey], NSArray)) {
//                isSuccess   = true;
//                NSDictionary *pageInfo = result[kLSPageControllerPageInfoKey];
//                _totalPage  = [pageInfo[kLSPageControllerPageInfoTotalKey] intValue];
//                listData    = result[kLSPageControllerListKey];
//            }else{
//                isSuccess   = false;
//                errorMessage= @"网络访问类型不为DH标准的分页格式";
//                
//            }
//            
//            if (isSuccess) {
//                NSMutableArray *newListElement = [[listData mutableCopy] autorelease];
//                [self _mergeArray:_list with:newListElement withKeyName:_keyName at:DHPageControllerMergeDirectionTail];
//                if (_onNextSuccessBlock) {
//                    _onNextSuccessBlock(_list,result);
//                }
//            }else{
//                NSError *error = [[NSError alloc]initWithDomain:PageControllerErrorDomain code:001 userInfo:@{
//                                                                                                              NSLocalizedDescriptionKey : STRING_EMPTY_IF_NULL(errorMessage)
//                                                                                                              }];
//                _onNextFailedBlock(error);
//                [error autorelease];
//            }
//
//        };
//        
//
//        __block typeof(self) bSelf = self;
//        self.pageControllerRefreshSuccessBlock = ^(id result) {
//            NSArray *listData = NULL;
//            BOOL isSuccess= false;
//            NSString *errorMessage;
//            
//            if (_pageinfoAdapter) {
//                _pageinfoAdapter(result,&isSuccess,&listData,&_totalPage,&errorMessage);
//            }else if (IS_CLASS_OF(result[kLSPageControllerPageInfoKey], NSDictionary)&&IS_CLASS_OF(result[kLSPageControllerListKey], NSArray)) {
//                NSDictionary *pageInfo = result[kLSPageControllerPageInfoKey];
//                _totalPage  = [pageInfo[kLSPageControllerPageInfoTotalKey] intValue];
//                listData    = result[kLSPageControllerListKey];
//                isSuccess = true;
//            }else{
//                isSuccess = false;
//                errorMessage = @"网络访问类型不为DH标准的分页格式";
//            }
//            if (isSuccess) {
//                NSMutableArray *newlistElement = [[listData mutableCopy] autorelease];
//                if (bSelf -> _shouldMerge) {
//                    [self _mergeArray:_list with:newlistElement withKeyName:_keyName at:DHPageControllerMergeDirectionFront];
//                }else{
//                    self.list = newlistElement;
//                }
//                if (_onRefreashSuccessBlock) {
//                    _onRefreashSuccessBlock(_list,result);
//                }
//                bSelf ->_refreashConnection.addCache = true;
//            }else{
//                NSError *error = [[NSError alloc]initWithDomain:PageControllerErrorDomain code:001 userInfo:@{
//                                                                                                              NSLocalizedDescriptionKey : STRING_EMPTY_IF_NULL(errorMessage)
//                                                                                                              }];
//                _onRefreashFailedBlock(error);
//                [error autorelease];
//            }
//        };
    }
    return self;
}
- (id)initWithApiName:(NSString *)apiName{
    self = [self init];
    if (self) {
        _apiName = [apiName copy];
        _apiParams=@{};
        
        if (_list == NULL) {
            _list = [[NSMutableArray alloc]init];
        }
    }
    return self;    
}

- (id)initWithApiName:(NSString *)apiName andParams:(NSDictionary *)apiParams{
    self = [self init];
    if (self) {
        _apiName = [apiName copy];
        _apiParams=[apiParams copy];

        if (_list == NULL) {
            _list = [[NSMutableArray alloc]init];
        }
    }
    return self;
}
- (void)releaseBlocks{
    Block_release(_onNextFailedBlock);
    _onNextFailedBlock = nil;
    Block_release(_onNextSuccessBlock);
    _onNextSuccessBlock = nil;
    Block_release(_onRefreashFailedBlock);
    _onRefreashFailedBlock = nil;
    Block_release(_onRefreashSuccessBlock);
    _onRefreashSuccessBlock = nil;
    Block_release(_beforeNextPageRequestBlock);
    _beforeNextPageRequestBlock = nil;
    Block_release(_beforeRefreashRequestBlock);
    _beforeRefreashRequestBlock = nil;
//    Block_release(_pageControllerRefreshSuccessBlock);
//    _pageControllerRefreshSuccessBlock = nil;
//    Block_release(_pageControllerNextSuccessBlock);
//    _pageControllerNextSuccessBlock = nil;
    Block_release(_onCacheNextBlock);
    _onCacheNextBlock = nil;
    Block_release(_onCacheRefreashBlock);
    _onCacheRefreashBlock = nil;
}
- (void)dealloc
{
    [self releaseBlocks];

    [_pageName release];
    [_stepName release];
    [_apiName release];
    [_apiParams release];
    [_list release];
    if (_isLoading) {
        [_nextPageConnection cancel];
    }
    if (_isRefreashing) {
        [_refreashConnection cancel];
    }
    [super dealloc];
}
#pragma mark ----获取上一页的数据----
-(void)UpPage{
    
    _currentPage --;
    if (_currentPage<1) {
        _currentPage = 1;
        
        return;
    }
    
    NSMutableDictionary *params = [_apiParams mutableCopy];
    params[_stepName] = STRING_FROM_INT(_step);
    params[_pageName] = STRING_FROM_INT(_currentPage);
    _nextPageConnection = [[NSClassFromString(_apiClass) sharedInstance]connectionWithApiName:_apiName params:params];
    
    [_nextPageConnection setSuccessTarget:self selector:@selector(nextRequestDidSuccess:)];
    [_nextPageConnection setCacheSuccessTarget:self selector:@selector(nextRequestDidSuccess:)];
    
    [_nextPageConnection setOnFailed:_onNextFailedBlock];
    [_nextPageConnection setOnFinal:^{
        _isLoading = false;
    }];
    
    BOOL validatePass = true;
    if(_beforeNextPageRequestBlock){
        validatePass = _beforeNextPageRequestBlock(_nextPageConnection);
    }
    if (validatePass) {
        _isLoading = true;
        [_nextPageConnection startAsynchronous];
    }
    [params release];
}
#pragma mark method
- (void)nextPage{
    if (!self.hasMore) {
        if (_onNextFailedBlock) {
            NSError *error = [[NSError alloc]initWithDomain:PageControllerErrorDomain code:002 userInfo:@{
                                                                                                          NSLocalizedDescriptionKey : @"没有更多啦"
                                                                                                          }];
           
            
            _onNextFailedBlock(error);
            
            [error release];
        }
        return ;
    }
    _currentPage ++;
    
    NSMutableDictionary *params = [_apiParams mutableCopy];
    params[_stepName] = STRING_FROM_INT(_step);
    params[_pageName] = STRING_FROM_INT(_currentPage);
    _nextPageConnection = [[NSClassFromString(_apiClass) sharedInstance]connectionWithApiName:_apiName params:params];
    
    [_nextPageConnection setSuccessTarget:self selector:@selector(nextRequestDidSuccess:)];
    [_nextPageConnection setCacheSuccessTarget:self selector:@selector(nextRequestDidSuccess:)];
    
    [_nextPageConnection setOnFailed:_onNextFailedBlock];
    [_nextPageConnection setOnFinal:^{
        _isLoading = false;
    }];
    
    BOOL validatePass = true;
    if(_beforeNextPageRequestBlock){
        validatePass = _beforeNextPageRequestBlock(_nextPageConnection);
    }
    if (validatePass) {
        _isLoading = true;
        [_nextPageConnection startAsynchronous];
    }
    [params release];
}
- (void)nextPage:(UIScrollView *)dataScroll{
    if (!self.hasMore) {
        if (_onNextFailedBlock) {
            NSError *error = [[NSError alloc]initWithDomain:PageControllerErrorDomain code:002 userInfo:@{
                                 NSLocalizedDescriptionKey : @"没有更多啦"
                              }];
            [dataScroll.footer endRefreshing];
            
            _onNextFailedBlock(error);
            
            [error release];
        }
        return ;
    }
    _currentPage ++;

    NSMutableDictionary *params = [_apiParams mutableCopy];
    params[_stepName] = STRING_FROM_INT(_step);
    params[_pageName] = STRING_FROM_INT(_currentPage);
    _nextPageConnection = [[NSClassFromString(_apiClass) sharedInstance]connectionWithApiName:_apiName params:params];
    
    [_nextPageConnection setSuccessTarget:self selector:@selector(nextRequestDidSuccess:)];
    [_nextPageConnection setCacheSuccessTarget:self selector:@selector(nextRequestDidSuccess:)];
    
    [_nextPageConnection setOnFailed:_onNextFailedBlock];
    [_nextPageConnection setOnFinal:^{
        _isLoading = false;
    }];
    
    BOOL validatePass = true;
    if(_beforeNextPageRequestBlock){
        validatePass = _beforeNextPageRequestBlock(_nextPageConnection);
    }
    if (validatePass) {
        _isLoading = true;
        [_nextPageConnection startAsynchronous];
    }
    [params release];
}

- (void)refresh{
    [self refresh:NO];
}
- (void)refreshNoMerge{
    [self refresh:NO];
}
- (void)refresh:(BOOL)shoudMerge{
    [self cancelRefreashing];
    NSMutableDictionary *params = [_apiParams mutableCopy];
    params[_stepName] = STRING_FROM_INT(_step);
    params[_pageName] = STRING_FROM_INT(1);

    if (shoudMerge == false) {
        _currentPage = 1;
        
        [SVProgressHUD show];
    }

    _refreashConnection = [[NSClassFromString(_apiClass) sharedInstance] connectionWithApiName:_apiName params:params];
    _refreashConnection.addCache = false;
    
    _shouldMerge = shoudMerge;
    
    [_refreashConnection setSuccessTarget:self selector:@selector(refreashRequestDidSuccess:)];
    [_refreashConnection setCacheSuccessTarget:self selector:@selector(refreashRequestDidSuccess:)];
    [_refreashConnection setOnFailed:_onRefreashFailedBlock];
    
    [_refreashConnection setOnFinal:^{
        if (shoudMerge == false) {
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                if (_list.count==0) {

                    [SVProgressHUD showImage:nil status:@"服务器没有返回数据呦！" maskType:SVProgressHUDMaskTypeNone];
                }else{
                    [SVProgressHUD dismiss];
                }
            });

        }
        _isRefreashing = false;
    }];
    [_refreashConnection loadFromCache];
    BOOL validatePass = true;
    if(_beforeRefreashRequestBlock){
        validatePass = _beforeRefreashRequestBlock(_refreashConnection);
    }
    if (validatePass) {
        _isRefreashing = true;
        [_refreashConnection startAsynchronous];
    }
    [params release];
}

- (void)clearList{
    [_list removeAllObjects]; 
}

- (void)cancelLoading{
    if (_isLoading) {
        [_nextPageConnection cancel];
        _isLoading = false;
    }
}
- (void)cancelRefreashing{
    if (_isRefreashing) {
        [_refreashConnection cancel];
        _isRefreashing = false;
    }
}


#pragma mark response handler
-(void) refreashRequestDidSuccess:(NSDictionary *)result{
    NSArray *listData = NULL;
    BOOL isSuccess= false;
    NSString *errorMessage;

    if (_pageinfoAdapter) {
        _pageinfoAdapter(result,&isSuccess,&listData,&_totalPage,&errorMessage);
    }else if (IS_CLASS_OF(result[kLSPageControllerPageInfoKey], NSDictionary)&&IS_CLASS_OF(result[kLSPageControllerListKey], NSArray)) {
        NSDictionary *pageInfo = result[kLSPageControllerPageInfoKey];
        _totalPage  = [pageInfo[kLSPageControllerPageInfoTotalKey] intValue];
        listData    = result[kLSPageControllerListKey];
        isSuccess = true;
    }else{
        isSuccess = false;
        errorMessage = @"网络访问类型不为DH标准的分页格式";
    }
    if (isSuccess) {
        NSMutableArray *newlistElement = [[listData mutableCopy] autorelease];
        if (_shouldMerge) {
            [self _mergeArray:_list with:newlistElement withKeyName:_keyName at:DHPageControllerMergeDirectionFront];
        }else{
            self.list = newlistElement;
        }
        if (_refreashConnection.isCacheLoading) {
            if (_onCacheRefreashBlock) {
                _onCacheRefreashBlock(_list,result);
            }
        }else{
            if (_onRefreashSuccessBlock) {
                _onRefreashSuccessBlock(_list,result);
            }
            _refreashConnection.addCache = true;
        }
       
    }else{
        NSError *error = [[NSError alloc]initWithDomain:PageControllerErrorDomain 
                                                   code:001 
                                               userInfo:@{ NSLocalizedDescriptionKey : STRING_EMPTY_IF_NULL(errorMessage) }];
        _onRefreashFailedBlock(error);
        [error autorelease];
    }
}

-(void) nextRequestDidSuccess:(NSDictionary *)result{
    NSArray *listData = NULL;
    BOOL isSuccess= false;
    NSString *errorMessage;
    if (_pageinfoAdapter) {
        _pageinfoAdapter(result,&isSuccess,&listData,&_totalPage,&errorMessage);
    }else if (IS_CLASS_OF(result[kLSPageControllerPageInfoKey], NSDictionary)&&IS_CLASS_OF(result[kLSPageControllerListKey], NSArray)) {
        isSuccess   = true;
        NSDictionary *pageInfo = result[kLSPageControllerPageInfoKey];
        _totalPage  = [pageInfo[kLSPageControllerPageInfoTotalKey] intValue];
        listData    = result[kLSPageControllerListKey];
    }else{
        isSuccess   = false;
        errorMessage= @"网络访问类型不为DH标准的分页格式";
        
    }
    
    if (isSuccess) {
        NSMutableArray *newListElement = [[listData mutableCopy] autorelease];
        if (_isOnlyTenDataShow) {
            [_list removeAllObjects];
            [_list addObjectsFromArray:newListElement];
        }else{
            [self _mergeArray:_list with:newListElement withKeyName:_keyName at:DHPageControllerMergeDirectionTail];
        }
        
        if (_nextPageConnection.isCacheLoading) {
            if (_onCacheNextBlock) {
                _onCacheNextBlock(_list,result);
            }
        }else{
            if (_onNextSuccessBlock) {
                _onNextSuccessBlock(_list,result);
            }
        }
    }else{
        NSError *error = [[NSError alloc]initWithDomain:PageControllerErrorDomain code:001 userInfo:@{
                                                                                                      NSLocalizedDescriptionKey : STRING_EMPTY_IF_NULL(errorMessage)
                                                                                                      }];
        _onNextFailedBlock(error);
        [error autorelease];
    }

}
#pragma mark -
#pragma mark private method
- (void)_mergeArray:(NSMutableArray *)destination with:(NSMutableArray *)src withKeyName:(NSString *)keyname at:(DHPageControllerMergeDirection)direction{
    if (!(IS_CLASS_OF(destination, NSMutableArray)&&IS_CLASS_OF(src, NSMutableArray))) {
        return;
    }
    switch (direction) {
        case DHPageControllerMergeDirectionFront:{
            NSMutableArray *source = [src mutableCopy];
            int *shouldRemoveIndexs = (int *)malloc(sizeof(int)*source.count);
            int shouldRemoveIndexsCount = 0;
            for(int i = 0 ; i < source.count ;i ++){
                NSDictionary *data = source[i];
                NSString *key = data[keyname];
                if (IS_CLASS_OF(key, NSString)) {
                    int index = [self _indexOfObject:data ByKey:keyname inArray:destination];
                    if (index >= 0) {
                        destination[index] = data;
                        shouldRemoveIndexs[shouldRemoveIndexsCount] = i;
                        shouldRemoveIndexsCount++;
                    }
                }
            }
            for (int i = shouldRemoveIndexsCount -1 ; i >=0; i--) {
                [source removeObjectAtIndex:shouldRemoveIndexs[i]];
            }
            free(shouldRemoveIndexs);
            

            [source addObjectsFromArray:destination];
            [destination setArray:source];
            
            [source release];
            break;
        }
        case DHPageControllerMergeDirectionTail:{
            NSMutableArray *source = [src mutableCopy];
            int *shouldRemoveIndexs = (int *)malloc(sizeof(int)*source.count);
            int shouldRemoveIndexsCount = 0;
            for(int i = 0 ; i < source.count ;i ++){
                NSDictionary *data = source[i];
                NSString *key = data[keyname];
                if (IS_CLASS_OF(key, NSString)) {
                    int index = [self _indexOfObject:data ByKey:keyname inArray:destination];
                    if (index >= 0) {
                        destination[index] = data;
                        shouldRemoveIndexs[shouldRemoveIndexsCount] = i;
                        shouldRemoveIndexsCount++;
                    }
                }
            }
            for (int i = shouldRemoveIndexsCount -1 ; i >=0; i--) {
                [source removeObjectAtIndex:shouldRemoveIndexs[i]];
            }
            free(shouldRemoveIndexs);
            
            [destination addObjectsFromArray:source];
            
            [source release];
            break;
        }
        default:
            break;
    }
}
- (int)_indexOfObject:(NSDictionary *)object ByKey:(NSString *)key inArray:(NSArray *)src{
    if (!(IS_CLASS_OF(object, NSDictionary)&&IS_CLASS_OF(key,NSString)&&IS_CLASS_OF(src, NSArray))) {
        return  -1;
    }
    
    for (int i =  0; i<src.count; i ++ ) {
        if([src[i][key] isEqual:object[key]]) return i;
    }
    return  -1;
}
#pragma mark -
#pragma mark Setter and Getter

- (BOOL)isBusy{
    return _isLoading||_isRefreashing;
}

- (BOOL)hasMore{
    return _currentPage<_totalPage;
}
@end


@implementation LSPageController (DefaultSetting)
+ (void)setDefaultStepName:(NSString *)stepName{
    kLSPageControllerStepName = stepName;
}
+ (void)setDefaultPageName:(NSString *)pageName{
    kLSPageControllerStepName = pageName;
}
+ (void)setDefaultStep:(int)step{
    kLSPageControllerStep    = step;
}

+ (void)setDefaultListKey:(NSString *)listKey{
    kLSPageControllerListKey = listKey;
}
+ (void)setDefaultPageInfoKey:(NSString *)pageinfokey{
    kLSPageControllerPageInfoKey = pageinfokey;
}
+ (void)setDefaultPageInfoTotalKey:(NSString *)totalkey{
    kLSPageControllerPageInfoTotalKey = totalkey;
}
@end
