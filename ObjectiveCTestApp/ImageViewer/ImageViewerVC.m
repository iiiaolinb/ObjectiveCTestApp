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

@synthesize image;

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.imageView.image = image;
}

-(void)setImage:(UIImage *)transmittedImage
{
    image = transmittedImage;
}

@end
