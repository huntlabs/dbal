module dbal.defined;

import dbal;

enum JoinMethod : string {
    InnerJoin = " INNER JOIN ",
    LeftJoin = " LEFT JOIN ",
    RightJoin = " RIGHT JOIN ",
    FullJoin = " FULL JOIN ",
    CrossJoin = " CROSS JOIN ",
}
enum Method : string {
    Select = " SELECT ",
    Insert = " INSERT ",
    Update = " UPDATE ",
    Delete = " DELETE FROM",
	Count = " SELECT count(*) FROM "
}
enum Relation : string {
    And = " AND ", 
    Or = " OR "
}
enum CompareType : string {
    eq = " = ", 
    ne = " != ", 
    gt = " > ", 
    lt = " < ", 
    ge = " >= ", 
    le = " <= ", 
    eqnull = " is ",
    nenull = " is not ",
    like = " like "
}
