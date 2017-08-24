module dbal.factory;

import dbal;

interface IFactory
{

}

class SqlFactory : IFactory
{
    SqlBuilder createMySqlBuilder()
    {
        return new MySqlBuilder();
    }
}
