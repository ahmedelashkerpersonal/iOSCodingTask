//
//  Product.h
//  iOSCodingTask
//
//  Created by Ahmed Elashker on 7/6/15.
//  Copyright (c) 2015 Ahmed Elashker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject

@property (nonatomic, strong) NSNumber *productID;

@property (nonatomic, strong) NSNumber *imageWidth;
@property (nonatomic, strong) NSNumber *imageHeight;

@property (nonatomic, strong) NSNumber *price;

@property (nonatomic, strong) NSString *productDescription;

@property (nonatomic, strong) NSString *imageURL;
@end
