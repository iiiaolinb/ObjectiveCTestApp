//
//  CollectionViewController.h
//  ObjectiveCTestApp
//
//  Created by Егор Худяев on 26.01.2023.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CollectionViewController : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic) NSString *pocemonsName;
@property (nonatomic) NSMutableArray *images;
@property (nonatomic) NSMutableArray *array;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

-(void)setPocemon:(NSString *)pocemonsName;

@end

NS_ASSUME_NONNULL_END
