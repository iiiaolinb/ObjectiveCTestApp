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
    return [self URLForQuery:@"https://www.flickr.com/services/rest/?method=flickr.tags.getHotList&api_key=eab35027935d7a4ac21f4e882a000446&count=100&format=json&nojsoncallback=1"];
}

+ (NSURL *)URLPocemonsImages:(NSString *)pocemonsName {
    pocemonsName = [NSString stringWithFormat:@"https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=eab35027935d7a4ac21f4e882a000446&tags=%@", pocemonsName];
    //tags=
    pocemonsName = [pocemonsName stringByAppendingString:@"&extras=url_s%2C+url_l&per_page=10&page=1&format=json&nojsoncallback=1"];
    return  [self URLForQuery:pocemonsName];
}

+ (void)fetchPocemonsList:(void(^_Nullable)(NSArray  * _Nullable list))competion {
    NSURL *url = [URLHelper URLPocemonsNames];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDownloadTask *task = [session downloadTaskWithURL:url
                                                completionHandler:
        ^(NSURL *location, NSURLResponse *response, NSError *error) {

            if (!error) {
                NSError *error = nil;
                NSData *jsonResults = [NSData dataWithContentsOfURL:url];
                if (jsonResults) {
                    NSDictionary *results = [NSJSONSerialization JSONObjectWithData:jsonResults
                                                                          options:NSJSONReadingMutableContainers
                                                                            error:&error];
                    NSMutableArray *array = NSMutableArray.new;
                    NSDictionary *places = results[@"hottags"];
                    NSArray *pocemons = places[@"tag"];
                    for (NSDictionary *temp in pocemons){
                        NSString *tag = temp[@"_content"];
                        [array addObject:tag];
                    }

                    competion(array);
              } else {
                  NSLog(@"Error fetching pocemons");
                  competion(nil);
              }
            } else {
                NSLog(@"Error connection");
                competion(nil);
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
                      //NSMutableArray *finalArray = NSMutableArray.new;
                      NSDictionary *images = results[@"photos"];
                      NSArray *arrayOfImage = images[@"photo"];
                      for (NSDictionary *temp in arrayOfImage){
                          NSString *url_s = temp[@"url_s"];
                          if (url_s!=nil) {
                              [arrayOfURLStrings addObject:url_s];
                          } else {
                              NSLog(@"Error fetching pocemons images");
                          }
                      }

                    [self asyncLoadImages:arrayOfURLStrings :^(NSMutableArray *result) {
                        [arrayOfImages addObjectsFromArray:result];
                        if (arrayOfImages.count != 0) {
                            completion(true);
                        } else {
                            completion(false);
                        }
                    }];
                  }
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
