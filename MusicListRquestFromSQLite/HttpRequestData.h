//
//  HttpRequestData.h
//  MusicListRquestFromSQLite
//
//  Created by zhang xu on 15/11/26.
//  Copyright © 2015年 zhang xu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpRequestData : NSObject
+(HttpRequestData *)shareInstance;

-(void)muiscUrl:(NSString *)url requestDataBlock:(void(^)(NSArray *array))block;


@end
