//
//  ViewController.m
//  SBT-Lesson-2
//
//  Created by Dmitry Shapkin on 27/02/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SKNode *node = [SKNode new];
    NSLog(@"%@", node);
    
    // 1. Void function
    [self helloWorld];
    
    // 2. Check the size of any types
    NSInteger year = 2019;
    NSString *name = @"Dmitry";
    BOOL isBool = YES;
    char aChar = 'a';
    float justFloat = 15.5;
    CGFloat someCGFloat = 15.5;
    double justDouble = 17.7;
    
    NSLog(@"The size of NSInteger is %lu", sizeof(year)); // 8
    NSLog(@"The size of NSString is %lu", sizeof(name)); // 8
    NSLog(@"The size of BOOL is %lu", sizeof(isBool)); // 1
    NSLog(@"The size of BOOL is %lu", sizeof(aChar)); // 1
    NSLog(@"The size of float is %lu", sizeof(justFloat)); // 4
    NSLog(@"The size of CGFloat is %lu", sizeof(someCGFloat)); // 8
    NSLog(@"The size of double is %lu", sizeof(justDouble)); // 8
    
    // 3. Integers and BOOL
    BOOL anotherBool = YES;
    NSLog(@"%d", anotherBool);
    NSLog(@"%@", anotherBool ? @"YES" : @"NO");
    
    char bChar = 'b';
    unsigned char anUsignedChar = 255;
    NSLog(@"The letter %c is ASCII number %hhd", bChar, bChar);
    NSLog(@"%hhu", anUsignedChar);
    
    short aShort = -32768;
    unsigned short anUnsignedShort = 65535;
    NSLog(@"%hd", aShort);
    NSLog(@"%hu", anUnsignedShort);
    
    int anInt = -2147483648;
    unsigned int anUnsignedInt = 4294967295;
    NSLog(@"%d", anInt);
    NSLog(@"%u", anUnsignedInt);
    
    long aLong = -9223371903408380224;
    unsigned long anUnsignedLong = 183676733467397159;
    NSLog(@"%ld", aLong);
    NSLog(@"%lu", anUnsignedLong);
    NSLog(@"The size of long is %lu", sizeof(aLong)); // 8
    
    long long aLongLong = -9223371903408380224;
    unsigned long long anUnsignedLongLong = 183676733467397159;
    NSLog(@"%lld", aLongLong);
    NSLog(@"%llu", anUnsignedLongLong);
    NSLog(@"The size of long long is %lu", sizeof(aLongLong)); // 8 - "but in OS X and iOS the additional long makes no difference."
    
    // 4. Practice with sizeof
    NSLog(@"Primitive sizes:");
    NSLog(@"The size of a char is: %zu.", sizeof(char));
    NSLog(@"The size of short is: %lu.", sizeof(short));
    NSLog(@"The size of int is: %lu.", sizeof(int));
    NSLog(@"The size of long is: %lu.", sizeof(long));
    NSLog(@"The size of long long is: %lu.", sizeof(long long));
    NSLog(@"The size of a unsigned char is: %lu.", sizeof(unsigned char));
    NSLog(@"The size of unsigned short is: %lu.", sizeof(unsigned short));
    NSLog(@"The size of unsigned int is: %lu.", sizeof(unsigned int));
    NSLog(@"The size of unsigned long is: %lu.", sizeof(unsigned long));
    NSLog(@"The size of unsigned long long is: %lu.", sizeof(unsigned long long));
    NSLog(@"The size of a float is: %lu.", sizeof(float));
    NSLog(@"The size of a double is %lu.", sizeof(double));
    
    NSLog(@"Ranges:");
    NSLog(@"CHAR_MIN:   %c",   CHAR_MIN);
    NSLog(@"CHAR_MAX:   %c",   CHAR_MAX);
    NSLog(@"SHRT_MIN:   %i",  SHRT_MIN);    // signed short int
    NSLog(@"SHRT_MAX:   %i",  SHRT_MAX);
    NSLog(@"INT_MIN:    %i",   INT_MIN);
    NSLog(@"INT_MAX:    %i",   INT_MAX);
    NSLog(@"LONG_MIN:   %li",  LONG_MIN);    // signed long int
    NSLog(@"LONG_MAX:   %li",  LONG_MAX);
    NSLog(@"ULONG_MAX:  %lu",  ULONG_MAX);   // unsigned long int
    NSLog(@"LLONG_MIN:  %lli", LLONG_MIN);   // signed long long int
    NSLog(@"LLONG_MAX:  %lli", LLONG_MAX);
    NSLog(@"ULLONG_MAX: %llu", ULLONG_MAX);  // unsigned long long int
    
    // 5. Целые фиксированной длины
    
    // Exact integer types
    int8_t aOneByteInt = 127;
    uint8_t aOneByteUnsignedInt = 255;
    int16_t aTwoByteInt = 32767;
    uint16_t aTwoByteUnsignedInt = 65535;
    int32_t aFourByteInt = 2147483647;
    uint32_t aFourByteUnsignedInt = 4294967295;
    int64_t anEightByteInt = 9223372036854775807;
    uint64_t anEightByteUnsignedInt = 18446744073709551615;
    
    // Minimum integer types
    int_least8_t aTinyInt = 127;
    uint_least8_t aTinyUnsignedInt = 255;
    int_least16_t aMediumInt = 32767;
    uint_least16_t aMediumUnsignedInt = 65535;
    int_least32_t aNormalInt = 2147483647;
    uint_least32_t aNormalUnsignedInt = 4294967295;
    int_least64_t aBigInt = 9223372036854775807;
    uint_least64_t aBigUnsignedInt = 18446744073709551615;
    
    // The largest supported integer type
    intmax_t theBiggestInt = 9223372036854775807;
    uintmax_t theBiggestUnsignedInt = 18446744073709551615;
    
    // Single precision floating-point (4 bytes for both 32-bit and 64-bit)
    float aFloat = 72.0395f;
    NSLog(@"%f", aFloat);
    NSLog(@"%8.2f", aFloat);
    
    // Double precision floating-point (8 bytes for both 32-bit and 64-bit)
    double aDouble = -72.0345f;
    NSLog(@"%8.2f", aDouble);
    NSLog(@"%e", aDouble);

    // Extended precision floating-point (16 bytes for both 32-bit and 64-bit)
    long double aLongDouble = 72.0345e7L;
    NSLog(@"%Lf", aLongDouble);
    NSLog(@"%Le", aLongDouble);
    
    // Work with size_t
    NSArray *anArray = @[@1, @2, @3, @4, @5];
    size_t numberOfElements = sizeof(anArray)/sizeof(anArray[0]);
    NSLog(@"%zu", numberOfElements);
    
    // Сравнение на равенство запрещено
    NSLog(@"%.29f", .1);
    
    // id
    id mysteryObject = @"An NSString object";
    NSLog(@"%@", [mysteryObject description]);
    mysteryObject = @{@"model": @"Ford", @"year": @1967};
    NSLog(@"%@", [mysteryObject description]);
    
    // Class
    Class targetClass = [NSString class];
    id mysteryObjectTwo = @"An NSString object";
    if ([mysteryObjectTwo isKindOfClass:targetClass]) {
        NSLog(@"Yup! That's an instance of the target class");
    }
    
    // SEL
    SEL someMethod = @selector(helloWorld);
}

- (void) helloWorld {
    NSLog(@"Hello world! This function will not return anything");
}

@end
