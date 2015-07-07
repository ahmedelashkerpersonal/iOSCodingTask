//
//  RequestManager.m
//  iOSCodingTask
//
//  Created by Ahmed Elashker on 7/6/15.
//  Copyright (c) 2015 Ahmed Elashker. All rights reserved.
//

#import "RequestManager.h"

@implementation RequestManager

@synthesize imgViews;

+ (RequestManager*)sharedInstance
{
    static RequestManager* sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init
{
    if (self = [super init])
    {
        imgViews = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)requestData
{
    NSString *urlString = @"http://grapesnberries.getsandbox.com/products?count=10&from=1";
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         if (error)
         {
             //NSLog(@"Error,%@", [error localizedDescription]);
         }
         else
         {
             NSArray* products = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
             
             for (NSDictionary* product in products) {
                 
                 Product *p = [[Product alloc] init];
                 p.productID = [product valueForKey:@"id"];
                 p.imageWidth = [[product valueForKey:@"image"] valueForKey:@"width"];
                 p.imageHeight = [[product valueForKey:@"image"] valueForKey:@"height"];
                 p.imageURL = [[product valueForKey:@"image"] valueForKey:@"url"];
                 p.price = [product valueForKey:@"price"];
                 p.productDescription = [product valueForKey:@"productDescription"];
                 
                 dispatch_async(dispatch_get_main_queue(), ^(void){
                     // Run UI Updates
                     
                     CustomImageView *civ = [[CustomImageView alloc] initWithProduct:p];
                     
                     [imgViews addObject:civ];
                 });
             }
             
             dispatch_async(dispatch_get_main_queue(), ^(void){
                 // Run UI Updates
                 
                 [[NSNotificationCenter defaultCenter] postNotificationName:@"ProductsResolved" object:self];
             });
             
         }
     }];
}

@end
