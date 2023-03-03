//
//  TableVCPresenter.h
//  ObjectiveCTestApp
//
//  Created by Егор Худяев on 03.03.2023.
//

#import "UIKit/UIKit.h"
#import <Foundation/Foundation.h>

@protocol TableVCProtocol

@property (nonatomic, strong) id <TableVCProtocol> view;

- (void) initWithView: (id <TableVCProtocol>) view;
- (void) showAlertController: (UITableViewController *)vc;

@end

@interface TableVCPresenterImpl : NSObject <TableVCProtocol>

- (void) showAlertController: (UITableViewController *)vc;

@end

//@protocol TableVCPresenterOutput <NSObject>
//
//- (void)showAlertController:(UITableViewController *)vc;
//
//@end
//
//@interface TableVCPresenterImpl : NSObject
//
//@end
