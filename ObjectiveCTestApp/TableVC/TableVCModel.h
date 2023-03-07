//
//  TableVCModel.h
//  ObjectiveCTestApp
//
//  Created by Егор Худяев on 03.03.2023.
//

#import <Foundation/Foundation.h>

@interface TableVCModel : NSObject

//@property (nonatomic, retain) NSMutableArray * _Nullable content;

+(void)createDataModel:(void(^_Nullable)(NSMutableArray  * _Nullable content))competion;

@end
