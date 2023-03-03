//
//  TableViewController.h
//  ObjectiveCTestApp
//
//  Created by Егор Худяев on 26.01.2023.
//

#import "UIKit/UIKit.h"
#import "TableVCPresenter.h"

//NS_ASSUME_NONNULL_BEGIN

@interface TableViewController : UITableViewController <TableVCProtocol, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar * _Nullable searchBar;
@property (nonatomic, nullable) NSArray * pocemons;
@property (nonatomic, nullable) NSArray * searchTag;

@property (nullable) TableVCPresenterImpl *presenter;

//- (void)showAlertController;

@end

//NS_ASSUME_NONNULL_END
