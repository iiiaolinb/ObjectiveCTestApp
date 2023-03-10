//
//  TableVCPresenter.m
//  ObjectiveCTestApp
//
//  Created by Егор Худяев on 03.03.2023.
//

#import "TableVCPresenter.h"
#import "CollectionViewController.h"
#import "CollectionVCPresenter.h"
#import "TableVCModel.h"

@implementation TableVCPresenter

@synthesize view;

- (void)initWithView:(UITableViewController *)view {
    self.view = view;
}

- (void)createDataModel:(void(^_Nullable)(NSMutableArray  * _Nullable content))competion {
    
    [TableVCModel createDataModel:^(NSMutableArray * _Nullable content) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (content.count != 0) {
                [self.view.tableView reloadData];
            } else {
                [self showAlertController:self.view];
            }
        });
        competion(content);
    }];
}

- (void) showAlertController: (UITableViewController *)vc; {
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

    [vc presentViewController:alert animated:YES completion:nil];
}

- (void)searchTag:(NSString *)searchText inList:(NSMutableArray *)array :(void(^)(NSMutableArray *result))completion {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        NSMutableArray *newArray = NSMutableArray.new;
        for (NSString *tag in array) {
            if ([tag containsString:[searchText lowercaseString]]) {
                [newArray addObject:tag];
            }
        }
        if (searchText.length!=0) {
            completion(newArray);
        } else {
            completion(array);
        }
    });
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        NSIndexPath *indexPath = [self.view.tableView indexPathForCell:sender];
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
