//
//  XSSaveLocalManager.h
//  XieshiPrivate
//
//  Created by Tesiro on 16/9/20.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^SaveFinish)(NSDictionary *dic);
typedef void (^SaveFaied )();
@interface XSSaveLocalManager : NSObject
@property(nonatomic,copy) SaveFinish finished;
@property(nonatomic,copy) SaveFaied  failed;
-(void)requestWithUrl:(NSString*)fileName finished:(SaveFinish)finishe failed:(SaveFaied)failed;
-(void)requestWithArrays:(NSArray *)imageArray finished:(SaveFinish)finishe failed:(SaveFaied)failed;
-(void)requestVideoWithUrl:(NSString*)fileName finished:(SaveFinish)finishe failed:(SaveFaied)failed;
@end
