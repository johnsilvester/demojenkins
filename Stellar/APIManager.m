//
//  APIManager.m
//  Stellar
//
//  Created by John Silvester on 1/6/19.
//  Copyright © 2019 John Silvester. All rights reserved.
//

#define Stellar 512

#import "APIManager.h"

NSString *baseURL = @"https://horizon.stellar.org";

@implementation APIManager



-(void)getPriceForKey:(NSString*)key withCompletion:(stringCompletion) completion{
    
   NSURL *url = [NSURL URLWithString:
                  @"https://pro-api.coinmarketcap.com/v1/cryptocurrency/quotes/latest?id=512"];
   NSMutableURLRequest *mutableRequest = [[NSMutableURLRequest alloc]initWithURL:url];
   [mutableRequest setHTTPMethod:@"GET"];
   [mutableRequest addValue:@"9b072989-0fb1-4687-a589-d025a88d6a48" forHTTPHeaderField:@"X-CMC_PRO_API_KEY"];
   
   NSURLSessionTask *task = [[NSURLSession sharedSession]dataTaskWithRequest:mutableRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
      
      NSDictionary *jsonObject=[NSJSONSerialization
                                JSONObjectWithData:data
                                options:NSJSONReadingMutableLeaves
                                error:nil];
      double price = [[[[[[jsonObject objectForKey:@"data"] objectForKey:@"512"] objectForKey:@"quote"] objectForKey:@"USD"] valueForKey:@"price"] doubleValue];

      completion([NSString stringWithFormat:@"%f",price]);
      
   }];
   
    
        // 3
    [task resume];

}

-(void)getAssetsWithIssuers: (NSDictionary*)issuers withCompletion:(dictionaryCompletion) completion{

   NSMutableDictionary *returnedValues = [[NSMutableDictionary alloc]init];
   int itemsCounter = issuers.count;
   for(NSString *key in issuers){
       NSLog(@"%@",key);
      NSLog(@"%@", [issuers objectForKey:key]);
   NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/assets?asset_issuer=%@",baseURL,[issuers objectForKey:key]]];

   NSMutableURLRequest *mutableRequest = [[NSMutableURLRequest alloc]initWithURL:url];
   [mutableRequest setHTTPMethod:@"GET"];
   itemsCounter--;
   NSURLSessionTask *task = [[NSURLSession sharedSession]dataTaskWithRequest:mutableRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
      
      NSDictionary *jsonObject=[NSJSONSerialization
                                JSONObjectWithData:data
                                options:NSJSONReadingMutableLeaves
                                error:nil];
      
      
      [returnedValues setObject:jsonObject forKey:key];
     
      if ( itemsCounter == 0){
     completion(returnedValues);
      }
   }];
   
   
      // 3
   [task resume];
   }
   
   
}




-(void)getAccountInformationForAccount: (NSString*)account withCompletion:(dictionaryCompletion) completion{
      NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/accounts/%@",baseURL,account]];

   NSMutableURLRequest *mutableRequest = [[NSMutableURLRequest alloc]initWithURL:url];
   [mutableRequest setHTTPMethod:@"GET"];
   NSURLSessionTask *task = [[NSURLSession sharedSession]dataTaskWithRequest:mutableRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
      
      NSDictionary *jsonObject=[NSJSONSerialization
                                JSONObjectWithData:data
                                options:NSJSONReadingMutableLeaves
                                error:nil];
      
      
      completion(jsonObject);
      
   }];
   
   
      // 3
   [task resume];
   
   
}



@end
