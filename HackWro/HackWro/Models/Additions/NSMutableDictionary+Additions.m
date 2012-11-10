#import "NSMutableDictionary+Additions.h"

@implementation NSMutableDictionary (Additions)

- (void)setTextObject:(NSString *)object forKey:(NSString *)key {
    if((object != nil) && (key != nil)) {
        [self setObject:[NSDictionary dictionaryWithObject:object forKey:@"text"] forKey:key];
    }
}

@end
