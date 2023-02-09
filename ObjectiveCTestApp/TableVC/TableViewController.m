//
//  TableViewController.m
//  ObjectiveCTestApp
//
//  Created by Егор Худяев on 26.01.2023.
//

#import "TableViewController.h"
#import "CollectionViewController.h"
#import "URLHelper.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [URLHelper fetchPocemonsList:^(NSArray * list) {
        self.pocemons = list;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
    
    [self setTitle:@"Pocemons"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {    
    return self.pocemons.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = self.pocemons[indexPath.row];

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
