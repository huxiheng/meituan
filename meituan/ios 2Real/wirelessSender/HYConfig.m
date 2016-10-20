
#import "HYConfig.h"

id ct_blockWithWeakifiedSelf(id self, id(^block)(id __unsafe_unretained self)){
    id __unsafe_unretained weakSelf = self;
    return block(weakSelf);
}