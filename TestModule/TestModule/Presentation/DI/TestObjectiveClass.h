//
//  TestObjectiveClass.h
//  TestModule
//
//  Created by A-25 on 25.02.2019.
//  Copyright © 2019 Ilya Merkulov. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TestObjectiveClass : NSObject

@property (nonatomic,copy,readonly) NSString *title;

-(instancetype)initWithTitle:( NSString* _Nonnull )title;
-(void)testMethod;

@end

NS_ASSUME_NONNULL_END
