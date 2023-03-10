//
//  ModelBuilder.m
//  ObjectiveCTestApp
//
//  Created by Егор Худяев on 10.03.2023.
//

#import "ModelBuilder.h"

@implementation ModelBuilder

+(void)buildPocemonsListModel: (NSURL *)url :(void(^_Nullable)(NSMutableArray  * _Nullable list))competion{
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
}

+(NSMutableArray *)buildPocemonsImagesModel: (NSURL *)url {
    NSMutableArray *arrayOfURLStrings = NSMutableArray.new;
    NSData *jsonResults = [NSData dataWithContentsOfURL:url];
    NSDictionary *results = [NSJSONSerialization JSONObjectWithData:jsonResults
                                                            options:0
                                                              error:NULL];
    NSDictionary *images = results[@"photos"];
    NSMutableArray *arrayOfImage = images[@"photo"];
    for (NSDictionary *temp in arrayOfImage){
        NSString *url_s = temp[@"url_s"];
        if (url_s!=nil) {
            [arrayOfURLStrings addObject:url_s];
        } else {
            NSLog(@"Error fetching pocemons images");
        }
    }
    return arrayOfURLStrings;
}

@end
