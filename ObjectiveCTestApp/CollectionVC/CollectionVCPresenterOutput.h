//
//  CollectionVCPresenterOutput.h
//  ObjectiveCTestApp
//
//  Created by Егор Худяев on 06.03.2023.
//

#import "UIKit/UIKit.h"

#pragma mark: view <- presenter

@protocol CollectionVCPresenterOutput <NSObject>

@property (nonatomic, strong) UICollectionView * collectionView;

- (void)reloadCollectionView;
- (void)stopAnimatingActivityIndicator;

@end
