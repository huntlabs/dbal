import std.stdio;

import dbal;

void main()
{
	writeln("Edit source/app.d to start your project.");

    auto sql = (new SqlFactory).createMysqlBuilder.build();
}
