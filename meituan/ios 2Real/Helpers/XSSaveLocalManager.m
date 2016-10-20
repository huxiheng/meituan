//
//  XSSaveLocalManager.m
//  XieshiPrivate
//
//  Created by Tesiro on 16/9/20.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "XSSaveLocalManager.h"
#define kSaveImageArrayTag  1090
@interface XSSaveLocalManager()
{
    //仅当
    NSInteger currentIndex;  //当前是第几个
    NSInteger totalCounts;   //总数
    NSString *strurls;
}
@end
@implementation XSSaveLocalManager
-(void)requestWithUrl:(NSString*)fileName finished:(SaveFinish)finishe failed:(SaveFaied)failed
{
    self.finished = finishe ;
    NSLog(@"加载self.finish%@",self.finished);
    self.failed = failed;
    [self performSelectorInBackground:@selector(grabURLInBackground:) withObject:fileName];
    
}
-(void)requestVideoWithUrl:(NSString*)fileName finished:(SaveFinish)finishe failed:(SaveFaied)failed {
    self.finished = finishe ;
    NSLog(@"加载self.finish%@",self.finished);
    self.failed = failed;
    [self performSelectorInBackground:@selector(grabVideoURLInBackground:) withObject:fileName];
}
-(void)requestWithArrays:(NSArray *)imageArray finished:(SaveFinish)finishe failed:(SaveFaied)failed {
    totalCounts =imageArray.count;
    currentIndex =0;
    self.finished =finishe;
    self.failed =failed;
    strurls =[[NSString alloc] init];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (NSInteger i=0; i<imageArray.count; i++){
            UIImage *image =nil;
            if ([imageArray[i] isKindOfClass:[UIImage class]]) {
                image = imageArray[i];
            }
            NSData *imageData = UIImagePNGRepresentation(image);
            NSString *fileName = [NSString stringWithFormat:@"%@/%@.png",Local_File_path,@"saveLocalImage"];
            if (![imageData writeToFile:fileName atomically:YES]) {
                NSLog(@"%@,%d,%@",NSStringFromSelector(_cmd),__LINE__,@"写入文件失败");
            }
            [self performSelectorInBackground:@selector(grabURLInBackgroundAndTag:) withObject:@{@"tag":[NSNumber numberWithInteger:kSaveImageArrayTag],@"filename":fileName}];
        }
        
       
        }
        
    );
}
-(void)grabURLInBackground:(NSString*)fileName
{
   
    
}
-(void)grabVideoURLInBackground:(NSString*)fileName
{
    
    
}
-(void)grabURLInBackgroundAndTag:(NSDictionary*)dic
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.finished(dic);
        
    });
}
- (void)requestFinished:(ASIHTTPRequest *)request
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *relativeUrl = [request responseString];
        NSLog(@"上传成功%@",relativeUrl);
        NSLog(@"self.finish%@",self.finished);
        if (request.tag>1089&&request.tag<1100) {
            currentIndex ++;
            strurls =[strurls stringByAppendingString:[NSString stringWithFormat:@"%@,",relativeUrl]];
            if (currentIndex ==totalCounts) {
                strurls =[strurls substringToIndex:strurls.length -1];
                self.finished(strurls);
            }
        }
        else {
            if (self.finished)
            {
                self.finished(relativeUrl);
            }
        }
        
    });
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    if (self.failed)
    {
        self.failed();
    }
    
    NSLog(@"上传 失败:%@",error);
}
@end
