//
//  URLHelper.h
//  ObjectiveCTestApp
//
//  Created by Егор Худяев on 27.01.2023.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface URLHelper : NSObject

+ (NSURL *)URLForQuery:(NSString *)query;
+ (NSURL *)URLPocemonsNames;
+ (NSURL *)URLPocemonsImages:(NSString *)pocemonsName;

@end

NS_ASSUME_NONNULL_END
