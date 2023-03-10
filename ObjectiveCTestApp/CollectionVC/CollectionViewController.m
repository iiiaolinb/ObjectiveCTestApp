//
//  CollectionViewController.m
//  ObjectiveCTestApp
//
//  Created by Егор Худяев on 26.01.2023.
//

#import "CollectionViewController.h"
#import "CollectionViewCell/CollectionViewCell.h"
#import "ImageViewerVC.h"
#import "URLHelper.h"

@implementation CollectionViewController

static NSString * const reuseIdentifier = @"CollectionViewCell";
@synthesize images;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.activityIndicator startAnimating];
    self.activityIndicator.hidesWhenStopped = true;
}

- (void)setPocemon:(NSString *)pocemonsName
{
    _pocemonsName = pocemonsName;
    self.images = [URLHelper fetchPocemonsImages:_pocemonsName :^(BOOL result) {
        if (result) {
            [self.activityIndicator stopAnimating];
            [self.collectionView reloadData];
        } else {
            NSLog(@"Error loading images");
        }
    }];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([sender isKindOfClass:[UICollectionViewCell class]]) {
        NSIndexPath *indexPath =[self.collectionView indexPathForCell:sender];
        if (indexPath) {
            if ([segue.identifier isEqualToString:@"OnePocemonsImage"]) {
                if ([segue.destinationViewController isKindOfClass:[ImageViewerVC class]]) {
                    [segue.destinationViewController setImage:[[sender imageView] image]];
                }
            }
        }
    }
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    if (self.images[indexPath.row]) {
        cell.imageView.image = self.images[indexPath.row];
    }
    
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(CGRectGetWidth(collectionView.frame) / 2 - 20, (CGRectGetWidth(collectionView.frame)) / 2 - 20);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

@end
