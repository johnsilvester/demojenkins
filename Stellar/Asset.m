//
//  Asset.m
//  Stellar
//
//  Created by John Silvester on 1/11/19.
//  Copyright © 2019 John Silvester. All rights reserved.
//

#import "Asset.h"

@implementation Asset
//asset class

- (id)initWithDictionary: (NSDictionary *)assetInformation
{
    self = [super init];
    if(self && assetInformation != nil) {
        self.name = [assetInformation objectForKey:@"name"];
        self.issuer = [assetInformation objectForKey:@"issuer"];
        self.price = [[assetInformation valueForKey:@"price"] doubleValue];
    }else{
        self.name = @"Defualt";
        self.issuer = @"N/A";
        self.price = 0.0;
        //Throw error here
    }
    return self;
}




@end
