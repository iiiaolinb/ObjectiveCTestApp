//
//  TableViewController.h
//  ObjectiveCTestApp
//
//  Created by Егор Худяев on 26.01.2023.
//

#import "UIKit/UIKit.h"

//NS_ASSUME_NONNULL_BEGIN

@interface TableViewController : UITableViewController <UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar * _Nullable searchBar;
@property (nonatomic, nullable) NSArray * pocemons;
@property (nonatomic, nullable) NSArray * searchTag;

- (void)showAlertController;

@end

//NS_ASSUME_NONNULL_END
