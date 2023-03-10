//
//  TableViewController.h
//  ObjectiveCTestApp
//
//  Created by Егор Худяев on 26.01.2023.
//

#import "UIKit/UIKit.h"
#import "TableVCPresenterInput.h"
#import "TableVCPresenterOutput.h"

@interface TableViewController : UITableViewController <UISearchBarDelegate, TableVCPresenterOutput>

@property (strong, nonatomic) IBOutlet UISearchBar * _Nullable searchBar;
@property (nonatomic, nullable) NSMutableArray * pocemons;
@property (nonatomic, nullable) NSMutableArray * searchTag;

@property _Nullable id <TableVCPresenterInput> presenter;

@end
