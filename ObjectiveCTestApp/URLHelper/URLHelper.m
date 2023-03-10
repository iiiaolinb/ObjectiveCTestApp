//
//  URLHelper.m
//  ObjectiveCTestApp
//
//  Created by Егор Худяев on 27.01.2023.
//

#import "UIKit/UIKit.h"
#import "URLHelper.h"
#import "ModelBuilder.h"

#define QUERY "https://www.flickr.com/services/rest/?method=flickr.tags.getHotList&api_key=eab35027935d7a4ac21f4e882a000446&count=100&format=json&nojsoncallback=1"
#define FIRST_PART_OF_POCEMONS_IMAGES "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=eab35027935d7a4ac21f4e882a000446&tags="
#define END_OF_POCEMONS_IMAGES "&extras=url_s%2C+url_l&per_page=10&page=1&format=json&nojsoncallback=1"

@implementation URLHelper

+ (NSURL *)URLForQuery:(NSString *)query {
    query = [NSString stringWithFormat:@"%@", query];
    return [NSURL URLWithString:query];
}

+ (NSURL *)URLPocemonsNames {
    return [self URLForQuery:@QUERY];
}

+ (NSURL *)URLPocemonsImages:(NSString *)name {
    NSString *pocemonsName = [NSString stringWithFormat:@FIRST_PART_OF_POCEMONS_IMAGES];
    pocemonsName = [pocemonsName stringByAppendingString:name];
    pocemonsName = [pocemonsName stringByAppendingString:@END_OF_POCEMONS_IMAGES];
    return  [self URLForQuery:pocemonsName];
}

+ (void)fetchPocemonsList:(void(^_Nullable)(NSMutableArray  * _Nullable list))competion {
    NSURL *url = [URLHelper URLPocemonsNames];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDownloadTask *task = [session downloadTaskWithURL:url
                                                completionHandler:
        ^(NSURL *location, NSURLResponse *response, NSError *error) {

            if (!error) {
                [ModelBuilder buildPocemonsListModel:url :^(NSMutableArray * _Nullable list) {
                    competion(list);
                }];
            } else {
                NSLog(@"Error connection");
                competion(nil);
            }
        
        }];
    [task resume];
}

+ (void)fetchPocemonsImages:(NSString *)pocemonsName :(void(^)(NSMutableArray * result))completion {
    NSMutableArray *arrayOfImages = NSMutableArray.new;
    NSURL *url = [URLHelper URLPocemonsImages:pocemonsName];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDownloadTask *task = [session downloadTaskWithURL:url
                                                completionHandler:
              ^(NSURL *location, NSURLResponse *response, NSError *error) {
        
                  if (!error) {
                    [self asyncLoadImages:[ModelBuilder buildPocemonsImagesModel:url] :^(NSMutableArray *result) {
                        [arrayOfImages addObjectsFromArray:result];
                        completion(arrayOfImages);
                    }];
                  }
    }];
    [task resume];
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
