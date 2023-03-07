//
//  TableVCModel.m
//  ObjectiveCTestApp
//
//  Created by Егор Худяев on 03.03.2023.
//

#import "TableVCModel.h"
#import "URLHelper.h"

@implementation TableVCModel

+(void)createDataModel:(void(^_Nullable)(NSMutableArray  * _Nullable content))competion
{
    NSLog(@"WORK");
    [URLHelper fetchPocemonsList:^(NSMutableArray * _Nullable list) {
        
        //self.content = list;
        competion(list);
    }];
}

@end
