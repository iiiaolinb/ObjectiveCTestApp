//
//  TableVCPresenterInput.h
//  ObjectiveCTestApp
//
//  Created by Егор Худяев on 06.03.2023.
//

#import "UIKit/UIKit.h"
#import "TableVCModel.h"

#pragma mark: view -> presenter

@protocol TableVCPresenterInput <NSObject>

@property (nonatomic, strong) UITableViewController * _Nullable view;
//@property (nonatomic, strong) TableVCModel * _Nullable model;

- (void)initWithView: (UITableViewController *_Nullable)view;
- (void)createDataModel:(void(^_Nullable)(NSMutableArray  * _Nullable content))competion;
- (void)showAlertController: (UITableViewController *_Nullable) vc;
- (void)searchTag:(NSString *_Nullable)searchText inList:(NSMutableArray *_Nullable)array :(void(^_Nullable)(NSMutableArray * _Nullable result))completion;
- (void)prepareForSegue:(UIStoryboardSegue *_Nullable)segue sender:(id _Nullable )sender;

@end
