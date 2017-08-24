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
    SqlBuilder createPgSqlBuilder()
    {
        return new PgSqlBuilder();
    }
    SqlBuilder createSqliteBuilder()
    {
        return new SqliteBuilder();
    }
}
