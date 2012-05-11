//
//  FSValuedArgument.h
//  ArgumentParser
//
//  Created by Christopher Miller on 5/11/12.
//  Copyright (c) 2012 FSDEV. All rights reserved.
//

#import "FSArgumentSignature.h"
#import "FSExplicitArgument.h"

/** An argument which has one or more values attached to it. */
@interface FSValuedArgument : FSArgumentSignature

@property (strong) NSCharacterSet * switchAliases;
@property (strong) NSSet * longAliases;

@property (assign) bool shouldAllowMultipleInvocations;

@property (assign) bool required;

/** The number of values per invocation, which should be between 1 and NSNotFound. */
@property (assign) NSUInteger valuesPerInvocation;

/**
 * If set, this argument will continue to try and grab values beyond barriers, which are defined as any other explicit argument invocation or a double dash.
 *
 * For example, if the signature signified by the short name c were to have valuesPerInvocation as 3, and shouldGrabBeyondBarrier were false, the following would error as having insufficient values to the argument:
 *
 *     foo -c 1 2 -f 3
 *
 * However, given the same signature with shouldGrabBeyondBarrier set to true, the same invocation would succeed and grab the 3 and add it to c.
 */
@property (assign) bool shouldGrabBeyondBarrier;

@end
