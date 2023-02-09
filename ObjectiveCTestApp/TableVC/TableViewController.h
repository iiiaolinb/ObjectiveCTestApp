//
//  TableViewController.h
//  ObjectiveCTestApp
//
//  Created by Егор Худяев on 26.01.2023.
//

#import "UIKit/UIKit.h"

//NS_ASSUME_NONNULL_BEGIN

@interface TableViewController : UITableViewController

@property (nonatomic, nullable) NSArray * pocemons;

- (void)showAlertController;

@end

//NS_ASSUME_NONNULL_END
