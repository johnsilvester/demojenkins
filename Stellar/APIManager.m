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
   NSLog(@"%d", itemsCounter);
   for(NSString *key in issuers){
      NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/order_book?selling_asset_type=native&buying_asset_type=credit_alphanum4&buying_asset_code=%@&buying_asset_issuer=%@",baseURL,key,[issuers objectForKey:key]]];
      
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
            NSDictionary *prices = [self returnPricingAverage:returnedValues];
            completion(prices);
         }
      }];
      
      
         // 3
      [task resume];
   }
   
}


-(NSDictionary *)returnPricingAverage: (NSDictionary *)data{
   
   NSMutableDictionary *prices = [[NSMutableDictionary alloc]init];
   for (NSString *key in data) {
      NSLog(@"Checking: %@",key);
      NSArray *price = [[data objectForKey:key] objectForKey:@"asks"];
      double lowestPrice = [[[price objectAtIndex:0]objectForKey:@"price"] doubleValue];
      [prices setValue:[NSNumber numberWithDouble:lowestPrice] forKey:key];
      NSLog(@"Found: %@",[NSNumber numberWithDouble:lowestPrice]);
   }
   return prices;
   
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
