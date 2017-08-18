import std.stdio;

class SqlSyntax
{
	string tableName;
    this(){}

	this(SqlBuilder builder)
	{
		this.tableName = builder._tableName;
	}
}

class MysqlSyntax : SqlSyntax
{

}
class PgsqlSyntax : SqlSyntax
{

}

class SqlBuilder
{
	string _tableName;
	this()
	{
	
	}

	SqlBuilder tableName(string name)
	{
		this._tableName = name;
		return this;
	}

	SqlSyntax build()
	{
		return new SqlSyntax(this);
	}
}


interface IFactory
{
    
}

void main()
{
	writeln("Edit source/app.d to start your project.");

	auto sql = (new SqlBuilder()).tableName("test").build();

}
