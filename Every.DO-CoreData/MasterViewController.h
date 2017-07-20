//
//  MasterViewController.h
//  Every.DO-CoreData
//
//  Created by Endeavour2 on 7/20/17.
//  Copyright © 2017 SamOg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddTodoViewController.h"

@interface MasterViewController : UITableViewController <AddTodoDelegate>


-(void)addNewToDoData:(Todo *)newTodoItem;

@end
