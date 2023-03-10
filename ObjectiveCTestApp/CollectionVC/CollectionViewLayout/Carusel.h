//
//  Carusel.h
//  ObjectiveCTestApp
//
//  Created by Егор Худяев on 09.03.2023.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Carusel : UICollectionViewLayout

@property(nonatomic) CGSize itemSize IBInspectable;
@property(nonatomic) CGFloat interItemSpace IBInspectable;

@end
