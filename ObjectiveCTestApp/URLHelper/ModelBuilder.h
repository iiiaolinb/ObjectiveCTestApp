//
//  ModelBuilder.h
//  ObjectiveCTestApp
//
//  Created by Егор Худяев on 10.03.2023.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ModelBuilder : NSObject

+(void)buildPocemonsListModel: (NSURL *)url :(void(^_Nullable)(NSMutableArray  * _Nullable list))competion ;
+(NSMutableArray *)buildPocemonsImagesModel: (NSURL *)url;

@end

NS_ASSUME_NONNULL_END
