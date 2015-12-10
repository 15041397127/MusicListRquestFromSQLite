//
//  DBHelper.m
//  MusicListRquestFromSQLite
//
//  Created by zhang xu on 15/11/26.
//  Copyright © 2015年 zhang xu. All rights reserved.
//

#import "DBHelper.h"

@implementation DBHelper
+(DBHelper *)shareSqlite{
    static DBHelper *dbHelper =nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dbHelper=[[DBHelper alloc]init];
        
    });
    return dbHelper;
}

static sqlite3 *db =nil;
#pragma mark 打开数据库
-(void)openDB{
    NSString *docmeuntPatch =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    
    NSString *filePatch=[docmeuntPatch stringByAppendingPathComponent:@"musicList.sqlite"];
    NSInteger dataList =sqlite3_open([filePatch UTF8String], &db);
    if (dataList==SQLITE_OK) {
        NSLog(@"打开成功");
        NSString *sql =@"CREATE TABLE IF NOT EXISTS Music (number INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE, name TEXT NOT NULL, picUrl TEXT NOT NULL, singer TEXT NOT NULL)";
        char *error;
        NSInteger dataList2 =sqlite3_exec(db, sql.UTF8String, NULL, NULL, &error);
        if (dataList2==SQLITE_OK) {
            NSLog(@"创建表格成功");
        }else{
            
            NSLog(@"创建表失败======%s",error);
        }

    }

}

#pragma mark 关闭数据库
- (void)closeDB{
    if (db!=nil) {
        NSInteger dataList =sqlite3_close(db);
        if (dataList==SQLITE_OK) {
            NSLog(@"关闭成功");
            db=nil;
        }else{
            NSLog(@"关闭失败");
        }
    }
}


#pragma mark 插入信息
- (void)insertMusicList:(MusicModel *)musicList{

    NSLog(@"%@",musicList.name);
    
    NSString *sql=[NSString stringWithFormat:@"INSERT INTO Music (name, picUrl, singer) values ('%@','%@', '%@')",musicList.name,musicList.picUrl,musicList.singer];
    char *error;
    NSInteger dataList =sqlite3_exec(db, sql.UTF8String, NULL, NULL, &error);
    if (dataList== SQLITE_OK) {
        NSLog(@"插入成功");
    }else{
        NSLog(@"插入失败============%s",error);
    }
}

#pragma mark 删除信息

- (void)deleteMusicList{
    NSString *sql =[NSString stringWithFormat:@"DELETE FROM Music"];
    char *error;
    NSInteger dataList =sqlite3_exec(db, sql.UTF8String, NULL, NULL, &error);
    if (dataList ==SQLITE_OK) {
        NSLog(@"删除成功");
    }else{
        NSLog(@"删除失败");
        NSLog(@"%s",error);
    }
    
    
    
}

#pragma mark 更新信息
- (void)updataMusicList:(NSString *)name singer:(NSString *)singer picUrl:(NSString *)picUrl{
    
}


#pragma mark 查找所有歌曲
- (NSMutableArray *)selectAllMusic{
    NSMutableArray *arr =[NSMutableArray array];
    NSString *sql=@"SELECT * FROM Music";
    
    sqlite3_stmt *stmt=nil;
    NSInteger dataList=sqlite3_prepare(db, sql.UTF8String, -1, &stmt, NULL);
    if (dataList==SQLITE_OK) {
        NSLog(@"成功执行sql语句");
        while (sqlite3_step(stmt)==SQLITE_ROW) {
            NSLog(@"查到数据");
            const char *name1=(const char*)sqlite3_column_text(stmt, 0);
            NSString *name =[NSString stringWithCString:name1 encoding:NSUTF8StringEncoding];
            
            const char *singer1=(const char*)sqlite3_column_text(stmt, 1);
            NSString *singer =[NSString stringWithCString:singer1 encoding:NSUTF8StringEncoding];
            
            const char *picUrl1=(const char*)sqlite3_column_text(stmt, 2);
            NSString *picUrl =[NSString stringWithCString:picUrl1 encoding:NSUTF8StringEncoding];
            
            MusicModel *model=[[MusicModel alloc]init];
            model.name=name;
            model.singer=singer;
            model.picUrl=picUrl;
            
            [arr addObject:model];
            
        }
    }else{
        NSLog(@"查询失败");
    }
    
    sqlite3_finalize(stmt);
    
    return arr;
    
}





@end
