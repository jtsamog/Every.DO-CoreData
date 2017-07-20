//
//  DetailViewController.h
//  Every.DO-CoreData
//
//  Created by Endeavour2 on 7/20/17.
//  Copyright © 2017 SamOg. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Todo;

@interface DetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *detailTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailPriorityLabel;
@property (strong, nonatomic) Todo *detailItem;

@end
