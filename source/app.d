import std.stdio;

class Sql
{
	string tableName;

	this(SqlBuilder builder)
	{
		this.tableName = builder._tableName;
	}
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

	Sql build()
	{
		return new Sql(this);
	}
}

void main()
{
	writeln("Edit source/app.d to start your project.");

	auto sql = (new SqlBuilder()).tableName("test").build();

}
