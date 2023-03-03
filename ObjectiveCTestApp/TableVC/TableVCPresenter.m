//
//  TableVCPresenter.m
//  ObjectiveCTestApp
//
//  Created by Егор Худяев on 03.03.2023.
//

#import "TableVCPresenter.h"

@implementation TableVCPresenterImpl

@synthesize view;

- (void)initWithView:(id<TableVCProtocol>)view {
    self.view = view;
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





@end
