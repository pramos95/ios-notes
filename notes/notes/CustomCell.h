//
//  CustomCell.h
//  notes
//
//  Created by Pedro Ramos on 7/12/19.
//  Copyright © 2019 Pedro Ramos. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *content;

@end

NS_ASSUME_NONNULL_END
