//
//  RKTaskmodel.m
//  overdue
//
//  Created by CLICC User on 3/4/15.
//  Copyright (c) 2015 RyanKim. All rights reserved.
//

#import "RKTaskmodel.h"

@implementation RKTaskmodel

-(id)init
{
    self = [self initWithData:nil];
    return self;
}

-(id)initWithData:(NSDictionary *)data
{
    self = [super init];
    
    if (self){
    self.title = data[TITLE];
    self.description = data[DESCRIPTION];
    self.date = data[DATE];
    self.iscompleted = [data[COMPLETION] boolValue];
    }
    
    return self;
}
@end
