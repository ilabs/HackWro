#import "NSObject+Parsed.h"

@implementation NSObject (Parsed)

- (NSArray *)parsedElements {
    NSMutableArray *parsedElements = [NSMutableArray new];
    
    if([self isKindOfClass:[NSDictionary class]]) {
        [parsedElements addObject:self];
    } else if([self isKindOfClass:[NSArray class]]) {
        for(id arrayElement in (NSArray *)self) {
            if([arrayElement isKindOfClass:[NSDictionary class]]) {
                [parsedElements addObject:arrayElement];
            }
        }
    }
    
    return parsedElements;
}

@end
