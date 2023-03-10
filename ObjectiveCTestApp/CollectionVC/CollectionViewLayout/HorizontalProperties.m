//
//  HorizontalProperties.m
//  ObjectiveCTestApp
//
//  Created by Егор Худяев on 09.03.2023.
//

#import "HorizontalProperties.h"
#import "Carusel.h"


@interface HorizontalProperties ()

@property(nonatomic, readwrite) CGRect contentRect;
@property(nonatomic, readwrite) CGFloat contentStart;
@property(nonatomic) CGFloat cellYPosition;

@end

@implementation HorizontalProperties

- (instancetype)initWithLayout:(Carusel *)layout {
    self = [super init];
    if (self) {
        _layout = layout;

        [self calculateLayoutProperties];
    }

    return self;
}

#pragma mark - Calculating Layout Properties

- (void)calculateLayoutProperties {
    UICollectionView *collectionView = self.layout.collectionView;

    CGSize collectionViewSize = collectionView.bounds.size;

    CGFloat rightLeftMargin = (collectionViewSize.width - self.layout.itemSize.width) / 3;
    CGFloat topBottomMargin = (collectionViewSize.height - self.layout.itemSize.height) / 3;

    NSInteger numberOfItems = [collectionView numberOfItemsInSection:0];

    CGFloat contentWidth = numberOfItems * self.layout.itemSize.width + (numberOfItems - 1) * self.layout.interItemSpace + 2 * rightLeftMargin;
    CGFloat contentHeight = self.layout.itemSize.height + 2 * topBottomMargin;
    CGRect contentRect = CGRectMake(0, 0, contentWidth, contentHeight);
    self.contentRect = UIEdgeInsetsInsetRect(contentRect, collectionView.contentInset);

    self.contentStart = rightLeftMargin;
    self.cellYPosition = CGRectGetMidY(self.contentRect) - collectionView.contentInset.top;
}

#pragma mark - Center Calculation

- (CGPoint)centerForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat x = self.contentStart + indexPath.row * (self.layout.itemSize.width + self.layout.interItemSpace) + self.layout.itemSize.width / 2;
    return CGPointMake(x, self.cellYPosition);
}

@end

