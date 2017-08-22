import std.stdio;

import sqlbuilder;

void main()
{
	writeln("Edit source/app.d to start your project.");

    auto sql = (new SqlFactory).createMysqlBuilder.build();
}
