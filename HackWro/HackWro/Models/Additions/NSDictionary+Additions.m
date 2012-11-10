#import "NSDictionary+Additions.h"

@implementation NSDictionary (Additions)

- (NSString *)textObjectForKey:(NSString *)key {
    id value = [self objectForKey:key];
    
    if([value isKindOfClass:[NSDictionary class]]) {
        return [(NSDictionary *)value objectForKey:@"text"];
    } else {
        return nil;
    }
}

@end
