//
//  ImageViewerVC.m
//  ObjectiveCTestApp
//
//  Created by Егор Худяев on 27.01.2023.
//

#import "ImageViewerVC.h"
#import "URLHelper.h"

@interface ImageViewerVC ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ImageViewerVC

@synthesize images, indexPath;

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.imageView.image = images[indexPath];
    self.navigationController.navigationBar.backgroundColor = UIColor.blackColor;
}

-(void)transferImages:(NSMutableArray *)transmitedImages :(long)selectedIndexPath
{
    images = transmitedImages;
    indexPath = selectedIndexPath;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
        UITouch *touch = [touches anyObject];
        gestureStartPoint = [touch locationInView:self.view];
  }

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint currentPosition = [touch locationInView:self.view];

    CGFloat deltaX = gestureStartPoint.x - currentPosition.x;

    if (deltaX >= kMinimumGestureLength && (images.count - 1) > indexPath) {
        indexPath += 1;
        self.imageView.image = images[indexPath];
    } else if (deltaX <= -kMinimumGestureLength && indexPath > 0) {
        indexPath -= 1;
        self.imageView.image = images[indexPath];
    }
}

@end
