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
    [URLHelper fetchPocemonsList:^(NSArray * _Nullable list) {
        self.pocemons = list;
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.pocemons.count != 0) {
                NSLog(@"NOT WORK");
                [self.tableView reloadData];
            } else {
                NSLog(@"WORK");
                [self showAlertController];
            }
        });
    }];
    
    [self setTitle:@"Pocemons"];
}

- (void)showAlertController {
    UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"Oooops"
                                     message:@"Check your connection!"
                                     preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction* okButton = [UIAlertAction
                                    actionWithTitle:@"Ok"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
        
                                    }];
    [alert addAction:okButton];

    [self presentViewController:alert animated:YES completion:nil];
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
