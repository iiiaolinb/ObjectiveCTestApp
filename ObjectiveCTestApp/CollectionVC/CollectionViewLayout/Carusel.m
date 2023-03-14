//
//  Carusel.m
//  ObjectiveCTestApp
//
//  Created by Егор Худяев on 09.03.2023.
//

#import "Carusel.h"

@interface Carusel ()

@property(nonatomic) CGFloat scaleOffset;
@property(nonatomic) CGFloat scaleFactor;
@property(nonatomic) CGFloat alphaFactor;
@property(nonatomic) CGFloat lineSpacing;
@property(nonatomic) CGFloat rotationAngle;

@end

@implementation Carusel

- (instancetype)init
{
    self.scaleOffset = 200;
    self.scaleFactor = 0.5;
    self.alphaFactor = 0.5;
    self.lineSpacing = 15;
    self.rotationAngle = 0.5 * M_PI;
    
    self = [super init];
    if (self) {
        self.minimumLineSpacing = self.lineSpacing;
    }
    return self;
}

#pragma mark - Attributes

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {

    NSArray *superAttributes = [super layoutAttributesForElementsInRect:rect];
    
    CGPoint contentOffset = self.collectionView.contentOffset;
    CGSize size = self.collectionView.bounds.size;
    
    CGRect visibleRect = CGRectMake(contentOffset.x, contentOffset.y, size.width, size.height);
    CGFloat visibleCenterX = CGRectGetMidX(visibleRect);
    
    NSMutableArray *newAttributesArray = [[NSMutableArray alloc] initWithArray:superAttributes copyItems:TRUE];
    
        //set up base transform
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1.0/500.0;
    transform = CATransform3DTranslate(transform, -CGSizeZero.width, -CGSizeZero.height, 0.0);
    
    for (UICollectionViewLayoutAttributes *attribute in newAttributesArray) {
    
        CGFloat distanceFromCenter = visibleCenterX - attribute.center.x;
        CGFloat absDistanceFromCenter = fmin(fabs(distanceFromCenter), self.scaleOffset);

        CGFloat scale = (absDistanceFromCenter * (self.scaleFactor - 1)) / self.scaleOffset + 1;
        CGFloat rotate = (distanceFromCenter * self.rotationAngle) / self.scaleOffset;
        CGFloat alpha = absDistanceFromCenter * (self.alphaFactor - 1) / self.scaleOffset + 1;

        transform = CATransform3DTranslate(transform, 0, 0, 0);
        attribute.transform3D = CATransform3DConcat(CATransform3DScale(transform, 1.5 * scale, 1.5 * scale, 1),
                                                    CATransform3DRotate(transform, rotate, 0, 1, 0));
        attribute.alpha = alpha;
    }
    
    return newAttributesArray;
}

#pragma mark - Target Content Offset

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    
    CGRect proposedRect = CGRectMake(proposedContentOffset.x, 0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    
    NSArray *layoutAttributes = [self layoutAttributesForElementsInRect:proposedRect];
    
    UICollectionViewLayoutAttributes *candidateAttributes;
    CGFloat proposedContentOffsetCenterX = proposedContentOffset.x + self.collectionView.bounds.size.width / 2;
    
    for (UICollectionViewLayoutAttributes *attributes in layoutAttributes) {
        if (attributes.representedElementCategory != UICollectionElementCategoryCell) {
            continue;
        }
        
        if (candidateAttributes == nil) {
            candidateAttributes = attributes;
            continue;
        }
        
        if (fabs(attributes.center.x - proposedContentOffsetCenterX) < fabs(candidateAttributes.center.x - proposedContentOffsetCenterX)) {
            candidateAttributes = attributes;
        }
    }
    
    UICollectionViewLayoutAttributes *aCandidateAttributes = candidateAttributes;
    CGFloat newOffsetX = aCandidateAttributes.center.x - self.collectionView.bounds.size.width / 2;
    CGFloat offset = newOffsetX - self.collectionView.contentOffset.x;
    
    if ((velocity.x < 0 && offset > 0) || (velocity.x > 0 && offset < 0)) {
        CGFloat pageWidth = self.itemSize.width + self.minimumLineSpacing;
        newOffsetX += velocity.x > 0 ? pageWidth : -pageWidth;
    }
    
    return CGPointMake(newOffsetX, proposedContentOffset.y);
}

#pragma mark - Config Content Insets

- (void) configureContentInset {
    CGFloat inset = self.collectionView.bounds.size.width / 2 - self.itemSize.width / 2;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, inset, 0, inset);
    self.collectionView.contentOffset = CGPointMake(-inset, 0);
}

#pragma mark - Invalidating Layout

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return TRUE;
}

- (void)invalidateLayoutWithContext:(UICollectionViewLayoutInvalidationContext *)context {
    [super invalidateLayoutWithContext:context];
    if ((self.collectionView.bounds.size.width != self.lastCollectionViewSize.width) && (self.collectionView.bounds.size.height != self.lastCollectionViewSize.height)) {
        [self configureContentInset];
        self.lastCollectionViewSize = self.collectionView.bounds.size;
    }
}

@end

