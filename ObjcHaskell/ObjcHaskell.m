//
//  ObjcHaskell.m
//
//  Created by ToKoRo on 2013-10-29.
//

#import "ObjcHaskell.h"

@implementation ObjcHaskell
    
+ (curryingBlock)hsSectionWithOperator:(int)op
{
    switch (op) {
        case '+': return add;
        case '-': return sub;
        case '*': return mul;
        case '/': return div;
        case ':': return cons;
        case '<': return lessThan;
        case '>': return greaterThan;
        default: return [ObjcHaskell hsReturnNil];
    }
}

+ (curryingBlock)hsReturnNil
{
    CURRYING2(
        x, y,
        return nil;
    );
}

+ (curryingBlock)hsAdd
{
    CURRYING2(
        x, y,
        return @([x intValue] + [y intValue]);
    );
}

+ (curryingBlock)hsSub
{
    CURRYING2(
        x, y,
        return @([x intValue] - [y intValue]);
    );
}

+ (curryingBlock)hsMul
{
    CURRYING2(
        x, y,
        return @([x intValue] * [y intValue]);
    );
}

+ (curryingBlock)hsDiv
{
    CURRYING2(
        x, y,
        return @([x intValue] / [y intValue]);
    );
}

+ (curryingBlock)hsCons
{
    CURRYING2(
        x, xs,
        NSMutableArray* ret = [xs mutableCopy];
        [ret insertObject:x atIndex:0];
        return ret;
    );
}

+ (curryingBlock)hsLessThan
{
    CURRYING2(
        x, y,
        return @(NSOrderedAscending == [x compare:y]);
    );
}

+ (curryingBlock)hsGreaterThan
{
    CURRYING2(
        x, y,
        return @(NSOrderedDescending == [x compare:y]);
    );
}

+ (curryingBlock)hsFoldl
{
    CURRYING3(
        binary, ini, list,

        id acc = ini;
        curryingBlock fnc = binary;
        for (id elem in list) {
            acc = fnc (acc) (elem);
        }
        return acc;
    );
}

+ (curryingBlock)hsFoldr
{
    CURRYING3(
        binary, ini, list,

        id acc = ini;
        curryingBlock fnc = binary;
        for (id elem in [list reverseObjectEnumerator]) {
            acc = fnc (elem) (acc);
        }
        return acc;
    );
}

+ (curryingBlock)hsMap
{
    CURRYING2(
        unary, list,
        curryingBlock fnc = unary;
        NSMutableArray* ret = [NSMutableArray array];
        for (id elem in list) {
            [ret addObject:(fnc (elem))];
        }
        return ret;
    );
}

+ (curryingBlock)hsFilter
{
    CURRYING2(
        unary, list,
        curryingBlock fnc = unary;
        NSMutableArray* ret = [NSMutableArray array];
        for (id elem in list) {
            if ([(fnc (elem)) boolValue]) {
                [ret addObject:elem];
            }
        }
        return ret;
    );
}


+ (curryingBlock)hsSum
{
    return ((id)
        foldr OP('+') (@0)
    );
}

@end
