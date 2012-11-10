#import <Foundation/Foundation.h>

@interface Parser : NSObject <NSXMLParserDelegate> {
    NSMutableString *textData;
    NSMutableArray *parsedData;
}

+ (NSMutableDictionary *)parseXML:(NSString *)path;
+ (NSMutableDictionary *)parseXMLString:(NSString *)xmlString;

- (NSMutableDictionary *)parseXML:(NSString *)path;
- (NSMutableDictionary *)parseXMLString:(NSString *)xmlString;

@end
