//
//  TestObjectiveClass.m
//  TestModule
//
//  Created by A-25 on 25.02.2019.
//  Copyright © 2019 Ilya Merkulov. All rights reserved.
//

#import "TestObjectiveClass.h"

@implementation TestObjectiveClass

-(instancetype)initWithTitle:(NSString* _Nonnull)title {
    if (self = [super init]) {
        _title = title;
    }
    return self;
}

-(void)testMethod {
    _title = @"test";
}

@end
