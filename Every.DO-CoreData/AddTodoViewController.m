//
//  AddTodoViewController.m
//  Every.DO-CoreData
//
//  Created by Endeavour2 on 7/20/17.
//  Copyright © 2017 SamOg. All rights reserved.
//

#import "AddTodoViewController.h"
#import "Todo+CoreDataClass.h"
#import "AppDelegate.h"

@interface AddTodoViewController ()
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField;
@property (weak, nonatomic) IBOutlet UITextField *priorityTextField;
@property (nonatomic) NSManagedObjectContext *context;
@property (nonatomic) AppDelegate *delegate;

@end

@implementation AddTodoViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
  self.context = self.delegate.context;
//  self.delegate = self.delegate.persistentContainer.viewContext; //same as above
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)doneButton:(UIButton *)sender {
  [self saveData];
  [self.navigationController popViewControllerAnimated:YES];
  
}
  - (void)saveData {
    NSString *titl = self.titleTextField.text;
    NSString *desc = self.descriptionTextField.text;
    int priority = [self.priorityTextField.text intValue];
    
    Todo *t = [[Todo alloc] initWithContext:self.context];
    t.title = titl;
    t.todoDescription = desc;
    t.priorityNumber = priority;
    [self.delegate saveContext];
    [self dismissViewControllerAnimated:YES completion:nil];
  }
  
//  Todo *newTodoData = [[Todo alloc] initWithTitle:self.titleTextField.text Description:self.descriptionTextField.text Priority:[self.priorityTextField.text intValue]];
//  [self.todoDelegate addNewToDoData:newTodoData];
//  [self dismissViewControllerAnimated:YES completion:nil]; //dismisses the view controller that was presented modally
  



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
