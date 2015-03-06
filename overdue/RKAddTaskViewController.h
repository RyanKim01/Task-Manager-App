//
//  RKAddTaskViewController.h
//  overdue
//
//  Created by CLICC User on 3/4/15.
//  Copyright (c) 2015 RyanKim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RKTaskmodel.h"
@protocol RKAddTaskViewControllerDelegate

-(void)didCancel;
-(void)didAddTask:(RKTaskmodel *)task;

@end

@interface RKAddTaskViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>

@property (weak, nonatomic) id <RKAddTaskViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
- (IBAction)addTaskButtonPressed:(UIButton *)sender;
- (IBAction)cancelButtonPressed:(UIButton *)sender;

@end
