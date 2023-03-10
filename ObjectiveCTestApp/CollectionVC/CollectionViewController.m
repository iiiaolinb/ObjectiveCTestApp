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
#import "CollectionVCPresenter.h"
#import "Carusel.h"

@implementation CollectionViewController

static NSString * const reuseIdentifier = @"CollectionViewCell";
@synthesize images;

- (void)viewDidLoad {
    [super viewDidLoad];

    self.collectionView.decelerationRate = UIScrollViewDecelerationRateFast;
    self.collectionView.delegate = self;
    
    Carusel *layout = [[Carusel alloc] init];
    layout.itemSize = CGSizeMake(CGRectGetWidth(self.collectionView.frame) / 1.5 ,
                                 CGRectGetWidth(self.collectionView.frame) / 1.5);
    layout.interItemSpace = 20;

    self.collectionView.collectionViewLayout = layout;
    
    [self.activityIndicator startAnimating];
    self.activityIndicator.hidesWhenStopped = true;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:true];
    self.navigationController.navigationBar.backgroundColor = UIColor.whiteColor;
}

- (void)setPocemon:(NSString *)pocemonsName
{
    self.presenter = [[CollectionVCPresenter alloc] init];
    [self.presenter initWithView:self];
    
    [self.presenter setPocemons:pocemonsName :^(NSMutableArray *result) {
        self->images = result;
    }];
}

#pragma mark - CollectionVCPresenterOutput

- (void)reloadCollectionView {
    [self.collectionView reloadData];
}

- (void)stopAnimatingActivityIndicator {
    [self.activityIndicator stopAnimating];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [self.presenter prepareForSegue:segue sender:sender withImages:self.images];
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

@end
