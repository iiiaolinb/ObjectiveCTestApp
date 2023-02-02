//
//  URLHelper.m
//  ObjectiveCTestApp
//
//  Created by Егор Худяев on 27.01.2023.
//

#import "URLHelper.h"

@implementation URLHelper

+ (NSURL *)URLForQuery:(NSString *)query
{
    query = [NSString stringWithFormat:@"%@", query];
    //NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
    
    //query = [query stringByAddingPercentEncodingWithAllowedCharacters:set];        //NSUTF8StringEncoding
    
    return [NSURL URLWithString:query];
}

+ (NSURL *)URLPocemonsNames
{
    return [self URLForQuery:@"https://pokeapi.co/api/v2/pokemon/"];
}

+ (NSURL *)URLPocemonsImages:(NSString *)pocemonsName
{
    pocemonsName = [NSString stringWithFormat:@"https://pokeapi.co/api/v2/pokemon/%@", pocemonsName];
    return  [self URLForQuery:pocemonsName];
}

@end

//ObjectiveCTestApp
//Key:
//22386f27b01f6b9e1ffbe16f82e1f937
//Secret:
//cbfeb4a3d271e144
