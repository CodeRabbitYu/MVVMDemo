

#import "ViewModelClass.h"
#import "RTNetworking.h"

@implementation ViewModelClass


#pragma 接收传过来的block
-(void) setBlockWithReturnBlock: (ReturnValueBlock) returnBlock
                 WithErrorBlock: (ErrorCodeBlock) errorBlock
{
    _returnBlock = returnBlock;
    _errorBlock = errorBlock;
}
@end
