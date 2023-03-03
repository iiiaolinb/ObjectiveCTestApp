//
//  TableViewController.m
//  ObjectiveCTestApp
//
//  Created by Егор Худяев on 26.01.2023.
//

#import "TableViewController.h"
#import "CollectionViewController.h"
#import "URLHelper.h"

//@interface TableViewController ()
//
//@end

@implementation TableViewController

//@synthesize presenter;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchBar.delegate = self;
    
    self.presenter = [[TableVCPresenterImpl alloc] init];
    [self.presenter initWithView:self];

    [URLHelper fetchPocemonsList:^(NSArray * _Nullable list) {
        self.pocemons = list;
        self.searchTag = list;
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.pocemons.count != 0) {
                [self.tableView reloadData];
            } else {
                [self.presenter showAlertController:self];
            }
        });
    }];
    
    [self setTitle:@"Top tags"];
    self.navigationController.navigationBar.backgroundColor = UIColor.whiteColor;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:true];
    self.navigationController.navigationBar.backgroundColor = UIColor.whiteColor;
}

//- (void)showAlertController {
//    [self.presenter showAlertController];
//}

#pragma mark - SearchBar delegate func

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        NSMutableArray *newArray = NSMutableArray.new;
        for (NSString *tag in self.pocemons) {
            if ([tag isEqual:[searchText lowercaseString]]) {
                [newArray addObject:tag];
            }
        }
        if (searchText.length!=0) {
            self.searchTag = newArray;
            [self.tableView reloadData];
        } else {
            self.searchTag = self.pocemons;
            [self.tableView reloadData];
        }
    });
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.searchTag.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = self.searchTag[indexPath.row];

    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        NSIndexPath *indexPath =[self.tableView indexPathForCell:sender];
        if (indexPath) {
            if ([segue.identifier isEqualToString:@"PocemonsImages"]) {
                if ([segue.destinationViewController isKindOfClass:[CollectionViewController class]]) {
                    
                    [segue.destinationViewController setPocemon:[[sender textLabel] text]];
                    [segue.destinationViewController setTitle:[[sender textLabel] text]];
                    
                }
            }
        }
    }
}

@end
