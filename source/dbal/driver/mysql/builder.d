module dbal.driver.mysql.builder;

import dbal;

class MysqlBuilder : sqlBuilder 
{
	Method _method;
	string _tableName;
	string _tableNameAlias;
	string[] _selectKeys = ["*"];
	string _having;
	string _groupby;
	string _orderByKey;
	string _order;
	int _offset;
	int _limit;
	string _multiWhereStr;
	WhereExpression[] _whereKeys;
	WhereExpression[] _whereKeysParameters;
	ValueExpression[string] _values;
	ValueExpression[] _valuesParameters;
	JoinExpression[] _joins;

	sqlBuilder from(string tableName,string tableNameAlias = null)
	{
		_tableName = tableName;
		_tableNameAlias = tableNameAlias.length ? tableNameAlias : tableName;
		return this;
	}
	sqlBuilder select(string...)(string args)
	{
		_selectKeys = null;
		foreach(arg;args)_selectKeys ~= arg;
		_method = Method.Select;
		return this;
	}
	sqlBuilder insert(string tableName)
	{
		_tableName = tableName;
		_method = Method.Insert;
		return this;
	}
	sqlBuilder update(string tableName)
	{
		_tableName = tableName;
		_method = Method.Update;
		return this;
	}
	sqlBuilder remove(string tableName)
	{
		_tableName = tableName;
		_method = Method.Delete;
		return this;
	}
	sqlBuilder where(string expression)
	{
		if(!expression.length)return this;
		auto arr = split(strip(expression)," ");
		if(arr.length != 3)return this;
		auto expr = new WhereExpression(arr[0],arr[1],arr[2]);
		_whereKeys ~= expr;
		if(arr[2] == "?")_whereKeysParameters ~= expr;
		return this;
	}
	sqlBuilder where(T)(string key,string op,T value)
	{
		_whereKeys ~= new WhereExpression(key,op,value.to!string);
		return this;
	}
	sqlBuilder eq(T)(string key,T value)
	{
		_whereKeys ~= new WhereExpression(key,CompareType.eq,value.to!string);
		return this;
	}
	sqlBuilder ne(T)(string key,T value)
	{
		_whereKeys ~= new WhereExpression(key,CompareType.ne,value.to!string);
		return this;
	}
	sqlBuilder gt(T)(string key,T value)
	{
		_whereKeys ~= new WhereExpression(key,CompareType.gt,value.to!string);
		return this;
	}
	sqlBuilder lt(T)(string key,T value)
	{
		_whereKeys ~= new WhereExpression(key,CompareType.lt,value.to!string);
		return this;
	}
	sqlBuilder ge(T)(string key,T value)
	{
		_whereKeys ~= new WhereExpression(key,CompareType.ge,value.to!string);
		return this;
	}
	sqlBuilder le(T)(string key,T value)
	{
		_whereKeys ~= new WhereExpression(key,CompareType.le,value.to!string);
		return this;
	}
	sqlBuilder like(T)(string key,T value)
	{
		_whereKeys ~= new WhereExpression(key,CompareType.like,value.to!string);
		return this;
	}
	sqlBuilder where(MultiWhereExpression expr)
	{
		_multiWhereStr = expr.toString;
		return this;
	}
	sqlBuilder having(string expression)
	{
		_having = expression;
		return this;
	}
	MultiWhereExpression expr()
	{
		return new MultiWhereExpression();
	}
	sqlBuilder join(JoinMethod joinMethod,string table,string tablealias,string joinWhere)
	{
		_joins ~= new JoinExpression(joinMethod,table,tablealias,joinWhere);
		return this;
	}
	sqlBuilder join(JoinMethod joinMethod,string table,string joinWhere)
	{
		return join(joinMethod,table,table,joinWhere);
	}
	sqlBuilder innerJoin(string table,string tablealias,string joinWhere)
	{
		return join(JoinMethod.InnerJoin,table,tablealias,joinWhere);
	}
	sqlBuilder innerJoin(string table,string joinWhere)
	{
		return innerJoin(table,table,joinWhere);
	}
	sqlBuilder leftJoin(string table,string tableAlias,string joinWhere)
	{
		return join(JoinMethod.LeftJoin,table,tableAlias,joinWhere);
	}
	sqlBuilder leftJoin(string table,string joinWhere)
	{
		return leftJoin(table,table,joinWhere);
	}
	sqlBuilder rightJoin(string table,string tableAlias,string joinWhere)
	{
        return join(JoinMethod.RightJoin,table,tableAlias,joinWhere);
	}
	sqlBuilder rightJoin(string table,string joinWhere)
	{
        return rightJoin(table,table,joinWhere);
	}
	sqlBuilder fullJoin(string table,string tableAlias,string joinWhere)
	{
		return join(JoinMethod.FullJoin,table,tableAlias,joinWhere);
	}
	sqlBuilder fullJoin(string table,string joinWhere)
	{
		return fullJoin(table,table,joinWhere);
	}
	sqlBuilder crossJoin(string table,string tableAlias)
	{
		return join(JoinMethod.CrossJoin,table,tableAlias,null);
	}
	sqlBuilder crossJoin(string table)
	{
		return crossJoin(table,table);
	}
	sqlBuilder groupBy(string expression)
	{
		_groupby = expression;
		return this;
	}
	sqlBuilder orderBy (string key,string order = "DESC")
	{
		_orderByKey = key;
		_order = order;
		return this;
	}
	sqlBuilder offset(int offset)
	{
		_offset = offset;
		return this;
	}
	sqlBuilder limit(int limit)
	{
		_limit = limit;
		return this;
	}
	sqlBuilder values(string[string] arr)
	{
		foreach(key,value;arr){
			auto expr = new ValueExpression(key,value);
			_values[key] = expr;
			if(value == "?")_valuesParameters ~= expr;
		}
		return this;
	}
	sqlBuilder setValue(string key,string value)
	{
		auto expr = new ValueExpression(key,value);
		_values[key] = expr;
		if(value == "?")_valuesParameters ~= expr;
		return this;
	}
	sqlBuilder setParameter(int index,string value)
	{
		if(_whereKeysParameters.length){
			if(index > _whereKeysParameters.length - 1)
				throw new DbalException("query builder setParameter range valite");
			_whereKeysParameters[index].value = value;
		}else{
			if(index > _valuesParameters.length - 1)
				throw new DbalException("query builder setParameter range valite");
			_valuesParameters[index].value = value;
		}
		return this;
	}


	string tableName()
	{
		return this._tableName;
	}

    string tableNameAlias()
    {
        return this._tableNameAlias;
    }

    Method method()
    {
        return this._method;
    }

    string[] selectKeys()
    {
        return this._selectKeys;
    }

    string having()
    {
        return this._having;
    }

    string groupBy()
    {
        return this._groupby;
    }

    string orderBy()
    {
        return this._orderByKey;
    }

    string order()
    {
        return this._order;
    }

    int limit()
    {
        return this._limit;
    }

    int offset()
    {
        return this._offset;
    }

    string multiWhereStr()
    {
        return this._multiWhereStr;
    }

    WhereExpression[] whereKeys()
    {
        return this._whereKeys;
    }

    ValueExpression[string] values()
    {
        return this._values;
    }

    JoinExpression[] joins()
    {
        return this._joins;
    }

	MysqlSyntax build()
	{
		return new MysqlSyntax(this);
	}
}
