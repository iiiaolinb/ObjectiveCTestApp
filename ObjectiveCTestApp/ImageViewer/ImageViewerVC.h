//
//  ImageViewerVC.h
//  ObjectiveCTestApp
//
//  Created by Егор Худяев on 27.01.2023.
//

#import <UIKit/UIKit.h>

#define kMinimumGestureLength  70

NS_ASSUME_NONNULL_BEGIN

@interface ImageViewerVC : UIViewController {
    CGPoint gestureStartPoint;
}

@property (nonatomic) NSMutableArray *images;
@property (nonatomic) long indexPath;

-(void)transferImages:(NSMutableArray *)transmitedImages :(long)selectedIndexPath;

@end

NS_ASSUME_NONNULL_END
