//
//  NSObject+MYJSONModel.h
//  RunTime
//
//  Created by sunjinshuai on 2018/1/3.
//  Copyright © 2018年 MYSampleCode. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MYJSONModel <NSObject>

@optional

// 数组[value,value] 或 字典{key: value,key: value} value模型映射类型
+ (NSDictionary *)modelClassInArrayOrDictonary;

// 属性名 - key 映射
+ (NSDictionary *)modelPropertyMapper;

// 忽略某些属性
+ (NSArray *)ignoreModelProperties;

// 是否自定义未识别（不能处理的）value
- (BOOL)shouldCustomUnkownValueWithKey:(NSString *)key;

// 处理未识别（不能处理的）字典value 返回自定义的value
- (id)customValueWithKey:(NSString *)key unkownValueDictionary:(NSDictionary *)unkownValueDictionary;

// 处理未识别（不能处理的）数组value 返回自定义的value
- (id)customValueWithKey:(NSString *)key unkownValueArray:(NSArray *)unkownValueArray;

@end

@interface NSObject (MYJSONModel) <MYJSONModel>

// json转模型
+ (instancetype)my_ModelWithJSON:(id)json;
// json: NSString,NSDictionary,NSData
+ (instancetype)my_ModelWithDictonary:(NSDictionary *)dic;

- (void)my_setModelWithDictonary:(NSDictionary *)dic;

// model to json
- (id)my_ModelToJSONObject; // array or dic
- (NSData *)my_ModelToJSONData;
- (NSString *)my_ModelToJSONString;
- (NSDictionary *)my_ModelToDictonary;

// dic array to model array
+ (NSArray *)my_ModelArrayWithDictionaryArray:(NSArray *)dicArray;
// model array to dic array
+ (NSArray *)my_DictionaryArrayWithModelArray:(NSArray *)dicArray;

// NSCoding
- (void)my_EncodeWithCoder:(NSCoder *)aCoder;
- (instancetype)my_InitWithCoder:(NSCoder *)aDecoder;

@end

@interface NSArray (MYJSONModel)

// to model array
- (NSArray *)my_ModelArrayWithClass:(Class)cls;

// to dic array
- (NSArray *)my_ModelArrayToDicArray;

@end

@interface NSDictionary (MYJSONModel)

// to model dictionary
- (NSDictionary *)my_ModelDictionaryWithClass:(Class)cls;

// to dictionary
- (NSDictionary *)my_ModelDictionaryToDictionary;

@end
