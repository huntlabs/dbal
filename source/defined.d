module sqlbuilder.defined;

import sqlbuilder;

enum JoinMethod {
        InnerJoin = " INNER JOIN ",
        LeftJoin = " LEFT JOIN ",
        RightJoin = " RIGHT JOIN ",
        FullJoin = " FULL JOIN ",
        CrossJoin = " CROSS JOIN ",
}
enum Method {
        Select = " SELECT ",
        Insert = " INSERT ",
        Update = " UPDATE ",
        Delete = " DELETE FROM"
}
enum Relation {
        And = " AND ", 
        Or = " OR ",
}
enum CompareType {
        eq = "=", 
        ne = "!=", 
        gt = ">", 
        lt = "<", 
        ge = ">=", 
        le = "<=", 
}
