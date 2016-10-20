//
//  AppSettingMacro.h
//  XieshiPrivate
//
//  Created by Tesiro on 16/9/20.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#ifndef AppSettingMacro_h
#define AppSettingMacro_h

#define Local_File_path [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]
#define kImagePath  [NSString stringWithFormat:@"%@/Library/Caches/%@",NSHomeDirectory(),@"Images/"]

#endif /* AppSettingMacro_h */
