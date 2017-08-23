module dbal.builder;

import dbal;

interface sqlBuilder
{
    sqlBuilder from(string tableName,string tableNameAlias = null);
    sqlBuilder select(T...)(T args)
	{
		string[] arr;
		foreach(arg;args){
			arr ~= arg;
		}
		return selectImpl(arr);
	}
    sqlBuilder selectImpl(string[] args);
    sqlBuilder insert(string tableName);
    sqlBuilder update(string tableName);
    sqlBuilder remove(string tableName);
    sqlBuilder where(string expression);
    sqlBuilder having(string expression);
    sqlBuilder eq(T)(string key,T value)
	{
		return whereImpl(key,CompareType.eq,value.to!string);
	}
    sqlBuilder ne(T)(string key,T value)
	{
		return whereImpl(key,CompareType.ne,value.to!string);
	}
    sqlBuilder gt(T)(string key,T value)
	{
		return whereImpl(key,CompareType.gt,value.to!string);
	}
    sqlBuilder lt(T)(string key,T value)
	{
		return whereImpl(key,CompareType.lt,value.to!string);
	}
    sqlBuilder ge(T)(string key,T value)
	{
		return whereImpl(key,CompareType.ge,value.to!string);
	}
    sqlBuilder le(T)(string key,T value)
	{
		return whereImpl(key,CompareType.le,value.to!string);
	}
    sqlBuilder like(T)(string key,T value)
	{
		return whereImpl(key,CompareType.like,value.to!string);
	}
    sqlBuilder where(T)(string key,CompareType type,T value)
	{
		return whereImpl(key,type,value.to!string);
	}
	sqlBuilder whereImpl(string key,CompareType type,string value);
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
    sqlBuilder set(string key,string value);
    sqlBuilder setParameter(int index,string value);
    
    string tableName();
    string tableNameAlias();
    Method method();
    string[] selectKeys();
    string having();
    string groupBy();
    string orderBy();
    string order();
    int limit();
    int offset();
    string multiWhereStr();
    WhereExpression[] whereKeys();
    ValueExpression[string] values();
    JoinExpression[] joins();
    
    sqlSyntax build();
}

