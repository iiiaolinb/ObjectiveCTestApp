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
}

- (void)setPocemon:(NSString *)pocemonsName
{
    _pocemonsName = pocemonsName;
    [self fetchPocemonsImages];
}
- (IBAction)fetchPocemonsImages
{
    NSURL *url = [URLHelper URLPocemonsImages:_pocemonsName];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDownloadTask *task = [session downloadTaskWithURL:url
                                                completionHandler:
              ^(NSURL *location, NSURLResponse *response, NSError *error) {
        
                  if (!error) {
                      NSData *jsonResults = [NSData dataWithContentsOfURL:url];
                      NSDictionary *results = [NSJSONSerialization JSONObjectWithData:jsonResults
                                                                              options:0
                                                                                error:NULL];
                      NSArray *images = [results valueForKeyPath:@"sprites"];
                      
                      NSMutableArray *arr = [NSMutableArray array];
                      [arr addObject:[images valueForKeyPath:@"back_default"]];
                      [arr addObject:[images valueForKeyPath:@"back_female"]];
                      [arr addObject:[images valueForKeyPath:@"back_shiny"]];
                      [arr addObject:[images valueForKeyPath:@"back_shiny_female"]];
                      [arr addObject:[images valueForKeyPath:@"front_default"]];
                      [arr addObject:[images valueForKeyPath:@"front_female"]];
                      [arr addObject:[images valueForKeyPath:@"front_shiny"]];
                      [arr addObject:[images valueForKeyPath:@"front_shiny_female"]];
                      
                      self.array = arr;

                  } else {
                      NSLog(@"Error fetching pocemons images");
                  }

        [self asyncLoadImages];
                    
    }];
    [task resume];
}

-(void)asyncLoadImages
{
    NSMutableArray *img = [NSMutableArray array];
                  
    dispatch_group_t dispatchGroup = dispatch_group_create();

    for (int i = 0; i < self.array.count; i++) {
        if (self.array[i] != [NSNull null]) {

            dispatch_group_enter(dispatchGroup);

            NSURL *url = [URLHelper URLForQuery:self.array[i]];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            NSURLSession *session = [NSURLSession sharedSession];
                
            NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request
                                                            completionHandler:
                ^(NSURL *localfile, NSURLResponse *response, NSError *error) {
                
                    if (!error) {
                        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:localfile]];
                        [img addObject:image];
                    } else {
                        NSLog(@"Error loading pocemons image");
                    }
                
                dispatch_group_leave(dispatchGroup);
                }];
            
            [task resume];
        }
    }
    
    self.images = img;
    
    dispatch_group_notify(dispatchGroup, dispatch_get_main_queue(), ^{
        self.collectionView.reloadData;
    });
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
    cell.imageView.image = self.images[indexPath.row];
    
    return cell;
}

@end
