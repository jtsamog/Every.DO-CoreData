//
//  TodoCell.m
//  Every.DO-CoreData
//
//  Created by Endeavour2 on 7/20/17.
//  Copyright © 2017 SamOg. All rights reserved.
//

#import "TodoCell.h"
#import "Todo+CoreDataClass.h"

@interface TodoCell()
//@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
//@property (weak, nonatomic) IBOutlet UILabel *todoDescriptionLabel;
//@property (weak, nonatomic) IBOutlet UILabel *priorityLabel;
@property (nonatomic) Todo *todoObj;


@end


@implementation TodoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setToDo:(Todo *)toDo {
  _todoObj = toDo;
  [self configure];
  
}
-(void)configure{
  
  NSString *string = [[self.todoObj.todoDescription componentsSeparatedByString:@" "]objectAtIndex:0];
  
  if (self.todoObj.isDone == NO) {
    self.titleLabel.text = self.todoObj.title;
    self.todoDescriptionLabel.text = [NSString stringWithFormat:@"%@...",string];
    self.priorityLabel.text = [NSString stringWithFormat:@"P: %i", self.todoObj.priorityNumber];
  }else{
    NSMutableAttributedString *striked = [[NSMutableAttributedString alloc]initWithString:self.todoObj.title];
    [striked addAttribute:NSStrikethroughStyleAttributeName value:@2 range:NSMakeRange(0, [striked length])];
  }
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
