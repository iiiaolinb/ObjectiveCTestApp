//
//  Carusel.m
//  ObjectiveCTestApp
//
//  Created by Егор Худяев on 09.03.2023.
//

#import "Carusel.h"
#import "HorizontalProperties.h"
#import "PropertiesProtocol.h"

@interface Carusel ()

@property(nonatomic, strong) NSIndexPath *indexPathForCenteredItem;

@property(nonatomic, strong) id <PropertiesProtocol> properties;

@end

@implementation Carusel

#pragma mark - Preparing Layout

- (void)prepareLayout {
    [super prepareLayout];

    self.properties = [[HorizontalProperties alloc] initWithLayout:self];
}

- (CGSize)collectionViewContentSize {
    return self.properties.contentRect.size;
}

#pragma mark - Attributes

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    CGFloat combinedItemWidth = self.itemSize.width + self.interItemSpace;

    CGFloat minimalXPosition = CGRectGetMinX(rect) - self.properties.contentStart;
    CGFloat maximalXPosition = CGRectGetMaxX(rect) - self.properties.contentStart;

    CGFloat firstVisibleItem = floorf(minimalXPosition / combinedItemWidth);
    CGFloat lastVisibleItem = ceilf(maximalXPosition / combinedItemWidth);

    if (firstVisibleItem < 0) {
        firstVisibleItem = 0;
    }

    if (lastVisibleItem > [[self collectionView] numberOfItemsInSection:0]) {
        lastVisibleItem = [[self collectionView] numberOfItemsInSection:0];
    }

    NSMutableArray *layoutAttributes = [NSMutableArray array];

    for (NSInteger j = (NSInteger) firstVisibleItem; j < lastVisibleItem; j++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:j inSection:0];
        [layoutAttributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }

    return layoutAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [[[self class] layoutAttributesClass] layoutAttributesForCellWithIndexPath:indexPath];

    CGRect bounds = CGRectZero;
    bounds.size = self.itemSize;

    attributes.bounds = bounds;
    attributes.center = [self.properties centerForItemAtIndexPath:indexPath];

    return attributes;
}

#pragma mark - Target Content Offset

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    
    CGPoint targetContentOffset = proposedContentOffset;
    UICollectionViewLayoutAttributes *layoutAttributesForItemToCenterOn = [self layoutAttributesForUserFingerMovingWithVelocity:velocity proposedContentOffset:proposedContentOffset];

    if (layoutAttributesForItemToCenterOn) {
        targetContentOffset.x = layoutAttributesForItemToCenterOn.center.x - self.collectionView.bounds.size.width / 2;
        targetContentOffset.y = 0;
        self.indexPathForCenteredItem = layoutAttributesForItemToCenterOn.indexPath;
    }

    return targetContentOffset;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset {
    UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:self.indexPathForCenteredItem];
    CGPoint targetContentOffset = proposedContentOffset;

    if (attributes) {
        targetContentOffset.x = attributes.center.x - self.collectionView.bounds.size.width / 2;
        targetContentOffset.y = 0;
    }

    return targetContentOffset;
}

#pragma mark - Helpers

- (UICollectionViewLayoutAttributes *)layoutAttributesForUserFingerMovingWithVelocity:(CGPoint)velocity proposedContentOffset:(CGPoint)offset {
    
    UICollectionViewLayoutAttributes *layoutAttributesForItemToCenterOn = nil;
    CGRect nextVisibleBounds = [self collectionView].bounds;
    nextVisibleBounds.origin = offset;

    NSPredicate *itemsPredicate = [NSPredicate predicateWithFormat:@"representedElementCategory == %d",
                                                                   UICollectionElementCategoryCell];
    NSArray *layoutAttributesInRect = [[self layoutAttributesForElementsInRect:nextVisibleBounds] filteredArrayUsingPredicate:itemsPredicate];

    if (velocity.x > 0.0f) {
        layoutAttributesForItemToCenterOn = [layoutAttributesInRect lastObject];
    }
    else if (velocity.x < 0.0f) {
        layoutAttributesForItemToCenterOn = [layoutAttributesInRect firstObject];
    }
    else {
        CGFloat distanceToCenter = CGFLOAT_MAX;

        for (UICollectionViewLayoutAttributes *attributes in layoutAttributesInRect) {
            CGFloat midOfFrame = CGRectGetMidX(self.collectionView.frame);
            CGFloat center = self.collectionView.contentOffset.x + midOfFrame;

            CGFloat distance = ABS(center - attributes.center.x);

            if (distance < distanceToCenter) {
                distanceToCenter = distance;
                layoutAttributesForItemToCenterOn = attributes;
            }
        }
    }

    return layoutAttributesForItemToCenterOn;
}

#pragma mark - Invalidating Layout

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return !CGSizeEqualToSize(self.collectionView.bounds.size, newBounds.size);
}

#pragma mark - Overridden Setters

- (void)setItemSize:(CGSize)itemSize {
    if (!CGSizeEqualToSize(_itemSize, itemSize)) {
        _itemSize = itemSize;
        [self invalidateLayout];
    }
}

@end

