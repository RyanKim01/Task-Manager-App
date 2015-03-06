//
//  RKViewController.h
//  overdue
//
//  Created by CLICC User on 3/4/15.
//  Copyright (c) 2015 RyanKim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RKAddTaskViewController.h"
#import "RKDetailTaskViewController.h"

@interface RKViewController : UIViewController <RKAddTaskViewControllerDelegate, UITableViewDataSource, UITableViewDelegate, RKDetailTaskViewControllerDelegate>

@property (strong, nonatomic) NSMutableArray *taskObjects;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)reorderBarButtonItemPressed:(UIBarButtonItem *)sender;
- (IBAction)addTaskBarButtonItemPressed:(UIBarButtonItem *)sender;

-(BOOL)isDateGreaterThanDate:(NSDate *)date and:(NSDate *)toDate;

@end
