//
//  CollectionVCPresenter.m
//  ObjectiveCTestApp
//
//  Created by Егор Худяев on 03.03.2023.
//

#import "CollectionVCPresenter.h"
#import "ImageViewerVC.h"
#import "URLHelper.h"

@implementation CollectionVCPresenter

@synthesize view;

- (void)initWithView:(UICollectionViewController <CollectionVCPresenterOutput> *)view {
    self.view = view;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender withImages:(NSMutableArray *)images {
    
    if ([sender isKindOfClass:[UICollectionViewCell class]]) {
        NSIndexPath *indexPath =[self.view.collectionView indexPathForCell:sender];
        if (indexPath) {
            if ([segue.identifier isEqualToString:@"OnePocemonsImage"]) {
                if ([segue.destinationViewController isKindOfClass:[ImageViewerVC class]]) {
                    [segue.destinationViewController transferImages:images :indexPath.row];
                }
            }
        }
    }
}

- (void)setPocemons:(NSString *)pocemonsName :(void(^)(NSMutableArray * result))completion {

    [URLHelper fetchPocemonsImages:pocemonsName :^(NSMutableArray *result) {
        if (result) {
            completion(result);
            [self.view stopAnimatingActivityIndicator];
            [self.view reloadCollectionView];
        } else {
            NSLog(@"Error loading images");
        }
    }];
    //return array;
}

@end
