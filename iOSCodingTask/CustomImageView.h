//
//  CustomImageView.h
//  iOSCodingTask
//
//  Created by Ahmed Elashker on 7/6/15.
//  Copyright (c) 2015 Ahmed Elashker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"

@interface CustomImageView : UIView

- (id)initWithProduct:(Product*)product;

@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) UILabel *lblPrice;

@property (nonatomic, strong) UILabel *lblDescription;

@end
