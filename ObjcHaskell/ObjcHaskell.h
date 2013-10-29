//
//  ObjcHaskell.h
//
//  Created by ToKoRo on 2013-10-29.
//

typedef id (^unaryBlock)(id);
typedef unaryBlock (^higherOrderBlock)(id);
typedef higherOrderBlock (^curryingBlock)(id);

#define CURRYING(x, imp) return (unaryBlock)^(id x) { \
    imp \
}

#define CURRYING2(x, y, imp) return (curryingBlock)^(id x) { \
    return (unaryBlock)^(id y) { \
        imp \
    }; \
}

#define CURRYING3(x, y, z, imp) return (curryingBlock)^(id x) { \
    return (curryingBlock)^(id y) { \
        return (unaryBlock)^(id z) { \
            imp \
        }; \
    }; \
}

#define OP(op) ([ObjcHaskell hsSectionWithOperator:op])

#define add [ObjcHaskell hsAdd]
#define sub [ObjcHaskell hsSub]
#define mul [ObjcHaskell hsMul]
#define div [ObjcHaskell hsDiv]
#define cons [ObjcHaskell hsCons]
#define lessThan [ObjcHaskell hsLessThan]
#define greaterThan [ObjcHaskell hsGreaterThan]
#define foldl [ObjcHaskell hsFoldl]
#define foldr [ObjcHaskell hsFoldr]
#define map [ObjcHaskell hsMap]
#define filter [ObjcHaskell hsFilter]
#define sum [ObjcHaskell hsSum]

@interface ObjcHaskell : NSObject

+ (curryingBlock)hsSectionWithOperator:(int)op;

+ (curryingBlock)hsReturnNil;
+ (curryingBlock)hsAdd;
+ (curryingBlock)hsSub;
+ (curryingBlock)hsMul;
+ (curryingBlock)hsDiv;
+ (curryingBlock)hsCons;
+ (curryingBlock)hsLessThan;
+ (curryingBlock)hsGreaterThan;
+ (curryingBlock)hsFoldl;
+ (curryingBlock)hsFoldr;
+ (curryingBlock)hsMap;
+ (curryingBlock)hsFilter;
+ (curryingBlock)hsSum;

@end
