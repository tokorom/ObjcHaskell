//
//  ObjcHaskellTests.m
//  ObjcHaskellTests
//
//  Created by ytokoro on 10/29/13.
//  Copyright (c) 2013 tokoro. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ObjcHaskell.h"

@interface ObjcHaskellTests : XCTestCase

@end

@implementation ObjcHaskellTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testAdd
{
    id result = add (@1) (@3);
    XCTAssertEqualObjects(result, @4, @"result is invalid");
}

- (void)testSub
{
    id result = sub (@1) (@3);
    XCTAssertEqualObjects(result, @-2, @"result is invalid");
}

- (void)testMul
{
    id result = mul (@1) (@3);
    XCTAssertEqualObjects(result, @3, @"result is invalid");
}

- (void)testDiv
{
    id result = div (@1) (@3);
    XCTAssertEqualObjects(result, @0, @"result is invalid");
}

- (void)testLessThan
{
    id result;

    result = OP('<') (@1) (@2);
    XCTAssertEqualObjects(result, @YES, @"result is invalid");

    result = OP('<') (@2) (@2);
    XCTAssertEqualObjects(result, @NO, @"result is invalid");

    result = OP('<') (@2) (@1);
    XCTAssertEqualObjects(result, @NO, @"result is invalid");
}

- (void)testGreaterThan
{
    id result;

    result = OP('>') (@1) (@2);
    XCTAssertEqualObjects(result, @NO, @"result is invalid");

    result = OP('>') (@2) (@2);
    XCTAssertEqualObjects(result, @NO, @"result is invalid");

    result = OP('>') (@2) (@1);
    XCTAssertEqualObjects(result, @YES, @"result is invalid");
}

- (void)testCons
{
    id result = cons (@1) (@[@2]);
    XCTAssertEqualObjects(result, (@[@1, @2]), @"result is invalid");
}

- (void)testSection
{
    id result;

    result = OP('+') (@1) (@3);
    XCTAssertEqualObjects(result, @4, @"result is invalid");

    result = OP('-') (@1) (@3);
    XCTAssertEqualObjects(result, @-2, @"result is invalid");

    result = OP('*') (@1) (@3);
    XCTAssertEqualObjects(result, @3, @"result is invalid");

    result = OP('/') (@1) (@3);
    XCTAssertEqualObjects(result, @0, @"result is invalid");
}

- (void)testFoldl
{
    id result;

    result = foldl OP('+') (@10) (@[@3, @2, @1]);
    XCTAssertEqualObjects(result, @16, @"result is invalid");

    result = foldl OP('-') (@10) (@[@3, @2, @1]);
    XCTAssertEqualObjects(result, @4, @"result is invalid");
}

- (void)testFoldr
{
    id result;

    result = foldr OP('+') (@10) (@[@3, @2, @1]);
    XCTAssertEqualObjects(result, @16, @"result is invalid");

    result = foldr OP('-') (@10) (@[@3, @2, @1]);
    XCTAssertEqualObjects(result, @-8, @"result is invalid");

    result = foldr OP(':') (@[]) (@[@3, @2, @1]);
    XCTAssertEqualObjects(result, (@[@3, @2, @1]), @"result is invalid");
}

- (void)testMap
{
    id result = map (OP('+') (@3)) (@[@1, @2, @3]); //< map (+3) [1, 2, 3]
    XCTAssertEqualObjects(result, (@[@4, @5, @6]), @"result is invalid");
}

- (void)testFilter
{
    id result = filter (OP('>') (@3)) (@[@1, @2, @3, @4]);
    XCTAssertEqualObjects(result, (@[@1, @2]), @"result is invalid");
}

- (void)testSum
{
    id result = sum (@[@1, @2, @3]);
    XCTAssertEqualObjects(result, @6, @"result is invalid");
}

- (void)testComposite
{
    id result;

    result = sum (filter (OP('>') (@10)) (@[@8, @9, @10, @11]));
    XCTAssertEqualObjects(result, @17, @"result is invalid");
}

@end
