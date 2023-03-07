//
//  CollectionVCPresenterInput.h
//  ObjectiveCTestApp
//
//  Created by Егор Худяев on 06.03.2023.
//

#import "UIKit/UIKit.h"
#import "CollectionVCPresenterOutput.h"
//#import "CollectionViewController.h"

#pragma mark: view -> presenter

@protocol CollectionVCPresenterInput <NSObject>

//@property (nonatomic, strong) UICollectionViewController * view;
@property UICollectionViewController <CollectionVCPresenterOutput> * view;

- (void)initWithView: (UICollectionViewController *) view;
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender withImages:(NSMutableArray *)images;
- (void)setPocemons:(NSString *)pocemonsName :(void(^)(NSMutableArray * result))completion;

@end
