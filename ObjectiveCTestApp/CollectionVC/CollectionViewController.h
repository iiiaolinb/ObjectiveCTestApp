//
//  CollectionViewController.h
//  ObjectiveCTestApp
//
//  Created by Егор Худяев on 26.01.2023.
//

#import <UIKit/UIKit.h>
#import "CollectionVCPresenterInput.h"
#import "CollectionVCPresenterOutput.h"

@interface CollectionViewController : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, CollectionVCPresenterOutput>

@property _Nullable id <CollectionVCPresenterInput> presenter;

NS_ASSUME_NONNULL_BEGIN

@property (nonatomic) NSString *pocemonsName;
@property (nonatomic) NSMutableArray *images;
@property (nonatomic) NSMutableArray *array;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

-(void)setPocemon:(NSString *)pocemonsName;

@end

NS_ASSUME_NONNULL_END
