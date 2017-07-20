//
//  DetailViewController.m
//  Every.DO-CoreData
//
//  Created by Endeavour2 on 7/20/17.
//  Copyright © 2017 SamOg. All rights reserved.
//

#import "DetailViewController.h"
#import "Todo+CoreDataClass.h"

@interface DetailViewController ()


@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  [self configureView];
    // Do any additional setup after loading the view.
}

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
  if (_detailItem != newDetailItem) {
    _detailItem = newDetailItem;
    
    // Update the view.
    [self configureView];
  }
}


- (void)configureView {
  // Update the user interface for the detail item.
  if (self.detailItem) {
    //      self.detailDescriptionLabel.text = [self.detailItem description];
    
    self.detailTitleLabel.text = self.detailItem.title;
    self.detailDescriptionLabel.text = self.detailItem.todoDescription;
    self.detailPriorityLabel.text = [NSNumber numberWithInt:self.detailItem.priorityNumber].stringValue;
    
  }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
