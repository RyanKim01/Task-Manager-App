//
//  RKViewController.m
//  overdue
//
//  Created by CLICC User on 3/4/15.
//  Copyright (c) 2015 RyanKim. All rights reserved.
//

#import "RKViewController.h"
#import "RKAddTaskViewController.h"
#import "RKTaskmodel.h"
#import "RKEditTaskViewController.h"

@interface RKViewController ()

@end

@implementation RKViewController

#pragma mark -Lazy iNSTANTIATION OF properties

-(NSMutableArray *)taskObjects
{
    if (!_taskObjects) {
        _taskObjects = [[NSMutableArray alloc]init];
    }
    return _taskObjects;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    NSArray *taskObjectAsAPropertyLists = [[NSUserDefaults standardUserDefaults] arrayForKey:OBJECTSKEY];
    for (NSDictionary *dictionary in taskObjectAsAPropertyLists) {
        RKTaskmodel *taskObject = [self dictionaryAsATaskObject:dictionary];
        [self.taskObjects addObject:taskObject];
        
    }
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[RKAddTaskViewController class]])
    {
        RKAddTaskViewController *addTaskViewController = segue.destinationViewController;
        addTaskViewController.delegate = self;
    } else if ([segue.destinationViewController isKindOfClass:[RKDetailTaskViewController class]]) {
        
        RKDetailTaskViewController *detailViewController = segue.destinationViewController;
        NSIndexPath *path = sender;
        RKTaskmodel *taskObject = self.taskObjects[path.row];
        detailViewController.task = taskObject;
        detailViewController.delegate = self;
    } 
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)addTaskBarButtonItemPressed:(UIBarButtonItem *)sender
{
    [self performSegueWithIdentifier:@"toAddTaskViewControllerSegue" sender:nil];
}

    
#pragma mark -RKAddTaskViewControllerDelegate

-(void)didCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
    
-(void)didAddTask:(RKTaskmodel *)task
{
    [self.taskObjects addObject:task];
    
    NSLog(@"%@", task.title);
    
    NSMutableArray *taskObjectAsAPropertyLists = [[[NSUserDefaults standardUserDefaults] arrayForKey:OBJECTSKEY] mutableCopy];
    if (!taskObjectAsAPropertyLists) taskObjectAsAPropertyLists = [[NSMutableArray alloc] init];
    
    [taskObjectAsAPropertyLists addObject:[self taskObjectAsAPropertyList:task]];
    [[NSUserDefaults standardUserDefaults] setObject:taskObjectAsAPropertyLists forKey:OBJECTSKEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.tableView reloadData];
}

#pragma mark - RKDetailTaskViewControllerDelegate
-(void)updateTask
{
    [self saveTasks];
    [self.tableView reloadData];
}



#pragma mark - Helper Method

-(NSDictionary *)taskObjectAsAPropertyList:(RKTaskmodel *)taskObject
{
    NSDictionary *dictionary = @{TITLE: taskObject.title, DESCRIPTION: taskObject.description, DATE: taskObject.date, COMPLETION: @(taskObject.iscompleted)};
    
    return dictionary;

}

-(RKTaskmodel *)dictionaryAsATaskObject:(NSDictionary *)dictionary
{
    RKTaskmodel *taskObject = [[RKTaskmodel alloc]initWithData:dictionary];
    return taskObject;
}

-(BOOL)isDateGreaterThanDate:(NSDate *)date and:(NSDate *)toDate
{
    NSTimeInterval dateInterval = [date timeIntervalSince1970];
    NSTimeInterval toDateInterval = [toDate timeIntervalSince1970];
    
    if (toDateInterval >= dateInterval)
    {
                return YES;
    } else {
               return NO;
    }
}

-(void)updateCompletionOfTask:(RKTaskmodel *)task forIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *taskObjectsAsPropertyLists = [[[NSUserDefaults standardUserDefaults] arrayForKey:OBJECTSKEY]mutableCopy];
    
    if (!taskObjectsAsPropertyLists)
    {   taskObjectsAsPropertyLists = [[NSMutableArray alloc]init];
    }
    
    [taskObjectsAsPropertyLists removeObjectAtIndex:indexPath.row];
    if(task.iscompleted == YES) {
        task.iscompleted = NO;
    } else {
        task.iscompleted = YES;
    }
    [taskObjectsAsPropertyLists insertObject:[self taskObjectAsAPropertyList:task] atIndex:indexPath.row];
    [[NSUserDefaults standardUserDefaults] setObject:taskObjectsAsPropertyLists forKey:OBJECTSKEY];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [self.tableView reloadData];
}

-(void)saveTasks
{
    NSMutableArray *taskObjectsAsPropertyLists = [[NSMutableArray alloc]init];
    for (int x=0; x<[self.taskObjects count]; x++) {
        [taskObjectsAsPropertyLists addObject:[self taskObjectAsAPropertyList:self.taskObjects[x]]];
    }
    [[NSUserDefaults standardUserDefaults] setObject:taskObjectsAsPropertyLists forKey:OBJECTSKEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}



#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.taskObjects count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    //configure the cell...
    RKTaskmodel *task = [self.taskObjects objectAtIndex:indexPath.row];
    cell.textLabel.text = task.title;
  
    

    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *stringFromDate = [formatter stringFromDate:task.date];
    cell.detailTextLabel.text = stringFromDate;
    


    BOOL isOverDue = [self isDateGreaterThanDate:[NSDate date] and:task.date];
    if (task.iscompleted == YES) cell.backgroundColor = [UIColor greenColor];
    else if (isOverDue == YES)
    {
        cell.backgroundColor = [UIColor yellowColor];
    } else {
        cell.backgroundColor = [UIColor redColor];
    }
    return cell;
}


#pragma mark -UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RKTaskmodel *task = self.taskObjects[indexPath.row];
    [self updateCompletionOfTask:task forIndexPath:indexPath];
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    RKTaskmodel *taskObject = [self.taskObjects objectAtIndex:sourceIndexPath.row];
    
    [self.taskObjects removeObjectAtIndex:sourceIndexPath.row];
    [self.taskObjects insertObject:taskObject atIndex:destinationIndexPath.row];
   
    [self saveTasks];
    
}


#pragma mark - Table Edit

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self.taskObjects removeObjectAtIndex:indexPath.row];
        
        NSMutableArray *newTaskObjectsData = [[NSMutableArray alloc] init];
        for (RKTaskmodel *task in self.taskObjects) {
            [newTaskObjectsData addObject:[self taskObjectAsAPropertyList:task]];
        }
        [[NSUserDefaults standardUserDefaults] setObject:newTaskObjectsData forKey:OBJECTSKEY];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        [self.tableView reloadData];
    }
}


-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"toDetailTaskViewControllerSegue" sender:indexPath];
}

#pragma mark - reordering

-(void)reorderBarButtonItemPressed:(UIBarButtonItem *)sender
{
    if (self.tableView.editing == YES) {
        [self.tableView setEditing:NO animated:YES];
    } else {
        [self.tableView setEditing:YES animated:YES];
    }
}


@end
