//
//  CollectionViewController.h
//  ObjectiveCTestApp
//
//  Created by Егор Худяев on 26.01.2023.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CollectionViewController : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic,strong) NSString *pocemonsName;
@property (nonatomic,strong) NSMutableArray *images;
@property (nonatomic,strong) NSMutableArray *array;

- (void)setPocemon:(NSString *)pocemonsName;
-(void)asyncLoadImages;

@end

NS_ASSUME_NONNULL_END
