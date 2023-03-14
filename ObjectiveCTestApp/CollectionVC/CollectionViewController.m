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

@interface CollectionViewController ()

@property UIEdgeInsets sectionInsets;
@property CGSize sizeForItem;

@end

@implementation CollectionViewController

static NSString * const reuseIdentifier = @"CollectionViewCell";
@synthesize images;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.sectionInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    self.sizeForItem = CGSizeMake(UIScreen.mainScreen.bounds.size.width / 2 ,
                                  UIScreen.mainScreen.bounds.size.height / 2);

    self.collectionView.delegate = self;
    
    Carusel *layout = [[Carusel alloc] init];
    layout.itemSize = self.sizeForItem;
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
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

#pragma mark - UICollectionViewDataSource

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

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    self.sizeForItem = [self sizeForItem:self.collectionView];
    return self.sizeForItem;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return self.sectionInsets;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return self.sectionInsets.left;
}

- (CGSize)sizeForItem:(UICollectionView *)collectionView {
    
    CGFloat widthPaddingSpace = self.sectionInsets.left * 2;
    CGFloat heightPaddingSpace = self.sectionInsets.top;
    CGFloat availableWidth = self.collectionView.frame.size.width - widthPaddingSpace;
    CGFloat widthPerItem = floor(availableWidth / 2);
    CGFloat availableHeight = self.collectionView.frame.size.height - heightPaddingSpace;
    CGFloat heightPerItem = floor(availableHeight);

    return CGSizeMake(widthPerItem, heightPerItem);
}

@end
