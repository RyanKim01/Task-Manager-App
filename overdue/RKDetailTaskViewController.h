//
//  RKDetailTaskViewController.h
//  overdue
//
//  Created by CLICC User on 3/4/15.
//  Copyright (c) 2015 RyanKim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RKTaskmodel.h"
#import "RKEditTaskViewController.h"

@protocol RKDetailTaskViewControllerDelegate <NSObject>

-(void)updateTask;

@end

@interface RKDetailTaskViewController : UIViewController <RKEditTaskViewControllerDelegate>

@property (strong, nonatomic) RKTaskmodel *task;
@property (weak, nonatomic) id <RKDetailTaskViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *detailLabel;
- (IBAction)editBarButtonItemPressed:(UIBarButtonItem *)sender;

@end
