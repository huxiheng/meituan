//
//  xiaoweiHD-Info.h
//  xiaoweiHD
//
//  Created by Lessu on 13-1-20.
//  Copyright (c) 2013年 Lessu. All rights reserved.
// version 1.1

#ifndef LS_CONSTANCE_h
#define LS_CONSTANCE_h

#define VIEW_CONTROLLER_LOAD(viewController) UNUSED_VAR(viewController.view)


#define BREAK_IF(cond) if(cond) break
#define UNUSED_VAR(__variable) ((void)__variable)
#define LS_CAST(__type,exp) ((__type)exp)
#define ARRAY_CAST(__array)  LS_CAST(NSArray *,__array)
#define DICTIONARY_CAST(__dict)  LS_CAST(NSDictionary *,__dict)
#define STRING_CAST(__string) LS_CAST(NSString*,__string)

#ifdef __OBJC__

/**
 *      CGPoint
 *
 */
#define cgpsPlus(__P1,__P2)  (__P1 = CGPointMake(__P1.x+__P2.x,__P1.y+__P2.y))
/**------------------------------------------------------
 *                       UI
 *
 *------------------------------------------------------*/
#define LSUI_NEW_INSTANCE(__Classname) (__Classname*)[[NSBundle mainBundle] loadNibNamed:@#__Classname owner:nil options:nil][0];

//| UIViewAutoresizingFlexibleBottomMargin |UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin
//| UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight
#define LSUI_VIEW_AUTORESIZE_W_H    (UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)
#define LSUI_VIEW_AUTORESIZE_W      (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth)
#define LSUI_VIEW_AUTORESIZE_H      (UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight)

#define LSUI_VIEW_AUTORESIZE_L_T    (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin)
#define LSUI_VIEW_AUTORESIZE_L_B    (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin)
#define LSUI_VIEW_AUTORESIZE_R_T    (UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin)
#define LSUI_VIEW_AUTORESIZE_R_B    (UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin)
/**------------------------------------------------------
 *                       createFunction
 *
 *------------------------------------------------------*/
