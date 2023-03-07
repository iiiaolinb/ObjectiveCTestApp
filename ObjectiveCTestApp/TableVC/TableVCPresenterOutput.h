//
//  TableVCPresenterOutput.h
//  ObjectiveCTestApp
//
//  Created by Егор Худяев on 06.03.2023.
//

#import "UIKit/UIKit.h"

#pragma mark: view <- presenter

@protocol TableVCPresenterOutput <NSObject>

@property (nonatomic, strong) UITableView * tableView;

@end
