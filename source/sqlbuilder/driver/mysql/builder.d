module sqlbuilder.driver.mysql.builder;

import sqlbuilder;

class MysqlBuilder : sqlBuilder 
{
    private string _tableName;

    MysqlBuilder tableName(string name)
    {
        this._tableName = name;
        return this;
    }

    string tableName()
    {
        return this._tableName;
    }

    MysqlSyntax build()
    {
        return new MysqlSyntax(this);
    }

}
