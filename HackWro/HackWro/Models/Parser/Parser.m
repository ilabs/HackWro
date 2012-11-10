#import "Parser.h"

@implementation Parser

- (id)init {
    if((self = [super init])) {
        textData = nil;
        parsedData = nil;
    }
    
    return self;
}

+ (NSMutableDictionary *)parseXML:(NSString *)path {
    Parser *parser = [[Parser alloc] init];
    NSMutableDictionary *parsedDictionary = [parser parseXML:path];
    
    return parsedDictionary;
}

+ (NSMutableDictionary *)parseXMLString:(NSString *)xmlString {
    Parser *parser = [[Parser alloc] init];
    NSMutableDictionary *parsedDictionary = [parser parseXMLString:xmlString];
    
    return parsedDictionary;
}

- (NSMutableDictionary *)parseXML:(NSString *)path {
    if(!path) {
        NSLog(@"Invalid path.");
        return nil;
    }
    
    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path]];
    
    if(!xmlParser) {
        NSLog(@"Couldn't parse %@!", path);
        return nil;
    }
    
    xmlParser.shouldProcessNamespaces = NO;
    xmlParser.shouldReportNamespacePrefixes = NO;
    xmlParser.shouldResolveExternalEntities = NO;
    xmlParser.delegate = self;
    
    textData = [[NSMutableString alloc] init];
    parsedData = [[NSMutableArray alloc] init];
    
    NSMutableDictionary *rootDict = [[NSMutableDictionary alloc] init];
    [parsedData addObject:rootDict];
    
    BOOL parsed = [xmlParser parse];

    if(parsed) {
        NSMutableDictionary *parsedDictionary = [parsedData objectAtIndex:0];
        
        if([parsedDictionary objectForKey:@"xml"] != nil) {
            return [parsedDictionary objectForKey:@"xml"];
        } else {
            return parsedDictionary;
        }
    } else {
        NSLog(@"Parsing %@ failed!", path);
        return nil;
    }
}

- (NSMutableDictionary *)parseXMLString:(NSString *)xmlString {
    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:[NSData dataWithBytes:[xmlString cStringUsingEncoding:NSUTF8StringEncoding] length:[xmlString lengthOfBytesUsingEncoding:NSUTF8StringEncoding]]];
                              
    if(!xmlParser) {
        NSLog(@"Couldn't parse string: %@", xmlString);
        return nil;
    }
    
    xmlParser.shouldProcessNamespaces = NO;
    xmlParser.shouldReportNamespacePrefixes = NO;
    xmlParser.shouldResolveExternalEntities = NO;
    xmlParser.delegate = self;
    
    textData = [[NSMutableString alloc] init];
    parsedData = [[NSMutableArray alloc] init];
    
    NSMutableDictionary *rootDict = [[NSMutableDictionary alloc] init];
    [parsedData addObject:rootDict];
    
    BOOL parsed = [xmlParser parse];
    
    if(parsed) {
        NSMutableDictionary *parsedDictionary = [parsedData objectAtIndex:0];
        
        if([parsedDictionary objectForKey:@"xml"] != nil) {
            return [parsedDictionary objectForKey:@"xml"];
        } else {
            return parsedDictionary;
        }
    } else {
        NSLog(@"Parsing string failed!\n%@", xmlString);
        return nil;
    }
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    NSMutableDictionary *lastDict = [parsedData lastObject];
    NSMutableDictionary *newDict = [[NSMutableDictionary alloc] init];
    [parsedData addObject:newDict];
    
    [newDict addEntriesFromDictionary:attributeDict];
    
    if(![lastDict objectForKey:elementName]) {
        [lastDict setObject:newDict forKey:elementName];
    } else {
        id currentObject = [lastDict objectForKey:elementName];
        
        if([currentObject isKindOfClass:[NSMutableArray class]]) {
            [(NSMutableArray *)currentObject addObject:newDict];
        } else {
            NSMutableArray *objectArray = [[NSMutableArray alloc] initWithObjects:currentObject, nil];
            [objectArray addObject:newDict];
            [lastDict setObject:objectArray forKey:elementName];
        }
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    NSString *trimmedTextData = [textData stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if([trimmedTextData length] > 0)
        [[parsedData lastObject] setObject:trimmedTextData forKey:@"text"];
    
    textData = [[NSMutableString alloc] init];
    [parsedData removeLastObject];
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    [textData appendString:string];
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    NSLog(@"Parse error: %@", [parseError description]);
}

@end
