import std.stdio;

import dbal;

void main()
{
	writeln("Edit source/app.d to start your project.");

    SqlFactory sqlFactory = new SqlFactory();
	sqlBuilder builder;
    sqlSyntax syntax;

	//create SQL Query Builder
	builder = sqlFactory.createMysqlBuilder();

	//builder a Query
    int id = 2680;
    float money = 15.9;
    bool status = true;
    string name = "test";
	syntax = builder
		.from("users")
        .where("id",CompareType.eq,id)
        .eq("money",money)
        .where("status",CompareType.eq,status)
        .where("name",CompareType.eq,name)
		.where("id = ?")
		.setParameter(0,"26680")
    .build();
	writeln(syntax);


	//insert 
	builder = sqlFactory.createMysqlBuilder();
	syntax = builder.insert("users")
		.values([
			"id" : "?",
			"name" : "?",
			])
		.set("phone","?")
		.setParameter(0,"26681")
		.setParameter(1,"\"viile\"")
		.setParameter(2,"18812341234")
        .build();
	writeln(syntax);

	//delete
	builder = sqlFactory.createMysqlBuilder();
	syntax = builder.remove("users")
		.where("id = ?")
		.where("name = ?")
		.setParameter(0,"26681")
		.setParameter(1,"\"viile\"")
		.orderBy("name","ASC")
		.limit(10).build;
	writeln(syntax);

	//update
	builder = sqlFactory.createMysqlBuilder();
	syntax = builder.update("users")
		.set("name","?")
		.setParameter(0,"\"viile\"")
		.where("id = 26681")
		.orderBy("name","ASC")
		.limit(10).build();
	writeln(syntax);

	//Building Where Expressions 
	builder = sqlFactory.createMysqlBuilder();
	builder.select("id", "name")
		.from("users")
		.where(
			builder.expr().andX(
				builder.expr().eq("username", "\"test\""),
				builder.expr().eq("email", "\"test@putao.com\""),
				builder.expr().orX(
					builder.expr().eq("role", "\"test\""),
					builder.expr().eq("public", "\"test@putao.com\""),
				)
			)
		);
	writeln(builder.build);
	
    //GROUP BY and HAVING Clause
	builder = sqlFactory.createMysqlBuilder();
	builder.select("DATE(last_login) as date", "COUNT(id) AS users")
		.from("users")
		.groupBy("DATE(last_login)")
		.having("users > 10");
	writeln(builder.build);

	//Table alias
	builder = sqlFactory.createMysqlBuilder();
	builder.select("id","name")
		.from("users","u")
		.where("id = ?")
		.setParameter(0,"26680");
	writeln(builder.build);

	//Join Clauses
	builder = sqlFactory.createMysqlBuilder();
	builder.select("u.id","u.username","p.name")
		.from("users","u")
		.leftJoin("phone","p","p.uid = u.id")
		.where("u.id = ?")
		.setParameter(0,"26680");
	writeln(builder.build);

	//Limit Clause
	builder = sqlFactory.createMysqlBuilder();
	builder.select("u.id","u.username","p.name")
		.from("users","u")
		.leftJoin("phone","p","p.uid = u.id")
		.where("u.id = ?")
		.setParameter(0,"26680")
		.offset(10)
		.limit(20);
	writeln(builder.build);
}

