//
//  ImageViewerVC.h
//  ObjectiveCTestApp
//
//  Created by Егор Худяев on 27.01.2023.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImageViewerVC : UIViewController

@property (nonatomic, strong) UIImage *image;

-(void)setImage:(UIImage *)transmittedImage;

@end

NS_ASSUME_NONNULL_END
