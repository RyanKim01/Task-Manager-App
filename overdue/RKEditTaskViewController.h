//
//  RKEditTaskViewController.h
//  overdue
//
//  Created by CLICC User on 3/4/15.
//  Copyright (c) 2015 RyanKim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RKTaskmodel.h"

@protocol RKEditTaskViewControllerDelegate <NSObject>

-(void)didUpdateTask;

@end


@interface RKEditTaskViewController : UIViewController <UITextViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) id <RKEditTaskViewControllerDelegate> delegate;
@property (strong, nonatomic) RKTaskmodel *task;

@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
- (IBAction)saveBarButtonItemPressed:(UIBarButtonItem *)sender;

@end
