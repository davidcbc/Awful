//
//  NSManagedObject+Awful.m
//  Awful
//
//  Created by Nolan Waite on 2012-10-10.
//  Copyright (c) 2012 Regular Berry Software LLC. All rights reserved.
//

#import "NSManagedObject+Awful.h"

@implementation NSManagedObject (Awful)

+ (NSArray *)fetchAll
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:[(Class)self entityName]];
    NSError *error;
    NSArray *all = [[AwfulDataStack sharedDataStack].context executeFetchRequest:request
                                                                           error:&error];
    if (!all) {
        NSLog(@"error fetching all %@: %@", self, error);
    }
    return all;
}

+ (NSArray *)fetchAllMatchingPredicate:(id)format, ...
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:[(Class)self entityName]];
    if ([format isKindOfClass:[NSPredicate class]]) {
        [request setPredicate:(NSPredicate *)format];
    } else {
        va_list args;
        va_start(args, format);
        [request setPredicate:[NSPredicate predicateWithFormat:format arguments:args]];
        va_end(args);
    }
    NSError *error;
    NSArray *matches = [[AwfulDataStack sharedDataStack].context executeFetchRequest:request
                                                                               error:&error];
    if (!matches) {
        NSLog(@"error fetching %@ matching %@: %@", self, [request predicate], error);
    }
    return matches;
}

+ (void)deleteAllMatchingPredicate:(NSString *)format, ...
{
    va_list args;
    va_start(args, format);
    NSPredicate *predicate = [NSPredicate predicateWithFormat:format arguments:args];
    va_end(args);
    for (NSManagedObject *dying in [self fetchAllMatchingPredicate:predicate]) {
        [dying.managedObjectContext deleteObject:dying];
    }
}

+ (id)insertNew
{
    return [(Class)self insertInManagedObjectContext:[AwfulDataStack sharedDataStack].context];
}

@end