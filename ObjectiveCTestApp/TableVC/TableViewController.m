//
//  TableViewController.m
//  ObjectiveCTestApp
//
//  Created by Егор Худяев on 26.01.2023.
//

#import "TableViewController.h"
#import "CollectionViewController.h"
#import "URLHelper.h"
#import "TableVCPresenter.h"

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchBar.delegate = self;
    
    self.presenter = [[TableVCPresenter alloc] init];
    [self.presenter initWithView:self];
    
    [self.presenter createDataModel:^(NSMutableArray * _Nullable content) {
        self.searchTag = content;
        self.pocemons = content;
    }];
    
    [self setTitle:@"Top tags"];
    self.navigationController.navigationBar.backgroundColor = UIColor.whiteColor;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:true];
    self.navigationController.navigationBar.backgroundColor = UIColor.whiteColor;
}

#pragma mark - TableVCPresenterOutput



#pragma mark - SearchBar delegate func

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    [self.presenter searchTag:searchText inList:self.pocemons :^(NSMutableArray * _Nullable result) {
        self.searchTag = result;
        [self.tableView reloadData];
    }];
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
    [self.presenter prepareForSegue:segue sender:sender];
}

@end
