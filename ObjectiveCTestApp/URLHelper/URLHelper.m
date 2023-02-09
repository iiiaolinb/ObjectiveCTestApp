//
//  URLHelper.m
//  ObjectiveCTestApp
//
//  Created by Егор Худяев on 27.01.2023.
//

#import "UIKit/UIKit.h"
#import "URLHelper.h"

@implementation URLHelper

+ (NSURL *)URLForQuery:(NSString *)query {
    query = [NSString stringWithFormat:@"%@", query];
    return [NSURL URLWithString:query];
}

+ (NSURL *)URLPocemonsNames {
    return [self URLForQuery:@"https://pokeapi.co/api/v2/pokemon/"];
}

+ (NSURL *)URLPocemonsImages:(NSString *)pocemonsName {
    pocemonsName = [NSString stringWithFormat:@"https://pokeapi.co/api/v2/pokemon/%@", pocemonsName];
    return  [self URLForQuery:pocemonsName];
}

+ (void)fetchPocemonsList:(void(^)(NSArray  * _Nullable list))competion {
    NSURL *url = [URLHelper URLPocemonsNames];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDownloadTask *task = [session downloadTaskWithURL:url
                                                completionHandler:
        ^(NSURL *location, NSURLResponse *response, NSError *error) {
        
              if (!error) {
                  NSLog(@"NOT ERROR%@", response);
                  NSData *jsonResults = [NSData dataWithContentsOfURL:url];
                  NSDictionary *results = [NSJSONSerialization JSONObjectWithData:jsonResults
                                                                          options:0
                                                                            error:NULL];
                  NSArray *places = [results valueForKeyPath:@"results"];
                  NSArray *pocemons = [places valueForKey:@"name"];
                  competion(pocemons);
              } else {
                  NSLog(@"Error fetching pocemons");
              }
            }];
    [task resume];
}

+ (NSMutableArray *)fetchPocemonsImages:(NSString *)pocemonsName :(void(^)(BOOL result))completion {
    NSMutableArray *arrayOfURLStrings = NSMutableArray.new;
    NSMutableArray *arrayOfImages = NSMutableArray.new;
    NSURL *url = [URLHelper URLPocemonsImages:pocemonsName];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDownloadTask *task = [session downloadTaskWithURL:url
                                                completionHandler:
              ^(NSURL *location, NSURLResponse *response, NSError *error) {
        
                  if (!error) {
                      NSData *jsonResults = [NSData dataWithContentsOfURL:url];
                      NSDictionary *results = [NSJSONSerialization JSONObjectWithData:jsonResults
                                                                              options:0
                                                                                error:NULL];
                      NSArray *images = [results valueForKeyPath:@"sprites"];
                      [arrayOfURLStrings addObject:[images valueForKeyPath:@"back_default"]];
                      [arrayOfURLStrings addObject:[images valueForKeyPath:@"back_female"]];
                      [arrayOfURLStrings addObject:[images valueForKeyPath:@"back_shiny"]];
                      [arrayOfURLStrings addObject:[images valueForKeyPath:@"back_shiny_female"]];
                      [arrayOfURLStrings addObject:[images valueForKeyPath:@"front_default"]];
                      [arrayOfURLStrings addObject:[images valueForKeyPath:@"front_female"]];
                      [arrayOfURLStrings addObject:[images valueForKeyPath:@"front_shiny"]];
                      [arrayOfURLStrings addObject:[images valueForKeyPath:@"front_shiny_female"]];
                  } else {
                      NSLog(@"Error fetching pocemons images");
                  }

        [self asyncLoadImages:arrayOfURLStrings :^(NSMutableArray *result) {
            [arrayOfImages addObjectsFromArray:result];
            if (arrayOfImages.count != 0) {
                completion(true);
            } else {
                completion(false);
            }
        }];
    }];
    [task resume];

    return arrayOfImages;
}

+(void)asyncLoadImages:(NSMutableArray *)array :(void(^)(NSMutableArray *result))completion {
    
    NSMutableArray *images = [NSMutableArray array];
    dispatch_group_t dispatchGroup = dispatch_group_create();

    for (int i = 0; i < array.count; i++) {
        if (array[i] != [NSNull null]) {

            dispatch_group_enter(dispatchGroup);

            [self startLoadImage:array[i]: ^(UIImage *image) {
                [images addObject:image];
                dispatch_group_leave(dispatchGroup);
            }];
        }
    }
    
    dispatch_group_notify(dispatchGroup, dispatch_get_main_queue(), ^{
        completion(images);
    });
}

+(void)startLoadImage:(NSString *)urlString :(void(^)(UIImage * image))completion {
    NSURL *url = [URLHelper URLForQuery:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
        
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request
                                                    completionHandler:
                                      ^(NSURL * _Nullable localfile, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (!error) {
                UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:localfile]];
                completion(image);
            } else {
                NSLog(@"Error loading pocemons image");
            }
        }];
    [task resume];
}

@end

//ObjectiveCTestApp
//Key:
//22386f27b01f6b9e1ffbe16f82e1f937
//Secret:
//cbfeb4a3d271e144
