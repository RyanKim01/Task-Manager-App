//
//  RKAddTaskViewController.m
//  overdue
//
//  Created by CLICC User on 3/4/15.
//  Copyright (c) 2015 RyanKim. All rights reserved.
//

#import "RKAddTaskViewController.h"




@interface RKAddTaskViewController ()

@end

@implementation RKAddTaskViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.textView.delegate = self;
    self.textField.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(RKTaskmodel *)returnNewTaskObject
{
    RKTaskmodel *taskObject = [[RKTaskmodel alloc]init];
    taskObject.title = self.textField.text;
    taskObject.description = self.textView.text;
    taskObject.date = self.datePicker.date;
    taskObject.iscompleted = NO;
    
    return taskObject;
}


- (IBAction)addTaskButtonPressed:(UIButton *)sender {
    [self.delegate didAddTask:[self returnNewTaskObject]];
}

- (IBAction)cancelButtonPressed:(UIButton *)sender {
    [self.delegate didCancel];
}

#pragma  mark - UITextFieldDelegate


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.textField resignFirstResponder];
    return YES;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [self.textView resignFirstResponder];
        return NO;
    } return YES;
}


@end
