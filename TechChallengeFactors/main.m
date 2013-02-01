//
//  main.m
//  TechChallengeFactors
//
//  Created by Keith Wedinger on 1/13/13.
//  Copyright (c) 2013 Keith Wedinger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <math.h>

//
// Display syntax for this program
//
void displaySyntax() {
    NSLog( @"Syntax: TechChallengeFactors <factors.txt>" );
}

//
// Factor a number and return a sorted, comma delimited string of the factors
//
NSString* factor(long number) {
    // List<int> factors = new List<int>();
    NSMutableArray *factors = [[NSMutableArray alloc] init];
    // int max = (int)Math.Sqrt(number);  //round down
    long max = (long)sqrt( number );
    for( long factor = 1; factor <= max; ++factor ) { //test from 1 to the square root, or the int below it, inclusive.
        if ( number % factor == 0 ) {
            [factors addObject:[NSNumber numberWithLong:factor]];
            if ( factor != number/factor ) { // Don't add the square root twice!  Thanks Jon
                [factors addObject:[NSNumber numberWithLong:( number / factor)]];
            }
        }
    }
    
    // Sort the factors before returning them
    NSString *resultString = @"";
    if ( factors.count > 2 ) {
        NSArray *sortedFactors = [factors sortedArrayUsingComparator:^(NSNumber *firstNumber, NSNumber *secondNumber) {
            long firstValue = [firstNumber longValue];
            long secondValue = [secondNumber longValue];
            if ( firstValue > secondValue ) {
                return NSOrderedDescending;
            } else if ( firstValue == secondValue ) {
                return NSOrderedSame;
            } else {
                return NSOrderedAscending;
            }
        }];
        
        // Create and return comma delimited factor string
        NSMutableString *factorString = [[NSMutableString alloc] init];
        for ( NSNumber *factor in sortedFactors ) {
            [factorString appendFormat:@"%@,", factor];
        }
        resultString = [factorString substringToIndex:factorString.length - 1];
    }
    
    return resultString;
}

//
// Main entry point
//
int main(int argc, const char * argv[]) {
    
    // Use Cocoa's reference counting
    @autoreleasepool {
        
        // Must have 2 command line parms, 1 being the command itself
        if ( argc != 2 ) {
            displaySyntax();
            return 1;
        }
        
        // 2nd command line parm must be a valid file
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        NSString *inputFilePath = [[NSString alloc] initWithCString:argv[1] encoding:NSASCIIStringEncoding];
        if ( ![fileMgr fileExistsAtPath:inputFilePath] ) {
            NSLog( @"*** ERROR *** %@ does not exist", inputFilePath );
            return 1;
        }
        
        // Read in date/time stamps from the input file
        NSString *fileContents = [NSString stringWithContentsOfFile:inputFilePath encoding:NSASCIIStringEncoding error:NULL];
        NSArray *dateTimeStamps = [[fileContents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]]
                                   sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        
        // We need a date formatter to create NSDate objects from UTC timestamps
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
        [dateFormatter setLocale:[NSLocale systemLocale]];
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
        
        NSDate *dateTime;
        NSString *outputLine;
        
        // Get handle to result file.
        NSString *outputFilename = @"factorsresult.txt";
        [[NSFileManager defaultManager] createFileAtPath:outputFilename contents:nil attributes:nil];
        NSFileHandle *resultFileHandle = [NSFileHandle fileHandleForWritingAtPath:outputFilename];

        // Convert the date/time stamps to millisecond values using NSDate
        for ( NSString *dateTimeStamp in dateTimeStamps ) {
            dateTime = [dateFormatter dateFromString:dateTimeStamp];
            if ( dateTime ) {
                // We purposefully add 0.1 to round ms value because the multiplication
                // below comes up 1 ms short due NSTimeInterval's sub-ms precision.
                long dateTimeInMilliseconds = (long)(([dateTime timeIntervalSince1970] * 1000.0) + 0.1);

                // Create the output line using the date/time in ms and its factors
                outputLine = [NSString stringWithFormat:@"%lu:%@\n", dateTimeInMilliseconds, factor( dateTimeInMilliseconds )];

                // Write output line to result file
                [resultFileHandle seekToEndOfFile];
                [resultFileHandle writeData:[outputLine dataUsingEncoding:NSASCIIStringEncoding]];
            }
        }
        NSLog( @"Done...results are in factorsresult.txt in the current directory" );
    }
    return 0;
}

