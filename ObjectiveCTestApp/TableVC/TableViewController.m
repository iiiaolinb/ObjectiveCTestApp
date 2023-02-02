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
    [self fetchPocemons];
    
    [self setTitle:@"Pocemons"];
}

-(IBAction)fetchPocemons{
    
    NSURL *url = [URLHelper URLPocemonsNames];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDownloadTask *task = [session downloadTaskWithURL:url
                                                completionHandler:
        ^(NSURL *location, NSURLResponse *response, NSError *error) {
        
              if (!error) {
                  NSData *jsonResults = [NSData dataWithContentsOfURL:url];
                  NSDictionary *results = [NSJSONSerialization JSONObjectWithData:jsonResults
                                                                          options:0
                                                                            error:NULL];
                  NSArray *places = [results valueForKeyPath:@"results"];
                  NSArray *pocemons = [places valueForKey:@"name"];
                  self.pocemons = pocemons;
              } else {
                  NSLog(@"Error fetching pocemons");
              }
              dispatch_async(dispatch_get_main_queue(), ^{
                  self.tableView.reloadData;
              });
            }];
    [task resume];
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
