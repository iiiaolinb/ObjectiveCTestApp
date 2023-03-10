//
//  PropertiesProtocol.h
//  ObjectiveCTestApp
//
//  Created by Егор Худяев on 09.03.2023.
//

#import <Foundation/Foundation.h>

@protocol PropertiesProtocol <NSObject>

@property(nonatomic, readonly) CGRect contentRect;
@property(nonatomic, readonly) CGFloat contentStart;

- (CGPoint)centerForItemAtIndexPath:(NSIndexPath *)indexPath;

@end
