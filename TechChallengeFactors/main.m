//
//  main.m
//  TechChallengeFactors
//
//  Created by Keith Wedinger on 1/13/13.
//  Copyright (c) 2013 Keith Wedinger. All rights reserved.
//

#import <Foundation/Foundation.h>

//
// Display syntax for this program
//
void displaySyntax() {
    NSLog( @"Syntax: TechChallengeFactors <factors.txt>" );
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
        NSLog( @"%@ has %lu date/time stamps", inputFilePath, dateTimeStamps.count );
        
        
    }
    return 0;
}

