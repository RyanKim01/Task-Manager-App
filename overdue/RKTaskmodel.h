//
//  RKTaskmodel.h
//  overdue
//
//  Created by CLICC User on 3/4/15.
//  Copyright (c) 2015 RyanKim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RKTaskmodel : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *description;
@property (strong, nonatomic) NSDate *date;
@property (nonatomic) BOOL iscompleted;

- (id)initWithData:(NSDictionary *)data;

@end
