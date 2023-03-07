//
//  URLHelper.h
//  ObjectiveCTestApp
//
//  Created by Егор Худяев on 27.01.2023.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

NS_ASSUME_NONNULL_BEGIN

@interface URLHelper : NSObject

+ (NSURL *)URLForQuery:(NSString *)query;
+ (NSURL *)URLPocemonsNames;
+ (NSURL *)URLPocemonsImages:(NSString *)pocemonsName;

+ (void)fetchPocemonsImages:(NSString *)pocemonsName :(void(^)(NSMutableArray * result))completion;
+ (void)asyncLoadImages:(NSMutableArray *)array :(void(^)(NSMutableArray * result))completion;
+ (void)startLoadImage:(NSString *)urlString :(void(^)(UIImage * image))completion;

NS_ASSUME_NONNULL_END

+ (void)fetchPocemonsList:(void(^_Nullable)(NSMutableArray * _Nullable list))competion;

@end


