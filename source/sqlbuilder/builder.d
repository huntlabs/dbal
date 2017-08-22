module sqlbuilder.builder;

import sqlbuilder;

interface sqlBuilder
{
    //string _tableName;
    sqlBuilder tableName(string name);
    string tableName();
    sqlSyntax build();
}

