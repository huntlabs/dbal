module dbal.factory;

import dbal;

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
