//
//  main.m
//  SqliteDemo
//
//  Created by Duke Wu on 13-12-18.
//  Copyright (c) 2013年 iBokan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "FMDatabase.h"
int callback(void *notUsed,int argc,char** argv,char**azCloName)
{
    for (int i=0; i<argc; i++) {
        NSLog(@"%s = %s ",azCloName[i],argv[i]? argv[i]: "NULL");
    }
    /*
     * ^If an sqlite3_exec() callback returns non-zero, the sqlite3_exec()
     * routine returns SQLITE_ABORT without invoking the callback again and
     * without running any subsequent SQL statements.
     */
    //若此处返回值!=0,则sqlite3_exec()会返回SQLTITE_ABORT错误,且不再执行;
    return 0;
}

void testSqlite(NSString* fileName)
{
    sqlite3 * database;
    sqlite3_open([fileName UTF8String], &database);
    

    /*
     * 创建表
     */
//        char * createTable = "create table  T1(id integer(20),name TEXT)";
//        sqlite3_exec(database, createTable, NULL, NULL, NULL);
//        NSLog(@"%s",sqlite3_errmsg(database));
    
    /*
     * 插入记录
     */
//        char * insert = "insert into T1 values( ? , ? )";
//        sqlite3_stmt * stmt;
//        //准备语句
//        int i = sqlite3_prepare_v2(database, insert, -1, &stmt, NULL);
//        NSLog(@"prepare result code = %d",i);
//        for(int i =0;i<100;i++)
//        {
//            //绑定第一个 ? 为整型
//            sqlite3_bind_int(stmt, 1, i);
//            //绑定第二个 ? 为字符串
//            sqlite3_bind_text(stmt, 2, "zhangsan", -1, NULL);
//            //执行语句
//            NSLog(@"%d", sqlite3_step(stmt));
//            //清空绑定状态
//            sqlite3_reset(stmt);
//        }
//         //销毁语句
//        sqlite3_finalize(stmt);
    
    /*
    * 读取记录
     */
//初始化语句
//        sqlite3_stmt * stmt;
//        char * select = "select id,name from T1 ";
//        //准备语句
//        int code = sqlite3_prepare_v2(database, select, -1, &stmt, NULL);
//        //打印错误信息
//        NSLog(@"prepare code = %d  \n errMessage = %s",code,sqlite3_errmsg(database));
//        //步进结果
//        while(sqlite3_step(stmt)==SQLITE_ROW)
//        {
//            //打印第0列和第1列的数据，每步进一次，向下走一行
//            NSLog(@"%d---%s", sqlite3_column_int(stmt, 0),sqlite3_column_text(stmt, 1));
//        }
//        //销毁语句
//        sqlite3_finalize(stmt);
    
    
    char * select =  "select id from T1 ";
    //执行语句
    /*
     *  参数1,数据库指针
     *  参数2,语句指针
     *  参数3,回调函数
     *  参数4,
     */
    int result = sqlite3_exec(database, select, callback, NULL, NULL);
    NSLog(@"%d",result);
    //关闭数据库连接
    sqlite3_close(database);

}
void testFMDB(NSString* fileName)
{
    FMDatabase* database = [FMDatabase databaseWithPath:fileName];
    [database open];
//    [database executeUpdate:@"create table if not exists T1 (id integer primary key autoincrement not null,name text,age integer)"];
//    [database executeUpdate:@"insert into T1 (name,age) values('zhangsan',20)"];
    
    //批量处理
    [database beginTransaction];
    for (int i =0 ; i<100; i++) {
        [database executeUpdate:@"insert into T1 (name,age) values('zhangsan?',i%20+20)",i];
    }
    [database commit];
    NSLog(@"%@",[database lastErrorMessage]);
    
//    FMResultSet* set = [database executeQuery:@"select * from T1"];
//    //列数
//    NSLog(@"%d", [set columnCount]);
//    //下一行
//    while ([set next]) {
//        NSLog(@"%d  %@",[set intForColumnIndex:0],[set stringForColumnIndex:1]);
//    }
    
}
int main(int argc, const char * argv[])
{
    //获取文件路径
    NSString* path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* fileName = [NSString stringWithFormat:@"%@/test.db",path];

//    testSqlite(fileName);
    testFMDB(fileName);
    return 0;
}

