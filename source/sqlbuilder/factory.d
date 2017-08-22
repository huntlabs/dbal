module sqlbuilder.factory;

import sqlbuilder;

interface IFactory
{

}

class SqlFactory : IFactory
{
    sqlBuilder createMysqlBuilder()
    {
        return new MysqlBuilder();
    }
}
