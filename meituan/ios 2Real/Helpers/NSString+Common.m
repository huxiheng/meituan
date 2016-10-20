//
//  NSString+Common.m
//  car4S
//
//  Created by huazi on 14-2-20.
//  Copyright (c) 2014年 huifu. All rights reserved.
//

#import "NSString+Common.h"
#import "CommonCrypto/CommonDigest.h"
#import "Toast+UIView.h"
@implementation NSString (Common)
+(NSString *)MD5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, strlen(cStr), result);
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
    
}
+(NSString *)Base64encode:(NSString *)encodeStr
{
    NSData *data = [encodeStr dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString* encoded =@"";
    //[[NSString alloc] initWithData:[GTMBase64 encodeData:data] encoding:NSUTF8StringEncoding];
    return encoded;
}

+(NSString *)Base64decode:(NSString *)decodeStr
{
    NSString *decoded =@"";
    //[[NSString alloc] initWithData:[GTMBase64 decodeString:decodeStr] encoding:NSUTF8StringEncoding];
    return decoded;
}
+(BOOL) isEmpty:(NSString *) str {
    
    if ([str isKindOfClass:[NSNull class]])
    {
        return true;
    }
    else {
    if (!str)
    {
        return true;
    } else {
        //A character set containing only the whitespace characters space (U+0020) and tab (U+0009) and the newline and nextline characters (U+000A–U+000D, U+0085).
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        
        //Returns a new string made by removing from both ends of the receiver characters contained in a given character set.
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        
        if ([trimedString length] == 0) {
            return true;
        } else {
            return false;
        }
    }
    }
}
+(BOOL)isMobileNumber:(NSString *)mobileNum
{
    
    NSString * MOBILE = @"^1\\d{10}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    if ([regextestmobile evaluateWithObject:mobileNum] == YES)
        
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
+(BOOL)isValidateEmail:(NSString *)msg {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:msg];
}
///计算Size
+(CGSize)calculateTextSize:(CGSize)size Content:(NSString *)strContent  font:(UIFont *)font
{
    NSDictionary *tdic =[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil];
    return [strContent boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;
}
///计算高度
+(CGFloat)calculateTextHeight:(CGFloat)widthInput Content:(NSString *)strContent  font:(UIFont *)font
{
    if ([NSString isEmpty:strContent]) {
        return 0.0f;
    }
    CGSize constraint = CGSizeMake(widthInput, 20000.0f);
    NSDictionary *tdic =[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil];
    CGSize size = [strContent boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;
    CGFloat height = ceilf(size.height);
    return height;
}

/**
 *  设置文本不同位置的颜色
 *
 */
+(NSMutableAttributedString *)calculateUpdateStringColor:(NSString *)willUpdateStr  allTextString:(NSString *)allTextStr willUpdateStringColor:(UIColor *)WillUpdateColor{
    NSString *string3=allTextStr;
    NSRange range3 = [string3 rangeOfString: willUpdateStr];
    NSRange fontRange3=[string3 rangeOfString:allTextStr];
    NSMutableAttributedString *attribute3 =[[NSMutableAttributedString alloc] initWithString: string3];
    [attribute3 addAttributes:@{
                                NSForegroundColorAttributeName:WillUpdateColor
                                }range:range3];
    [attribute3 addAttributes:@{
                                NSFontAttributeName:themeFont15
                                }range:fontRange3];
    NSLog(@"==%@",[attribute3 string]);
//    self.labelReplyContent.attributedText=attribute3;
    return attribute3;
}

//计算 宽度
+(CGFloat)calculateTextWidth:(CGFloat)widthInput Content:(NSString *)strContent  font:(UIFont *)font
{
    if ([NSString isEmpty:strContent]) {
        return 0.0f;
    }
    CGFloat constrainedSize = 150.0f; //其他大小也行
//    CGSize size = [strContent sizeWithFont:font constrainedToSize:CGSizeMake(constrainedSize, widthInput)];  //new add
    NSDictionary *tdic =[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil];
    CGSize size = [strContent boundingRectWithSize:CGSizeMake(constrainedSize, widthInput) options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;
    CGFloat width = size.width;
    return width;
}
+(BOOL)isStandardPassword:(NSString *)str andView:(UIView *)view
{
    if (str.length >5&&str.length<33)
    {
        
        return YES;
    }
    else
    {
        [view makeToast:@"请输入6~32位字符" duration:1.0 position:@"center"];
        return NO;
    }
}
+(BOOL)isStandardFargatherName:(NSString *)str andView:(UIView *)view
{
    if ([NSString isEmpty:str])
    {
        [view makeToast:@"聚会名不能为空" duration:1.5 position:@"center"];
        return NO;
    }
    else
    {
    if (str.length >0&&str.length<11)
    {
        return YES;
    }
    else
    {
        [view makeToast:@"请输入1~10位字符" duration:1.5 position:@"center"];
        return NO;
    }
    }
}
+(NSString *)stringRemoveEmoji:(NSString *)stringRemoveEmoji
{
    return @"";
}
+(NSString *)strarrNamesToStr:(NSArray *)arrayNames{
    if (arrayNames.count ==0) {
        return @"";
    }
    else if (arrayNames.count ==1)
    {
        return [[arrayNames objectAtIndex:0] objectForKey:@"userName"];
    }
    else {
        NSMutableString *strname =[[NSMutableString alloc] init];
        for (int i=0; i<arrayNames.count; i++){
            [strname appendString:[[arrayNames objectAtIndex:i]objectForKey:@"userName"]];
            if (i+1==arrayNames.count) {
         
            }
            else {
             [strname appendString:@","];
            }
        }
        return strname;
    }
}
+(NSString *)returnSessionsIds {
//    NSArray *arraySessions =[HYUserSessionCacheBean sharedInstance].sessionMessages;
//    NSMutableString *returnString =[[NSMutableString alloc] initWithString:@""];
//    if (arraySessions!=nil&&arraySessions.count>0) {
//        for (NSInteger i=0; i<arraySessions.count; i++) {
//            SessionMessage *session =[arraySessions objectAtIndex:i];
//            NSString *j1id =[session.url stringByReplacingOccurrencesOfString:@"j1wireless://chatting?msgId=C" withString:@""];
//            j1id =[j1id stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"_%i",[HYUserSessionCacheBean sharedInstance].user.userPbModel.id ] withString:@""];
//            //是和自己聊天
//            if ([NSString isEmpty:j1id]) {
//                [returnString appendString:[NSString stringWithFormat:@"%i,",[HYUserSessionCacheBean sharedInstance].user.userPbModel.id]];
//                continue ;
//            }
//            j1id =[j1id substringFromIndex:1];
//            [returnString appendString:[NSString stringWithFormat:@"%@,",j1id]];
//        }
//         return [returnString substringToIndex:returnString.length-1];
//    }
//   return returnString;
}
+(CGFloat)calculateTextHeight:(NSArray *)arrIems {
    float x=15.0f;
    float y=44.0f;
    if (arrIems ==nil||arrIems.count ==0) {
        return 44.0f;
    }
    for (int i=0; i<arrIems.count; i++) {
        NSString *strTabsName =arrIems[i];
        float tempWidth =[NSString calculateTextWidth:100 Content:strTabsName font:themeFont13];
        if (tempWidth +10+x>DeviceWidth-35)
        {
            x =15.0;
            y =y+20.0f;
        }
        else
        {
            x =x+tempWidth+10;
        }
    }
    return 30+y+10;
}
+(NSString*)returnImagesUser{
    NSString *doc =kImagePath;
    [[NSFileManager defaultManager] createDirectoryAtPath:doc withIntermediateDirectories:YES attributes:nil error:nil];
    NSString *plistPath = [doc stringByAppendingPathComponent:@"dataImage.plist"];
    return plistPath;
}
@end
