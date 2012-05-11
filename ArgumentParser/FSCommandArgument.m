//
//  FSCommandArgument.m
//  ArgumentParser
//
//  Created by Christopher Miller on 5/11/12.
//  Copyright (c) 2012 FSDEV. All rights reserved.
//

#import "FSCommandArgument.h"
#import "FSArgumentSignature_Internal.h"

// used in computing the hash value
#import <CommonCrypto/CommonDigest.h>

@implementation FSCommandArgument

@synthesize aliases = _aliases;

#pragma mark NSCopying

- (id)copy
{
    FSCommandArgument * copy = [super copy];
    
    if (copy) {
        copy->_aliases = _aliases;
    }
    
    return copy;
}

#pragma mark NSObject

- (NSUInteger)hash
{
    // use an MD5 hash to determine the uniqueness of the counted argument.
    // Injected sub-arguments are not considered.
    CC_MD5_CTX md5;
    CC_MD5_Init(&md5);
    
    [super internal_updateMD5:&md5]; // add shared stuff to the hash
    
    for (id o in _aliases) {
        NSUInteger longnamehash = [[o description] hash];
        CC_MD5_Update(&md5, (const void*)&longnamehash, sizeof(NSUInteger));
    }
    
    unsigned char* md5_final = (unsigned char*)malloc(sizeof(unsigned char)*CC_MD5_DIGEST_LENGTH);
    CC_MD5_Final(md5_final, &md5);
    return *((NSUInteger *)md5_final);
}

@end
