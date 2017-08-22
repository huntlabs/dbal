module sqlbuilder.builder;

import sqlbuilder;

interface sqlBuilder
{
    sqlBuilder from(string tableName,string tableNameAlias = null);
    sqlBuilder select(string...)(string args);
    sqlBuilder insert(string tableName);
    sqlBuilder update(string tableName);
    sqlBuilder remove(string tableName);
    sqlBuilder where(string expression);
    sqlBuilder having(string expression);
    sqlBuilder eq(T)(string key,T value);
    sqlBuilder ne(T)(string key,T value);
    sqlBuilder gt(T)(string key,T value);
    sqlBuilder lt(T)(string key,T value);
    sqlBuilder ge(T)(string key,T value);
    sqlBuilder le(T)(string key,T value);
    sqlBuilder like(T)(string key,T value);
    sqlBuilder where(MultiWhereExpression expr);
    MultiWhereExpression expr();
    sqlBuilder join(JoinMethod joinMethod,string table,string tablealias,string joinWhere);
    sqlBuilder join(JoinMethod joinMethod,string table,string joinWhere);
    sqlBuilder innerJoin(string table,string tablealias,string joinWhere);
    sqlBuilder innerJoin(string table,string joinWhere);
    sqlBuilder leftJoin(string table,string tableAlias,string joinWhere);
    sqlBuilder leftJoin(string table,string joinWhere);
    sqlBuilder rightJoin(string table,string tableAlias,string joinWhere);
    sqlBuilder rightJoin(string table,string joinWhere);
    sqlBuilder fullJoin(string table,string tableAlias,string joinWhere);
    sqlBuilder fullJoin(string table,string joinWhere);
    sqlBuilder crossJoin(string table,string tableAlias);
    sqlBuilder crossJoin(string table);
    sqlBuilder groupBy(string expression);
    sqlBuilder orderBy (string key,string order = "DESC");
    sqlBuilder offset(int offset);
    sqlBuilder limit(int limit);
    sqlBuilder values(string[string] arr);
    sqlBuilder setValue(string key,string value);
    sqlBuilder setParameter(int index,string value);
    
    string tableName();
    
    sqlSyntax build();
}

