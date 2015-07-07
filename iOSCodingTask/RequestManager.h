//
//  RequestManager.h
//  iOSCodingTask
//
//  Created by Ahmed Elashker on 7/6/15.
//  Copyright (c) 2015 Ahmed Elashker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomImageView.h"

@interface RequestManager : NSObject

+ (RequestManager*)sharedInstance;

- (void)requestData;

@property (nonatomic, strong) NSMutableArray *imgViews;

@end
