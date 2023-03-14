//
//  Carusel.h
//  ObjectiveCTestApp
//
//  Created by Егор Худяев on 09.03.2023.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Carusel : UICollectionViewFlowLayout

@property(nonatomic) CGFloat interItemSpace IBInspectable;

@property(nonatomic, assign) CGSize lastCollectionViewSize;

@end
