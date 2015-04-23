//
//  ViewController.m
//  AttributedCaps
//
//  Created by Eran Jalink on 23/04/15.
//  Copyright (c) 2015 Eran Jalink. All rights reserved.
//

#import "ViewController.h"
#import "MainView.h"

@interface ViewController ()

@end

@implementation ViewController {
    MainView *mainView;
}

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    mainView = [[MainView alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view = (UIView *)mainView;
    
    NSString *mainString = @"This is a DEMO STRING to detect PARTS OF THE STRING that are CAPITALIZED so it can apply CUSTOM NSATTRIBUTES to it. it will ALSO change to proper-case FORMATTING so sentences will START with a CAPITAL.";
    
    CGFloat margin = 10;
    CGRect aframe;
    aframe.origin.x = margin;
    aframe.origin.y = margin;
    aframe.size.width = CGRectGetWidth(mainView.bounds) - 2 * margin;
    aframe.size.height = CGRectGetHeight(mainView.bounds) - 2 * margin;
    UILabel *mainLabel = [[UILabel alloc]initWithFrame:aframe];
    mainLabel.attributedText = [self accentedString:mainString];
    mainLabel.numberOfLines = 0;
    [mainView addSubview:mainLabel];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)capitalizeSentences:(NSString *)stringToProcess {
    NSMutableString *processedString = [stringToProcess mutableCopy];
    
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en"];
    
    // Ironically, the tokenizer will only tokenize sentences if the first letter
    // of the sentence is capitalized...
    stringToProcess = [stringToProcess uppercaseStringWithLocale:locale];
    
    CFStringTokenizerRef stringTokenizer = CFStringTokenizerCreate(kCFAllocatorDefault, (__bridge CFStringRef)(stringToProcess), CFRangeMake(0, [stringToProcess length]), kCFStringTokenizerUnitSentence, (__bridge CFLocaleRef)(locale));
    
    while (CFStringTokenizerAdvanceToNextToken(stringTokenizer) != kCFStringTokenizerTokenNone) {
        CFRange sentenceRange = CFStringTokenizerGetCurrentTokenRange(stringTokenizer);
        
        if (sentenceRange.location != kCFNotFound && sentenceRange.length > 0) {
            NSRange firstLetterRange = NSMakeRange(sentenceRange.location, 1);
            
            NSString *uppercaseFirstLetter = [[processedString substringWithRange:firstLetterRange] uppercaseStringWithLocale:locale];
            
            [processedString replaceCharactersInRange:firstLetterRange withString:uppercaseFirstLetter];
        }
    }
    
    CFRelease(stringTokenizer);
    
    return processedString;
}

- (NSArray *)rangesOfUppercaseLettersInString:(NSString *)str {
    NSMutableCharacterSet *characterSet = [NSMutableCharacterSet characterSetWithCharactersInString:@" .,+=*"];
    NSCharacterSet *uppercaseSet = [NSCharacterSet uppercaseLetterCharacterSet];
    
    [characterSet formUnionWithCharacterSet:uppercaseSet];
    
    NSMutableArray *results = [NSMutableArray array];
    NSScanner *scanner = [NSScanner scannerWithString:str];
    while (![scanner isAtEnd]) {
        [scanner scanUpToCharactersFromSet:characterSet intoString:NULL]; // skip non-uppercase characters
        NSString *temp;
        NSUInteger location = [scanner scanLocation];
        if ([scanner scanCharactersFromSet:characterSet intoString:&temp]) {
            // found one (or more) uppercase characters
            NSRange range = NSMakeRange(location, [temp length]);
            [results addObject:[NSValue valueWithRange:range]];
        }
    }
    return results;
}


- (NSAttributedString *)accentedString:(NSString *)baseString {
    
    //define 'base' style
    NSMutableParagraphStyle *mainStyle = [[NSMutableParagraphStyle alloc]init];
    UIFont *mainFont = [UIFont systemFontOfSize:12];
    [mainStyle setLineHeightMultiple:1.3];
//    mainStyle.
    NSDictionary *mainAttributes = @{NSParagraphStyleAttributeName: mainStyle, NSFontAttributeName: mainFont};
    
    //accent properties
    UIFont *accentFont = [UIFont boldSystemFontOfSize:12];
    UIColor *accentColor = [UIColor redColor];

    NSDictionary *accentAttributes = @{NSParagraphStyleAttributeName: mainStyle, NSFontAttributeName: accentFont, NSForegroundColorAttributeName: accentColor};
    
    //convert base string to lowercase
    NSString *lowerCaseString = [baseString lowercaseString];
    
    //convert lowercase string to string with capitalized first letter
    NSString *properString = [self capitalizeSentences:lowerCaseString];
    
    //create attributed string to contain all values
    NSMutableAttributedString *mutAttrTextViewString = [[NSMutableAttributedString alloc] initWithString:properString attributes:mainAttributes];
    
    NSArray *upperCaseRanges = [self rangesOfUppercaseLettersInString:baseString];

    for (NSValue *rangeValue in upperCaseRanges) {
        NSRange range = [rangeValue rangeValue];
        if (range.length > 1) {
            [mutAttrTextViewString setAttributes:accentAttributes range:range];
        }
    }
    
    
    NSAttributedString *att = [[NSAttributedString alloc]initWithAttributedString:mutAttrTextViewString];
    return att;
}

@end
