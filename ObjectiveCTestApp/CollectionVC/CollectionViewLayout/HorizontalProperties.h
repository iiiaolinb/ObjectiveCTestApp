//
//  HorizontalProperties.h
//  ObjectiveCTestApp
//
//  Created by Егор Худяев on 09.03.2023.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PropertiesProtocol.h"

@class Carusel;

@interface HorizontalProperties : NSObject <PropertiesProtocol>

@property(nonatomic, weak, readonly) Carusel *layout;

- (instancetype)initWithLayout:(Carusel *)layout;

@end
