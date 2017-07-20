//
//  MasterViewController.m
//  Every.DO-CoreData
//
//  Created by Endeavour2 on 7/20/17.
//  Copyright © 2017 SamOg. All rights reserved.
//

#import "MasterViewController.h"
#import "TodoCell.h"
#import "Todo+CoreDataClass.h"
#import "DetailViewController.h"
#import "AddTodoViewController.h"
#import "AppDelegate.h"
@import CoreData;

@interface MasterViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSManagedObjectContext *context;
@property (nonatomic) AppDelegate *delegate;
@property (nonatomic) Todo *todo;
@property NSMutableArray *objects;
@property (nonatomic) NSArray <Todo*>*todos;

@end

@implementation MasterViewController
@dynamic tableView;


- (void)createData {
//  Todo *t1 = [[Todo alloc] initWithTitle:@"Lecture1" Description:@"iOS Dev: Objective-C" Priority:1];
//  Todo *t2 = [[Todo alloc] initWithTitle:@"Lecture2" Description:@"iOS Dev: Swift" Priority:2];
//  Todo *t3 = [[Todo alloc] initWithTitle:@"Lecture3" Description:@"iOS Dev: Foundation" Priority:3];
//  Todo *t4 = [[Todo alloc] initWithTitle:@"Lecture4" Description:@"iOS Dev: Cocoa" Priority:4];
//  
//  //  self.todos = @[t1, t2, t3, t4];
//  self.objects = [@[t1, t2, t3, t4] mutableCopy];
//  
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.tableView.dataSource = self;
  self.delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
  self.context = self.delegate.persistentContainer.viewContext;
  
  self.todos = @[];
  self.objects = [[NSMutableArray alloc] init];
  [self createData];
  
  
  UISwipeGestureRecognizer *swipeToRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeToCompleteTodo:)];
  [self.tableView addGestureRecognizer:swipeToRight];
  
  self.navigationItem.leftBarButtonItem = self.editButtonItem;
  
  UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
  self.navigationItem.rightBarButtonItem = addButton;
}


- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self fetchWithSort];
  [self.tableView reloadData];

}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)setTodos:(NSArray<Todo *> *)todos {
  _todos = todos;
  [self.tableView reloadData];

}

- (void)fetchWithSort{
  NSSortDescriptor *prioritySort = [NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES];
  NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Todo"];
  request.sortDescriptors = @[prioritySort];
  NSArray <Todo*>*result = [self.context executeFetchRequest:request error:nil];
  self.objects = [result mutableCopy];
}

- (void)insertNewObject:(id)sender {
  
  [self performSegueWithIdentifier:@"addItem" sender:nil];
  
  //  if (!self.objects) {
  //      self.objects = [[NSMutableArray alloc] init];
  //  }
  //  [self.objects insertObject:[NSDate date] atIndex:0];
  //  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
  //  [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)addNewToDoData:(Todo *)newTodoItem {
  [self.objects addObject:newTodoItem];
  [self.objects removeObject:newTodoItem];
  [self.objects insertObject:newTodoItem atIndex:0];
  [self.tableView reloadData];
  
  //  [self.navigationController popViewControllerAnimated:true];
  
}

- (void)deleteData {
  
  

  
//  - (void)deleteObject {
//    Person *iggy = [self fetchWithFilter];
//    [self.context deleteObject:iggy];
//    [self saveContext];
  
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([[segue identifier] isEqualToString:@"showDetail"]) {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    self.todo = self.objects[indexPath.row];
    DetailViewController *controller = (DetailViewController *)[segue destinationViewController];
    [controller setDetailItem:self.todo];
  } else if ([segue.identifier isEqualToString:@"addItem"]) {
    AddTodoViewController *avc = (AddTodoViewController *)[segue destinationViewController];
    avc.todoDelegate = self;
  }
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  TodoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
  
  //  Todo *todo = self.objects[indexPath.row];
  
  Todo *t = self.objects[indexPath.row];
//  [cell setToDo:self.todo];
  cell.titleLabel.text = t.title;
  cell.todoDescriptionLabel.text = t.todoDescription;
  cell.priorityLabel.text = [NSNumber numberWithInt:t.priorityNumber].stringValue;
  return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
  // Return NO if you do not want the specified item to be editable.
  return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
  if (editingStyle == UITableViewCellEditingStyleDelete) {
    [self.objects removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
  } else if (editingStyle == UITableViewCellEditingStyleInsert) {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
  }
}


-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
  if(sourceIndexPath != destinationIndexPath){
    Todo *todoObject = [self.objects objectAtIndex:sourceIndexPath.row];
    [self.objects removeObjectAtIndex:sourceIndexPath.row];
    [self.objects insertObject:todoObject atIndex:destinationIndexPath.row];
    [self.tableView reloadData];
    
  }
}

- (IBAction)swipeToCompleteTodo:(UISwipeGestureRecognizer *)sender {
  CGPoint currentPoint = [sender locationInView:self.tableView];
  NSIndexPath *index = [self.tableView indexPathForRowAtPoint:currentPoint];
  NSIndexPath *lastindex = [NSIndexPath indexPathForRow:self.objects.count-1 inSection:0];
  
  if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
    Todo *markTodo = self.objects[index.row];
    if (markTodo.isDone == NO) {
      markTodo.isDone = YES;
    }
    [self tableView:self.tableView moveRowAtIndexPath:index toIndexPath:lastindex];
    [self.tableView reloadData];
  }
}

@end