#define NEW_INSTANCE_FUNC_INTERFACE(__Classname) + (__Classname *)newInstance
#define NEW_INSTANCE_FUNC_IMPLEMENT(__Classname) + (__Classname *)newInstance{\
return (__Classname*)[[[NSBundle mainBundle] loadNibNamed:@#__Classname owner:self options:nil][0] retain];\
};


#define SHARED_INSTANCE_INTERFACE(__Classname) + (__Classname *) sharedInstance;
#define SHARED_INSTANCE_IMPLEMENT(__Classname,__instancename,__init) \
+ (__Classname *) sharedInstance{\
static __Classname *__instancename;\
if(__instancename == 0){\
__instancename = [[__Classname alloc]init];\
__init\
}\
return __instancename;\
}

/**------------------------------------------------------
 *                  release and retains
 *
 *------------------------------------------------------*/
#define LS_RELEASE_SAFELY(p)    do {if(p) { [(p) release]; (p) = 0 ;} } while(0)
#define LS_RETAIN_SAFELY(p)     do {if(p) { [(p) retain];} } while(0)

#define STRONG_ASSIGN(p1,p2) do {if(p1!=p2) {[p1 release];p1=[p2 retain];}}while(0)
#define COPY_ASSIGN(p1,p2)   do {if(p1!=p2) {[p1 release];p1=[p2 copy];}}while(0)




#define LS_EACH(__varname,__count) for(int __varname = 0;__varname < __count;__varname++)





#define ADD_DYNAMIC_PROPERTY(PROPERTY_TYPE,PROPERTY_NAME,SETTER_NAME) \
\
@dynamic PROPERTY_NAME ; \
static char kProperty##PROPERTY_NAME; \
- ( PROPERTY_TYPE ) PROPERTY_NAME { \
return ( PROPERTY_TYPE ) objc_getAssociatedObject(self, &(kProperty##PROPERTY_NAME ) ); \
} \
- (void) SETTER_NAME :( PROPERTY_TYPE ) PROPERTY_NAME { \
objc_setAssociatedObject(self, &kProperty##PROPERTY_NAME , PROPERTY_NAME , OBJC_ASSOCIATION_RETAIN); \
} \



#define CLEAR_COLOR [UIColor clearColor]

/**------------------------------------------------------
 *                       debug
 *                      Log info
 *
 *------------------------------------------------------*/
#define LSLogInfoLevel      1
#define LSLogWarningLevel   3
#define LSLogErrorLevel     5

#ifdef DEBUG
#define LSLogLevel 0
#else
#define LSLogLevel 2
#endif

#ifdef DEBUG

#define LSLog(format,...)   NSLog(@"%s(%d): " format, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

#else

#define LSLog(format,...) do{}while(0)

#endif

//Define the info
#if LSLogLevel < LSLogInfoLevel
#define LSInfo(format,...)      LSLog(format,##__VA_ARGS__)
#else
#define LSInfo(format,...)      do{}while(0)
#endif
//Define the warning
#if LSLogLevel < LSLogInfoLevel
#define LSWarning(format,...)   LSLog(format,##__VA_ARGS__)
#else
#define LSWarning(format,...)   do{}while(0)
#endif
//Define the error
#if LSLogLevel < LSLogInfoLevel
#define LSError(format,...)     LSLog(format,##__VA_ARGS__)
#else
#define LSError(format,...)   do{}while(0)
#endif

#define LSLogIf(condition,format,...) do{if(condition) LSLog(format,##__VA_ARGS__)}while(0)
//Log the Name
#define LSLogMethod() LSLog(@"%s", __PRETTY_FUNCTION__)


/**------------------------------------------------------
 *                       validate
 *
 *------------------------------------------------------*/
#define DEFAULT_IF_NULL(__value,__default) ((__value)?(__value) : __default)


#define IS_CLASS_OF(instance,CLASS) (instance!=NULL&&[instance isKindOfClass:[CLASS class]])
#define IS_ARRAY(__array) IS_CLASS_OF(__array,NSArray)
#define IS_DICTIONARY(__dict) IS_CLASS_OF(__dict,NSDictionary)
#define IS_STRING(__string) IS_CLASS_OF(__string,NSString)



#define STRING_NOT_EMPTY(string)            (IS_STRING(string)&&STRING_CAST(string).length>0)
#define ARRAY_NOT_EMPTY(array)              (IS_ARRAY(array)&&ARRAY_CAST(array).count>0)
#define DICTIONARY_NOT_EMPTY(dictionary)    (IS_DICTIONARY(dictionary)&&DICTIONARY_CAST(dictionary).count>0)

#define STRING_EMPTY_IF_NULL(string)            DEFAULT_IF_NULL(string,@"")
#define ARRAY_EMPTY_IF_NULL(array)              DEFAULT_IF_NULL(array,@[])
#define DICTIONARY_EMPTY_IF_NULL(dictionary)    DEFAULT_IF_NULL(dictionary,@{})

#define STRING_SET_EMPTY_IF_NULL(string)            if(string==NULL) string = @""
#define ARRAY_SET_EMPTY_IF_NULL(array)              if(array==NULL) array = @[]
#define DICTIONARY_SET_EMPTY_IF_NULL(dictionary)    if(dictionary==NULL) dictionary = @{}

#define STRING_EMPTY_IF_NOT(string)               (!IS_STRING(string)          ? @"":(string))
#define ARRAY_EMPTY_IF_NOT(array)                 (!IS_ARRAY(array)            ? @[]: (array))
#define DICTIONARY_EMPTY_IF_NOT(dictionary)       (!IS_DICTIONARY(dictionary)   ? @{}:(dictionary))

#define STRING_SET_EMPTY_IF_NOT(string)            if(!IS_STRING(string))     string = @""
#define ARRAY_SET_EMPTY_IF_NOT(array)              if(!IS_ARRAY(string))      array = @[]
#define DICTIONARY_SET_EMPTY_IF_NOT(dictionary)    if(!IS_DICTIONARY(string)) dictionary = @{}


#define STRING_FORMAT(format,...) [NSString stringWithFormat:format,##__VA_ARGS__]
#define STRING_FROM_INT(int)        STRING_FORMAT(@"%d",int)


#define VALIDATE_FAILED_IF(cond,message)    __validateMessage = message;BREAK_IF(cond);
#define VALIDATE_BEGIN \
do{\
BOOL __volidateSuccess = false;\
NSString *__validateMessage = @"";\
do {\

#define VALIDATE_END(success,message)\
__volidateSuccess = true;\
}while(0);\
success = __volidateSuccess;\
message = __validateMessage;\
}while(0)
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define IS_IOS7 ([UIDevice currentDevice].systemVersion.floatValue >= 7)
#define IS_FLAT_STYLE IS_IOS7
#define IOS7_LAYOUT_FIX \
if(IS_IOS7){\
[self setEdgesForExtendedLayout:UIRectEdgeNone];\
}
#define weakAlias(_alias,_var) __weak typeof(_var) _alias = _var;


#endif /*end of __OBJC__*/

#endif /*end of LS_CONSTANCE_h*/
